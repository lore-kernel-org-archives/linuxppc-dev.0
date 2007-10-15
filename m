Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E7C5DDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:08:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9FB8cNI012852
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:08:38 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9FB8eeP590034
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:08:40 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9FB8NJI011985
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:08:24 +1000
Message-ID: <47134A1B.8000001@linux.vnet.ibm.com>
Date: Mon, 15 Oct 2007 16:38:11 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Linux 2.6.23.1 - Open Firmware exception handler invoked
References: <20071012170140.GA18498@kroah.com>
In-Reply-To: <20071012170140.GA18498@kroah.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The Open Firmware exception handler is begin invoked, on power5 lpar.

boot: 2.6.23.1
Please wait, loading kernel...
Allocated 03500000 bytes for kernel @ 01c00000
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded 0020d000 @ 06b00000
DEFAULT CATCH!, exception-handler=fff00300 
at   %SRR0: c00000000202705c   %SRR1: 8000000000003002 
Open Firmware exception handler entered from non-OF code

Client's Fix Pt Regs:
 00 0223100003080000 00000000018bfac0 0000000004bbeaf8 00000000018bfb48
 04 00000000018bfc90 0000000000c39a48 0000000000000000 5c3a03080000a0fa
 08 0000000000000001 0000000000000000 05910000194c0223 000000005cae0000
 0c 0000000003f1eaf8 0000000000000000 0000000000000000 0000000000000000
 10 0000000000000000 0000000000c39a48 0000000000000000 00000000018bfc90
 14 0000000000c00000 000000000020d000 0000000000000000 0000000008b00000
 18 0000000000280004 00000000018bff04 0000000000000001 0000000000000000
 1c 0000000008b00000 0000000000c39a48 c000000004d1e530 0000000008b00000
Special Regs:
    %IV: 00000300     %CR: 44000028    %XER: 00000000  %DSISR: 08000000 
  %SRR0: c00000000202705c   %SRR1: 8000000000003002 
    %LR: c000000002027428    %CTR: c0000000020273f0 
   %DAR: 05910000194c02eb 
Virtual PID = 0 
PFW: Unable to send error log!
 ofdbg
0 > 

# cat /proc/cpuinfo 
processor       : 0
cpu             : POWER5+ (gs)
clock           : 1498.500000MHz
revision        : 2.0 (pvr 003b 0200)

processor       : 1
cpu             : POWER5+ (gs)
clock           : 1498.500000MHz
revision        : 2.0 (pvr 003b 0200)

timebase        : 187199000
platform        : pSeries
machine         : CHRP IBM,9133-55A
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
