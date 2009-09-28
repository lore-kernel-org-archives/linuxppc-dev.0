Return-Path: <anton@ozlabs.org>
Date: Mon, 28 Sep 2009 17:45:03 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: 64bit kernel is huge
Message-ID: <20090928074503.GB16073@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I've found at least one machine that wont boot 2.6.31-rc* with a 
pseries_defconfig. If I move real-base from 0xc00000 to 0xd00000 it
boots fine.

# size vmlinux
   text	   data	    bss	    dec	    hex	filename
9812942	1982496	1105228	12900666	 c4d93a	vmlinux

Looks like we blow right through the 12MB mark. It desperately needs to eat
less and lose weight.

Here are some of the problem areas:

788224  kallsyms_names
537600  kallsyms_addresses

I guess mostly CONFIG_KALLSYMS_ALL.

262144  kstat_irqs_all
131072  irq_desc
16384   irq_stat

Could we dynamically allocate our irq structures?

151912  __start_mcount_loc
131076  map_pid_to_cmdline

ftrace stuff. With a name like map_pid_to_cmdline I'm pretty sure I'm not
going to like what it does.

131072  lppaca
65536   paca

I think we've attacked these before, not sure if there is anything left
we can trim.

131072  __log_buf

Looks like we can dynamically allocate a large log buf at runtime. Perhaps
we should default to a small log_buf and grow it at boot based on machine size
(eg max cpus).

101160  powerpc_opcodes

xmon instruction disassembly. I'd probably prefer to cut off my right hand and
debug one handed before losing this though.

87600   __start___bug_table

Can't do much about this.

77452   _fw_acenic_tg2_bin_bin

We could probably change acenic to be a module, 

46464   kmalloc_caches
32768   read_buffers
32768   mem_section
21816   hstates
20480   node_devices
14336   bootmem_node_data

mm stuff.

32096   _fw_tigon_tg3_tso5_bin_name
12184   .tg3_reset_hw
10124   .tg3_get_invariants

tg3

20804   .radeonfb_pm_init
18412   .radeon_pm_disable_dynamic_mode
15280   .radeon_write_mode

Radeon

26288   __start___ex_table
22632   PPC64_CACHES
20564   alg_test_descs
17784   ioctl_start
16384   xics_ipi_message
16384   vdso64_end
16384   stateid_hashtbl
16384   raw_devices
16384   lockstateid_hashtbl
16384   kexec_stack
16384   init_thread_union
16384   boot_pageset
15360   latency_record
14880   .do_balance
14008   .hidinput_connect
11920   kernel_config_data
10240   futex_queues
10044   .e1000_init_hw

Anton
