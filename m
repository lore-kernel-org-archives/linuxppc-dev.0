From: phandel@cise.ufl.edu
Date: Mon, 28 Feb 2000 21:58:26 -0500 (EST)
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Powerbook code in 2.3.x [was Re: problem building 2.3.47: no
 macintosh.a file]
In-Reply-To: <38BB28DD.BE1E320E@chpc.utah.edu>
Message-ID: <Pine.LNX.4.21.0002282145380.14383-100000@adsl-78-160-189.gnv.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Feb 2000, Lou Langholtz wrote:

> undefined references are to: find_via_pmu, pmu_poll, backlight_level,
> pmu_set_brightness, and vgacon_remap_base.

This is because there is Powerbook code without #ifdef CONFIG_PMAC_PBOOK
around it.  Here is a quick patch:

====================================================================

--- old_mac_keyb.c	Sun Feb 27 23:15:16 2000
+++ mac_keyb.c	Sun Feb 27 23:18:24 2000
@@ -586,7 +586,9 @@
 #endif /* CONFIG_ADBMOUSE */

 /* XXX Needs to get rid of this, see comments in pmu.c */
+#ifdef CONFIG_PMAC_PBOOK
 extern int backlight_level;
+#endif

 static void
 buttons_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
@@ -628,6 +630,7 @@
 		case 0xa:
 			/* down event */
 #ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC_PBOOK
 			if ( data[1] == (data[1]&0xf) ) {
 				if (backlight_level > 2)
 					pmu_set_brightness(backlight_level-2);
@@ -635,17 +638,20 @@
 					pmu_set_brightness(0);
 			}
 #endif
+#endif
 			break;
 		/* brightness increase */
 		case 0x9:
 			/* down event */
 #ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC_PBOOK
 			if ( data[1] == (data[1]&0xf) ) {
 				if (backlight_level < 0x1e)
 					pmu_set_brightness(backlight_level+2);
 				else
 					pmu_set_brightness(0x1f);
 			}
+#endif
 #endif
 			break;
 	}

====================================================================


Thanks,
Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
