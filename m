Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 4360E2BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 09:24:23 +1000 (EST)
Date: Mon, 4 Oct 2004 16:24:11 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041004162411.B13777@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Sync ppcboot.h with U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This puts us back in sync with current U-Boot CVS tree
board info definition. Please apply.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== include/asm-ppc/ppcboot.h 1.8 vs edited =====
--- 1.8/include/asm-ppc/ppcboot.h	2004-07-29 06:08:44 -07:00
+++ edited/include/asm-ppc/ppcboot.h	2004-09-19 23:34:07 -07:00
@@ -30,20 +30,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
-typedef void (interrupt_handler_t)(void *);
-
-typedef struct monitor_functions {
-	int	(*getc)(void);
-	int	(*tstc)(void);
-	void	(*putc)(const char c);
-	void	(*puts)(const char *s);
-	void	(*printf)(const char *fmt, ...);
-	void	(*install_hdlr)(int, interrupt_handler_t *, void *);
-	void	(*free_hdlr)(int);
-	void	*(*malloc)(size_t);
-	void	(*free)(void *);
-} mon_fnc_t;
-
 typedef struct bd_info {
 	unsigned long	bi_memstart;	/* start of DRAM memory */
 	unsigned long	bi_memsize;	/* size	 of DRAM memory in bytes */
@@ -75,7 +61,7 @@
 	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
 #endif
 	unsigned long	bi_baudrate;	/* Console Baudrate */
-#if defined(CONFIG_405GP)
+#if defined(CONFIG_4xx)
 	unsigned char	bi_s_version[4];	/* Version of this structure */
 	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
 	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz */
@@ -86,12 +72,26 @@
 #if defined(CONFIG_HYMOD)
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_85xx)
-	/* the board has three onboard ethernet ports */
+#if defined(CONFIG_EVB64260) || defined(CONFIG_44x) || defined(CONFIG_85xx)
+	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
+#endif
+#if defined(CONFIG_EVB64260) || defined(CONFIG_440GX) || defined(CONFIG_85xx)
+	/* third onboard ethernet ports */
 	unsigned char	bi_enet2addr[6];
 #endif
-	mon_fnc_t	*bi_mon_fnc;	/* Pointer to monitor functions	*/
+#if defined(CONFIG_440GX)
+	/* fourth onboard ethernet ports */
+	unsigned char	bi_enet3addr[6];
+#endif
+#if defined(CONFIG_4xx)
+	unsigned int	bi_opbfreq;		/* OB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+#if defined(CONFIG_440GX)
+	int		bi_phynum[4];		/* phy mapping */
+	int		bi_phymode[4];		/* phy mode */
+#endif
 } bd_t;
 
 #endif /* __ASSEMBLY__ */
