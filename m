Message-Id: <200112212037.PAA05208@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: PATCH - lowest gt64260 irq
Date: Fri, 21 Dec 2001 15:37:40 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch removes the restriction that the
"canonical" gt64260 irq [as gt64260_get_irq()
sees it] always be the same as the Linux irq.




===== include/asm-ppc/gt64260.h 1.6 vs edited =====
*** /tmp/gt64260.h-1.6-8399	Mon Dec 17 17:35:17 2001
--- edited/include/asm-ppc/gt64260.h	Wed Dec 19 19:17:27 2001
***************
*** 30,35 ****
--- 30,36 ----


  extern u32     gt64260_base;
+ extern u32     gt64260_firstIRQ;     /* We handle the next 96 IRQs from here */
  extern u32     gt64260_revision;
  extern u8      gt64260_pci_exclude_bridge;

===== arch/ppc/kernel/gt64260_pic.c 1.4 vs edited =====
*** /tmp/gt64260_pic.c-1.4-8399	Mon Dec 17 17:10:23 2001
--- edited/arch/ppc/kernel/gt64260_pic.c	Wed Dec 19 19:32:57 2001
***************
*** 68,73 ****
--- 68,76 ----
  	NULL				/* set_affinity */
  };

+ u32 gt64260_firstIRQ = 0;      /* GT64260 handles the next 96 IRQs from here */
+
+
  /* gt64260_init_irq()
   *
   *  This function initializes the interrupt controller. It assigns
***************
*** 117,127 ****

  	/* use the gt64260 for all (possible) interrupt sources */

! 	for ( i = 0 ; i < 96 ; i++ )
  		irq_desc[i].handler = &gt64260_pic;

  	if ( ppc_md.progress ) ppc_md.progress("gt64260_init_irq: exit", 0x0);
- 	return;
  }


--- 120,130 ----

  	/* use the gt64260 for all (possible) interrupt sources */

! 	for( i = gt64260_firstIRQ;  i < (gt64260_firstIRQ + 96);  i++ )  {
  	        irq_desc[i].handler = &gt64260_pic;
+ 	}

  	if ( ppc_md.progress ) ppc_md.progress("gt64260_init_irq: exit", 0x0);
  }


***************
*** 178,184 ****
  		}
  	}

! 	return irq;
  }

  /* gt64260_unmask_irq()
--- 181,187 ----
  		}
  	}

! 	return( irq + gt64260_firstIRQ );
  }

  /* gt64260_unmask_irq()
***************
*** 198,203 ****
--- 201,207 ----
  static void
  gt64260_unmask_irq(unsigned int irq)
  {
+ 	irq -= gt64260_firstIRQ;
  	if (irq > 31) {
  		if (irq > 63) {
  			/* unmask GPP irq */
***************
*** 233,238 ****
--- 237,243 ----
  static void
  gt64260_mask_irq(unsigned int irq)
  {
+ 	irq -= gt64260_firstIRQ;
  	if (irq > 31) {
  		if (irq > 63) {
  			/* mask GPP irq */
***************
*** 252,265 ****
  	if (irq == 36) { /* Seems necessary for SDMA interrupts */
  		udelay(1);
  	}
-
- 	return;
  }


  /* gt64260_mask_irq()
   *
!  *  This funktion disables and acknowledges the requested interrupt.
   *
   * Input Variable(s):
   *  unsigned int	interrupt number (IRQ0...IRQ95).
--- 257,268 ----
  	if (irq == 36) { /* Seems necessary for SDMA interrupts */
  		udelay(1);
  	}
  }


  /* gt64260_mask_irq()
   *
!  *  This function disables and acknowledges the requested interrupt.
   *
   * Input Variable(s):
   *  unsigned int	interrupt number (IRQ0...IRQ95).
***************
*** 305,316 ****
  static void
  gt64260_post_irq(struct pt_regs *regs, int irq)
  {
! 	if (irq >= 64) {
  again:
! 		GT64260_REG_WRITE(GT_GPP_ICR, ~(1<<(irq-64)));
  		if ((GTREGREAD(GPP_VALUE)
  		     & ppc_cached_irq_mask[2]
! 		     & (1<<(irq-64))) != 0) {
  			ppc_irq_dispatch_handler(regs, irq);
  			goto again;
  		}
--- 308,321 ----
  static void
  gt64260_post_irq(struct pt_regs *regs, int irq)
  {
! 	int irqC = irq - gt64260_firstIRQ;             /* IRQ canonicalized */
!
! 	if (irqC >= 64) {
  again:
! 		GT64260_REG_WRITE(GT_GPP_ICR, ~(1<<(irqC-64)));
  		if ((GTREGREAD(GPP_VALUE)
  		     & ppc_cached_irq_mask[2]
! 		     & (1<<(irqC-64))) != 0) {
  			ppc_irq_dispatch_handler(regs, irq);
  			goto again;
  		}
***************
*** 323,344 ****
  gt64260_end_irq(unsigned int irq)
  {
  	u32	val;

!         if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
                  gt64260_unmask_irq(irq);
  	}

! 	if (irq > 63) {
  again:
  		val = GT64260_REG_READ(GT64260_GPP_VALUE);

! 		if ((val & ppc_cached_irq_mask[2] & (1<<(irq-64))) != 0) {
  			GT64260_REG_WRITE(GT64260_GPP_INTR_CAUSE,
! 					  ~(1<<(irq-64)));
! 			ppc_irq_dispatch_handler(NULL, irq);
  			goto again;
  		}
  	}
-
- 	return;
  }
--- 328,350 ----
  gt64260_end_irq(unsigned int irq)
  {
  	u32	val;
+ 	int     irqC = irq - gt64260_firstIRQ;          /* IRQ canonicalized */

!
!         if (!(irq_desc[irqC].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
                  gt64260_unmask_irq(irq);
  	}

! 	if (irqC > 63) {
  again:
  		val = GT64260_REG_READ(GT64260_GPP_VALUE);

! 		if ((val & ppc_cached_irq_mask[2] & (1<<(irqC-64))) != 0) {
  			GT64260_REG_WRITE(GT64260_GPP_INTR_CAUSE,
! 					  ~(1<<(irqC-64)));
! 			ppc_irq_dispatch_handler(NULL, irq);   /* Recursion! */
  			goto again;
  		}
  	}
  }
+
===== drivers/net/gt64260_eth.c 1.6 vs edited =====
*** /tmp/gt64260_eth.c-1.6-8399	Tue Nov 20 13:25:46 2001
--- edited/drivers/net/gt64260_eth.c	Fri Dec 21 20:28:33 2001
***************
*** 872,883 ****
           EVB64260_ETH_irq[port]++     )
      {
  #endif
!         retval = request_irq( GT64260_ETH_irq[port],
                                gt64260_eth_int_handler,
                               (SA_INTERRUPT | SA_SAMPLE_RANDOM),
                               "GT64260_Eth", dev );
          if( !retval )  {
!             dev->irq = GT64260_ETH_irq[port];
              printk( "gt64260_eth_open : Assigned IRQ %d to gt64260_eth%d\n",
                                                                dev->irq, port );
  #if 0 /* XXXX */
--- 898,909 ----
           EVB64260_ETH_irq[port]++     )
      {
  #endif
!         retval = request_irq( GT64260_ETH_irq[port] + gt64260_firstIRQ,
                                gt64260_eth_int_handler,
                               (SA_INTERRUPT | SA_SAMPLE_RANDOM),
                               "GT64260_Eth", dev );
          if( !retval )  {
!             dev->irq = GT64260_ETH_irq[port] + gt64260_firstIRQ;
              printk( "gt64260_eth_open : Assigned IRQ %d to gt64260_eth%d\n",
                                                                dev->irq, port );
  #if 0 /* XXXX */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
