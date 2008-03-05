Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA235DDF32
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:21:50 +1100 (EST)
Date: Wed, 05 Mar 2008 17:21:43 +0900 (JST)
Message-Id: <20080305.172143.-1350505489.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 1/11] celleb: coding style cleanup
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---
 arch/powerpc/platforms/celleb/beat.c         |   17 +++++++----------
 arch/powerpc/platforms/celleb/beat.h         |    4 ++--
 arch/powerpc/platforms/celleb/beat_wrapper.h |    3 ++-
 arch/powerpc/platforms/celleb/htab.c         |    7 ++++---
 arch/powerpc/platforms/celleb/interrupt.c    |   26 ++++++++++++++------------
 arch/powerpc/platforms/celleb/scc_epci.c     |    8 ++++----
 arch/powerpc/platforms/celleb/scc_sio.c      |    4 ++--
 arch/powerpc/platforms/celleb/spu_priv1.c    |    3 +--
 arch/powerpc/platforms/celleb/udbg_beat.c    |    5 +++--
 9 files changed, 39 insertions(+), 38 deletions(-)

Index: b/arch/powerpc/platforms/celleb/beat.c
===================================================================
--- a/arch/powerpc/platforms/celleb/beat.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/beat.c	2008-03-04 13:54:19.000000000 +0900
@@ -48,6 +48,7 @@
 }
 
 u64 beat_halt_code = 0x1000000000000000UL;
+EXPORT_SYMBOL(beat_halt_code);
 
 void beat_halt(void)
 {
@@ -94,9 +95,8 @@
 		len = count;
 		if (len > BEAT_NVRW_CNT)
 			len = BEAT_NVRW_CNT;
-		if (beat_eeprom_read(i, len, p)) {
+		if (beat_eeprom_read(i, len, p))
 			return -EIO;
-		}
 
 		p += len;
 		i += len;
@@ -121,9 +121,8 @@
 		len = count;
 		if (len > BEAT_NVRW_CNT)
 			len = BEAT_NVRW_CNT;
-		if (beat_eeprom_write(i, len, p)) {
+		if (beat_eeprom_write(i, len, p))
 			return -EIO;
-		}
 
 		p += len;
 		i += len;
@@ -149,13 +148,14 @@
 	u64 db[2];
 	s64 ret;
 
-	ret = beat_get_characters_from_console(vterm, len, (u8*)db);
+	ret = beat_get_characters_from_console(vterm, len, (u8 *)db);
 	if (ret == 0) {
 		*t1 = db[0];
 		*t2 = db[1];
 	}
 	return ret;
 }
+EXPORT_SYMBOL(beat_get_term_char);
 
 int64_t beat_put_term_char(u64 vterm, u64 len, u64 t1, u64 t2)
 {
@@ -163,8 +163,9 @@
 
 	db[0] = t1;
 	db[1] = t2;
-	return beat_put_characters_to_console(vterm, len, (u8*)db);
+	return beat_put_characters_to_console(vterm, len, (u8 *)db);
 }
+EXPORT_SYMBOL(beat_put_term_char);
 
 void beat_power_save(void)
 {
@@ -261,7 +262,3 @@
 }
 
 device_initcall(beat_event_init);
-
-EXPORT_SYMBOL(beat_get_term_char);
-EXPORT_SYMBOL(beat_put_term_char);
-EXPORT_SYMBOL(beat_halt_code);
Index: b/arch/powerpc/platforms/celleb/beat.h
===================================================================
--- a/arch/powerpc/platforms/celleb/beat.h	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/beat.h	2008-03-04 13:54:19.000000000 +0900
@@ -24,8 +24,8 @@
 #define DABRX_KERNEL		(1UL<<1)
 #define DABRX_USER		(1UL<<0)
 
-int64_t beat_get_term_char(uint64_t,uint64_t*,uint64_t*,uint64_t*);
-int64_t beat_put_term_char(uint64_t,uint64_t,uint64_t,uint64_t);
+int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint64_t *);
+int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t);
 int64_t beat_repository_encode(int, const char *, uint64_t[4]);
 void beat_restart(char *);
 void beat_power_off(void);
Index: b/arch/powerpc/platforms/celleb/htab.c
===================================================================
--- a/arch/powerpc/platforms/celleb/htab.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/htab.c	2008-03-04 13:54:19.000000000 +0900
@@ -35,9 +35,9 @@
 #include "beat_wrapper.h"
 
 #ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
+#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while (0)
 #else
-#define DBG_LOW(fmt...) do { } while(0)
+#define DBG_LOW(fmt...) do { } while (0)
 #endif
 
 static DEFINE_SPINLOCK(beat_htab_lock);
@@ -116,7 +116,8 @@
 		hpte_r &= ~_PAGE_COHERENT;
 
 	spin_lock(&beat_htab_lock);
-	if ((lpar_rc = beat_read_mask(hpte_group)) == 0) {
+	lpar_rc = beat_read_mask(hpte_group);
+	if (lpar_rc == 0) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" full\n");
 		spin_unlock(&beat_htab_lock);
Index: b/arch/powerpc/platforms/celleb/interrupt.c
===================================================================
--- a/arch/powerpc/platforms/celleb/interrupt.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/interrupt.c	2008-03-04 13:54:19.000000000 +0900
@@ -34,7 +34,7 @@
 static uint64_t	beatic_irq_mask_enable[(MAX_IRQS+255)/64];
 static uint64_t	beatic_irq_mask_ack[(MAX_IRQS+255)/64];
 
-static struct irq_host *beatic_host = NULL;
+static struct irq_host *beatic_host;
 
 /*
  * In this implementation, "virq" == "IRQ plug number",
@@ -49,13 +49,13 @@
 
 	off = (irq_plug / 256) * 4;
 	masks[0] = beatic_irq_mask_enable[off + 0]
-	           & beatic_irq_mask_ack[off + 0];
+		& beatic_irq_mask_ack[off + 0];
 	masks[1] = beatic_irq_mask_enable[off + 1]
-	           & beatic_irq_mask_ack[off + 1];
+		& beatic_irq_mask_ack[off + 1];
 	masks[2] = beatic_irq_mask_enable[off + 2]
-	           & beatic_irq_mask_ack[off + 2];
+		& beatic_irq_mask_ack[off + 2];
 	masks[3] = beatic_irq_mask_enable[off + 3]
-	           & beatic_irq_mask_ack[off + 3];
+		& beatic_irq_mask_ack[off + 3];
 	if (beat_set_interrupt_mask(irq_plug&~255UL,
 		masks[0], masks[1], masks[2], masks[3]) != 0)
 		panic("Failed to set mask IRQ!");
@@ -96,7 +96,8 @@
 	s64 err;
 	unsigned long flags;
 
-	if ((err = beat_downcount_of_interrupt(irq_plug)) != 0) {
+	err = beat_downcount_of_interrupt(irq_plug);
+	if (err != 0) {
 		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
 			panic("Failed to downcount IRQ! Error = %16lx", err);
 
@@ -138,7 +139,8 @@
 	struct irq_desc *desc = get_irq_desc(virq);
 	int64_t	err;
 
-	if ((err = beat_construct_and_connect_irq_plug(virq, hw)) < 0)
+	err = beat_construct_and_connect_irq_plug(virq, hw);
+	if (err < 0)
 		return -EIO;
 
 	desc->status |= IRQ_LEVEL;
@@ -202,22 +204,22 @@
 		beat_detect_pending_interrupts(i, pending);
 		__asm__ ("cntlzd %0,%1":"=r"(ub):
 			"r"(pending[0] & beatic_irq_mask_enable[i/64+0]
-			               & beatic_irq_mask_ack[i/64+0]));
+				       & beatic_irq_mask_ack[i/64+0]));
 		if (ub != 64)
 			return i + ub + 0;
 		__asm__ ("cntlzd %0,%1":"=r"(ub):
 			"r"(pending[1] & beatic_irq_mask_enable[i/64+1]
-			               & beatic_irq_mask_ack[i/64+1]));
+				       & beatic_irq_mask_ack[i/64+1]));
 		if (ub != 64)
 			return i + ub + 64;
 		__asm__ ("cntlzd %0,%1":"=r"(ub):
 			"r"(pending[2] & beatic_irq_mask_enable[i/64+2]
-			               & beatic_irq_mask_ack[i/64+2]));
+				       & beatic_irq_mask_ack[i/64+2]));
 		if (ub != 64)
 			return i + ub + 128;
 		__asm__ ("cntlzd %0,%1":"=r"(ub):
 			"r"(pending[3] & beatic_irq_mask_enable[i/64+3]
-			               & beatic_irq_mask_ack[i/64+3]));
+				       & beatic_irq_mask_ack[i/64+3]));
 		if (ub != 64)
 			return i + ub + 192;
 	}
@@ -250,7 +252,7 @@
 
 	/* Allocate an irq host */
 	beatic_host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
-					 &beatic_pic_host_ops,
+				     &beatic_pic_host_ops,
 					 0);
 	BUG_ON(beatic_host == NULL);
 	irq_set_default_host(beatic_host);
Index: b/arch/powerpc/platforms/celleb/spu_priv1.c
===================================================================
--- a/arch/powerpc/platforms/celleb/spu_priv1.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/spu_priv1.c	2008-03-04 13:54:19.000000000 +0900
@@ -183,8 +183,7 @@
 	return enable;
 }
 
-const struct spu_priv1_ops spu_priv1_beat_ops =
-{
+const struct spu_priv1_ops spu_priv1_beat_ops = {
 	.int_mask_and = int_mask_and,
 	.int_mask_or = int_mask_or,
 	.int_mask_set = int_mask_set,
Index: b/arch/powerpc/platforms/celleb/udbg_beat.c
===================================================================
--- a/arch/powerpc/platforms/celleb/udbg_beat.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/udbg_beat.c	2008-03-04 13:54:19.000000000 +0900
@@ -54,7 +54,8 @@
 	if (inbuflen == 0) {
 		/* get some more chars. */
 		inbuflen = 0;
-		rc = beat_get_term_char(celleb_vtermno, &inbuflen, inbuf+0, inbuf+1);
+		rc = beat_get_term_char(celleb_vtermno, &inbuflen,
+					inbuf+0, inbuf+1);
 		if (rc != 0)
 			inbuflen = 0;	/* otherwise inbuflen is garbage */
 	}
@@ -78,7 +79,7 @@
 		if (ch == -1) {
 			/* This shouldn't be needed...but... */
 			volatile unsigned long delay;
-			for (delay=0; delay < 2000000; delay++)
+			for (delay = 0; delay < 2000000; delay++)
 				;
 		} else {
 			return ch;
Index: b/arch/powerpc/platforms/celleb/beat_wrapper.h
===================================================================
--- a/arch/powerpc/platforms/celleb/beat_wrapper.h	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/beat_wrapper.h	2008-03-04 13:54:19.000000000 +0900
@@ -197,7 +197,8 @@
 	u64 b[2];
 
 	memcpy(b, buffer, len);
-	return beat_hcall_norets(HV_put_characters_to_console, termno, len,					 b[0], b[1]);
+	return beat_hcall_norets(HV_put_characters_to_console, termno, len,
+		b[0], b[1]);
 }
 
 static inline s64 beat_get_spe_privileged_state_1_registers(
Index: b/arch/powerpc/platforms/celleb/scc_epci.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_epci.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/scc_epci.c	2008-03-04 13:57:49.000000000 +0900
@@ -161,9 +161,9 @@
 	if (bus != hose->bus)
 		addr = celleb_epci_get_epci_cfg(hose) +
 		       (((bus->number & 0xff) << 16)
-		        | ((devfn & 0xff) << 8)
-		        | (where & 0xff)
-		        | 0x01000000);
+			| ((devfn & 0xff) << 8)
+			| (where & 0xff)
+			| 0x01000000);
 	else
 		addr = celleb_epci_get_epci_cfg(hose) +
 		       (((devfn & 0xff) << 8) | (where & 0xff));
@@ -174,7 +174,7 @@
 }
 
 static int celleb_epci_read_config(struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 * val)
+			unsigned int devfn, int where, int size, u32 *val)
 {
 	PCI_IO_ADDR epci_base;
 	PCI_IO_ADDR addr;
Index: b/arch/powerpc/platforms/celleb/scc_sio.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_sio.c	2008-03-04 13:54:15.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/scc_sio.c	2008-03-04 13:57:49.000000000 +0900
@@ -28,7 +28,7 @@
 
 /* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
     mmio=0xfff000-0x1000,0xff2000-0x1000 */
-static int txx9_serial_bitmap __initdata = 0;
+static int txx9_serial_bitmap __initdata;
 
 static struct {
 	uint32_t offset;
@@ -84,7 +84,7 @@
 	int	i;
 
 	for (;;) {
-		switch(get_option(&ptr, &i)) {
+		switch (get_option(&ptr, &i)) {
 		default:
 			return 0;
 		case 2:
