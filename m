Date: Sun, 28 Nov 1999 22:17:13 -0600
From: Shaw Terwilliger <sterwill@io.nu>
To: BenH <bh40@calva.net>
Cc: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org, dan@netx4.com,
        bregor@anusf.anu.edu.au
Subject: Re: 2.3.30-pre3
Message-ID: <19991128221713.A17532@io.nu>
References: <19991128154913.A15762@io.nu> <19991129000645.003441@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <19991129000645.003441@smtp.calvacom.fr>; from bh40@calva.net on Mon, Nov 29, 1999 at 12:06:45AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii

BenH wrote:
> Yes, please, send me your patches. Paul will be away for a few weeks and
> I want to move all my patches (there are more coming ;) to 2.3.x asap.

OK... here they are.  They're against paul's devel tree as of an hour
ago.  I'm running a fresh-built kernel from a tree with these applied;
everything's working well.

Besides being attached here, the individual patches (and the README) are
available at http://www.abisource.com/~sterwill/patches/.

If anyone else is interested in bulding the kernel, just grab the
devel tree and do "patch -p0 < all.patch" from /usr/src (assuming
the tree is /usr/src/linux).

-- 
Shaw Terwilliger (sterwill@io.nu)

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="all.patch"

--- linux.paul/CREDITS	Sat Oct 16 02:56:04 1999
+++ linux/CREDITS	Sun Nov 28 21:20:04 1999
@@ -1978,6 +1978,15 @@
 S: Seattle, WA  98195-1800
 S: USA
 
+N: Shaw Terwilliger
+E: sterwill@io.nu
+D: macintosh adb keyboard fixes
+D: ppc chipsfb misc fixes 
+D: misc hfs maintenance
+S: 1116 Broadmoor Drive #3
+S: Champaign, IL  61821
+S: USA
+
 N: Corey Thomas
 E: corey@world.std.com
 W: http://world.std.com/~corey/index.html
--- linux.paul/drivers/video/chipsfb.c	Sat Oct 16 05:05:00 1999
+++ linux/drivers/video/chipsfb.c	Sun Nov 28 20:25:32 1999
@@ -417,7 +417,7 @@
 	disp->visual = fix->visual;
 	disp->var = *var;
 
-#if (defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_FB_COMPAT_XPMAC))
+#if (defined(CONFIG_FB_COMPAT_XPMAC))
 	display_info.depth = bpp;
 	display_info.pitch = fix->line_length;
 #endif
--- linux.paul/fs/hfs/file.c	Thu Jul  1 00:01:54 1999
+++ linux/fs/hfs/file.c	Fri Nov  5 17:53:26 1999
@@ -498,7 +498,6 @@
 				written = -EFAULT;
 			break;
 		}
-		update_vm_cache(inode,pos,p,c);
 		pos += c;
 		written += c;
 		buf += c;
--- linux.paul/include/asm/keyboard.h	Sun Nov 28 19:31:57 1999
+++ linux/include/asm/keyboard.h	Sun Nov 28 19:45:46 1999
@@ -27,14 +27,32 @@
 #define DISABLE_KBD_DURING_INTERRUPTS	0
 #define INIT_KBD
 
+/* 
+ * I'm not a PPC keyboard driver expert, but one day kbd_init_hw()
+ * disappeared from this file (include/asm-ppc/keyboard.h), so I
+ * cloned it from a version found in a 2.2 kernel.  It works for me.
+ * - Shaw Terwilliger <sterwill@io.nu>
+ */
+
+static inline void kbd_init_hw(void)
+{
+#ifdef CONFIG_PREP
+	if (prep_kbd_present)
+#endif /* CONFIG_PREP */
+		ppc_md.kbd_init_hw();
+}
+
 static inline int kbd_setkeycode(unsigned int scancode, unsigned int keycode)
 {
+	/*
+	 * There used to be a stray "else" clause here that might
+	 * have been a left-over fragment from a copy-and-paste.
+	 * - Shaw Terwilliger <sterwill@io.nu>
+	 */
+	   
 	if ( ppc_md.kbd_setkeycode )
 		return ppc_md.kbd_setkeycode(scancode, keycode);
 	else
-		retureycode )
-		return ppc_md.kbd_setkeycode(scancode, keycode);
-	else
 		return 0;
 }
   
@@ -65,9 +83,16 @@
   
 static inline void kbd_leds(unsigned char leds)
 {
+	/*
+	 * The commented line below was, at one time, part of 
+	 * the code flow.  I've translated it to what I think its author
+	 * meant.
+	 * - Shaw Terwilliger <sterwill@io.nu>
+	 */
+
 	if ( ppc_md.kbd_leds )
-		ppc_md.kbd_ledt_hw )
-		ppc_md.kbd_init_hw();
+	/*	ppc_md.kbd_ledt_hw ) */
+		ppc_md.kbd_leds(leds);
 }
 
 #define kbd_sysrq_xlate	(ppc_md.ppc_kbd_sysrq_xlate)

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=README

Available here are patches to Paul Mackerras's latest (as of Sunday
November 28, 1999, CST) development (unstable) PPC Linux kernel mirror.
Get the code with "rsync -arvuz samba.anu.edu.au::linux-pmac-devel <tgtdir>"
where <tgtdir> is where you want your source tree to end up.

Then apply these patches:

all.patch:
	All of the below in one hunk.

chipsfb.c.patch:

	[linux/drivers/video/chipsfb.c]

	Changed chipsfb driver to store some display_info data only
	when CONFIG_FB_COMPAT_XPMAC is defined (and not as it was previously
	enabled--when _either_ CONFIG_PMAC_PBOOK or ...COMPAT_XPMAC).

	*** THIS PATCH IS UNTESTED *** ... I made these changes so I could
	compile chipsfb.c with my configuration, which enables 
	CONFIG_PMAC_PBOOK, but does not need Xpmac compatability.

hfs.file.c.patch:

	[linux/fs/hfs/file.c]

	Synced hfs code with code from Linus's 2.3.28 tree, which simply
	removes the call to update_vm_cache().

	*** HFS SEEMS BROKEN *** ... HFS works for _simple_ operations	
	with the kernels built from this code.  Mounts (ro and rw) work,
	file cp works, things like mv do NOT.  Don't try it unless you 
	really like xmon.

	I don't know if HFS has just been neglected through kernel 2.3,
	or if it's been this way for a while.

keyboard.h.patch:

	[linux/include/asm-ppc/keyboard.h]

	My version of this file came in just about half-baked.
	Added missing kbd_init_hw() function, cleaned up some
	stray chunks of code elsewhere in the file.

CREDITS.patch:

	Just tacked myself in there for the changes to keyboard and
	HFS, both of which I'd like to devote some of my time to 
	make work reliably on my PowerBook.  :)


--jI8keyz6grp/JLjh--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
