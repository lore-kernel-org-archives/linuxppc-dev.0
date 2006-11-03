Return-Path: <philn@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5550D67C71
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 17:06:46 +1100 (EST)
Received: from lamorak.int.avalon.com.au (lamorak.int.avalon.com.au
	[192.168.1.46])
	by camden.avalon.com.au (8.13.1/8.13.1) with ESMTP id kA35lsVm029657
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Nov 2006 16:17:58 +1030
Subject: kernel oops in m41t00 rtc routines
From: Phil Nitschke <philn@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 03 Nov 2006 16:17:53 +1030
Message-Id: <1162532873.4199.50.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Some time ago we built a 2.6.17, then a 2.6.18 kernel for our 7448
PowerPC processor using source from kernel.org.  However we've suffered
from the following problem whenever the m41t00 code is accessed:

kernel: Oops: kernel access of bad area, sig: 11 [#1]
kernel: NIP: C012DA14 LR: C010B944 CTR: 00000000
kernel: REGS: efd9dd50 TRAP: 0300   Not tainted  (2.6.18-pmppc744x)
kernel: MSR: 00009032 <EE,ME,IR,DR>  CR: 28002488  XER: 00000000
kernel: DAR: 00000004, DSISR: 40000000
kernel: TASK = efd720b0[55] 'hwclock' THREAD: efd9c000
kernel: GPR00: 00000000 EFD9DE00 EFD720B0 EFD9DE94 00000000 00000000 EFD9DEB4 0FF70500 
kernel: GPR08: 40247009 00000000 00000001 EFD8D360 88002488 1001E7F8 00000000 7FF5E6D0 
kernel: GPR16: 00000000 00000000 10010000 00000000 EFD9DE14 C0240000 00000000 00000000 
kernel: GPR24: 00000000 C024400A 0006E919 40247009 FFFFFFF7 EFCFF960 EFD9DE94 EFD9DE09 
kernel: NIP [C012DA14] m41t00_get_rtc_time+0x30/0x268
kernel: LR [C010B944] gen_rtc_ioctl+0xb8/0x338
kernel: Call Trace:
kernel: [EFD9DE00] [EFCFF960] 0xefcff960 (unreliable)
kernel: [EFD9DE70] [C010B944] gen_rtc_ioctl+0xb8/0x338
kernel: [EFD9DED0] [C00760D0] do_ioctl+0x80/0x84
kernel: [EFD9DEE0] [C0076160] vfs_ioctl+0x8c/0x418
kernel: [EFD9DF10] [C007652C] sys_ioctl+0x40/0x74
kernel: [EFD9DF40] [C0004460] ret_from_syscall+0x0/0x38
kernel: Instruction dump:
kernel: 7c0802a6 9421ff90 be810040 3ea0c024 39400001 3be10009 90010074 38000000 
kernel: 81356718 3a810014 98010008 38000000 <a1690004> 39210008 b0010016 38000008 


We have modified the kernel using a series of patches we've developed
here over time.  However, other than adding marvell DMA support, the
patches mostly just create a 'platform' file for the PmPPC7448, which is
almost identical to arch/ppc/platforms/katana.c, so I'm guessing that
(a) the patches we're applying aren't the problem, and (b) the katana
board would suffer the same problem.  

I also suspect the M41T00 RTC I2C Client Driver was re-written about the
time that we started seeing problems being introduced...

Has anyone else used recent kernels on these platforms?

Thanks for any suggestions you can offer,

-- 
Phil
