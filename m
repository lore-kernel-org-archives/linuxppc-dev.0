Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CFC9BDDF5E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170240.537717000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:59 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 26/35] Work around errata 4713
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for errata 4713: Concurrent access to some of the devices
in the SOC will result in a bus hang.

To avoid this, we introduce the lbi_lock, and grab it in the drivers
in question. Not a pretty solution, but adequate for now.


Index: mainline/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
+++ mainline/arch/powerpc/platforms/pasemi/setup.c
@@ -42,6 +42,8 @@
 static void __iomem *reset_reg;
 void __iomem *mem_errsta0, *mem_errsta1;
 
+DEFINE_SPINLOCK(lbi_lock);
+
 static void pas_restart(char *cmd)
 {
 	printk("Restarting...\n");
Index: mainline/drivers/i2c/busses/i2c-pasemi.c
===================================================================
--- mainline.orig/drivers/i2c/busses/i2c-pasemi.c
+++ mainline/drivers/i2c/busses/i2c-pasemi.c
@@ -59,17 +59,24 @@ struct pasemi_smbus {
 #define CLK_100K_DIV	84
 #define CLK_400K_DIV	21
 
+extern spinlock_t lbi_lock;
+
 static inline void reg_write(struct pasemi_smbus *smbus, int reg, int val)
 {
+	int flags;
 	dev_dbg(&smbus->dev->dev, "smbus write reg %lx val %08x\n",
 		smbus->base + reg, val);
+	spin_lock_irqsave(&lbi_lock, flags);
 	outl(val, smbus->base + reg);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 
 static inline int reg_read(struct pasemi_smbus *smbus, int reg)
 {
-	int ret;
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	ret = inl(smbus->base + reg);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 	dev_dbg(&smbus->dev->dev, "smbus read reg %lx val %08x\n",
 		smbus->base + reg, ret);
 	return ret;
Index: mainline/drivers/serial/8250.c
===================================================================
--- mainline.orig/drivers/serial/8250.c
+++ mainline/drivers/serial/8250.c
@@ -342,39 +342,51 @@ static inline int map_8250_out_reg(struc
 
 #endif
 
+extern spinlock_t lbi_lock;
+
 static unsigned int serial_in(struct uart_8250_port *up, int offset)
 {
 	unsigned int tmp;
+	int ret, flags;
 	offset = map_8250_in_reg(up, offset) << up->port.regshift;
 
+	spin_lock_irqsave(&lbi_lock, flags);
 	switch (up->port.iotype) {
 	case UPIO_HUB6:
 		outb(up->port.hub6 - 1 + offset, up->port.iobase);
-		return inb(up->port.iobase + 1);
+		ret = inb(up->port.iobase + 1);
+		break;
 
 	case UPIO_MEM:
 	case UPIO_DWAPB:
-		return readb(up->port.membase + offset);
+		ret = readb(up->port.membase + offset);
+		break;
 
 	case UPIO_RM9000:
 	case UPIO_MEM32:
-		return readl(up->port.membase + offset);
+		ret = readl(up->port.membase + offset);
+		break;
 
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
-		return __raw_readl(up->port.membase + offset);
+		ret = __raw_readl(up->port.membase + offset);
+		break;
 #endif
 
 	case UPIO_TSI:
 		if (offset == UART_IIR) {
 			tmp = readl(up->port.membase + (UART_IIR & ~3));
-			return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
+			ret = (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
 		} else
-			return readb(up->port.membase + offset);
+			ret = readb(up->port.membase + offset);
+		break;
 
 	default:
-		return inb(up->port.iobase + offset);
+		ret = inb(up->port.iobase + offset);
+		break;
 	}
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 
 static void
@@ -382,8 +394,10 @@ serial_out(struct uart_8250_port *up, in
 {
 	/* Save the offset before it's remapped */
 	int save_offset = offset;
+	int flags;
 	offset = map_8250_out_reg(up, offset) << up->port.regshift;
 
+	spin_lock_irqsave(&lbi_lock, flags);
 	switch (up->port.iotype) {
 	case UPIO_HUB6:
 		outb(up->port.hub6 - 1 + offset, up->port.iobase);
@@ -424,6 +438,7 @@ serial_out(struct uart_8250_port *up, in
 	default:
 		outb(value, up->port.iobase + offset);
 	}
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 
 static void
@@ -1239,10 +1254,7 @@ static void serial8250_start_tx(struct u
 			unsigned char lsr, iir;
 			lsr = serial_in(up, UART_LSR);
 			iir = serial_in(up, UART_IIR) & 0x0f;
-			if ((up->port.type == PORT_RM9000) ?
-				(lsr & UART_LSR_THRE &&
-				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
-				(lsr & UART_LSR_TEMT && !(iir & UART_IIR_NO_INT)))
+			if (lsr & UART_LSR_TEMT && !(iir & UART_IIR_NO_INT))
 				transmit_chars(up);
 		}
 	}
@@ -1879,7 +1891,7 @@ static int serial8250_startup(struct uar
 	if (lsr & UART_LSR_TEMT && !(iir & UART_IIR_NO_INT)) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
-			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
+			printk("ttyS%d - enabling bad tx status workarounds\n",
 				 port->line);
 		}
 	} else {
Index: mainline/arch/powerpc/kernel/iomap.c
===================================================================
--- mainline.orig/arch/powerpc/kernel/iomap.c
+++ mainline/arch/powerpc/kernel/iomap.c
@@ -8,29 +8,51 @@
 #include <linux/mm.h>
 #include <asm/io.h>
 
+extern spinlock_t lbi_lock;
+
 /*
  * Here comes the ppc64 implementation of the IOMAP 
  * interfaces.
  */
 unsigned int ioread8(void __iomem *addr)
 {
-	return readb(addr);
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
+	ret = readb(addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 unsigned int ioread16(void __iomem *addr)
 {
-	return readw(addr);
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
+	ret = readw(addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 unsigned int ioread16be(void __iomem *addr)
 {
-	return in_be16(addr);
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
+	ret = in_be16(addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 unsigned int ioread32(void __iomem *addr)
 {
-	return readl(addr);
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
+	ret = readl(addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 unsigned int ioread32be(void __iomem *addr)
 {
-	return in_be32(addr);
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
+	ret = in_be32(addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -40,23 +62,38 @@ EXPORT_SYMBOL(ioread32be);
 
 void iowrite8(u8 val, void __iomem *addr)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	writeb(val, addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite16(u16 val, void __iomem *addr)
 {
+	int ret, flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	writew(val, addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite16be(u16 val, void __iomem *addr)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	out_be16(addr, val);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite32(u32 val, void __iomem *addr)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	writel(val, addr);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite32be(u32 val, void __iomem *addr)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	out_be32(addr, val);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -74,15 +111,24 @@ EXPORT_SYMBOL(iowrite32be);
  */
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_insb((u8 __iomem *) addr, dst, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_insw_ns((u16 __iomem *) addr, dst, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_insl_ns((u32 __iomem *) addr, dst, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -90,15 +136,24 @@ EXPORT_SYMBOL(ioread32_rep);
 
 void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_outsb((u8 __iomem *) addr, src, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_outsw_ns((u16 __iomem *) addr, src, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	int flags;
+	spin_lock_irqsave(&lbi_lock, flags);
 	_outsl_ns((u32 __iomem *) addr, src, count);
+	spin_unlock_irqrestore(&lbi_lock, flags);
 }
 EXPORT_SYMBOL(iowrite8_rep);
 EXPORT_SYMBOL(iowrite16_rep);

--
