Message-Id: <200108191003.MAA00874@piglet.grunz.lu>
Date: Sun, 19 Aug 2001 12:03:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: About TAU
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-998215473=:840"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-998215473=:840
Content-Type: TEXT/plain; charset=us-ascii

Hi there,

Attached is a small patch that 'beautifies' the TAU options in the
kernel configuration (proper indent for TAU's suboptions). Ben, Paul,
could you push that part?

Also, Troy, would you mind adding a Config.help text for the TAU
options? I agree it's WIP and not all done yet; but at least we should
document that then ;-) It seems to me in PPC land we have the bad habit
of never providing Config.help texts... It's not done initially, and
when the feature stabilizes, it gets pushed to Linus without help texts
and stays that way forever. (hint, hint to all that haven't done the
help texts ;-)

Something else about an eventual TAU usage: Troy writes '...use cpu load
(from scheduler) and ICTC to extend battery life...'. That could
probably be done via something like i386's kapm_idled (kernel thread to
burn cycles efficiently, basically). Does that sound feasible?

Anybody know of any adverse effects of using ICTC to slow the CPU?
Bogompis and the kernel delay loop come to mind; don't know whether
those would need to be adjusted... which would be quite difficult, I
guess.

Ideas?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-998215473=:840
Content-Type: TEXT/plain; name="tau.diff"
Content-Disposition: attachment; filename="tau.diff"

--- /usr/src/sources/2.4/linux-2.4.benh/arch/ppc/config.in	Fri Aug 17 21:37:48 2001
+++ arch/ppc/config.in	Sun Aug 19 09:43:31 2001
@@ -160,8 +160,8 @@
   bool 'AltiVec Support' CONFIG_ALTIVEC
   bool 'Thermal Management Support' CONFIG_TAU
   if [ "$CONFIG_TAU" = "y" ]; then
-    bool 'Interrupt driven TAU driver (DANGEROUS)' CONFIG_TAU_INT
-    bool 'Average high and low temp' CONFIG_TAU_AVERAGE
+    bool '    Interrupt driven TAU driver (DANGEROUS)' CONFIG_TAU_INT
+    bool '    Average high and low temp' CONFIG_TAU_AVERAGE
   fi
 fi


--134458388-1804289383-998215473=:840--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
