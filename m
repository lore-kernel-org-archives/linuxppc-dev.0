Date: Sat, 11 Aug 2001 00:18:58 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200108110718.AAA01730@krakatoa.gigabitnetworks.com>
To: dan@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	cort@cs.nmt.edu
Subject: MPC8240 EPIC Driver (Attached)
Cc: jfd@cs.stanford.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary=41b3_3d61-1e55_8c8-2620_77e6
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--41b3_3d61-1e55_8c8-2620_77e6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: 7UwRGxsnS/eLTVyAxGzatA==
X-Sun-Data-Type: text


A while ago, I posted some questions on getting the OpenPIC driver working
correctly for the EPIC (Embedded Programmable Interrupt Controller) internal
to the MPC8240. After several attempts on open_pic.*, I gave up, and ported a
an existing driver.

The attached files function as an interrupt driver for MPC8240 (PPC603)
systems with the internal EPIC operating in discrete mode. In this mode,
IRQ's are connected to the MPC8240 EPIC and the 8259 cascade function
is not needed. Typically, one or more PCI devices will use one of IRQ X (0-5)
on the MPC8240 EPIC, these interrupts will be received as EPIC_VECTOR_XX
and perform the EPIC EOI handling. Interrupts can be nested, such that higher
priority interrupts are not blocked out. For more information, see the Motorola
MPC8240 Users Manual, Chapter 11, Embedded Programmable Interrupt Controller.
Also, although I have not checked, I am pretty sure the same logic is in the
MPC8245.

If anyone has improvements or suggestions on how to improve this driver,
please email me directly.


					Thanks,
					-James

--41b3_3d61-1e55_8c8-2620_77e6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: TVs4pttKiqSYumMyVeMyTg==
Content-Description: mpc8240_pic.h
X-Sun-Data-Type: h-file

/*
 *   arch/ppc/kernel/mpc8240_pic.h ---- MPC8240 EPIC Interrupt Controller
 *
 *   Copyright (C) 2001  James Dougherty (jfd@cs.stanford.edu)
 *   Copyright (C) 1999  Motorola Inc.
 *
 *   Modification History:
 *   =====================
 *   01a,04Feb99,My  Created.
 *
*/
#ifndef _PPC_KERNEL_PPC8240_H
#define _PPC_KERNEL_PPC8240_H

#include "local_irq.h"
extern void* EPIC_Addr;
/*
 * All of these registers are accessed from the EPIC_BASE
 * which is the EUMBBAR BASE + EPIC_EUMBBAR_OFFSET address
 * that gets remapped in mpc10x_bridge_init()
 */
#define EPIC_EUMBBAR_OFFSET 	 0x40000  /* Offset of EPIC from EUMBBAR*/
#define EPIC_FEATURES_REG	 0x01000  /* Feature reporting */
#define EPIC_GLOBAL_REG		 0x01020  /* Global config.  */
#define EPIC_INT_CONF_REG	 0x01030  /* Interrupt config. */
#define EPIC_VENDOR_ID_REG	 0x01080  /* Vendor id */
#define EPIC_PROC_INIT_REG	 0x01090  /* Processor init. */
#define EPIC_SPUR_VEC_REG	 0x010e0  /* Spurious vector */
#define EPIC_TM_FREQ_REG	 0x010f0  /* Timer Frequency */

#define EPIC_TM0_CUR_COUNT_REG	 0x01100  /* Gbl TM0 Cur. Count*/
#define EPIC_TM0_BASE_COUNT_REG	 0x01110  /* Gbl TM0 Base Count*/
#define EPIC_TM0_VEC_REG	 0x01120  /* Gbl TM0 Vector Pri*/
#define EPIC_TM0_DES_REG	 0x01130  /* Gbl TM0 Dest. */

#define EPIC_TM1_CUR_COUNT_REG	 0x01140  /* Gbl TM1 Cur. Count*/
#define EPIC_TM1_BASE_COUNT_REG	 0x01150  /* Gbl TM1 Base Count*/
#define EPIC_TM1_VEC_REG	 0x01160  /* Gbl TM1 Vector Pri*/
#define EPIC_TM1_DES_REG	 0x01170  /* Gbl TM1 Dest. */

#define EPIC_TM2_CUR_COUNT_REG	 0x01180  /* Gbl TM2 Cur. Count*/
#define EPIC_TM2_BASE_COUNT_REG	 0x01190  /* Gbl TM2 Base Count*/
#define EPIC_TM2_VEC_REG	 0x011a0  /* Gbl TM2 Vector Pri*/
#define EPIC_TM2_DES_REG	 0x011b0  /* Gbl TM2 Dest */

#define EPIC_TM3_CUR_COUNT_REG	 0x011c0  /* Gbl TM3 Cur. Count*/
#define EPIC_TM3_BASE_COUNT_REG	 0x011d0  /* Gbl TM3 Base Count*/
#define EPIC_TM3_VEC_REG	 0x011e0  /* Gbl TM3 Vector Pri*/
#define EPIC_TM3_DES_REG	 0x011f0  /* Gbl TM3 Dest. */

#define EPIC_TMx_CUR_COUNT_REG(x)	(EPIC_TM0_CUR_COUNT_REG  + 0x40 * (x))
#define EPIC_TMx_BASE_COUNT_REG(x)	(EPIC_TM0_BASE_COUNT_REG + 0x40 * (x))
#define EPIC_TMx_VEC_REG(x)		(EPIC_TM0_VEC_REG        + 0x40 * (x))
#define EPIC_TMx_DES_REG(x)		(EPIC_TM0_DES_REG        + 0x40 * (x))

#define EPIC_EX_INT0_VEC_REG	 0x10200  /* Ext. Int. Sr0 Des */
#define EPIC_EX_INT0_DES_REG	 0x10210  /* Ext. Int. Sr0 Vect*/
#define EPIC_EX_INT1_VEC_REG	 0x10220  /* Ext. Int. Sr1 Des */
#define EPIC_EX_INT1_DES_REG	 0x10230  /* Ext. Int. Sr1 Vect*/
#define EPIC_EX_INT2_VEC_REG	 0x10240  /* Ext. Int. Sr2 Des */
#define EPIC_EX_INT2_DES_REG	 0x10250  /* Ext. Int. Sr2 Vect*/
#define EPIC_EX_INT3_VEC_REG	 0x10260  /* Ext. Int. Sr3 Des */
#define EPIC_EX_INT3_DES_REG	 0x10270  /* Ext. Int. Sr3 Vect*/
#define EPIC_EX_INT4_VEC_REG	 0x10280  /* Ext. Int. Sr4 Des */
#define EPIC_EX_INT4_DES_REG	 0x10290  /* Ext. Int. Sr4 Vect*/

#define EPIC_EX_INTx_VEC_REG(x)		(EPIC_EX_INT0_VEC_REG + (x) * 0x20)
#define EPIC_EX_INTx_DES_REG(x)		(EPIC_EX_INT0_DES_REG + (x) * 0x20)

#define EPIC_SR_INT0_VEC_REG	 0x10200  /* Sr. Int. Sr0 Des */
#define EPIC_SR_INT0_DES_REG	 0x10210  /* Sr. Int. Sr0 Vect */
#define EPIC_SR_INT1_VEC_REG	 0x10220  /* Sr. Int. Sr1 Des */
#define EPIC_SR_INT1_DES_REG	 0x10230  /* Sr. Int. Sr1 Vect.*/
#define EPIC_SR_INT2_VEC_REG	 0x10240  /* Sr. Int. Sr2 Des */
#define EPIC_SR_INT2_DES_REG	 0x10250  /* Sr. Int. Sr2 Vect.*/
#define EPIC_SR_INT3_VEC_REG	 0x10260  /* Sr. Int. Sr3 Des */
#define EPIC_SR_INT3_DES_REG	 0x10270  /* Sr. Int. Sr3 Vect.*/
#define EPIC_SR_INT4_VEC_REG	 0x10280  /* Sr. Int. Sr4 Des */
#define EPIC_SR_INT4_DES_REG	 0x10290  /* Sr. Int. Sr4 Vect.*/

#define EPIC_SR_INT5_VEC_REG	 0x102a0  /* Sr. Int. Sr5 Des */
#define EPIC_SR_INT5_DES_REG	 0x102b0  /* Sr. Int. Sr5 Vect.*/
#define EPIC_SR_INT6_VEC_REG	 0x102c0  /* Sr. Int. Sr6 Des */
#define EPIC_SR_INT6_DES_REG	 0x102d0  /* Sr. Int. Sr6 Vect.*/
#define EPIC_SR_INT7_VEC_REG	 0x102e0  /* Sr. Int. Sr7 Des */
#define EPIC_SR_INT7_DES_REG	 0x102f0  /* Sr. Int. Sr7 Vect.*/
#define EPIC_SR_INT8_VEC_REG	 0x10300  /* Sr. Int. Sr8 Des */
#define EPIC_SR_INT8_DES_REG	 0x10310  /* Sr. Int. Sr8 Vect.*/
#define EPIC_SR_INT9_VEC_REG	 0x10320  /* Sr. Int. Sr9 Des */
#define EPIC_SR_INT9_DES_REG	 0x10330  /* Sr. Int. Sr9 Vect.*/

#define EPIC_SR_INT10_VEC_REG	 0x10340  /* Sr. Int. Sr10 Des */
#define EPIC_SR_INT10_DES_REG	 0x10350  /* Sr. Int. Sr10 Vect*/
#define EPIC_SR_INT11_VEC_REG	 0x10360  /* Sr. Int. Sr11 Des */
#define EPIC_SR_INT11_DES_REG	 0x10370  /* Sr. Int. Sr11 Vect*/
#define EPIC_SR_INT12_VEC_REG	 0x10380  /* Sr. Int. Sr12 Des */
#define EPIC_SR_INT12_DES_REG	 0x10390  /* Sr. Int. Sr12 Vect*/
#define EPIC_SR_INT13_VEC_REG	 0x103a0  /* Sr. Int. Sr13 Des */
#define EPIC_SR_INT13_DES_REG	 0x103b0  /* Sr. Int. Sr13 Vect*/
#define EPIC_SR_INT14_VEC_REG	 0x103c0  /* Sr. Int. Sr14 Des */
#define EPIC_SR_INT14_DES_REG	 0x103d0  /* Sr. Int. Sr14 Vect*/
#define EPIC_SR_INT15_VEC_REG	 0x103e0  /* Sr. Int. Sr15 Des */
#define EPIC_SR_INT15_DES_REG	 0x103f0  /* Sr. Int. Sr15 Vect*/

#define EPIC_SR_INTx_VEC_REG(x)		(EPIC_SR_INT0_VEC_REG + (x) * 0x20)
#define EPIC_SR_INTx_DES_REG(x)		(EPIC_SR_INT0_DES_REG + (x) * 0x20)

#define EPIC_I2C_INT_VEC_REG	 0x11020  /* I2C Int. Vect Pri.*/
#define EPIC_I2C_INT_DES_REG	 0x11030  /* I2C Int. Dest */
#define EPIC_DMA0_INT_VEC_REG	 0x11040  /* DMA0 Int. Vect Pri*/
#define EPIC_DMA0_INT_DES_REG	 0x11050  /* DMA0 Int. Dest */
#define EPIC_DMA1_INT_VEC_REG	 0x11060  /* DMA1 Int. Vect Pri*/
#define EPIC_DMA1_INT_DES_REG	 0x11070  /* DMA1 Int. Dest */
#define EPIC_MSG_INT_VEC_REG	 0x110c0  /* Msg Int. Vect Pri*/
#define EPIC_MSG_INT_DES_REG	 0x110d0  /* Msg Int. Dest  */

#define	EPIC_VECREG_PRIO_SHFT	16
#define	EPIC_VECREG_PRIO_MASK	(0xf << EPIC_EIS_PRIO_SHFT)
#define	EPIC_VECREG_VEC_SHFT	0
#define	EPIC_VECREG_VEC_MASK	(0xff << EPIC_EIS_VEC_SHFT)
#define	EPIC_VECREG_M		(1<<31)	/* MASK bit */
#define	EPIC_VECREG_A		(1<<30)	/* Activity  */
#define	EPIC_VECREG_P		(1<<23)	/* Polarity */
#define	EPIC_VECREG_S		(1<<22)	/* Sense */

#define EPIC_VECTOR_EXT0	0
#define EPIC_VECTOR_EXT1	1
#define EPIC_VECTOR_EXT2	2
#define EPIC_VECTOR_EXT3	3
#define EPIC_VECTOR_EXT4	4
#define EPIC_VECTOR_TM0		16
#define EPIC_VECTOR_TM1		17
#define EPIC_VECTOR_TM2		18
#define EPIC_VECTOR_TM3		19
#define EPIC_VECTOR_I2C		20
#define EPIC_VECTOR_DMA0	21
#define EPIC_VECTOR_DMA1	22
#define EPIC_VECTOR_I2O		23

#define	EPIC_VECTOR_CNT		0x100
#define EPIC_VECTOR_USED	24

#define	EPIC_GCR_RESET		(1<<31)
#define	EPIC_GCR_M		(1<<29)

#define	EPIC_ICR_R_SHFT		28
#define	EPIC_ICR_R_MASK		(7<<EPIC_ICR_R_SHFT)
#define	EPIC_ICR_SIE		(1<<27)


#define EPIC_PROC_CTASK_PRI_REG	 0x20080  /* Proc. current task*/
#define EPIC_PROC_INT_ACK_REG	 0x200a0  /* Int. acknowledge */
#define EPIC_PROC_EOI_REG	 0x200b0  /* End of interrupt */


#define EPIC_DIRECT_IRQ		0
#define EPIC_VEC_REG_INTERVAL	0x20	/* Distance between int. vector regs */
#define EPIC_VEC_SPURIOUS       127     /* Spurious interrupt */

extern struct hw_interrupt_type ppc8240_pic;

void mpc8240_pic_init(void);

void mpc8240_do_IRQ(struct pt_regs *regs,
                 int            cpu,
                 int            isfake);

int mpc8240_get_irq(struct pt_regs *regs);
void mpc8240_set_timer(int i, u_int freq);

#endif /* _PPC_KERNEL_PPC8260_H */
--41b3_3d61-1e55_8c8-2620_77e6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: IREIt2AX+GTMPpr8T1SoGA==
Content-Description: mpc8240_pic.c
X-Sun-Data-Type: c-file

/*
 *  arch/ppc/kernel/mpc8240_pic.c -- MPC8240 EPIC Interrupt Handling
 *
 *  Copyright (C) 2001 James Dougherty (jfd@cs.stanford.edu)
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License.  See the file COPYING in the main directory of this archive
 *  for more details.
 */
#include <linux/config.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <asm/ptrace.h>
#include <asm/signal.h>
#include <asm/io.h>
#include <asm/irq.h>

#include "mpc10x.h"
#include "mpc8240_pic.h"

void* EPIC_Addr;

static inline u_int
epic_read(u_int reg)
{
  return in_le32(((volatile u_int*)((u_int)EPIC_Addr + reg)));
}

static inline void
epic_write(u_int reg, u_int val)
{
  out_le32(((volatile u_int*)((u_int)EPIC_Addr+reg)), val);
}

/*
 * Typedef: epic_table_t
 * Purpose: Defines an entry in the EPIC table indexed by vector.
 *	    Each entry represents a vector that is permanently
 *	    assigned to a specific function as follows (see definitions
 *	    for EPIC_VECTOR_xxx):
 *
 *	Vector(s)	Assignment
 *	---------	-------------------
 *	0-15		External (and unused serial interrupts)
 *	16-19		Global timers
 *	20		I2C
 *	21-22		DMA
 *	23		I2O message
 *
 * NOTE: Higher priority numbers represent higher priority.
 */

typedef struct epic_table_s {
    int		et_prio;	/* Interrupt priority, fixed */
    /* IRQ handler to call, set when connected */
    void (*et_func)(int, void *, struct pt_regs *);
    int		et_par;		/* Param to func, set when connected */
    u_int	et_vecadr;	/* Address of EPIC vector register */
    u_int 	et_desadr;	/* Address of EPIC destination register */
} epic_table_t;

static epic_table_t epic_table[EPIC_VECTOR_USED] = {
  /* 0  */  {  5, 0, 0, EPIC_EX_INTx_VEC_REG(0),  EPIC_EX_INTx_DES_REG(0)  },
  /* 1  */  {  5, 0, 0, EPIC_EX_INTx_VEC_REG(1),  EPIC_EX_INTx_DES_REG(1)  },
  /* 2  */  {  5, 0, 0, EPIC_EX_INTx_VEC_REG(2),  EPIC_EX_INTx_DES_REG(2)  },
  /* 3  */  {  5, 0, 0, EPIC_EX_INTx_VEC_REG(3),  EPIC_EX_INTx_DES_REG(3)  },
  /* 4  */  { 10, 0, 0, EPIC_EX_INTx_VEC_REG(4),  EPIC_EX_INTx_DES_REG(4)  },
  /* 5  */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(5),  EPIC_SR_INTx_DES_REG(5)  },
  /* 6  */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(6),  EPIC_SR_INTx_DES_REG(6)  },
  /* 7  */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(7),  EPIC_SR_INTx_DES_REG(7)  },
  /* 8  */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(8),  EPIC_SR_INTx_DES_REG(8)  },
  /* 9  */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(9),  EPIC_SR_INTx_DES_REG(9)  },
  /* 10 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(10), EPIC_SR_INTx_DES_REG(10) },
  /* 11 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(11), EPIC_SR_INTx_DES_REG(11) },
  /* 12 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(12), EPIC_SR_INTx_DES_REG(12) },
  /* 13 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(13), EPIC_SR_INTx_DES_REG(13) },
  /* 14 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(14), EPIC_SR_INTx_DES_REG(14) },
  /* 15 */  {  5, 0, 0, EPIC_SR_INTx_VEC_REG(15), EPIC_SR_INTx_DES_REG(15) },
  /* 16 */  {  8, 0, 0, EPIC_TMx_VEC_REG(0),      EPIC_TMx_DES_REG(0)      },
  /* 17 */  {  5, 0, 0, EPIC_TMx_VEC_REG(1),      EPIC_TMx_DES_REG(1)      },
  /* 18 */  {  5, 0, 0, EPIC_TMx_VEC_REG(2),      EPIC_TMx_DES_REG(2)      },
  /* 19 */  {  5, 0, 0, EPIC_TMx_VEC_REG(3),      EPIC_TMx_DES_REG(3)      },
  /* 20 */  {  5, 0, 0, EPIC_I2C_INT_VEC_REG,     EPIC_I2C_INT_DES_REG     },
  /* 21 */  {  5, 0, 0, EPIC_DMA0_INT_VEC_REG,    EPIC_DMA0_INT_DES_REG    },
  /* 22 */  {  5, 0, 0, EPIC_DMA1_INT_VEC_REG,    EPIC_DMA1_INT_DES_REG    },
  /* 23 */  {  5, 0, 0, EPIC_MSG_INT_VEC_REG,     EPIC_MSG_INT_DES_REG     },
};

#define NUM_EPIC_SOURCES   (sizeof(epic_table)/sizeof(epic_table[0]))

void
mpc8240_set_timer(int i, u_int freq)
{
  switch(i){
  case 0:
    epic_write(EPIC_TM0_BASE_COUNT_REG, freq);
    break;
  case 1:
    epic_write(EPIC_TM1_BASE_COUNT_REG, freq);
    break;
  case 2:
    epic_write(EPIC_TM2_BASE_COUNT_REG, freq);
    break;
  case 3:
    epic_write(EPIC_TM3_BASE_COUNT_REG, freq);
    break;
  default:
    break;
  }
}


/*
 *  Enable/disable an external interrupt source
 *
 *  Externally called, irq is an offseted system-wide interrupt number
 */
void
mpc8240_enable_irq(u_int irq)
{
    epic_table_t	*et ;
    u_int 		vecreg;

    if (irq < 0 || irq > NUM_EPIC_SOURCES)
      return;

    et = epic_table + irq;
#if CONFIG_SANDPOINT_DEBUG
    if( irq != 1){
      sandpoint_progress("enable irq:",0x122);
      sandpoint_printhex(irq,1);
    }
#endif
#if 0
    if (NULL == et->et_func) {
	return(ERROR);
    }
    printf("EPIC: interrupt enable --- <vec=0x%x level=0x%x prio=0x%x>\n",
	   vec, et->et_level, et->et_prio);
#endif

    /*
     * Look up the interrupt level for the vector and enable that level
     * setting the correct vector #, priority,
     */
    vecreg = (et->et_prio << EPIC_VECREG_PRIO_SHFT |
	      irq << EPIC_VECREG_VEC_SHFT);

    /* MPC8240 EPIC in Discrete mode, IRQ 0-4 external */
    if (irq >= EPIC_VECTOR_EXT0 && irq <= EPIC_VECTOR_EXT4)
	vecreg |= EPIC_VECREG_S;	/* Set sense bit */

    epic_write(et->et_vecadr, vecreg);

    /* Direct the interrupt to this processor */
    epic_write(et->et_desadr, 1);

    mb(); /* sync */
}


/*
 * Disable an EPIC interrupt.
 */
static void
mpc8240_disable_irq(u_int irq)
{
    epic_table_t	*et ;
    u_int		vecreg;

    if (irq < 0 || irq > NUM_EPIC_SOURCES)
      return;

    et = epic_table + irq;

#if 0
    if (NULL == et->et_func)
      return;
#endif

    /* Set mask bit */
    vecreg = epic_read(et->et_vecadr);
    vecreg |= EPIC_VECREG_M;
    epic_write(et->et_vecadr, vecreg);

    mb();  /* sync */

}



/*
 * Disabled and Acknowledge an EPIC interrupt.
 */
void
mpc8240_ack_irq(u_int irq)
{
  mpc8240_disable_irq(irq);

  if ((irq_desc[irq].status & IRQ_LEVEL) != 0)
    epic_write(EPIC_PROC_EOI_REG, 0x0);  /* Signal EOI */
}


/*
 * Acknowledge and re-enable an EPIC Interrupt
 */
void
mpc8240_end_irq(u_int irq)
{

  if ((irq_desc[irq].status & IRQ_LEVEL) != 0)
    epic_write(EPIC_PROC_EOI_REG, 0x0);  /* Signal EOI */

  if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
   mpc8240_enable_irq(irq);

}




/*
 * Configure an EPIC interrupt with a given vector and prio.
 * Parameters:	vec - interrupt vector number/level
 *		prio - PPC interrupt priority
 *		func - function to call
 *		par - parameter passed to func on interrupt.
 * Returns:	0, -1 on error
 */
int
mpc8240_int_configure(int vec, int prio,
		      void (*func)(int, void *, struct pt_regs *),
		      int par)
{
    epic_table_t *et = &epic_table[vec];

    if (NULL != et->et_func || vec < 0 || vec >= EPIC_VECTOR_USED) {
	return -1;
    }
    et->et_func	 = func;
    et->et_par	 = par;
    et->et_prio	 = prio;
    return 0;
}

struct hw_interrupt_type mpc8240_pic = {
	" MPC8240 EPIC  ",
	NULL,
	NULL,
	mpc8240_enable_irq,
	mpc8240_disable_irq,
#if 1
	0,0,
#else
	mpc8240_ack_irq,
	mpc8240_end_irq,
#endif
	0
};


/*
 * Initialize the MPC8240 EPIC
 * Use discrete mode, which allows for IRQ0-4 to be directed
 * from up to 5 external sources.
 */
void
mpc8240_pic_init(void)
{
    int                 i;
    u_int               tmp;
    epic_table_t	*et ;
    u_int		vecreg;

    /* Set current task priority to 0 */
    epic_write(EPIC_PROC_CTASK_PRI_REG, 0);

    /* Set reset bit and wait for reset to complete */
    epic_write(EPIC_GLOBAL_REG, EPIC_GCR_RESET);
    while (epic_read(EPIC_GLOBAL_REG) & EPIC_GCR_RESET)
	;

    /* Set current task priority to 0 */
    epic_write(EPIC_PROC_CTASK_PRI_REG, 0);

    /* Discrete ints please */
    epic_write(EPIC_GLOBAL_REG, EPIC_GCR_M); /* GCR[M]=1 */

    /* Set direct interrupts (disable serial interrupts) */
    tmp = epic_read(EPIC_INT_CONF_REG);
    epic_write(EPIC_INT_CONF_REG, tmp & ~EPIC_ICR_SIE);

#if 1
    /* Set serial mode and frequency */
    tmp = epic_read(EPIC_INT_CONF_REG);
    tmp &= ~0x70000000; /* Clear bits 27,28,29 */
    tmp |=  0x40000000; /* Set bit 29 */
    epic_write(EPIC_INT_CONF_REG, tmp);
#endif

    /* Clear M Bit in all vectors */
    for( vecreg = 0; vecreg < NUM_EPIC_SOURCES; vecreg ++){
      et = epic_table + vecreg;
      /* Mask all IRQ's mask bit */
      vecreg = epic_read(et->et_vecadr);
      vecreg |= EPIC_VECREG_M;
      epic_write(et->et_vecadr, vecreg);
    }


    /* Clear all pending interrupt */
    while (epic_read(EPIC_PROC_INT_ACK_REG) != 0xff);

    /* Set current task priority to 0 */
    epic_write(EPIC_PROC_CTASK_PRI_REG, 0);

    /* Publish interface */
    for(i = 0; i < NUM_EPIC_SOURCES; i++) {
      irq_desc[i].handler = &mpc8240_pic;
      irq_desc[i].status |= IRQ_DISABLED | IRQ_LEVEL;
    }

    /*
     * Set clock rate to default just in case, which is 1/8 of the timebase
     * divider input frequency.  The PPC timebase counter itself operates
     * at 1/4 the divider input frequency (twice the aux clock).
     */
    mpc8240_set_timer(0, 33000000 );

#if CONFIG_SANDPOINT_DEBUG
    sandpoint_progress("timer0:ok ",0);
#endif

    if ( ppc_md.progress ) ppc_md.progress(" mpc8240_epic_init_ok ",0x122);

}

/*
 * Handle an interrupt from the EPIC.
 */
int
do_IRQ(struct pt_regs *regs,
       int            cpu,
       int            isfake)
{
    int          irq, msr;
    u_int        o_pri;			/* Old priority */
    epic_table_t *et;

    /*    int cpu = smp_processor_id();*/

    hardirq_enter(cpu);


    irq = epic_read(EPIC_PROC_INT_ACK_REG) ;
    et  = epic_table + irq;
#if CONFIG_SANDPOINT_DEBUG
    if( irq != 0){
      sandpoint_progress(" do_IRQ:",0x122);
      sandpoint_printhex(irq,1);
    }
#endif
    if (irq < 0) {
      if( irq != -2){
	printk(KERN_DEBUG "Bogus interrupt %d from PC = %lx\n",
	       irq, regs->nip);
	ppc_spurious_interrupts++;
      }
      goto out;
    }
    else if ((irq >= 0) && (irq < EPIC_VECTOR_USED)) {
      o_pri = epic_read(EPIC_PROC_CTASK_PRI_REG); 	/* Save prev level */
      epic_write(EPIC_PROC_CTASK_PRI_REG, et->et_prio);/* Set task level */

      /* Allow nesting */
      save_flags(msr);
      msr |=MSR_EE;
      restore_flags(msr);

      ppc_irq_dispatch_handler( regs, irq ); /* Call IRQ handler */

      if ( ppc_md.post_irq)
           ppc_md.post_irq(regs, irq);

      epic_write(EPIC_PROC_CTASK_PRI_REG, o_pri);   /* Restore level */
      epic_write(EPIC_PROC_EOI_REG, 0x0);	    /* Signal EOI */
    }

 out:
    hardirq_exit(cpu);
    return 1;
}

/*
 * Get current EPIC Interrupt
 */
int
mpc8240_get_irq(struct pt_regs *regs)
{
    int irq;
    irq = epic_read(EPIC_PROC_INT_ACK_REG) ;
    return irq;
}


--41b3_3d61-1e55_8c8-2620_77e6--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
