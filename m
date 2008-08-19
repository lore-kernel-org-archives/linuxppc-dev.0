Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id 71B31DEB43
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 23:02:43 +1000 (EST)
Received: from toip6.srvr.bell.ca ([209.226.175.125])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080819130241.SWCD1572.tomts5-srv.bellnexxia.net@toip6.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 09:02:41 -0400
Date: Tue, 19 Aug 2008 09:02:16 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080819130216.GA18001@Krystal>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<20080818184158.GA1798@Krystal> <48AA98E4.6060606@extricom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48AA98E4.6060606@extricom.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Eran Liberty (liberty@extricom.com) wrote:
> Mathieu Desnoyers wrote:
>> Can you check if, at some point during the system execution (starting
>> from boot), 0xdd5b1d58 is an address where a module is loaded ? (the
>> module can be later unloaded, what I wonder is if this address would
>> appear to have had a loaded+unloaded module).
>>
>> Actually, could you try to compile your kernel without "MODULE_UNLOAD" ?
>>
>> Mathieu
>>   
> No modules...
>
> ~ # uname -a
> Linux 2.6.27-rc2 #6 Tue Aug 19 12:33:34 IDT 2008 ppc unknown
> ~ # gunzip /proc/config.gz -c | grep UNLOAD
> # CONFIG_MODULE_UNLOAD is not set
> ~ # gunzip /proc/config.gz -c | grep FTRACE
> CONFIG_HAVE_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_FTRACE=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_FTRACE_SELFTEST=y
> CONFIG_FTRACE_STARTUP_TEST=y
> ~ # gunzip /proc/config.gz -c | grep MARKERS
> CONFIG_MARKERS=y
> ~ # lsmod
> Module                  Size  Used by
> ~ # while [ 1 ] ; do find / > /dev/null ; echo .  ; done
> .
> Oops: Exception in kernel mode, sig: 11 [#1]
> Exsw1600
> Modules linked in:
> NIP: c00bb724 LR: c00bb724 CTR: 00000000
> REGS: d8b59c50 TRAP: 0700   Not tainted  (2.6.27-rc2)
> MSR: 00029000 <EE,ME>  CR: 24082282  XER: 20000000
> TASK = dbc68de0[1712] 'find' THREAD: d8b58000
> GPR00: 00000000 d8b59d00 dbc68de0 dd801180 d8b59d68 d8b59d58 dd8019db 
> 100234ec
> GPR08: c0800000 00019330 0000ffff d8b59d20 24000288 100ad874 100936f8 
> 1008a1d0
> GPR16: 10083f80 d8b59e2c d8b59d68 fffffff4 c0380000 d8b59d60 d8b59d58 
> dd802084

Register GPR30 is always zero... (also true for the other oops)

> GPR24: ddc69500 dd802018 d8b59d68 c0380000 dd801180 d8b59d68 00000000 
> d8b59d00
> NIP [c00bb724] d_lookup+0x40/0x90
> LR [c00bb724] d_lookup+0x40/0x90
> Call Trace:
> [d8b59d00] [d8b59d58] 0xd8b59d58 (unreliable)
> [d8b59d20] [c00ae7c8] do_lookup+0xe8/0x220
> [d8b59d50] [c00b0684] __link_path_walk+0x5a4/0xd54
> [d8b59dc0] [c00b0e8c] path_walk+0x58/0xe0
> [d8b59df0] [c00b0ffc] do_path_lookup+0x78/0x13c
> [d8b59e20] [c00b1cf8] user_path_at+0x64/0xac
> [d8b59e90] [c00a8c98] vfs_lstat_fd+0x34/0x74
> [d8b59ec0] [c00a8d6c] vfs_lstat+0x30/0x48
> [d8b59ed0] [c00a8db4] sys_lstat64+0x30/0x5c
> [d8b59f40] [c0010554] ret_from_syscall+0x0/0x3c
> Instruction dump:
> 7c0802a6 bf61000c 3f60c038 7c3f0b78 90010024 7c7c1b78 7c9d2378 83db32a0

Just like this instruction... maybe related ?

Mathieu

> 73c00001 7f83e378 7fa4eb78 4082002f <00000000> 2f830000 409e0030 801b32a0
> ---[ end trace 7766edd310cd3442 ]---
>

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
