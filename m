Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 16:02:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, benh@kernel.crashing.org
Subject: hypervisor call trace module
Message-ID: <20091027050223.GI3085@kryten>
References: <20091027044742.GB3085@kryten> <20091027044914.GC3085@kryten>
	<20091027045029.GD3085@kryten> <20091027045109.GE3085@kryten>
	<20091027045157.GF3085@kryten> <20091027045224.GG3085@kryten>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <20091027045224.GG3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here is an example of using the hcall tracepoints. This kernel
module provides strace like functionality for hypervisor hcalls:

-> 0x64(ff000002, 1, 2, d0000000034d7a71, f, c000000000a6f388, 1, c000000000989008, c000000000a3f480)
  <- 0x64()

Which was an EOI (opcode 0x64) of 0xff000002

There are a number of drivers that carry a lot of hcall related debug
code just in case we have to chase down a bug. I'm hoping hcall tracepoints
could replace it all and allow for much more powerful debugging.

Anton

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

obj-m := hcall_trace.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -rf *.mod.c *.ko *.o .*.cmd .tmp_versions Module.markers modules.order Module.symvers

--oC1+HKm2/end4ao3
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="hcall_trace.c"

/*
 * Hypervisor hcall trace
 *
 * Look for output in /sys/kernel/debug/powerpc/hcall_trace/
 * 
 * Copyright (C) 2009 Anton Blanchard <anton@au.ibm.com>, IBM
 *      
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 */             
                        
#include <linux/module.h>
#include <linux/debugfs.h>
#include <linux/relay.h>
#include <asm/trace.h>

#define SUBBUF_SIZE	131072
#define N_SUBBUFS	8

#define BUFLEN		512

static struct rchan *log_chan;

static void probe_hcall_entry(unsigned long opcode, unsigned long *args)
{
	char buf[BUFLEN];

	/* Don't log H_CEDE */
	if (opcode == H_CEDE)
		return;

	snprintf(buf, BUFLEN,
		"-> 0x%lx(%lx, %lx, %lx, %lx, %lx, %lx, %lx, %lx, %lx)\n",
		opcode, *args, *(args+1), *(args+2), *(args+3), *(args+4),
		*(args+5), *(args+6), *(args+7), *(args+8));

	relay_write(log_chan, buf, strlen(buf));
}

static void probe_hcall_exit(unsigned long opcode, unsigned long retval,
			     unsigned long *retbuf)
{
	char buf[BUFLEN];

	/* Don't log H_CEDE */
	if (opcode == H_CEDE)
		return;

	if (retbuf)
		snprintf(buf, BUFLEN, 
		    "  <- 0x%lx(%lx, %lx, %lx, %lx, %lx, %lx, %lx, %lx, %lx)\n",
			opcode, *retbuf, *(retbuf+1),
			*(retbuf+2), *(retbuf+3), *(retbuf+4), *(retbuf+5),
			*(retbuf+6), *(retbuf+7), *(retbuf+8));
	else
		sprintf(buf, "  <- 0x%lx()\n", opcode);

	relay_write(log_chan, buf, strlen(buf));
}

static struct dentry *create_buf_file_handler(const char *filename,
					      struct dentry *parent, int mode,
					      struct rchan_buf *buf,
					      int *is_global)
{
	return debugfs_create_file(filename, mode, parent, buf,
		&relay_file_operations);
}

static int remove_buf_file_handler(struct dentry *dentry)
{
	debugfs_remove(dentry);
	return 0;
}

static int subbuf_start(struct rchan_buf *buf, void *subbuf, void *prev_subbuf,
			size_t prev_padding)
{
	return 1;
}

static struct rchan_callbacks relay_callbacks =
{
	.create_buf_file = create_buf_file_handler,
	.remove_buf_file = remove_buf_file_handler,
	.subbuf_start = subbuf_start,
};

static struct dentry *debugfs_root;

static int __init hcall_trace_init(void)
{
	debugfs_root = debugfs_create_dir("hcall_trace", powerpc_debugfs_root);

	if (debugfs_root == ERR_PTR(-ENODEV)) {
		printk(KERN_ERR "Debugfs not configured\n");
		goto err_out;
	}

	if (!debugfs_root) {
		printk(KERN_ERR "Could not create debugfs directory\n");
		goto err_out;
	}

	log_chan = relay_open("cpu", debugfs_root, SUBBUF_SIZE,
			      N_SUBBUFS, &relay_callbacks, NULL);
	if (!log_chan) {
		printk(KERN_ERR "relay_open failed\n");
		goto err_relay_open;
	}

	if (register_trace_hcall_entry(probe_hcall_entry)) {
		printk(KERN_ERR "probe_hcall_entry probe point failed\n");
		goto err_probe_hcall_entry;
	}

	if (register_trace_hcall_exit(probe_hcall_exit)) {
		printk(KERN_ERR "probe_hcall_exit probe point failed\n");
		goto err_probe_hcall_exit;
	}

	return 0;

err_probe_hcall_exit:
	unregister_trace_hcall_entry(probe_hcall_entry);
err_probe_hcall_entry:
	relay_close(log_chan);
err_relay_open:
	debugfs_remove(debugfs_root);
err_out:
	return -ENODEV;
}

static void __exit hcall_trace_exit(void)
{
	unregister_trace_hcall_exit(probe_hcall_exit);
	unregister_trace_hcall_entry(probe_hcall_entry);

	relay_close(log_chan);
	debugfs_remove(debugfs_root);
}

module_init(hcall_trace_init)
module_exit(hcall_trace_exit)
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Anton Blanchard");

--oC1+HKm2/end4ao3--
