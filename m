Date: Fri, 25 Oct 2002 18:42:22 +0200
Subject: Re: PrPMC800 interrupt problem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Tom Rini <trini@kernel.crashing.org>
From: Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <20021025160001.GB30713@opus.bloom.county>
Message-Id: <BC199E78-E838-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> What you're suggesting brings back the old hacking behavior.  Again I
> say, look at what lopec_setup.c does for handling interrupts, look at
> the manual for the prpmc800 (and the MPC107 (OpenPIC/EPIC related bits)
> or MPC8240 (again, OpenPIC/EPIC)) manuals.
>
OK, hope this is a correct solution then (it works, which is a good thing)
. Thanks for your patience, all the levels in the interrupt handling are a
bit hairy to understand.

Regards

Anders Blomdell

--- ../2002-10-14/arch/ppc/platforms/prpmc800_setup.c   Fri Oct 11 17:58:31
2002
+++ arch/ppc/platforms/prpmc800_setup.c Fri Oct 25 18:33:49 2002
@@ -53,23 +53,23 @@

  static u_char prpmc800_openpic_initsenses[] __initdata =
  {
-    1, /* PRPMC800_INT_HOSTINT0 */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_DEBUGINT */
-    1, /* PRPMC800_INT_HARRIER_WDT */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_HOSTINT1 */
-    1, /* PRPMC800_INT_HOSTINT2 */
-    1, /* PRPMC800_INT_HOSTINT3 */
-    1, /* PRPMC800_INT_PMC_INTA */
-    1, /* PRPMC800_INT_PMC_INTB */
-    1, /* PRPMC800_INT_PMC_INTC */
-    1, /* PRPMC800_INT_PMC_INTD */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_UNUSED */
-    1, /* PRPMC800_INT_HARRIER_INT (UARTS, ABORT, DMA) */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HOSTINT0 *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_DEBUGINT *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HARRIER_WDT
*/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HOSTINT1 *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HOSTINT2 *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HOSTINT3 *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_PMC_INTA *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_PMC_INTB *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_PMC_INTC *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_PMC_INTD *
/
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_UNUSED */
+  (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),   /* PRPMC800_INT_HARRIER_INT
(UARTS, ABORT, DMA) */
  };

  static int
@@ -105,9 +105,6 @@
         conswitchp = &dummy_con;
  #endif

-       OpenPIC_InitSenses = prpmc800_openpic_initsenses;
-       OpenPIC_NumInitSenses = sizeof(prpmc800_openpic_initsenses);
-
         printk("PrPMC800 port (C) 2001 MontaVista Software, Inc. (source@m
vista.com)\n");
  }

@@ -198,14 +195,16 @@
  static void __init
  prpmc800_init_IRQ(void)
  {
-       openpic_init(0);
+  OpenPIC_InitSenses = prpmc800_openpic_initsenses;
+  OpenPIC_NumInitSenses = sizeof(prpmc800_openpic_initsenses);

-#define PRIORITY       15
-#define VECTOR         16
-#define PROCESSOR      0
-       /* initialize the harrier's internal interrupt priority 15, irq 1
*/
-       out_be32((u32 *)HARRIER_IFEVP_REG, (PRIORITY<<16) | VECTOR);
-       out_be32((u32 *)HARRIER_IFEDE_REG, (1<<PROCESSOR));
+  // Setup external interrupt sources
+  openpic_set_sources(0, 16, OpenPIC_Addr + 0x10000);
+  // Setup internal UART interrupt source
+  openpic_set_sources(16, 1, OpenPIC_Addr + 0x10200);
+
+  // Do the MPIC initialization based on the above settings
+  openpic_init(0);

         /* enable functional exceptions for uarts and abort */
         out_8((u8 *)HARRIER_FEEN_REG, (HARRIER_FE_UA0|HARRIER_FE_UA1));


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
