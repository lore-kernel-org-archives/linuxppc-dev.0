Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id AD690DE45B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 04:51:52 +1100 (EST)
Date: Thu, 25 Jan 2007 18:51:50 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
In-Reply-To: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PS3: Cleanup the frame buffer device before clearing the HPTE mapping

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/htab.c |    5 +++++
 1 files changed, 5 insertions(+)

--- ps3-linux.orig/arch/powerpc/platforms/ps3/htab.c
+++ ps3-linux/arch/powerpc/platforms/ps3/htab.c
@@ -234,6 +234,11 @@ static void ps3_hpte_invalidate(unsigned
 
 static void ps3_hpte_clear(void)
 {
+	extern void ps3fb_cleanup(void);
+
+#ifdef CONFIG_FB_PS3
+	ps3fb_cleanup();
+#endif
 	lv1_unmap_htab(htab_addr);
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
