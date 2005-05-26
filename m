Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 00341679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 May 2005 09:55:18 +1000 (EST)
Message-ID: <429511C8.1010205@mvista.com>
Date: Wed, 25 May 2005 17:01:12 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="------------030002000008030602090105"
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] MPC834x BCSR_SIZE too small for use in a BAT
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030002000008030602090105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
   The value of BCSR_SIZE (32K) in arch/ppc/platforms/83xx/mpc834x_sys.h 
is too small for a BAT (min 128K). The size is used in an 
io_block_mapping call to map the Board Control and Status Registers. 
Since there are no current dependencies on the result of the 
io_block_mapping call, it was removed as a solution to the problem 
rather than increasing the value of BCSR_SIZE. If access to the BCSR 
block is needed, it can easily be mapped via ioremap at the point of use.

             Randy Vinson

--------------030002000008030602090105
Content-Type: text/plain;
 name="bcsr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bcsr.patch"

MPC834x BCSR_SIZE too small for use in a BAT.

The call to io_block_mapping was creating an invalid BAT entry because
the value of BCSR_SIZE (32K) is too small to be used in a BAT (128K min).
This change removes the io_block_mapping call since these registers can
easily be mapped using ioremap at the point of use.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

---
commit 269bcdbf0a9f000400052b2da38348733dbfe88f
tree d10f5c31c29228a00a1a7551e3e825b439bfc741
parent 1b981021e88c8c28dc6a22cb1a327d8dc9296473
author Randy Vinson <rvinson@linuxbox.(none)> Wed, 25 May 2005 16:14:40 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Wed, 25 May 2005 16:14:40 -0700

 arch/ppc/platforms/83xx/mpc834x_sys.c |    1 -
 arch/ppc/platforms/83xx/mpc834x_sys.h |    1 -
 2 files changed, 2 deletions(-)

Index: arch/ppc/platforms/83xx/mpc834x_sys.c
===================================================================
--- 5eeefa658d7f9c13cd352994805ac3ead628b7e9/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
+++ d10f5c31c29228a00a1a7551e3e825b439bfc741/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
@@ -127,7 +127,6 @@
 {
 	/* we steal the lowest ioremap addr for virt space */
 	io_block_mapping(VIRT_IMMRBAR, immrbar, 1024*1024, _PAGE_IO);
-	io_block_mapping(BCSR_VIRT_ADDR, BCSR_PHYS_ADDR, BCSR_SIZE, _PAGE_IO);
 }
 
 int
Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- 5eeefa658d7f9c13cd352994805ac3ead628b7e9/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ d10f5c31c29228a00a1a7551e3e825b439bfc741/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -26,7 +26,6 @@
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
-#define BCSR_VIRT_ADDR		((uint)0xfe100000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
 #ifdef CONFIG_PCI

--------------030002000008030602090105--
