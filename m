Message-ID: <37E20384.BD066E8C@switchboard.ericsson.se>
Date: Fri, 17 Sep 1999 11:01:56 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        Dan Malek <dmalek@jlc.net>
Subject: Cleanup thought.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I would like to take up the question about configuration again.

I believe that the situation is the same for a lot of people 
out here: Get Linux working on some kind of new 8xx hardware.

Today we need to modify and add #ifdefs to different files.

I like the idea of some kind of central board specific file.

I'm relly happy the day I just add my board_name.h to mpc8xx.h
and everything works...or something else.

I suggested the following code to Dan Malek a while ago, and he didn't 
like the idea with a lot of inline code in one .h file, right Dan? 

Anyone else out there with another idea how to solve this problem?

Or is it a problem..?

Cheers /

Magnus

Code from my ads.h - board specific file for my ADS board.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Macros and values needed by the ethernet driver - enet.c                  */

#include <linux/types.h>
#include <asm/residual.h>
#include <asm/8xx_immap.h>

#define PA_ENET_RXD	((ushort)0x0001)
#define PA_ENET_TXD	((ushort)0x0002)

#define PA_ENET_TCLK	((ushort)0x0100)
#define PA_ENET_RCLK	((ushort)0x0200)
#define PB_ENET_TENA	((ushort)0x00001000)

#define PC_ENET_CLSN	((ushort)0x0010)
#define PC_ENET_RENA	((ushort)0x0020)

#define SICR_ENET_MASK	((uint)0x000000ff)
#define SICR_ENET_CLKRT	((uint)0x0000002c) // T=CLK1, R=CLK2

#define PC_ENET_ETHLOOP ((ushort)0x0800)
#define PC_ENET_TPFLDL  ((ushort)0x0400)
#define PC_ENET_TPSQEL  ((ushort)0x0200)

/* tell the ethernet driver we want to use SCC1 */

extern __inline__ int enet_get_scc(unsigned int enet_nr)
{
        switch(enet_nr) {
	case 0: return 1;  /* allow only one ethernet, use SCC1 */
	default: return 0;
	}
}

/* configure ethernet pins, clocks and the ethernet address */

extern __inline__ void enet_configure(unsigned int enet_nr, 
				      immap_t	*immap, unsigned char *eap)
{							
	bd_t		*bd = (bd_t *)res;
	int i;

	/* Configure port A pins for Txd and Rxd.			
	*/								
	immap->im_ioport.iop_papar |= (PA_ENET_RXD | PA_ENET_TXD);	
	immap->im_ioport.iop_padir &= ~(PA_ENET_RXD | PA_ENET_TXD);	
	immap->im_ioport.iop_paodr &= ~PA_ENET_TXD;			
									
	/* Configure port C pins to enable CLSN and RENA.		
	*/								
	immap->im_ioport.iop_pcpar &= ~(PC_ENET_CLSN | PC_ENET_RENA);	
	immap->im_ioport.iop_pcdir &= ~(PC_ENET_CLSN | PC_ENET_RENA);	
	immap->im_ioport.iop_pcso |= (PC_ENET_CLSN | PC_ENET_RENA);	
									
	/* Configure port A for TCLK and RCLK.				
	*/								
	immap->im_ioport.iop_papar |= (PA_ENET_TCLK | PA_ENET_RCLK);	
	immap->im_ioport.iop_padir &= ~(PA_ENET_TCLK | PA_ENET_RCLK);	
									
        /* Port C is used to control the PHY, 68160.			
	*/		
        immap->im_ioport.iop_pcdir |=					
	  (PC_ENET_ETHLOOP | PC_ENET_TPFLDL | PC_ENET_TPSQEL);		
									
        immap->im_ioport.iop_pcdat |= PC_ENET_TPFLDL;			
        immap->im_ioport.iop_pcdat &= ~(PC_ENET_ETHLOOP | PC_ENET_TPSQEL);

	/* Configure Serial Interface clock routing.
	 * First, clear all SCC bits to zero, then set the ones we want.
	 */
	immap->im_cpm.cp_sicr &= ~SICR_ENET_MASK;
	immap->im_cpm.cp_sicr |= SICR_ENET_CLKRT;

	/* Set ethernet address 
	 */
	for (i=0; i<6; i++)			
		eap[i] = bd->bi_enetaddr[i];
	
}

/* enable the ethernet transmitter */

extern __inline__ void  enet_tena(unsigned int enet_nr, immap_t *immap)
{
	immap->im_cpm.cp_pbpar |= PB_ENET_TENA;	
	immap->im_cpm.cp_pbdir |= PB_ENET_TENA;	
						
        *((uint *)BCSR1) &= ~BCSR1_ETHEN;       
}

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/* Should there be a SMC at /dev/ttyS<uart_nr> ? */

extern __inline__ int uart_get_smc(unsigned int uart_nr)
{
        switch(uart_nr) {
	case 0: return 1;  /* the first serial port is at SMC1 */
	case 2: return 2;
	default: return 0;
	}
}

/* Or should it be a SCC ? */

extern __inline__ int uart_get_scc(unsigned int uart_nr)
{
        switch(uart_nr) {
	case 1: return 3;
	default: return 0;
	}

//        return 0;          /* we don't want any SCCs at all */
}

/* And what clock should it use ? */
/* Get clock source: 0 -> 3 = BRG1 -> BRG4, 4 -> 7 = CLK1 -> CLK4 */

extern __inline__ int uart_get_clksrc(unsigned int uart_nr)
{
	return uart_nr + 1;
}



extern __inline__ int uart_console_get_smc(void)
{
        return 1;          /* console at SMC1 */
}


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
