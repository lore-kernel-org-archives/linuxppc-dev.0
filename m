Date: Thu, 20 Nov 2003 21:51:37 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
Subject: Fix for BAT mapping calculation
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="134458388-1804289383-1069361497=:1062"
Message-Id: <E1AMvm6-0000Ia-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-1069361497=:1062
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE

Hi,

The attached patch fixes a cosmetic problem with displaying the
RAM-to-BAT mapping on kernel start.

Please apply to 2.4 kernels (don't know whether 2.6 has the same bug).

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
--134458388-1804289383-1069361497=:1062
Content-Type: TEXT/PLAIN; NAME="pgtable.c.diff"
Content-Disposition: ATTACHMENT; FILENAME="pgtable.c.diff"

--- arch/ppc/mm/pgtable.c.orig	Thu Nov 20 21:42:39 2003
+++ arch/ppc/mm/pgtable.c	Thu Nov 20 21:43:00 2003
@@ -238,7 +238,7 @@

 	printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb,"
 			" residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
-			(total_memory - (__bat2 - __bat3)) >> 20);
+			(total_memory - (__bat2 + __bat3)) >> 20);

 	/* On SMP, we limit the lowmem to the area mapped with BATs.
 	 * We also assume nobody will do SMP with 601s

--134458388-1804289383-1069361497=:1062--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
