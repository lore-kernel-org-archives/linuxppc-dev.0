Date: Sun, 21 Jan 2001 14:40:57 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: [patch] missing exported symbols
Message-ID: <20010121144057.A27643@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

I had to add these two symbol exports to this file.

The first one I have noticed was not available for the last few weks or so
of 2.4.0 and 2.4.0-pre kernels. The second one I only noticed today when I
tried to build the gmac as a module.

The first one I am pretty sure belongs in this file as i have noticed a few
other archs have to export it here.

The gmac one i am unsure if this is the best place to put the export, but it
works so I put it here.

Most if not all filesystems need the flush_dcache_page exported if they are
built as modules. The gmac thing needs to be exported if gmac is built as a
module.

This is from a paulus 2.4.0 rsynced yesterday (saturday AEST).

--- old/linux-pmac-devel/arch/ppc/kernel/ppc_ksyms.c    Tue Jan  9 14:49:03 2001
+++ linux-pmac-devel/arch/ppc/kernel/ppc_ksyms.c        Sun Jan 21 13:07:08 2001
@@ -364,3 +364,7 @@
 EXPORT_SYMBOL_NOVERS(__no_use_restore_flags);
 EXPORT_SYMBOL_NOVERS(__no_use_save_flags);
 #endif
+
+/* needed by some modules */
+EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(feature_set_gmac_phy_reset);

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
