Message-Id: <200009031315.PAA00925@piglet.grunz.lu>
Date: Sun, 3 Sep 2000 15:15:45 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: PATCH: final version of l2cr cmd line
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1681692777-967986952=:867"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1681692777-967986952=:867
Content-Type: TEXT/plain; charset=us-ascii

Hi Paul,

Since BenH fixed the _set_L2CR() function, I have been able to shorten
the l2cr command line code. Attached is the patch vs. your current 2.4
rsync tree. I've not been able for a long time to boot a 2.4 kernel, but
it never crashed in this part ;-)

Anyway, all the patch does is to actually enable the processing of l2cr=
command lines.

Thanks for including this if you have no objection.

Cheers

Michel

PS Patch also posted to sourceforge.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1681692777-967986952=:867
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="l2cr.diff"

diff -uNr linux-2.4.paul/arch/ppc/kernel/setup.c linux/arch/ppc/kernel/setup.c
--- linux-2.4.paul/arch/ppc/kernel/setup.c	Tue Aug  8 07:46:33 2000
+++ linux/arch/ppc/kernel/setup.c	Sat Sep  2 11:26:13 2000
@@ -661,11 +661,13 @@
 	{
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
-		_set_L2CR(0);
-		_set_L2CR(val);
+		_set_L2CR(0); 		/* force invalidate by disable cache */
+		_set_L2CR(val);		/* and enable it */
 	}
 }

+__setup("l2cr=", ppc_setup_l2cr);
+
 void __init ppc_init(void)
 {
 	/* clear the progress line */

--134458388-1681692777-967986952=:867--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
