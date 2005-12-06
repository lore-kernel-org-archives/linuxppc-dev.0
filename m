Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.206])
	by ozlabs.org (Postfix) with ESMTP id 4AEC568896
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:50:48 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so54714nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 13:50:48 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>, linuxppc-embedded@ozlabs.org
Date: Tue, 6 Dec 2005 23:58:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512062358.44661.pantelis.antoniou@gmail.com>
Subject: [PATCH] ppc32-8xx: Generic pin interface
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx pin generic interface.

---
commit 978475b1cf2b5b060bd07321ec482918966ac20b
tree b6b43444da43746669759d7313012e058fe658c5
parent 83f5e0be8db948f28442dd279f6472bd3367ea45
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:16:45 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:16:45 +0200

 include/asm-ppc/8xx_pin.h |  206 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 206 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/8xx_pin.h b/include/asm-ppc/8xx_pin.h
new file mode 100644
--- /dev/null
+++ b/include/asm-ppc/8xx_pin.h
@@ -0,0 +1,206 @@
+/*
+ * A way to access fast the PORT pins of 8xx systems.
+ *
+ * Copyright (c) 2005 Pantelis Antoniou <pantelis.antoniou@gmail.com>
+ *                    Dan Malek <dan@embeddedalley.com>
+ *
+ */
+#ifndef __8XX_PIN_H
+#define __8XX_PIN_H
+
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+
+/*
+
+   A few words about this. Yes the macros are a bit weird and hard to follow
+   but it is done for two reasons.
+
+   1) The implementation is very fast. The resulting set & clr port bit code
+      is the minimal possible. One load, one and/or, one store.
+
+   2) The pin definition for each pin is quite clear.
+
+   For example let's take two pins called RXD, TXD.
+   They are connected to PC6 & PE12.
+
+   We define them as simply:
+
+     #define RXD_PORT PORTC
+     #define RXD_BIT  6
+
+     #define TXD_PORT PORTE
+     #define TXD_BIT  12
+
+   To configure RXD as an input, and TXD as an output do:
+
+     _PIN_CFG_IN(RXD)
+     _PIN_CFG_OUT(TXD)
+
+   To read RXD do:
+
+     _PIN_GET(RXD)
+
+   To set TXD do:
+
+     _PIN_SET(TXD, 0|1)
+
+   Please take note that we assume that IMAP_ADDR is a constant define.
+   This code will *not* work with ioremaped IMAP.
+
+*/
+
+/********************************************************************************/
+
+/* shorthand for the ports data registers */
+#define PORTA		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat)
+#define PORTB		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat)
+#define PORTC		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pcdat)
+#define PORTD		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pddat)
+#define PORTE		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pedat)
+
+/********************************************************************************/
+
+#define PIN_PORT_EQ(p, x)	((void *) & x ## _PORT == (void *) & p)
+#define PIN_PORT_NE(p, x)	((void *) & x ## _PORT != (void *) & p)
+
+#define PIN_PORT_RW(x)		(PIN_PORT_NE(PORTXWO, x) && PIN_PORT_NE(PORTXRO, x))
+#define PIN_PORT_RO(x)		PIN_PORT_EQ(PORTXRO, x)
+#define PIN_PORT_WO(x)		PIN_PORT_EQ(PORTXWO, x)
+
+/********************************************************************************/
+
+#define PIN_SFT(x) ((sizeof(x ## _PORT) * 8 - 1) - x ## _BIT)
+#define PIN_MSK(x) (1U << PIN_SFT(x))
+
+/********************************************************************************/
+
+/* normal m8xx pins */
+#define _PIN_HI(x) \
+	do { \
+		x ## _PORT |=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_LO(x) \
+	do { \
+		x ## _PORT &= ~PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_TGL(x) \
+	do { \
+		x ## _PORT ^=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_GET(x) \
+	(!!(x ## _PORT & PIN_MSK(x)))
+
+#define _PIN_SET(x, v)	\
+	do { \
+		if (__builtin_constant_p(v)) { \
+			if ((v) != 0) \
+				_PIN_HI(x); \
+			else \
+				_PIN_LO(x); \
+		} else \
+			x ## _PORT = ( x ## _PORT & ~PIN_MSK(x)) | (!!(v) << PIN_SFT(x)); \
+	} while(0)
+
+#define _PIN_CFG_IN(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_ANY(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_FALL(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT(x, v) \
+	do { \
+		_PIN_SET(x, v); \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(0, PIN_MSK(x), 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT_HI(x) _PIN_CFG_OUT(x, 1)
+#define _PIN_CFG_OUT_LO(x) _PIN_CFG_OUT(x, 0)
+
+#ifndef __ASSEMBLY__
+
+static inline void PORTA_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_padir  = (imap->im_ioport.iop_padir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_paodr &= ~msk;
+	imap->im_ioport.iop_papar &= ~msk;
+}
+
+static inline void PORTB_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pbdir  = (imap->im_cpm.cp_pbdir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_pbodr &= ~msk;
+	imap->im_cpm.cp_pbpar &= ~msk;
+}
+
+static inline void PORTC_config(uint inmsk, uint outmsk, uint fallmsk)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pcdir  = (imap->im_ioport.iop_pcdir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pcso  &= ~msk;
+	imap->im_ioport.iop_pcint  = (imap->im_ioport.iop_pcint & ~(ushort)inmsk) | ((ushort)fallmsk & (ushort)inmsk);
+	imap->im_ioport.iop_pcpar &= ~msk;
+}
+
+static inline void PORTD_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pddir  = (imap->im_ioport.iop_pddir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pdpar &= ~msk;
+}
+
+static inline void PORTE_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pedir  = (imap->im_cpm.cp_pedir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_peodr &= ~msk;
+	imap->im_cpm.cp_pepar &= ~msk;
+}
+
+#endif /* __ASSEMBLY */
+
+#endif
