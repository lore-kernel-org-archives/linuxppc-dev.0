Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B5BA1A0130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 11:11:32 +1100 (AEDT)
In-Reply-To: <1416975004.5089.48.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
 Rusty Russell <rusty@rustcorp.com.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Add debugfs file to grab opalv3 trace data
Message-Id: <20141128001131.F199414019D@ozlabs.org>
Date: Fri, 28 Nov 2014 11:11:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-26-11 at 04:10:04 UTC, Benjamin Herrenschmidt wrote:
> This adds files in debugfs that can be used to retrieve the
> OPALv3 firmware "live binary traces" which can then be parsed
> using a userspace tool.
> 
> Mostly from Rusty with some updates by myself (BenH)
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Conspicuous review of patch from maintainer follows ...

Meta-comment: given we need a userspace tool to read the trace anyway, could we
make this a lot simpler by just letting userspace mmap the trace buffers?
 
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index f241acc..315a825 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,7 +1,7 @@
>  obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> -obj-y			+= opal-msglog.o opal-hmi.o
> +obj-y			+= opal-msglog.o opal-hmi.o opal-trace.o

Should depend on CONFIG_DEBUG_FS at least no?

> diff --git a/arch/powerpc/platforms/powernv/opal-trace-types.h b/arch/powerpc/platforms/powernv/opal-trace-types.h
> new file mode 100644
> index 0000000..3bd8ac2
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-trace-types.h
> @@ -0,0 +1,58 @@
> +/* API for kernel to read trace buffer. */

Copyright/GPL header ?

/*
 * Copyright 201x, Purple Monkey Dishwasher, IBM Corporation.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 */

> +#ifndef __OPAL_TRACE_TYPES_H
> +#define __OPAL_TRACE_TYPES_H

We usually do __POWERNV_FOO_H for these. But they're all a bit of a mess.

> +#define TRACE_REPEAT 1
> +#define TRACE_OVERFLOW 2
> +#define TRACE_OPAL 3
> +#define TRACE_FSP 4

Linux tracepoints defines a bunch of TRACE_FOO macros, obviously REPEAT is the
only one that's likely to clash. But still might be worth namespacing.

> +/* One per cpu, plus one for NMIs */
> +struct tracebuf {
> +	/* Mask to apply to get buffer offset. */
> +	__be64 mask;
> +	/* This where the buffer starts. */
> +	__be64 start;
> +	/* This is where writer has written to. */
> +	__be64 end;
> +	/* This is where the writer wrote to previously. */
> +	__be64 last;
> +	/* This is where the reader is up to. */
> +	__be64 rpos;
> +	/* If the last one we read was a repeat, this shows how many. */
> +	__be32 last_repeat;

So I think start/end/last/rpos/last_repeat are all full virtual addresses right?

> +	/* Maximum possible size of a record. */
> +	__be32 max_size;
> +
> +	char buf[/* TBUF_SZ + max_size */];

We don't have TBUF_SZ.

> +};
> +
> +/* Common header for all trace entries. */
> +struct trace_hdr {
> +	__be64 timestamp;
> +	u8 type;
> +	u8 len_div_8;
> +	__be16 cpu;
> +	u8 unused[4];
> +};
> +

The comment below is attached to trace_repeat, but it seems like it should go
with hdr no ?

> +/* Note: all other entries must be at least as large as this! */
> +struct trace_repeat {
> +	__be64 timestamp; /* Last repeat happened at this timestamp */
> +	u8 type; /* == TRACE_REPEAT */
> +	u8 len_div_8;
> +	__be16 cpu;
> +	__be16 prev_len;
> +	__be16 num; /* Starts at 1, ie. 1 repeat, or two traces. */
> +	/* Note that the count can be one short, if read races a repeat. */
> +};
> +
> +struct trace_overflow {
> +	__be64 unused64; /* Timestamp is unused */
> +	u8 type; /* == TRACE_OVERFLOW */
> +	u8 len_div_8;
> +	u8 unused[6]; /* ie. hdr.cpu is indeterminate */
> +	__be64 bytes_missed;
> +};

Some lining up of comments would help readability of those.

> diff --git a/arch/powerpc/platforms/powernv/opal-trace.c b/arch/powerpc/platforms/powernv/opal-trace.c
> new file mode 100644
> index 0000000..6529756
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-trace.c
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright (C) 2013 Rusty Russell, IBM Corporation
> + *

GPL ?

> + * Simple debugfs file firmware_trace to read out OPALv3 trace
                          ^
			  now called opal-trace
> + * ringbuffers.
> + */

<blank>

> +#include <linux/mutex.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <asm/debug.h>
> +#include <asm/opal.h>
> +
> +#include "opal-trace-types.h"
> +
> +static DEFINE_MUTEX(tracelock);
> +static struct tracebuf **opal_tb;
> +static size_t opal_num_tb;
> +static __be64 *opal_tmask_p;

_p ? pointer, or phys?

> +
> +/* Maximum possible size of record (since len is 8 bits). */
> +union max_trace {
> +	struct trace_hdr hdr;
> +	struct trace_overflow overflow;
> +	struct trace_repeat repeat;
> +	char buf[255 * 8];
> +};
> +static union max_trace trace;

I *think* this is only used in opal_trace_read(), so it'd be nice if it was in
there.

> +static bool trace_empty(const struct tracebuf *tb)
> +{
> +	const struct trace_repeat *rep;
> +
> +	if (tb->rpos == tb->end)
> +		return true;
> +
> +	/*
> +	 * If we have a single element only, and it's a repeat buffer
> +	 * we've already seen every repeat for (yet which may be
> +	 * incremented in future), we're also empty.
> +	 */
> +	rep = (void *)tb->buf + (be64_to_cpu(tb->rpos & tb->mask));
> +	if (be64_to_cpu(tb->end) != be64_to_cpu(tb->rpos) + sizeof(*rep))
> +		return false;
> +
> +	if (rep->type != TRACE_REPEAT)
> +		return false;
> +
> +	if (be16_to_cpu(rep->num) != be32_to_cpu(tb->last_repeat))
> +		return false;
> +
> +	return true;
> +}
> +
> +/* You can't read in parallel, so some locking required in caller. */
> +static bool trace_get(union max_trace *t, struct tracebuf *tb)
> +{
> +	u64 start, rpos;
> +
> +	if (trace_empty(tb))
> +		return false;
> +
> +again:
> +	/*
> +	 * The actual buffer is slightly larger than tbsize, so this
> +	 * memcpy is always valid.

We don't seem to have tbsize anymore?

> +	 */
> +	memcpy(t, tb->buf + be64_to_cpu(tb->rpos & tb->mask),
> +	       be32_to_cpu(tb->max_size));
> +
> +	rmb(); /* read barrier, so we read tb->start after copying record. */
> +
> +	start = be64_to_cpu(tb->start);
> +	rpos = be64_to_cpu(tb->rpos);
> +
> +	/* Now, was that overwritten? */
> +	if (rpos < start) {
> +		/* Create overflow record. */
> +		t->overflow.unused64 = 0;
> +		t->overflow.type = TRACE_OVERFLOW;
> +		t->overflow.len_div_8 = sizeof(t->overflow) / 8;
> +		t->overflow.bytes_missed = cpu_to_be64(start - rpos);
> +		tb->rpos = cpu_to_be64(start);
> +		return true;
> +	}
> +
> +	/* Repeat entries need special handling */
> +	if (t->hdr.type == TRACE_REPEAT) {
> +		u32 num = be16_to_cpu(t->repeat.num);
> +
> +		/* In case we've read some already... */
> +		t->repeat.num = cpu_to_be16(num - be32_to_cpu(tb->last_repeat));
> +
> +		/* Record how many repeats we saw this time. */
> +		tb->last_repeat = cpu_to_be32(num);
> +
> +		/* Don't report an empty repeat buffer. */
> +		if (t->repeat.num == 0) {
> +			/*
> +			 * This can't be the last buffer, otherwise
> +			 * trace_empty would have returned true.
> +			 */
> +			BUG_ON(be64_to_cpu(tb->end) <= rpos + t->hdr.len_div_8 * 8);

Can we just WARN_ON() and bail, seeing as this is for debug. I'd hate to panic
a customer system by dumping the trace buffer.

> +			/* Skip to next entry. */
> +			tb->rpos = cpu_to_be64(rpos + t->hdr.len_div_8 * 8);
> +			goto again;
> +		}
> +	} else {
> +		tb->last_repeat = 0;
> +		tb->rpos = cpu_to_be64(rpos + t->hdr.len_div_8 * 8);
> +	}
> +
> +	return true;
> +}
> +
> +/* Horrible polling interface, designed for dumping. */
> +static ssize_t opal_trace_read(struct file *file, char __user *ubuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	ssize_t err;
> +	unsigned int i;
> +
> +	err = mutex_lock_interruptible(&tracelock);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < opal_num_tb; i++) {

OK so I understand this now. You have multiple trace buffers, but you don't
care about maintaining that separation. You just merge all the streams here
into a single output stream.

> +		if (trace_get(&trace, opal_tb[i])) {
> +			size_t len = trace.hdr.len_div_8 * 8;
> +			if (len > count)
> +				len = count;
> +			if (copy_to_user(ubuf, &trace, len) != 0)
> +				err = -EFAULT;
> +			else
> +				err = len;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&tracelock);
> +	return err;
> +}
> +
> +static const struct file_operations opal_trace_fops = {
> +	.read =		opal_trace_read,
> +	.open =		simple_open,
> +	.llseek =	noop_llseek,
> +};
> +
> +static int opal_tmask_set(void *data, u64 val)
> +{
> +	*(__be64 *)data = cpu_to_be64(val);
> +	return 0;
> +}
> +static int opal_tmask_get(void *data, u64 *val)
> +{
> +	*val = be64_to_cpup((__be64 *)data);
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(opal_tmask, opal_tmask_get, opal_tmask_set, "%llx\n");

What is a tmask ?

I assume it's some mask of things we want traced?

> +static int opal_trace_init(void)
> +{
> +	const __be64 *traces;
> +	int len, i, rc;
> +	u64 tmask_phys;
> +
> +	if (!opal_node)
> +		return -ENODEV;
> +
> +	traces = of_get_property(opal_node, "ibm,opal-traces", &len);
> +	if (!traces) {
> +		pr_warning("%s: OPAL node property \"ibm,opal-traces\""
> +			   " not found\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	opal_num_tb = len / (sizeof(__be64) * 2);

So I won't say the "b" word, but it'd be nice to have at least a comment on
what the device tree property contains.

> +	if (!opal_num_tb) {
> +		pr_warning("%s: OPAL traces property has invalid length %i\n",
> +			   __func__, len);
> +		return -EINVAL;
> +	}
> +	opal_tb = kmalloc(sizeof(*opal_tb) * opal_num_tb, GFP_KERNEL);
> +	for (i = 0; i < opal_num_tb; i++)
> +		opal_tb[i] = __va(be64_to_cpu(traces[i*2]));

Just __va() ? ie. it's already in the linear mapping somewhere?

> +	debugfs_create_file("opal-trace", S_IRUSR, powerpc_debugfs_root,
> +			    NULL, &opal_trace_fops);
> +	rc = of_property_read_u64(opal_node, "ibm,opal-trace-mask",
> +				  &tmask_phys);
> +	if (!rc)
> +		opal_tmask_p = __va(tmask_phys);
> +	if (opal_tmask_p)

If tmask_phys was 0, opal_tmask_p is now 0xc00..00, so is that what we want to check?

> +		debugfs_create_file("opal-trace-mask", S_IRUSR | S_IWUSR,
> +				    powerpc_debugfs_root, opal_tmask_p,
> +				    &opal_tmask);
> +	return 0;
> +}
> +module_init(opal_trace_init);
> +

cheers
