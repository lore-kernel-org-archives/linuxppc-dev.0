Date: Mon, 9 Jul 2001 14:57:24 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200107092157.OAA18907@krakatoa.gigabitnetworks.com>
To: dan@mvista.com, anj@aps.anl.gov
Subject: Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
Cc: jfd@GigabitNetworks.COM, linuxppc-embedded@lists.linuxppc.org,
	cort@cs.nmt.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary=2297_15d4-7016_3d23-1911_358b
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--2297_15d4-7016_3d23-1911_358b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: fF9GQTB1987bMt/Z82r17w==
X-Sun-Data-Type: text

Thanks Dan, Thanks Andrew,

I am using MVista spdemo-linux-2.3.16-2000.02.10 from
ftp://ftp.mvista.com/pub/Area51/Sandpoint-8240 and
made a change to boot/ns16550.h for COM1 and defined
sandpoint_progress() to get output from the kernel.
Also, I removed the 8259 cascade intterupt and that
got me far enough to see that interrupts are not happening.
It is not a mapping issue though, since the registers can
be dumped and they show the right value.

Dan, is there a more recent version of the kernel source
which I should use?

Andrew, I am using the EPIC in direct (discrete mode) as
you are with EPIC IRQ4=SIO INTR, EPIC IRQ1=Enet Intr,
and EPIC IRQ3=PCI slot. Are you simply defining the
InitSenses[] array with 24 entries and the 0 sense for
UART, 1 for PCI (makes sense since PCI is active high).
If so, what kernel source are you using?

Finally, attached is the MPC8240 EPIC driver I am using
under VxWorks. It simply hooksup the PPC interrupt handler
to use the EPIC interrupt handler and initializes the
controller to run in discrete mode. This seems trivial to
port to Linux, the only question is how to make the
PPC irq handler call the epic IRQ handler.

Many thanks in advance.
					-James


> >
> > I am sure someone out there has had to deal with this issue before, so any
> > pointers in the right direction would be greatly appreciated.
>
> I have HHL2.0 (Linux-2.4.2) running on an MVME2100 board (MPC8240) which
> only uses the interrupts on the built-in EPIC device, no 8259.  I don't
> pretend to fully understand PCI interrupts, but I did discover that the
> OpenPIC_InitSenses[] array is critical to getting interrupts to work, and
> I also had to edit openpic.c to remove the 8259 stuff from
> openpic_get_irq() in my configuration.  You're working with an earlier
> version though, so YMMV.
>
> The openpic driver gets the default number of IRQs from the register on
> the EPIC chip to be 24, but these are not contiguous nor in their
> canonical places, so you need to provide the InitSenses array to let it
> know the real configuration.  I start with 16 zero entries as the first
> EPIC IRQ is offset by 16, then provide up to 16 entries for the real
> serial IRQ inputs to the EPIC.  The value you give to each entry
> determines the polarity / edge-sensitivity; my setup needs 1 for PCI
> devices, but 0 for the 16550 UART.  I'm not sure how you cope with the
> large gap before the I2C and DMA IRQ numbers; it looks like openpic.c
> needs modifying to properly cope with holes in the IRQ space, but it may
> be that you can do this with a cannonicalize_irq() routine (I don't have
> one, but I don't need the high IRQs and they're not essential for Linux to
> run).
>
> I discovered that even without serial interrupts working it was possible
> to type commands to my init shell (mount /proc;cat /proc/interrupts was
> very useful); you just have to wait up to 10 seconds for them to arrive,
> and don't type more than will fill the FIFO; be prepared to wait a while
> for the output to appear too!
>
> - Andrew
> --
> The world is such a cheerful place when viewed from upside-down
> It makes a rise of every fall, a smile of every frown
>
>
--2297_15d4-7016_3d23-1911_358b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: AAAAAAAAAAAAAAAAAAAAAA==
Content-Description: Attachment.txt
X-Sun-Data-Type: text


--2297_15d4-7016_3d23-1911_358b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: oHPqT9uaAb78/OxkQ7eDhQ==
Content-Description: epic.c
X-Sun-Data-Type: c-file

#include "vxWorks.h"
#include "intLib.h"
#include "excLib.h"
#include "epic.h"
#include "mpc107.h"
#include "stdio.h"
#include "string.h"

extern ULONG 	sysEUMBBARRead(ULONG regNum);
extern void 	sysEUMBBARWrite(ULONG regNum, ULONG regVal);

IMPORT STATUS	(*_func_intConnectRtn) (VOIDFUNCPTR *, VOIDFUNCPTR, int);
IMPORT int	(*_func_intEnableRtn) (int);
IMPORT int	(*_func_intDisableRtn)  (int);

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
    VOIDFUNCPTR	et_func;	/* Function to call, set when connected */
    int		et_par;		/* Param to func, set when connected */
    UINT32	et_vecadr;	/* Address of EPIC vector register */
    UINT32	et_desadr;	/* Address of EPIC destination register */
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

STATUS
epic_int_configure(int vec, int prio, VOIDFUNCPTR func, int par)
/*
 * Function: 	epic_int_configure
 * Purpose:	Configure an EPIC interrupt with a given vector and prio.
 * Parameters:	vec - interrupt vector number/level
 *		prio - PPC interrupt priority
 *		func - function to call
 *		par - parameter passed to func on interrupt.
 * Returns:	OK/ERROR
 */
{
    epic_table_t *et = &epic_table[vec];

    if (NULL != et->et_func || vec < 0 || vec >= EPIC_VECTOR_USED) {
	return(ERROR);
    }
    et->et_func	 = func;
    et->et_par	 = par;
    et->et_prio	 = prio;
    return(OK);
}

static STATUS
epic_int_connect(VOIDFUNCPTR *v_ptr, VOIDFUNCPTR rtn, int par)
/*
 * Function: 	epic_int_connect
 * Purpose:	Connect an epic interrupt.
 * Parameters:	v_ptr - vector #.
 *		rtn - function to call.
 *		par - parameter passed to function.
 * Returns:	OK/ERROR
 * Notes:	This routine uses the same priority as found in the table.
 */
{
    int		vec	= (int) v_ptr;

    if (vec < 0 || vec >= EPIC_VECTOR_USED)
	return(ERROR);

    return epic_int_configure(vec, epic_table[vec].et_prio, rtn, par);
}

static	void
epic_int_handler(void)
/*
 * Function: 	epic_int_handler
 * Purpose:	Handle an interrupt from the epic.
 * Parameters:	None.
 * Returns:	Nothing
 */
{
    int	vec;
    ULONG	o_pri;			/* Old priority */
    epic_table_t *et;

    vec = epic_read(EPIC_PROC_INT_ACK_REG) ;
    et  = epic_table + vec;
    if ((vec >= 0) && (vec < EPIC_VECTOR_USED) && (NULL != et->et_func)) {
	o_pri = epic_read(EPIC_PROC_CTASK_PRI_REG); 	/* Save prev level */
	epic_write(EPIC_PROC_CTASK_PRI_REG, et->et_prio);/* Set task level */
	intUnlock (_PPC_MSR_EE);			/* Allow nesting */
	et->et_func(et->et_par);			/* Call handler */
	intLock();
	epic_write(EPIC_PROC_CTASK_PRI_REG, o_pri);	/* Restore  level */
    }
    epic_write(EPIC_PROC_EOI_REG, 0x0);			/* Signal EOI */
}

STATUS
epic_int_enable(int vec)
/*
 * Function: 	epic_int_enable
 * Purpose:	Enable interrupts for the specified vector.
 * Parameters:	vec - vector # to enable interrupts for.
 * Returns:	OK/ERROR
 */
{
    epic_table_t	*et = epic_table + vec;
    UINT32		vecreg;

    if (NULL == et->et_func) {
	return(ERROR);
    }

#if 0
    printf("EPIC: interrupt enable --- <vec=0x%x level=0x%x prio=0x%x>\n",
	   vec, et->et_level, et->et_prio);
#endif

    /*
     * Look up the interrupt level for the vector and enable that level
     * setting the correct vector #, priority,
     */

    vecreg = (et->et_prio << EPIC_VECREG_PRIO_SHFT |
	      vec << EPIC_VECREG_VEC_SHFT);

    if (vec >= EPIC_VECTOR_EXT0 && vec <= EPIC_VECTOR_EXT4)
	vecreg |= EPIC_VECREG_S;	/* Set sense bit */

    epic_write(et->et_vecadr, vecreg);

    /* Direct the interrupt to this processor */
    epic_write(et->et_desadr, 1);

    return(OK);
}

STATUS
epic_int_disable(int vec)
/*
 * Function: 	epic_int_disable
 * Purpose:	Disable interrupts for the specified vector.
 * Parameters:	vec - vector number to disable.
 * Returns:	OK/ERROR
 */
{
    epic_table_t	*et = epic_table + vec;
    UINT32		vecreg;

    if (NULL == et->et_func) {
	return(ERROR);
    }

    /* Set mask bit */

    vecreg = epic_read(et->et_vecadr);
    vecreg |= EPIC_VECREG_M;
    epic_write(et->et_vecadr, vecreg);

    return(OK);
}

void
epic_init(void)
/*
 * Function: 	epic_init
 * Purpose:	Initialize the EPIC for interrupts.
 * Parameters:	None.
 * Returns:	Nothing.
 */
{
    ULONG	tmp;

    /* Set reset bit and wait for reset to complete */

    epic_write(EPIC_GLOBAL_REG, EPIC_GCR_RESET);
    while (epic_read(EPIC_GLOBAL_REG) & EPIC_GCR_RESET)
	;

    /* Discrete ints please */

    epic_write(EPIC_GLOBAL_REG, EPIC_GCR_M);

    /* Set direct interrupts (disable serial interrupts) */

    tmp = epic_read(EPIC_INT_CONF_REG);
    epic_write(EPIC_INT_CONF_REG, tmp & ~EPIC_ICR_SIE);

    /* Clear all pending interrupt */

    while (epic_read(EPIC_PROC_INT_ACK_REG) != 0xff);

    /* Use EPIC only, no winpic stuff. */

    _func_intEnableRtn	= epic_int_enable;
    _func_intDisableRtn = epic_int_disable;
    _func_intConnectRtn = epic_int_connect;

    /* Connect the real PPC vector to our handler. */

    excIntConnect ((VOIDFUNCPTR *) _EXC_OFF_INTR, epic_int_handler);

    /* Set current task priority to 0 */

    epic_write(EPIC_PROC_CTASK_PRI_REG, 0);
}
--2297_15d4-7016_3d23-1911_358b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-MD5: nSRKInRqkNwav3GAvEQI+Q==
Content-Description: epic.h
X-Sun-Data-Type: h-file



/*********************************************
 * Copyrigh 1999  Motorola Inc.
 *
 * Modification History:
 * =====================
 * 01a,04Feb99,My  Created.
 *
*/

#ifndef EPIC_H
#define EPIC_H

#define epic_write(r, v)	sysEUMBBARWrite((r), (v))
#define epic_read(r)		sysEUMBBARRead(r)

#define EPIC_EUMBBAR  		0x40000			/* EUMBBAR of EPIC  */
#define EPIC_FEATURES_REG	(EPIC_EUMBBAR + 0x01000)/* Feature reporting */
#define EPIC_GLOBAL_REG		(EPIC_EUMBBAR + 0x01020)/* Global config.  */
#define EPIC_INT_CONF_REG	(EPIC_EUMBBAR + 0x01030)/* Interrupt config. */
#define EPIC_VENDOR_ID_REG	(EPIC_EUMBBAR + 0x01080)/* Vendor id */
#define EPIC_PROC_INIT_REG	(EPIC_EUMBBAR + 0x01090)/* Processor init. */
#define EPIC_SPUR_VEC_REG	(EPIC_EUMBBAR + 0x010e0)/* Spurious vector */
#define EPIC_TM_FREQ_REG	(EPIC_EUMBBAR + 0x010f0)/* Timer Frequency */

#define EPIC_TM0_CUR_COUNT_REG	(EPIC_EUMBBAR + 0x01100)/* Gbl TM0 Cur. Count*/
#define EPIC_TM0_BASE_COUNT_REG	(EPIC_EUMBBAR + 0x01110)/* Gbl TM0 Base Count*/
#define EPIC_TM0_VEC_REG	(EPIC_EUMBBAR + 0x01120)/* Gbl TM0 Vector Pri*/
#define EPIC_TM0_DES_REG	(EPIC_EUMBBAR + 0x01130)/* Gbl TM0 Dest. */

#define EPIC_TM1_CUR_COUNT_REG	(EPIC_EUMBBAR + 0x01140)/* Gbl TM1 Cur. Count*/
#define EPIC_TM1_BASE_COUNT_REG	(EPIC_EUMBBAR + 0x01150)/* Gbl TM1 Base Count*/
#define EPIC_TM1_VEC_REG	(EPIC_EUMBBAR + 0x01160)/* Gbl TM1 Vector Pri*/
#define EPIC_TM1_DES_REG	(EPIC_EUMBBAR + 0x01170)/* Gbl TM1 Dest. */

#define EPIC_TM2_CUR_COUNT_REG	(EPIC_EUMBBAR + 0x01180)/* Gbl TM2 Cur. Count*/
#define EPIC_TM2_BASE_COUNT_REG	(EPIC_EUMBBAR + 0x01190)/* Gbl TM2 Base Count*/
#define EPIC_TM2_VEC_REG	(EPIC_EUMBBAR + 0x011a0)/* Gbl TM2 Vector Pri*/
#define EPIC_TM2_DES_REG	(EPIC_EUMBBAR + 0x011b0)/* Gbl TM2 Dest */

#define EPIC_TM3_CUR_COUNT_REG	(EPIC_EUMBBAR + 0x011c0)/* Gbl TM3 Cur. Count*/
#define EPIC_TM3_BASE_COUNT_REG	(EPIC_EUMBBAR + 0x011d0)/* Gbl TM3 Base Count*/
#define EPIC_TM3_VEC_REG	(EPIC_EUMBBAR + 0x011e0)/* Gbl TM3 Vector Pri*/
#define EPIC_TM3_DES_REG	(EPIC_EUMBBAR + 0x011f0)/* Gbl TM3 Dest. */

#define EPIC_TMx_CUR_COUNT_REG(x)	(EPIC_TM0_CUR_COUNT_REG  + 0x40 * (x))
#define EPIC_TMx_BASE_COUNT_REG(x)	(EPIC_TM0_BASE_COUNT_REG + 0x40 * (x))
#define EPIC_TMx_VEC_REG(x)		(EPIC_TM0_VEC_REG        + 0x40 * (x))
#define EPIC_TMx_DES_REG(x)		(EPIC_TM0_DES_REG        + 0x40 * (x))

#define EPIC_EX_INT0_VEC_REG	(EPIC_EUMBBAR + 0x10200)/* Ext. Int. Sr0 Des */
#define EPIC_EX_INT0_DES_REG	(EPIC_EUMBBAR + 0x10210)/* Ext. Int. Sr0 Vect*/
#define EPIC_EX_INT1_VEC_REG	(EPIC_EUMBBAR + 0x10220)/* Ext. Int. Sr1 Des */
#define EPIC_EX_INT1_DES_REG	(EPIC_EUMBBAR + 0x10230)/* Ext. Int. Sr1 Vect*/
#define EPIC_EX_INT2_VEC_REG	(EPIC_EUMBBAR + 0x10240)/* Ext. Int. Sr2 Des */
#define EPIC_EX_INT2_DES_REG	(EPIC_EUMBBAR + 0x10250)/* Ext. Int. Sr2 Vect*/
#define EPIC_EX_INT3_VEC_REG	(EPIC_EUMBBAR + 0x10260)/* Ext. Int. Sr3 Des */
#define EPIC_EX_INT3_DES_REG	(EPIC_EUMBBAR + 0x10270)/* Ext. Int. Sr3 Vect*/
#define EPIC_EX_INT4_VEC_REG	(EPIC_EUMBBAR + 0x10280)/* Ext. Int. Sr4 Des */
#define EPIC_EX_INT4_DES_REG	(EPIC_EUMBBAR + 0x10290)/* Ext. Int. Sr4 Vect*/

#define EPIC_EX_INTx_VEC_REG(x)		(EPIC_EX_INT0_VEC_REG + (x) * 0x20)
#define EPIC_EX_INTx_DES_REG(x)		(EPIC_EX_INT0_DES_REG + (x) * 0x20)

#define EPIC_SR_INT0_VEC_REG	(EPIC_EUMBBAR + 0x10200)/* Sr. Int. Sr0 Des */
#define EPIC_SR_INT0_DES_REG	(EPIC_EUMBBAR + 0x10210)/* Sr. Int. Sr0 Vect */
#define EPIC_SR_INT1_VEC_REG	(EPIC_EUMBBAR + 0x10220)/* Sr. Int. Sr1 Des */
#define EPIC_SR_INT1_DES_REG	(EPIC_EUMBBAR + 0x10230)/* Sr. Int. Sr1 Vect.*/
#define EPIC_SR_INT2_VEC_REG	(EPIC_EUMBBAR + 0x10240)/* Sr. Int. Sr2 Des */
#define EPIC_SR_INT2_DES_REG	(EPIC_EUMBBAR + 0x10250)/* Sr. Int. Sr2 Vect.*/
#define EPIC_SR_INT3_VEC_REG	(EPIC_EUMBBAR + 0x10260)/* Sr. Int. Sr3 Des */
#define EPIC_SR_INT3_DES_REG	(EPIC_EUMBBAR + 0x10270)/* Sr. Int. Sr3 Vect.*/
#define EPIC_SR_INT4_VEC_REG	(EPIC_EUMBBAR + 0x10280)/* Sr. Int. Sr4 Des */
#define EPIC_SR_INT4_DES_REG	(EPIC_EUMBBAR + 0x10290)/* Sr. Int. Sr4 Vect.*/

#define EPIC_SR_INT5_VEC_REG	(EPIC_EUMBBAR + 0x102a0)/* Sr. Int. Sr5 Des */
#define EPIC_SR_INT5_DES_REG	(EPIC_EUMBBAR + 0x102b0)/* Sr. Int. Sr5 Vect.*/
#define EPIC_SR_INT6_VEC_REG	(EPIC_EUMBBAR + 0x102c0)/* Sr. Int. Sr6 Des */
#define EPIC_SR_INT6_DES_REG	(EPIC_EUMBBAR + 0x102d0)/* Sr. Int. Sr6 Vect.*/
#define EPIC_SR_INT7_VEC_REG	(EPIC_EUMBBAR + 0x102e0)/* Sr. Int. Sr7 Des */
#define EPIC_SR_INT7_DES_REG	(EPIC_EUMBBAR + 0x102f0)/* Sr. Int. Sr7 Vect.*/
#define EPIC_SR_INT8_VEC_REG	(EPIC_EUMBBAR + 0x10300)/* Sr. Int. Sr8 Des */
#define EPIC_SR_INT8_DES_REG	(EPIC_EUMBBAR + 0x10310)/* Sr. Int. Sr8 Vect.*/
#define EPIC_SR_INT9_VEC_REG	(EPIC_EUMBBAR + 0x10320)/* Sr. Int. Sr9 Des */
#define EPIC_SR_INT9_DES_REG	(EPIC_EUMBBAR + 0x10330)/* Sr. Int. Sr9 Vect.*/

#define EPIC_SR_INT10_VEC_REG	(EPIC_EUMBBAR + 0x10340)/* Sr. Int. Sr10 Des */
#define EPIC_SR_INT10_DES_REG	(EPIC_EUMBBAR + 0x10350)/* Sr. Int. Sr10 Vect*/
#define EPIC_SR_INT11_VEC_REG	(EPIC_EUMBBAR + 0x10360)/* Sr. Int. Sr11 Des */
#define EPIC_SR_INT11_DES_REG	(EPIC_EUMBBAR + 0x10370)/* Sr. Int. Sr11 Vect*/
#define EPIC_SR_INT12_VEC_REG	(EPIC_EUMBBAR + 0x10380)/* Sr. Int. Sr12 Des */
#define EPIC_SR_INT12_DES_REG	(EPIC_EUMBBAR + 0x10390)/* Sr. Int. Sr12 Vect*/
#define EPIC_SR_INT13_VEC_REG	(EPIC_EUMBBAR + 0x103a0)/* Sr. Int. Sr13 Des */
#define EPIC_SR_INT13_DES_REG	(EPIC_EUMBBAR + 0x103b0)/* Sr. Int. Sr13 Vect*/
#define EPIC_SR_INT14_VEC_REG	(EPIC_EUMBBAR + 0x103c0)/* Sr. Int. Sr14 Des */
#define EPIC_SR_INT14_DES_REG	(EPIC_EUMBBAR + 0x103d0)/* Sr. Int. Sr14 Vect*/
#define EPIC_SR_INT15_VEC_REG	(EPIC_EUMBBAR + 0x103e0)/* Sr. Int. Sr15 Des */
#define EPIC_SR_INT15_DES_REG	(EPIC_EUMBBAR + 0x103f0)/* Sr. Int. Sr15 Vect*/

#define EPIC_SR_INTx_VEC_REG(x)		(EPIC_SR_INT0_VEC_REG + (x) * 0x20)
#define EPIC_SR_INTx_DES_REG(x)		(EPIC_SR_INT0_DES_REG + (x) * 0x20)

#define EPIC_I2C_INT_VEC_REG	(EPIC_EUMBBAR + 0x11020)/* I2C Int. Vect Pri.*/
#define EPIC_I2C_INT_DES_REG	(EPIC_EUMBBAR + 0x11030)/* I2C Int. Dest */
#define EPIC_DMA0_INT_VEC_REG	(EPIC_EUMBBAR + 0x11040)/* DMA0 Int. Vect Pri*/
#define EPIC_DMA0_INT_DES_REG	(EPIC_EUMBBAR + 0x11050)/* DMA0 Int. Dest */
#define EPIC_DMA1_INT_VEC_REG	(EPIC_EUMBBAR + 0x11060)/* DMA1 Int. Vect Pri*/
#define EPIC_DMA1_INT_DES_REG	(EPIC_EUMBBAR + 0x11070)/* DMA1 Int. Dest */
#define EPIC_MSG_INT_VEC_REG	(EPIC_EUMBBAR + 0x110c0)/* Msg Int. Vect Pri*/
#define EPIC_MSG_INT_DES_REG	(EPIC_EUMBBAR + 0x110d0)/* Msg Int. Dest  */

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


#define EPIC_PROC_CTASK_PRI_REG	(EPIC_EUMBBAR + 0x20080)/* Proc. current task*/
#define EPIC_PROC_INT_ACK_REG	(EPIC_EUMBBAR + 0x200a0)/* Int. acknowledge */
#define EPIC_PROC_EOI_REG	(EPIC_EUMBBAR + 0x200b0)/* End of interrupt */


#define EPIC_DIRECT_IRQ		0
#define EPIC_VEC_REG_INTERVAL	0x20	/* Distance between int. vector regs */

/*
 * Public interface
 */

#ifndef _ASMLANGUAGE
extern	void	epic_init(void);
extern	STATUS	epic_int_enable(int vec);
extern	STATUS	epic_int_disable(int vec);
#endif /* !_ASMLANGUAGE */

#endif /* defined(EPIC_H) */
--2297_15d4-7016_3d23-1911_358b--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
