Return-Path: <dwilder@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D89CE67A07
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 09:43:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k44Ngu2K022759
	for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2006 19:42:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k44NguVJ187276
	for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2006 17:42:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k44Nguwr031622
	for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2006 17:42:56 -0600
Received: from [9.67.81.69] ([9.67.81.69])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k44Ngtkx030947
	for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2006 17:42:56 -0600
Message-ID: <445A9B5C.1020504@us.ibm.com>
Date: Thu, 04 May 2006 17:25:00 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Hang in die() when using NMI soft-reset
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am debugging problem found in during kdump testing on a power 5 system 
2.6.16.   Maybe someone has some ideas?

I am generating an NMI from the firmware.   Each cpu responds to the NMI 
and  calls system_reset_exception() -> 
die()->show_regs()->show_instructions().   Sometimes the cpu will hang 
in show_instructions().  Since the cpu is holding the die_lock() any 
cpus that have not already run die() waits on the lock forever.    In 
show_instructions() a call is made to might_sleep().  The only reason I 
can see for it to sleep would be if it takes page or SLB fault?

I have not yet tested other fault paths that call die for the problem.

Oops: System Reset, sig: 6 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR
Modules linked in: crasher ipv6 apparmor aamatch_pcre loop dm_mod ide_cd 
cdrom e1000 sg ipr firmware_class pdc202xx_new sd_mod scsi_mod
NIP: C000000000028AC0 LR: C000000000028AA0 CTR: 800000000014DCD0
REGS: c0000000e84a3250 TRAP: 0100   Tainted: G     U  
(2.6.16.9-20060423154214-ppc64)
MSR: 8000000000089032 <EE,ME,IR,DR>  CR: 24448428  XER: 00000000
TASK = c00000000f854340[2747] 'hald-addon-stor' THREAD: c0000000e84a0000 
CPU: 0
GPR00: 0000000000000002 C0000000E84A34D0 C00000000062ECE8 0000000000000080
GPR04: 0000000000000080 0000000000000080 8000000000C24393 0000000000000002
GPR08: 0000000000000004 C000000000633E88 C000000000634090 000000B1044EAA9E
GPR12: 0000000000004000 C000000000492E80 0000000010000000 0000000010000000
GPR16: 0000000010000000 0000000010002EF0 0000000010000000 0000000010000000
GPR20: 00000000FFF3E15C 0000000000000800 00000000FFF3E1C4 0000000000000001
GPR24: C0000000EA4E8C18 C0000000EA4E8CC0 C0000000E6886380 C0000000EA4E8CC0
GPR28: C0000000EA4E8C00 C0000000EA4E8C00 0000000000000001 0000000000000003
NIP [C000000000028AC0] .smp_call_function+0xd8/0x1c8
LR [C000000000028AA0] .smp_call_function+0xb8/0x1c8
Call Trace:
[C0000000E84A34D0] [C000000000028AA0] .smp_call_function+0xb8/0x1c8 
(unreliable)
[C0000000E84A3570] [C0000000000CA00C] .invalidate_bdev+0x30/0x64
[C0000000E84A3600] [C0000000000EAAF8] .__invalidate_device+0x5c/0x80
[C0000000E84A3690] [C0000000000D231C] .check_disk_change+0x68/0xec
[C0000000E84A3720] [D00000000032DBF0] .cdrom_open+0xb14/0xb80 [cdrom]
[C0000000E84A3940] [D0000000002D1700] .idecd_open+0x128/0x19c [ide_cd]
[C0000000E84A39E0] [C0000000000D2940] .do_open+0x11c/0x5c4
[C0000000E84A3AA0] [C0000000000D30B0] .blkdev_open+0x38/0x88
[C0000000E84A3B30] [C0000000000C47D8] .__dentry_open+0x160/0x300
[C0000000E84A3BE0] [C0000000000C4AEC] .do_filp_open+0x50/0x70
[C0000000E84A3D00] [C0000000000C4B80] .do_sys_open+0x74/0x12c
[C0000000E84A3DB0] [C0000000001017A0] .compat_sys_open+0x24/0x38
[C0000000E84A3E30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump: pc=0xc000000000028a90
#1 pc = 0xc000000000028a90 i=0


-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789
