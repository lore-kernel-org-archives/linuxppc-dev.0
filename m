Date: Wed, 30 Aug 2000 11:52:11 +0200 (MET DST)
From: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SPI on MBX/MPC860 ?
In-Reply-To: <A914533BF4B9D2118D980008C7894C0A02D1EBD7@dueis01nok>
Message-ID: <Pine.LNX.4.21.0008251613010.17516-100000@odoaker.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm a beginner. I'm trying to get SPI working on my MBX. I use Monta Vista
kernel sources without microcode patch.  Has anyone ever done some work
with the SPI ? Dan, I read in a posting from you that you did ? I followed
the programming example in UM but didn't succeed. I tried ty send a few
bytes, but SPIE says 0 afterwards.

Here's what I did:

---------   snip   ---------

/* initialize the 860 SPI and send a few bytes */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/types.h>
#include <asm/page.h>
#include <asm/8xx_immap.h>
#include <commproc.h>

#define DP_RAM_OFFSET 0x2000
#define SPI_BUFSIZE 16

#define say(fmt,args...) printk(fmt,##args)

int init_module (void)
{
    uint i_isb = 0;	 		// internal space base address
    immap_t* im = 0;			// memory map, see UM chapter 2
    cpm8xx_t* cp = 0;			// CP resources
    cpic8xx_t* cpic = 0;		// CP interrupt controller registers
    spi_t* spi_pr = 0;			// SPI's parameter RAM
    cbd_t* spi_bd = 0;			// SPI's BD's
    uint spi_bd_dp = 0;			// SPI's BD's (DP RAM relative address)
    uint spi_buf = 0;			// SPI's Rx/Tx buffer virtual start address
    int i;
    char buf[2*SPI_BUFSIZE] = {0};	// Test Buffer

    say ("Module isdn_init inserted.\n");

    asm ("mfspr %0,638":"=r"(i_isb):); // taken from arch/ppc/8xx_io/uart.c
    i_isb &= 0xffff0000; // cut off lower 16  bit

    // set some base addresses
    im   = (immap_t*)(i_isb);
    cp   = (cpm8xx_t*)(i_isb+0x09c0);
    cpic = (cpic8xx_t*)(i_isb+0x0930);
    spi_pr = (spi_t*)(i_isb+0x3d80); // SPI parameter RAM

    // disable SPI
    cp->cp_spmode &= 0xfeff;

    // configure hardware interface
    cp->cp_pbpar |= 0x0000000e; cp->cp_pbpar &= 0xfffffffe;
    cp->cp_pbdir |= 0x0000000e;
    cp->cp_pbodr &= 0xfff1;
    // configure PB[23] to operate as low active 'SPI enable'
    cp->cp_pbpar &= 0xfffffeff;
    cp->cp_pbodr &= 0xfeff;
    cp->cp_pbdir |= 0x00000100;
    cp->cp_pbdat &= 0xfffffeff;

    // configure DMA for SPI
    im->im_siu_conf.sc_sdcr = 0x0001;
    spi_pr->spi_rfcr = 0x10;
    spi_pr->spi_tfcr = 0x10;

    // allocate  the BD's and buffers
    spi_buf = (uint)buf;
    strcpy((char*)(spi_buf+SPI_BUFSIZE), "Teststring123"); // Init TxBuffer
    spi_bd_dp =  m8xx_cpm_dpalloc (2*sizeof(cbd_t)); // one RxBD, TxBD

    // set Rx/Tx table base address. We use one RxBD followed by one TxBD
    spi_pr->spi_rbase = (ushort)spi_bd_dp;
    spi_pr->spi_tbase = (ushort)(spi_bd_dp+sizeof(cbd_t));
    spi_pr->spi_mrblr = (ushort)SPI_BUFSIZE; // maximum receive buffer length

    // CPCR: send command to CP: init Rx/Tx params for SPI
    while (cp->cp_cpcr & CPM_CR_FLG)
        for (i=0; i<0xFF; i++); // wait
    cp->cp_cpcr = 0x0051;
    for (i=0; i<0x123456; i++); // wait
    while (cp->cp_cpcr & CPM_CR_FLG)
        for (i=0; i<0xFF; i++); // wait

    // initialize RxBD, TxBD
    spi_bd = (cbd_t*)(i_isb+DP_RAM_OFFSET+spi_bd_dp);
    spi_bd[0].cbd_bufaddr = __pa(spi_buf); // va->pa for DMA
    spi_bd[0].cbd_datlen = 0; // optional
    spi_bd[0].cbd_sc = (ushort)(BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT);
    spi_bd[1].cbd_bufaddr = __pa(spi_buf+SPI_BUFSIZE); // va->pa for DMA
    spi_bd[1].cbd_datlen = (ushort)SPI_BUFSIZE;
    spi_bd[1].cbd_sc = (ushort)(BD_SC_READY | BD_SC_WRAP | BD_SC_INTRPT | BD_SC_LAST);

    // configure interrupts
    cp->cp_spie = 0xFF; // clear all events
    cp->cp_spim = 0x37; // set up mask
    cpic->cpic_cimr |= 0x00000020; // enable SPI interrupts at CPIC
    cpic->cpic_cicr |= CICR_IEN; // interrupt master enable

    // ... and go !
    cp->cp_spmode = 0x4b70;
    cp->cp_spcom = 0x80;

    // test the loop transfer
    for (i=0; i<0x1234567; i++); // wait

    say ("SPI parameter RAM and register summary:\n");
    say ("RBASE=%0#6x TBASE=%0#6x MRBLR=%0#6x RFCR=%0#4x TFCR=%0#4x\n",
	spi_pr->spi_rbase, spi_pr->spi_tbase, spi_pr->spi_mrblr,
	spi_pr->spi_rfcr, spi_pr->spi_tfcr);
    say ("RBPTR=%0#6x TBPTR=%0#6x  RBC=%0#6x TBC=%0#6x  RDP=%0#10x TDP=%0#10x\n",
	spi_pr->spi_rbptr, spi_pr->spi_tbptr,
	spi_pr->spi_rbc, spi_pr->spi_tbc, spi_pr->spi_rdp, spi_pr->spi_tdp);
    say ("SPIE=%0#4x SPIM=%0#4x SPCOM=%0#4x SPMODE=%0#6x CIMR=%0#10x CICR=%0#10x\n",
	cp->cp_spie, cp->cp_spim, cp->cp_spcom, cp->cp_spmode,
	cpic->cpic_cimr, cpic->cpic_cicr);
    say ("RxBD: SC=%0#6x LEN=%0#6x ADDR=%0#10x\n",
	spi_bd[0].cbd_sc, spi_bd[0].cbd_datlen, spi_bd[0].cbd_bufaddr);
    say ("TxBD: SC=%0#6x LEN=%0#6x ADDR=%0#10x\n",
	spi_bd[1].cbd_sc, spi_bd[1].cbd_datlen, spi_bd[1].cbd_bufaddr);
    say ("DMA status: SDSR=%0#4x\t", im->im_sdma.sdma_sdsr);
    say ("TxBUF:%s  RxBUF:%s\n", (char*)(spi_buf+SPI_BUFSIZE), (char*)spi_buf);

    return 0;
}

---------   snip   ---------

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
