Message-Id: <200004051909.VAA00311@piglet.grunz.lu>
Date: Wed, 5 Apr 2000 21:09:14 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: l2cr= command line and bogomips
To: linuxppc-dev@lists.linuxppc.org
cc: paulus@linuxcare.com
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-954961754=:310"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-954961754=:310
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi list,

For all those with G3-upgraded machines booting directly via OF, here
is a small patch that actually enables the 'l2cr=' kernel command line
option.

Paul, if you agree, can you add this to your tree? Thanks.

The code to handle the option was present; but it was never called. I've
also made it more secure when enabling the cache.

The main reason I wanted to have this as a command line option is to
get tha cache enabled _before_ calculating the bogomips value, in order
to get the delay loop calibrated for a correct value, which is not the
case if you enable the cache later only (via /proc/sys/kernel/l2cr).

However, I've noticed that in 2.3 the bogomips value is 'correct'
whether the cache is enabled or not, whereas in 2.2 it varies from
single to double without/with cache.

Any explanation? Is the loop tighter now, so it runs in L1? Does 2.3
always enable the cache (but how does it know the correct settings
then)?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-954961754=:310
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: l2cr-cmdline.diff

--- linux-2.3.paul/arch/ppc/kernel/setup.c	Tue Mar 21 06:12:14 2000
+++ linux/arch/ppc/kernel/setup.c	Wed Apr  5 20:58:33 2000
@@ -633,10 +633,14 @@
 	{
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
-		_set_L2CR(0);
-		_set_L2CR(val);
+		val |= 0x200000;		/* perform global invalidate */
+		_set_L2CR(0); 			/* disable cache */
+		_set_L2CR(val & ~0x80000000);	/* set cache parameters */
+		_set_L2CR(val);			/* and enable it */
 	}
 }
+
+__setup("l2cr=", ppc_setup_l2cr);

 void __init ppc_init(void)
 {

--134392852-1804289383-954961754=:310--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
