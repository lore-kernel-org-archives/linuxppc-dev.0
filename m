Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BCD18DDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 20:04:13 +1100 (EST)
Date: Thu, 11 Jan 2007 01:03:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
Message-Id: <20070111010358.851692fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: BSowislo@gmx.de,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Begin forwarded message:

Date: Thu, 11 Jan 2007 00:52:43 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot


http://bugzilla.kernel.org/show_bug.cgi?id=7808

           Summary: Xilinx ML403 does not boot
    Kernel Version: 2.6.19.1
            Status: NEW
          Severity: blocking
             Owner: platform_ppc-32@kernel-bugs.osdl.org
         Submitter: BSowislo@gmx.de


Most recent kernel where this bug did *NOT* occur:
I only tried out 2.6.19.1
Distribution:
kernel.org
Hardware Environment:
Xilinx ML403 board
Software Environment:
PPC crosscompiler on Centos linux i386
Problem Description:

a ramdom number (most likely 0x00000000)
is displayed as ramsize at the boot console:

Now booting the kernel

loaded at:     00400000 004DF13C
board data at: C01D16F8 C01D1710
relocated to:  00404040 00404058
zimage at:     00404E39 004DC857
avail ram:     004E0000 00000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...oops... out of memory
pause
done.
Now booting the kernel

reason:
board info is not returned from call to embed_config() in
arch/ppc/boot/simple/embed_config.c
caller: routine arch/ppc/boot/simple/misc_embedded.c, load_kernel()

first solution:
I removed the weak declaration of embed_config() in
arch/ppc/boot/simple/misc_embedded.c to force
the use of the procedure defined within 
arch/ppc/boot/simple/embed_config.c

Steps to reproduce:
use the arch/ppc/configs/ml403_defconfig as .config
for creating the kernel

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
