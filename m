Date: Sat, 10 Nov 2001 23:17:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: APUS cleanup patch
Message-ID: <Pine.LNX.4.33.0111102310290.12896-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This patch removes quite a lot of unused code.
- with the previous patch lots of irq code is not needed anymore.
- ide code in apus_setup.c is gone
- keyboard code in apus_setup.c is reduced
A bit code is also added (the initialization of SYSRQ_KEY and
ppc_md.ppc_kbd_sysrq_xlate got lost).

bye, Roman

--- arch/ppc/amiga/amiints.c	Sat Nov 10 22:56:20 2001
+++ arch/ppc/amiga/amiints.c	Sat Nov 10 22:57:05 2001
@@ -65,9 +65,6 @@
 extern void cia_init_IRQ(struct ciabase *base);
 extern int cia_get_irq_list(struct ciabase *base, char *buf);

-/* irq node variables for amiga interrupt sources */
-static irq_node_t *ami_irq_list[AMI_STD_IRQS];
-
 unsigned short ami_intena_vals[AMI_STD_IRQS] = {
 	IF_VERTB, IF_COPER, IF_AUD0, IF_AUD1, IF_AUD2, IF_AUD3, IF_BLIT,
 	IF_DSKSYN, IF_DSKBLK, IF_RBF, IF_TBE, IF_SOFT, IF_PORTS, IF_EXTER
@@ -127,152 +124,6 @@
 	cia_init_IRQ(&ciab_base);
 }

-static inline int amiga_insert_irq(irq_node_t **list, irq_node_t *node)
-{
-	unsigned long flags;
-	irq_node_t *cur;
-
-	if (!node->dev_id)
-		printk("%s: Warning: dev_id of %s is zero\n",
-		       __FUNCTION__, node->devname);
-
-	save_flags(flags);
-	cli();
-
-	cur = *list;
-
-	if (node->flags & SA_INTERRUPT) {
-		if (node->flags & SA_SHIRQ)
-			return -EBUSY;
-		/*
-		 * There should never be more than one
-		 */
-		while (cur && cur->flags & SA_INTERRUPT) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	} else {
-		while (cur) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	}
-
-	node->next = cur;
-	*list = node;
-
-	restore_flags(flags);
-	return 0;
-}
-
-static inline void amiga_delete_irq(irq_node_t **list, void *dev_id)
-{
-	unsigned long flags;
-	irq_node_t *node;
-
-	save_flags(flags);
-	cli();
-
-	for (node = *list; node; list = &node->next, node = *list) {
-		if (node->dev_id == dev_id) {
-			*list = node->next;
-			/* Mark it as free. */
-			node->handler = NULL;
-			restore_flags(flags);
-			return;
-		}
-	}
-	restore_flags(flags);
-	printk ("%s: tried to remove invalid irq\n", __FUNCTION__);
-}
-
-/*
- * amiga_request_irq : add an interrupt service routine for a particular
- *                     machine specific interrupt source.
- *                     If the addition was successful, it returns 0.
- */
-
-int amiga_request_irq(unsigned int irq,
-		      void (*handler)(int, void *, struct pt_regs *),
-                      unsigned long flags, const char *devname, void *dev_id)
-{
-	irq_node_t *node;
-	int error = 0;
-
-	if (irq >= AMI_IRQS) {
-		printk ("%s: Unknown IRQ %d from %s\n", __FUNCTION__,
-			irq, devname);
-		return -ENXIO;
-	}
-
-	if (irq >= IRQ_AMIGA_AUTO)
-		return sys_request_irq(irq - IRQ_AMIGA_AUTO, handler,
-		                       flags, devname, dev_id);
-
-	if (irq >= IRQ_AMIGA_CIAA)
-		return cia_request_irq(irq, handler, flags, devname, dev_id);
-
-	/*
-	 * IRQ_AMIGA_PORTS & IRQ_AMIGA_EXTER defaults to shared,
-	 * we could add a check here for the SA_SHIRQ flag but all drivers
-	 * should be aware of sharing anyway.
-	 */
-	if (ami_servers[irq]) {
-		if (!(node = new_irq_node()))
-			return -ENOMEM;
-		node->handler = handler;
-		node->flags   = flags;
-		node->dev_id  = dev_id;
-		node->devname = devname;
-		node->next    = NULL;
-		error = amiga_insert_irq(&ami_irq_list[irq], node);
-	} else {
-		ami_irq_list[irq]->handler = handler;
-		ami_irq_list[irq]->flags   = flags;
-		ami_irq_list[irq]->dev_id  = dev_id;
-		ami_irq_list[irq]->devname = devname;
-	}
-
-	/* enable the interrupt */
-	if (irq < IRQ_AMIGA_PORTS && !ami_ablecount[irq])
-		custom.intena = IF_SETCLR | ami_intena_vals[irq];
-
-	return error;
-}
-
-void amiga_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq >= AMI_IRQS) {
-		printk ("%s: Unknown IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_AUTO) {
-		sys_free_irq(irq - IRQ_AMIGA_AUTO, dev_id);
-		return;
-	}
-	if (irq >= IRQ_AMIGA_CIAA) {
-		cia_free_irq(irq, dev_id);
-		return;
-	}
-
-	if (ami_servers[irq]) {
-		amiga_delete_irq(&ami_irq_list[irq], dev_id);
-		/* if server list empty, disable the interrupt */
-		if (!ami_irq_list[irq] && irq < IRQ_AMIGA_PORTS)
-			custom.intena = ami_intena_vals[irq];
-	} else {
-		if (ami_irq_list[irq]->dev_id != dev_id)
-			printk("%s: removing probably wrong IRQ %d from %s\n",
-			       __FUNCTION__, irq, ami_irq_list[irq]->devname);
-		ami_irq_list[irq]->handler = ami_badint;
-		ami_irq_list[irq]->flags   = 0;
-		ami_irq_list[irq]->dev_id  = NULL;
-		ami_irq_list[irq]->devname = NULL;
-		custom.intena = ami_intena_vals[irq];
-	}
-}
-
 /*
  * Enable/disable a particular machine specific interrupt source.
  * Note that this may affect other interrupts in case of a shared interrupt.
@@ -478,29 +329,3 @@
 	ami_int4, ami_int5, ami_badint, ami_int7
 };
 #endif
-
-int amiga_get_irq_list(char *buf)
-{
-	int i, len = 0;
-	irq_node_t *node;
-
-	for (i = 0; i < AMI_STD_IRQS; i++) {
-		if (!(node = ami_irq_list[i]))
-			continue;
-		len += sprintf(buf+len, "ami  %2d: %10u ", i,
-		               kstat.irqs[0][i]);
-		do {
-			if (node->flags & SA_INTERRUPT)
-				len += sprintf(buf+len, "F ");
-			else
-				len += sprintf(buf+len, "  ");
-			len += sprintf(buf+len, "%s\n", node->devname);
-			if ((node = node->next))
-				len += sprintf(buf+len, "                    ");
-		} while (node);
-	}
-
-	len += cia_get_irq_list(&ciaa_base, buf+len);
-	len += cia_get_irq_list(&ciab_base, buf+len);
-	return len;
-}
--- arch/ppc/amiga/cia.c	Sat Nov 10 22:58:12 2001
+++ arch/ppc/amiga/cia.c	Sat Nov 10 22:58:36 2001
@@ -31,7 +31,6 @@
 	u_short int_mask;
 	int handler_irq, cia_irq, server_irq;
 	char *name;
-	irq_handler_t irq_list[CIA_IRQS];
 } ciaa_base = {
 	&ciaa, 0, 0, IF_PORTS,
 	IRQ_AMIGA_AUTO_2, IRQ_AMIGA_CIAA,
@@ -138,44 +137,6 @@
 	return cia_able_irq_private(base, mask);
 }

-int cia_request_irq(unsigned int irq,
-                    void (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
-{
-	u_char mask;
-	struct ciabase *base;
-
-	CIA_SET_BASE_ADJUST_IRQ(base, irq);
-
-	base->irq_list[irq].handler = handler;
-	base->irq_list[irq].flags   = flags;
-	base->irq_list[irq].dev_id  = dev_id;
-	base->irq_list[irq].devname = devname;
-
-	/* enable the interrupt */
-	mask = 1 << irq;
-	cia_set_irq_private(base, mask);
-	cia_able_irq_private(base, CIA_ICR_SETCLR | mask);
-	return 0;
-}
-
-void cia_free_irq(unsigned int irq, void *dev_id)
-{
-	struct ciabase *base;
-
-	CIA_SET_BASE_ADJUST_IRQ(base, irq);
-
-	if (base->irq_list[irq].dev_id != dev_id)
-		printk("%s: removing probably wrong IRQ %i from %s\n",
-		       __FUNCTION__, base->cia_irq + irq,
-		       base->irq_list[irq].devname);
-
-	base->irq_list[irq].handler = NULL;
-	base->irq_list[irq].flags   = 0;
-
-	cia_able_irq_private(base, 1 << irq);
-}
-
 static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
@@ -217,18 +178,4 @@
 	setup_irq(base->handler_irq, &amiga_sys_irqaction[base->handler_irq-IRQ_AMIGA_AUTO]);

 	custom.intena = IF_SETCLR | base->int_mask;
-}
-
-int cia_get_irq_list(struct ciabase *base, char *buf)
-{
-	int i, j, len = 0;
-
-	j = base->cia_irq;
-	for (i = 0; i < CIA_IRQS; i++) {
-		len += sprintf(buf+len, "cia  %2d: %10d ", j + i,
-			       kstat.irqs[0][j + i]);
-			len += sprintf(buf+len, "  ");
-		len += sprintf(buf+len, "%s\n", base->irq_list[i].devname);
-	}
-	return len;
 }
--- arch/ppc/kernel/apus_setup.c	Sat Nov 10 23:00:10 2001
+++ arch/ppc/kernel/apus_setup.c	Sat Nov 10 23:02:40 2001
@@ -17,64 +17,20 @@
  */

 #include <linux/config.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/kd.h>
 #include <linux/init.h>
-#include <linux/hdreg.h>
 #include <linux/blk.h>
-#include <linux/pci.h>
-#include <linux/kernel_stat.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/logging.h>

 /* Needs INITSERIAL call in head.S! */
 #undef APUS_DEBUG

-
-#include <linux/ide.h>
-#define T_CHAR          (0x0000)        /* char:  don't touch  */
-#define T_SHORT         (0x4000)        /* short: 12 -> 21     */
-#define T_INT           (0x8000)        /* int:   1234 -> 4321 */
-#define T_TEXT          (0xc000)        /* text:  12 -> 21     */
-
-#define T_MASK_TYPE     (0xc000)
-#define T_MASK_COUNT    (0x3fff)
-
-#define D_CHAR(cnt)     (T_CHAR  | (cnt))
-#define D_SHORT(cnt)    (T_SHORT | (cnt))
-#define D_INT(cnt)      (T_INT   | (cnt))
-#define D_TEXT(cnt)     (T_TEXT  | (cnt))
-
-static u_short driveid_types[] = {
-        D_SHORT(10),    /* config - vendor2 */
-        D_TEXT(20),     /* serial_no */
-        D_SHORT(3),     /* buf_type, buf_size - ecc_bytes */
-        D_TEXT(48),     /* fw_rev - model */
-        D_CHAR(2),      /* max_multsect - vendor3 */
-        D_SHORT(1),     /* dword_io */
-        D_CHAR(2),      /* vendor4 - capability */
-        D_SHORT(1),     /* reserved50 */
-        D_CHAR(4),      /* vendor5 - tDMA */
-        D_SHORT(4),     /* field_valid - cur_sectors */
-        D_INT(1),       /* cur_capacity */
-        D_CHAR(2),      /* multsect - multsect_valid */
-        D_INT(1),       /* lba_capacity */
-        D_SHORT(194)    /* dma_1word - reservedyy */
-};
-
-#define num_driveid_types       (sizeof(driveid_types)/sizeof(*driveid_types))
-
 #include <asm/bootinfo.h>
 #include <asm/setup.h>
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <asm/amigappc.h>
 #include <asm/pgtable.h>
-#include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/keyboard.h>
@@ -85,6 +41,11 @@

 extern void amiga_init_IRQ(void);

+extern int amiga_kbd_translate(unsigned char keycode, unsigned char *keycodep, char raw_mode);
+extern char amiga_sysrq_xlate[128];
+
+extern void apus_setup_pci_ptrs(void);
+
 void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
 /* machine dependent keyboard functions */
 int (*mach_keyb_init) (void) __initdata = NULL;
@@ -144,7 +105,7 @@
 {
 #ifdef CONFIG_APUS
 	extern unsigned long m68k_get_rtc_time(void);
-
+
 	return m68k_get_rtc_time ();
 #else
 	return 0;
@@ -162,46 +123,6 @@
 #endif
 }

-
-
-/* Here some functions we don't support, but which the other ports reference */
-int pckbd_setkeycode(unsigned int scancode, unsigned int keycode)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-	return 0;
-}
-int pckbd_getkeycode(unsigned int scancode)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-	return 0;
-}
-int pckbd_translate(unsigned char scancode, unsigned char *keycode,
-		    char raw_mode)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-	return 0;
-}
-char pckbd_unexpected_up(unsigned char keycode)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-	return 0;
-}
-void pckbd_leds(unsigned char leds)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-}
-void pckbd_init_hw(void)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-}
-unsigned char pckbd_sysrq_xlate[128];
-
-struct pci_bus * __init pci_scan_peer_bridge(int bus)
-{
-	printk("Bogus call to " __FILE__ ":" __FUNCTION__ "\n");
-	return NULL;
-}
-
 /*********************************************************** SETUP */
 /* From arch/m68k/kernel/setup.c. */
 void __init apus_setup_arch(void)
@@ -429,7 +350,7 @@
 	pte_t *pte = 0;

 	va &= PAGE_MASK;
-
+
 	dir = pgd_offset( mm, va );
 	if (dir)
 	{
@@ -464,7 +385,7 @@
 		       cmode);
 		break;
 	}
-
+
 	size /= PAGE_SIZE;
 	address &= PAGE_MASK;
 	while (size--)
@@ -504,7 +425,7 @@
 				goto exit;
 			}
 		}
-
+
 		ret = (unsigned long) __va(paddr);
 	}
 exit:
@@ -606,153 +527,8 @@
    apus_restart(NULL);
 }

-/****************************************************** from setup.c/IDE */
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-/*
- * IDE stuff.
- */
-
-#if 0	/* no longer used  -- paulus */
-void
-apus_ide_fix_driveid(struct hd_driveid *id)
-{
-   u_char *p = (u_char *)id;
-   int i, j, cnt;
-   u_char t;
-
-   if (!MACH_IS_AMIGA && !MACH_IS_MAC)
-   	return;
-   for (i = 0; i < num_driveid_types; i++) {
-      cnt = driveid_types[i] & T_MASK_COUNT;
-      switch (driveid_types[i] & T_MASK_TYPE) {
-         case T_CHAR:
-            p += cnt;
-            break;
-         case T_SHORT:
-            for (j = 0; j < cnt; j++) {
-               t = p[0];
-               p[0] = p[1];
-               p[1] = t;
-               p += 2;
-            }
-            break;
-         case T_INT:
-            for (j = 0; j < cnt; j++) {
-               t = p[0];
-               p[0] = p[3];
-               p[3] = t;
-               t = p[1];
-               p[1] = p[2];
-               p[2] = t;
-               p += 4;
-            }
-            break;
-         case T_TEXT:
-            for (j = 0; j < cnt; j += 2) {
-               t = p[0];
-               p[0] = p[1];
-               p[1] = t;
-               p += 2;
-            }
-            break;
-      }
-   }
-}
-#endif /* 0 */
-
-__init
-void apus_ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port,
-			       ide_ioreg_t ctrl_port, int *irq)
-{
-        if (data_port || ctrl_port)
-                printk("apus_ide_init_hwif_ports: must not be called\n");
-}
-#endif
 /****************************************************** IRQ stuff */

-static unsigned int apus_irq_cannonicalize(unsigned int irq)
-{
-	return irq;
-}
-
-int apus_get_irq_list(char *buf)
-{
-#ifdef CONFIG_APUS
-	extern int amiga_get_irq_list(char *buf);
-
-	return amiga_get_irq_list (buf);
-#else
-	return 0;
-#endif
-}
-
-/* IPL must be between 0 and 7 */
-static inline void apus_set_IPL(unsigned long ipl)
-{
-	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET | IPLEMU_DISABLEINT);
-	APUS_WRITE(APUS_IPL_EMU, IPLEMU_IPLMASK);
-	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET | ((~ipl) & IPLEMU_IPLMASK));
-	APUS_WRITE(APUS_IPL_EMU, IPLEMU_DISABLEINT);
-}
-
-static inline unsigned long apus_get_IPL(void)
-{
-	/* This returns the present IPL emulation level. */
-	unsigned long __f;
-	APUS_READ(APUS_IPL_EMU, __f);
-	return ((~__f) & IPLEMU_IPLMASK);
-}
-
-static inline unsigned long apus_get_prev_IPL(struct pt_regs* regs)
-{
-	/* The value saved in mq is the IPL_EMU value at the time of
-	   interrupt. The lower bits are the current interrupt level,
-	   the upper bits the requested level. Thus, to restore the
-	   IPL level to the post-interrupt state, we will need to use
-	   the lower bits. */
-	unsigned long __f = regs->mq;
-	return ((~__f) & IPLEMU_IPLMASK);
-}
-
-
-#ifdef CONFIG_APUS
-void free_irq(unsigned int irq, void *dev_id)
-{
-	extern void amiga_free_irq(unsigned int irq, void *dev_id);
-
-	amiga_free_irq (irq, dev_id);
-}
-
-int request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-	unsigned long irqflags, const char * devname, void *dev_id)
-{
-	extern int  amiga_request_irq(unsigned int irq,
-				      void (*handler)(int, void *,
-						      struct pt_regs *),
-				      unsigned long flags,
-				      const char *devname,
-				      void *dev_id);
-
-	return amiga_request_irq (irq, handler, irqflags, devname, dev_id);
-}
-
-/* In Linux/m68k the sys_request_irq deals with vectors 0-7. That's what
-   callers expect - but on Linux/APUS we actually use the IRQ_AMIGA_AUTO
-   vectors (24-31), so we put this dummy function in between to adjust
-   the vector argument (rather have cruft here than in the generic irq.c). */
-int sys_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-		    unsigned long irqflags, const char * devname, void *dev_id)
-{
-	extern int request_sysirq(unsigned int irq,
-				  void (*handler)(int, void *,
-						  struct pt_regs *),
-				  unsigned long irqflags,
-				  const char * devname, void *dev_id);
-	return request_sysirq(irq+IRQ_AMIGA_AUTO, handler, irqflags,
-			      devname, dev_id);
-}
-#endif
-
 static unsigned char last_ipl[8];

 int apus_get_irq(struct pt_regs* regs)
@@ -807,22 +583,11 @@
 	return scancode > 127 ? -EINVAL : scancode;
 }

-static int apus_kbd_translate(unsigned char keycode, unsigned char *keycodep,
-			      char raw_mode)
-{
-	*keycodep = keycode;
-	return 1;
-}
-
 static char apus_kbd_unexpected_up(unsigned char keycode)
 {
 	return 0200;
 }

-static void apus_kbd_leds(unsigned char leds)
-{
-}
-
 static void apus_kbd_init_hw(void)
 {
 #ifdef CONFIG_APUS
@@ -878,9 +643,9 @@
 }

 int __debug_serinit( void )
-{
+{
 	unsigned long flags;
-
+
 	save_flags (flags);
 	cli();

@@ -898,7 +663,7 @@
 	 */
 	ciab.ddra |= (SER_DTR | SER_RTS);   /* outputs */
 	ciab.ddra &= ~(SER_DCD | SER_CTS | SER_DSR);  /* inputs */
-
+
 #ifdef CONFIG_KGDB
 	/* turn Rx interrupts on for GDB */
 	custom.intena = IF_SETCLR | IF_RBF;
@@ -940,29 +705,6 @@
 /* The number of spurious interrupts */
 volatile unsigned int num_spurious;

-#define NUM_IRQ_NODES 100
-static irq_node_t nodes[NUM_IRQ_NODES];
-
-extern void (*amiga_default_handler[AUTO_IRQS])(int, void *, struct pt_regs *);
-
-static const char *default_names[SYS_IRQS] = {
-	"spurious int", "int1 handler", "int2 handler", "int3 handler",
-	"int4 handler", "int5 handler", "int6 handler", "int7 handler"
-};
-
-irq_node_t *new_irq_node(void)
-{
-	irq_node_t *node;
-	short i;
-
-	for (node = nodes, i = NUM_IRQ_NODES-1; i >= 0; node++, i--)
-		if (!node->handler)
-			return node;
-
-	printk ("new_irq_node: out of nodes\n");
-	return NULL;
-}
-
 extern struct irqaction amiga_sys_irqaction[AUTO_IRQS];


@@ -1076,7 +818,7 @@
 {
 	extern int parse_bootinfo(const struct bi_record *);
 	extern char _end[];
-
+
 	/* Parse bootinfo. The bootinfo is located right after
            the kernel bss */
 	parse_bootinfo((const struct bi_record *)&_end);
@@ -1094,9 +836,7 @@
 	ISA_DMA_THRESHOLD = 0x00ffffff;

 	ppc_md.setup_arch     = apus_setup_arch;
-	ppc_md.setup_residual = NULL;
 	ppc_md.get_cpuinfo    = apus_get_cpuinfo;
-	ppc_md.irq_cannonicalize = apus_irq_cannonicalize;
 	ppc_md.init_IRQ       = apus_init_IRQ;
 	ppc_md.get_irq        = apus_get_irq;

@@ -1122,25 +862,13 @@
 	ppc_md.find_end_of_memory = apus_find_end_of_memory;
 	ppc_md.setup_io_mappings = apus_map_io;

-	ppc_md.nvram_read_val = NULL;
-	ppc_md.nvram_write_val = NULL;
-
 	/* These should not be used for the APUS yet, since it uses
 	   the M68K keyboard now. */
 	ppc_md.kbd_setkeycode    = apus_kbd_setkeycode;
 	ppc_md.kbd_getkeycode    = apus_kbd_getkeycode;
-	ppc_md.kbd_translate     = apus_kbd_translate;
+	ppc_md.kbd_translate     = amiga_kbd_translate;
 	ppc_md.kbd_unexpected_up = apus_kbd_unexpected_up;
-	ppc_md.kbd_leds          = apus_kbd_leds;
 	ppc_md.kbd_init_hw       = apus_kbd_init_hw;
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-        ppc_ide_md.ide_init_hwif = apus_ide_init_hwif_ports;
-#endif
-}
-
-
-/*************************************************** coexistence */
-void __init adbdev_init(void)
-{
+	ppc_md.ppc_kbd_sysrq_xlate = amiga_sysrq_xlate;
+	SYSRQ_KEY                = 0xff;
 }
--- include/asm-ppc/irq.h	Sat Nov 10 22:25:46 2001
+++ include/asm-ppc/irq.h	Sat Nov 10 22:26:37 2001
@@ -126,47 +126,6 @@

 #else /* CONFIG_4xx + CONFIG_8xx */

-#if defined(CONFIG_APUS)
-/*
- * This structure is used to chain together the ISRs for a particular
- * interrupt source (if it supports chaining).
- */
-typedef struct irq_node {
-	void		(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-	const char	*devname;
-	struct irq_node *next;
-} irq_node_t;
-
-/*
- * This structure has only 4 elements for speed reasons
- */
-typedef struct irq_handler {
-	void		(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-	const char	*devname;
-} irq_handler_t;
-
-/* count of spurious interrupts */
-extern volatile unsigned int num_spurious;
-
-extern int sys_request_irq(unsigned int,
-	void (*)(int, void *, struct pt_regs *),
-	unsigned long, const char *, void *);
-extern void sys_free_irq(unsigned int, void *);
-
-/*
- * This function returns a new irq_node_t
- */
-extern irq_node_t *new_irq_node(void);
-
-/* Number of m68k interrupts */
-#define SYS_IRQS 8
-
-#endif /* CONFIG_APUS */
-
 /*
  * this is the # irq's for all ppc arch's (pmac/chrp/prep)
  * so it is the max of them all


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
