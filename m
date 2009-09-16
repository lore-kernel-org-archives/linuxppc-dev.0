Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 40B38B7B77
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 00:21:54 +1000 (EST)
Message-ID: <4AB0F07D.2080109@harris.com>
Date: Wed, 16 Sep 2009 10:04:45 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [Question] Does this oops point to a hardware bug?
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have built some custom hardware based on a PPC440EPx.  I saw
an oops that doesn't make much sense to me, so I'd like to ask
folks if this smells more like a hardware problem than a software
problem.

The oops is a signal 4 in kernel mode (trap 700).  If I'm
interpreting this correctly, it is a "program error", which
could be a privileged instruction trap, illegal instruction
trap, or unimplemented instruction trap.

Since this is in kernel mode, I wouldn't expect any of these
traps.

The other strange thing is the addresses.  NIP is 4c09e100, which
doesn't look like a kernel address.

So, I'm guessing that this exception happened in a user-space
program (SDEC-status) executing in kernel mode.  To me, that
feels like a hardware bug.

I've run some stand-alone memory tests, but they don't show any
problems.  This is an embedded system, so there is no swapping
to disk.  The kernel is stored in NOR flash, and copied to RAM
by uboot; modules are stored on a CF card in an ext3 file system.

Suggestions / theories gladly accepted. :-)

	Steve


Oops: Exception in kernel mode, sig: 4 [#1]
Hydra
Modules linked in: aemb audfpga hdird400_fe vpid saradec
aud_fpga_version vid_fpga_tse vid_fpga
NIP: 4c09e100 LR: 4c09e100 CTR: c001d710
REGS: ce84fea0 TRAP: 0700   Not tainted  (2.6.28.7)
MSR: 00029000 <EE,ME>  CR: 2409a024  XER: 20000001
TASK = ce804000[1162] 'SDEC-status' THREAD: ce84e000
GPR00: 4c09e100 ce84ff50 ce804000 c00c2908 c05bf860 cf043000 d7c8029c 00000000
GPR08: d7c8029c c00c2908 c03df000 001e0860 c009ab98 1005c1fc 00000004 cef4b580
GPR16: 4e900f78 fffffff7 cef4b900 00000000 ce84ff40 c009ac10 4e901098 4c09e0d8
GPR24: 00000000 00000000 0fb27883 4e901098 4c09e100 c000d870 00000000 00000000
NIP [4c09e100] 0x4c09e100
LR [4c09e100] 0x4c09e100
Call Trace:
[ce84ff50] [4c09e100] 0x4c09e100 (unreliable)
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 434a2d22c66cb1ce ]---

-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
