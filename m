Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0EACEDDDDB
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 05:13:01 +1000 (EST)
Date: Fri, 7 Sep 2007 14:13:19 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH v3] powerpc: Add workaround for MPICs with broken register
	reads
Message-ID: <20070907191319.GB6851@lixom.net>
References: <20070905024417.GE27139@lixom.net>
	<20070907092143.GB32102@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070907092143.GB32102@lixom.net>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some versions of PWRficient 1682M have an interrupt controller in which
the first register in each pair for interrupt sources doesn't always
read with the right polarity/sense values.

To work around this, keep a software copy of the register instead. Since
it's not modified from the mpic itself, it's a feasible solution. Still,
keep it under a config option to avoid wasting memory on other platforms.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 041df77..22a8fa9 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -137,6 +137,16 @@ config MPIC_U3_HT_IRQS
 	depends on PPC_MAPLE
 	default y
 
+config MPIC_BROKEN_REGREAD
+	bool
+	depends on MPIC
+	help
+	  This option enables a MPIC driver workaround for some chips
+	  that have a bug that causes some interrupt source information
+	  to not read back properly. It is safe to use on other chips as
+	  well, but enabling it uses about 8KB of memory to keep copies
+	  of the register contents in software.
+
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 95cd90f..117d90a 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -5,6 +5,7 @@ config PPC_PASEMI
 	select MPIC
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select MPIC_BROKEN_REGREAD
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 74c64c0..c0fe063 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -228,8 +228,13 @@ static inline u32 _mpic_irq_read(struct mpic *mpic, unsigned int src_no, unsigne
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
 
-	return _mpic_read(mpic->reg_type, &mpic->isus[isu],
-			  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	if (reg == 0)
+		return mpic->isu_reg0_shadow[idx];
+	else
+#endif
+		return _mpic_read(mpic->reg_type, &mpic->isus[isu],
+				  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -240,6 +245,11 @@ static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
 
 	_mpic_write(mpic->reg_type, &mpic->isus[isu],
 		    reg + (idx * MPIC_INFO(IRQ_STRIDE)), value);
+
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	if (reg == 0)
+		mpic->isu_reg0_shadow[idx] = value;
+#endif
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->reg_type,&(b),(r))
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 262db6b..c877fa7 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -309,6 +309,10 @@ struct mpic
 	unsigned long		*hwirq_bitmap;
 #endif
 
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	u32			isu_reg0_shadow[MPIC_MAX_IRQ_SOURCES];
+#endif
+
 	/* link */
 	struct mpic		*next;
 
