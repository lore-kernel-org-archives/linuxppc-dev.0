Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 02 Aug 2006 11:13:50 +1000
Subject: [PATCH] Make doc comments extractable
Message-Id: <20060802011352.3B9D867B70@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't have much in the way of doc comments, but some of those we do have
don't work because they start with "/***" or "/*", not "/**" which is what
kernel-doc requires.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/crash_dump.c |    2 +-
 arch/powerpc/sysdev/i8259.c      |    2 +-
 include/asm-powerpc/irq.h        |   24 ++++++++++++------------
 include/asm-powerpc/prom.h       |    8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

Index: to-merge/arch/powerpc/kernel/crash_dump.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash_dump.c
+++ to-merge/arch/powerpc/kernel/crash_dump.c
@@ -80,7 +80,7 @@ static int __init parse_savemaxmem(char 
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
-/*
+/**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
  * @buf: target memory address for the copy; this can be in kernel address
Index: to-merge/arch/powerpc/sysdev/i8259.c
===================================================================
--- to-merge.orig/arch/powerpc/sysdev/i8259.c
+++ to-merge/arch/powerpc/sysdev/i8259.c
@@ -224,7 +224,7 @@ static struct irq_host_ops i8259_host_op
 	.xlate = i8259_host_xlate,
 };
 
-/****
+/**
  * i8259_init - Initialize the legacy controller
  * @node: device node of the legacy PIC (can be NULL, but then, it will match
  *        all interrupts, so beware)
Index: to-merge/include/asm-powerpc/irq.h
===================================================================
--- to-merge.orig/include/asm-powerpc/irq.h
+++ to-merge/include/asm-powerpc/irq.h
@@ -137,7 +137,7 @@ struct irq_map_entry {
 extern struct irq_map_entry irq_map[NR_IRQS];
 
 
-/***
+/**
  * irq_alloc_host - Allocate a new irq_host data structure
  * @node: device-tree node of the interrupt controller
  * @revmap_type: type of reverse mapping to use
@@ -159,14 +159,14 @@ extern struct irq_host *irq_alloc_host(u
 				       irq_hw_number_t inval_irq);
 
 
-/***
+/**
  * irq_find_host - Locates a host for a given device node
  * @node: device-tree node of the interrupt controller
  */
 extern struct irq_host *irq_find_host(struct device_node *node);
 
 
-/***
+/**
  * irq_set_default_host - Set a "default" host
  * @host: default host pointer
  *
@@ -178,7 +178,7 @@ extern struct irq_host *irq_find_host(st
 extern void irq_set_default_host(struct irq_host *host);
 
 
-/***
+/**
  * irq_set_virq_count - Set the maximum number of virt irqs
  * @count: number of linux virtual irqs, capped with NR_IRQS
  *
@@ -188,7 +188,7 @@ extern void irq_set_default_host(struct 
 extern void irq_set_virq_count(unsigned int count);
 
 
-/***
+/**
  * irq_create_mapping - Map a hardware interrupt into linux virq space
  * @host: host owning this hardware interrupt or NULL for default host
  * @hwirq: hardware irq number in that host space
@@ -202,13 +202,13 @@ extern unsigned int irq_create_mapping(s
 				       irq_hw_number_t hwirq);
 
 
-/***
+/**
  * irq_dispose_mapping - Unmap an interrupt
  * @virq: linux virq number of the interrupt to unmap
  */
 extern void irq_dispose_mapping(unsigned int virq);
 
-/***
+/**
  * irq_find_mapping - Find a linux virq from an hw irq number.
  * @host: host owning this hardware interrupt
  * @hwirq: hardware irq number in that host space
@@ -221,7 +221,7 @@ extern unsigned int irq_find_mapping(str
 				     irq_hw_number_t hwirq);
 
 
-/***
+/**
  * irq_radix_revmap - Find a linux virq from a hw irq number.
  * @host: host owning this hardware interrupt
  * @hwirq: hardware irq number in that host space
@@ -232,7 +232,7 @@ extern unsigned int irq_find_mapping(str
 extern unsigned int irq_radix_revmap(struct irq_host *host,
 				     irq_hw_number_t hwirq);
 
-/***
+/**
  * irq_linear_revmap - Find a linux virq from a hw irq number.
  * @host: host owning this hardware interrupt
  * @hwirq: hardware irq number in that host space
@@ -247,7 +247,7 @@ extern unsigned int irq_linear_revmap(st
 
 
 
-/***
+/**
  * irq_alloc_virt - Allocate virtual irq numbers
  * @host: host owning these new virtual irqs
  * @count: number of consecutive numbers to allocate
@@ -261,7 +261,7 @@ extern unsigned int irq_alloc_virt(struc
 				   unsigned int count,
 				   unsigned int hint);
 
-/***
+/**
  * irq_free_virt - Free virtual irq numbers
  * @virq: virtual irq number of the first interrupt to free
  * @count: number of interrupts to free
@@ -300,7 +300,7 @@ extern unsigned int irq_of_parse_and_map
 
 /* -- End OF helpers -- */
 
-/***
+/**
  * irq_early_init - Init irq remapping subsystem
  */
 extern void irq_early_init(void);
Index: to-merge/include/asm-powerpc/prom.h
===================================================================
--- to-merge.orig/include/asm-powerpc/prom.h
+++ to-merge/include/asm-powerpc/prom.h
@@ -259,7 +259,7 @@ struct of_irq {
 	u32 specifier[OF_MAX_IRQ_SPEC];	/* Specifier copy */
 };
 
-/***
+/**
  * of_irq_map_init - Initialize the irq remapper
  * @flags:	flags defining workarounds to enable
  *
@@ -272,7 +272,7 @@ struct of_irq {
 
 extern void of_irq_map_init(unsigned int flags);
 
-/***
+/**
  * of_irq_map_raw - Low level interrupt tree parsing
  * @parent:	the device interrupt parent
  * @intspec:	interrupt specifier ("interrupts" property of the device)
@@ -292,7 +292,7 @@ extern int of_irq_map_raw(struct device_
 			  const u32 *addr, struct of_irq *out_irq);
 
 
-/***
+/**
  * of_irq_map_one - Resolve an interrupt for a device
  * @device:	the device whose interrupt is to be resolved
  * @index:     	index of the interrupt to resolve
@@ -305,7 +305,7 @@ extern int of_irq_map_raw(struct device_
 extern int of_irq_map_one(struct device_node *device, int index,
 			  struct of_irq *out_irq);
 
-/***
+/**
  * of_irq_map_pci - Resolve the interrupt for a PCI device
  * @pdev:	the device whose interrupt is to be resolved
  * @out_irq:	structure of_irq filled by this function
