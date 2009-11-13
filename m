Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83505.mail.sp1.yahoo.com (web83505.mail.sp1.yahoo.com
	[216.252.120.161]) by ozlabs.org (Postfix) with SMTP id ACAA5B6EDF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:07:02 +1100 (EST)
Message-ID: <705994.38950.qm@web83505.mail.sp1.yahoo.com>
Date: Fri, 13 Nov 2009 11:07:00 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Bus Error on MPC8313
To: linuxppc-dev@ozlabs.org
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

I wrote a custom driver for an MPC8313 based board.  Everything seems to
have been working for a long time, but now one of my IOCTL functions seems
to be having a problem.  I'm getting a "Bus error" reported by my
application and also a kernel "Oops".  Here's what the kernel is reporting. 

Oops: Machine check, sig: 7 [#1]
MPC831x RDB
Modules linked in: simpc
NIP: e10687d8 LR: e106880c CTR: 00000001
REGS: dfbcbdd0 TRAP: 0200   Not tainted  (2.6.27)
MSR: 00041000 <ME>  CR: 28000424  XER: 20000000
TASK = df864400[795] 'sisample.out' THREAD: dfbca000
GPR00: ff0865a9 dfbcbe80 df864400 00000000 bfdd47f8 00000014 dfbcbeb8 00080400
GPR08: bfdd4880 e1070000 00000000 e1180400 88000428 1005ecbc 1fffb000 00000000
GPR16: 1fff06e8 1fff5a30 00000000 100b3e7c 100a6358 100fb364 bf8d95b8 00000000
GPR24: 4800e71c 00000001 bfe51e74 dfbb2380 fffffff7 40047217 dfbb2380 dfbcbea8
NIP [e10687d8] SIMPC_TargetRead+0xc8/0x198 [simpc]
LR [e106880c] SIMPC_TargetRead+0xfc/0x198 [simpc]
Call Trace:
[dfbcbe80] [22000000] 0x22000000 (unreliable)
[dfbcbea0] [e1068368] SIMPC_ioctl+0x104/0x260 [simpc]
[dfbcbed0] [c00857b0] vfs_ioctl+0x94/0x98
[dfbcbee0] [c0085aac] do_vfs_ioctl+0x2f8/0x428
[dfbcbf10] [c0085c1c] sys_ioctl+0x40/0x74
[dfbcbf40] [c0011cec] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfc99b10
    LR = 0xfd4d8a8
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX 2b830001 XXXXXXXX XXXXXXXX XXXXXXXX 7d4903a6
XXXXXXXX XXXXXXXX XXXXXXXX 800b0000 XXXXXXXX XXXXXXXX XXXXXXXX 396b0004
---[ end trace faf66608f10b7074 ]---
Bus error

I'm not convinced that this is a problem with the driver as it has been
functioning without this problem for a while on our first two revisions of
hardware.  This problem is happening on new hardware, but everything seems
to work fine on the new hardware for a while (an hour or so) and then this
begins to happen.

Does anyone have any thoughts or ideas?  Let me know if you need a bit
more information.  Thanks in advance for any response.

Ron
