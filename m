From: "Choon Hooi Ng" <choonhooi.ng@motorola.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How can I tell if an interrupt has occured in MPC860?
Date: Wed, 19 Sep 2001 09:43:50 +0800
Message-ID: <001e01c140ac$88e8b830$fb5a01d9@crtc.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
        I am currently programming my custom-build MPC860 PowerPC board
      (embedded) to detect Ir keyboard. Basically, what i have is, I have an
      infrared detector connected to SCC3 of the 860 PPC. I am using the CPM
      as the comm processor and use UART mode. See illustration below:

           [ o ]-------------------[860 PPC]
         Ir detector          scc3

      I have done all the necessary configurations steps as stated in MPC860
      User's Manual pg.23-22, and enabled the interrupt. Now, when I press
      some keys on the Ir keyboard, I am expecting the 860 to detect it and
      then generate an interrupt. But, apparently, nothing happens. My
      questions are:
      1. How can i tell if the 860 receives my irq request
      2. How can I tell if 860 receives some signals from the Ir keyboard
      and
      3. How can I find out if an interrupt does happen

      For info, the Ir k/b is using baud rate: 1200, each data-unit contains
      total 10 bits of info - 1 start bit, 7 data bits, 1 parity and 1 stop
      bit.

      I have also included my code in this posting. cpm_silitek_kb_init is
      the function that will be called after initializing the eth (enet.c).

      Really appreciate if someone could help me out on this. Thanks in
      advance.

      Rgds,
        ch

      --------------start

/**************************************************************************/
      struct cpm_silitek_kb_private {
              /* The saved address of a sent-in-place packet/buffer, for
skfree().
      */
              ushort  skb_cur;
              ushort  skb_dirty;

              /* CPM dual port RAM relative addresses.
              */
              cbd_t   *rx_bd_base;            /* Address of Rx and Tx
buffers. */
              cbd_t   *tx_bd_base;
              cbd_t   *cur_rx, *cur_tx;               /* The next free ring
entry */
              cbd_t   *dirty_tx;      /* The ring entries to be free()ed. */
              scc_t   *sccp;
              char    tx_full;
              unsigned long lock;
      };

      static char uart_rx_buf[1];             /* Receive Buffer */
      static char uart_tx_buf[1];             /* Transmit Buffer */


/***********************************************************************/
      static void
      cpm_silitek_kb_interrupt (void)
      {
        printk("interr occured\n");
      }


/***********************************************************************/
      int __init cpm_silitek_kb_init(void)
      {
              struct device *dev;
              struct cpm_silitek_kb_private *cep;
              int i, j;

              bd_t            *bd;
              volatile        cbd_t           *bdp;
              volatile        cpm8xx_t        *cp;
              volatile        scc_uart_t      *sccxp;
              volatile        immap_t         *immap;

              immap = (immap_t *)IMAP_ADDR;   /* and to internal registers
*/

              /* Get pointer to SCC area in parameter RAM. */
              sccxp = (scc_uart_t *)
(&immap->im_cpm.cp_dparam[PROFF_SCC3]);

              /* Allocate some private information.
              */
              cep = (struct cpm_silitek_kb_private *)kmalloc(sizeof(*cep),
      GFP_KERNEL);

              /* Configure port A pins for Txd and Rxd.
              */
              /* pg. 34-5 */
      /*** 1. p.g. 34-5. Configure port A to enable  RXD3. Set PAPAR[10,11];
      Clear PADIR[10,11]; Clear PAODR[10,11]  */
              immap->im_ioport.iop_papar |= 0x0030;

              /* Set output & on-chip peripheral signal with PADIR(DRn) set
to '1'
      */
              immap->im_ioport.iop_padir &= 0xFFCF;

              /* Set signal to open-drain type */
              immap->im_ioport.iop_paodr &= 0xFFCF;


      /*** 2. Config port C to enable RTS2, CTS3 & CD2. Set PCPAR[14] &
      PCSO[8,9] & clear PCPAR[8,9] & PCDIR[8,9,14] */
              /* Configure port C pins to enable CLSN and RENA.
              */
              /* Set on-chip peripheral signal to '1' */
              immap->im_ioport.iop_pcpar = 0x0000;

              /* Set bit to '1' if the on-chip peripheral signal is to
generate an
      interrupt */
              /* at the same time. */
              immap->im_ioport.iop_pcso =  0x00F0;

              /* Set output & on-chip peripheral signal with PCDIR(DRn) set
to '1'
      */
              immap->im_ioport.iop_pcdir = 0x0F0A;

      /*** 3. pg.21-40 Config BRG1. Write BRGC1 with 0x0001 0144. The DIV16
      bit is not used and
              the divider is 162 (decimal). The resulting BRG1 clock is 16x
the
      preferred bit rate */
              /*
               * Baud Rate Generators, BRGs, initialization (disable)
               */
              /*immap->im_cpm.cp_brgc1 =*/
              /*immap->im_cpm.cp_brgc2 =*/
              immap->im_cpm.cp_brgc3 =
              /*immap->im_cpm.cp_brgc4 =*/ 0x0001057c;

      /* 4. pg.21-23 Connect BRG3 to SCC3 using serial interface. Clear
      SICR[R2CS, T2CS] */
              /* Configure Serial Interface clock routing.
               * First, clear all SCC bits to zero, then set the ones we
want.
               */
               /* pg 21-24 */
              immap->im_cpm.cp_sicr |= 0x00120000;

      /*** 5.  Initialize SDMA confin reg; SDCR=0x0001 */
              /* Manual says set SDDR, but I can't find anything with that
               * name.  I think it is a misprint, and should be SDCR.  This
               * has already been set by the communication processor
      initialization.
               */
              immap->im_siu_conf.sc_sdcr = 0x0001;

      /*** 6. Connect SCC3 to NMSI. Clear SICR[SC3] */
              immap->im_cpm.cp_sicr &= 0xFFBFFFFF;


      /* 7. ??? Write RBASE & TBASE in SCC3 parameters RAM to point to the
      RxBD and Tx TxBD tables in dual-port RAM. Assuming
                      one RxBD at the start of dual-port RAM followed by one
TxBD, write
      RBASE with 0x0000 and TBASE with 0x0008 */

              i = m8xx_cpm_dpalloc(sizeof(cbd_t)); /* i points to an empty
space in
      dual port ram */
              sccxp->scc_genscc.scc_rbase = i;
              cep->rx_bd_base = (cbd_t *)&immap->im_cpm.cp_dpmem[i];

              i = m8xx_cpm_dpalloc(sizeof(cbd_t)); /* i points to an empty
space in
      dual port ram */
              sccxp->scc_genscc.scc_tbase = i;
              cep->tx_bd_base = (cbd_t *)&immap->im_cpm.cp_dpmem[i];


      /* 8. pg. 19-6 Write 0x0081 to CPCR to exe the INIT RX and TX params
      connand for SCC3 */
               /* pg. 19-6 */
              immap->im_cpm.cp_cpcr = 0x0081;


      /* 9. ?? Write RFCR with 0x10 and TFCR with 0x10 */
              /* Initialize function code registers for big-endian.
              */
          sccxp->scc_genscc.scc_rfcr  = 0x18;         /*
MPC8XX_PRAM_SCC_FCR_BO_BE;
      */          /* Rx Func Code   */
          sccxp->scc_genscc.scc_tfcr  = 0x18; /* MPC8XX_PRAM_SCC_FCR_BO_BE;
      */          /* Tx Func Code   */

      /* 10. ?? Wrt MRBLR with the max # of bytes per Rx buffer. assume 16
      bytes; MRBLR = 0x0010 */
          sccxp->scc_genscc.scc_mrblr = 1;
      /* Max Rx Buf Len */


      /* 11. Wrt MAX_IDL with 0x0000 in the param RAM to disable the max
      idle func */
              sccxp->scc_maxidl = 0;                  /* Maximum Idle
Caracters       */

      /* 12.  Set BRKCR to 0x0001 so STOP TRANSMIT cmds send only one break
      char */
          sccxp->scc_brkcr   = 1;                     /* Break Count
Register (transmit)      */

      /* 13. Clr  PAREC, FRMEC, NOSEC & BRKEC in param RAM */
          sccxp->scc_parec   = 0;                     /* Receive Parity
Error Counter         */
          sccxp->scc_frmec   = 0;                     /* Receive Framing
Error Counter        */
          sccxp->scc_nosec   = 0;                     /* Receive Noise
Counter                        */
          sccxp->scc_brkec   = 0;                     /* Receive Break
Condition Counter      */

      /* 14. Clr  UADDR1 & UADDR2. Not used */
          sccxp->scc_uaddr1  = 0;                     /* UART Address
Character 1*/
          sccxp->scc_uaddr2  = 0;                     /* UART Address
Character 2*/

      /* 15. Clr TOSEQ. Not used */
          sccxp->scc_toseq   = 0;                     /* X-mit
Out-of-Sequence Character      */

      /* 16. Wrt CHARACTER1-8 with 0x8000. Not used */
          sccxp->scc_char1   = 0x8000;                /* Control Character 1
*/
          sccxp->scc_char2   = 0x8000;                /* Control Character 2
*/
          sccxp->scc_char3   = 0x8000;                /* Control Character 3
*/
          sccxp->scc_char4   = 0x8000;                /* Control Character 4
*/
          sccxp->scc_char5   = 0x8000;                /* Control Character 5
*/
          sccxp->scc_char6   = 0x8000;                /* Control Character 6
*/
          sccxp->scc_char7   = 0x8000;                /* Control Character 7
*/
          sccxp->scc_char8   = 0x8000;                /* Control Character 8
*/


      /* 17. Wrt RCCM with 0x C0FF. Not used */
          sccxp->scc_rccm    = 0xC0FF;                /* Receive Control
Character Mask       */

      /* 18. ?? Init the RxBD. Assume the Rx buffer is at 0x0000_1000 in
      main mem.
              Wrt oxB000 to RxBD[Status and Control], 0x0000 to RxBD[Data
length]
      and 0x0000_10000 to RxBD[Buf Ptr] */
              /*
           * Rx Buffer Descriptor
           */
              bdp = cep->rx_bd_base;
              bdp->cbd_sc = 0xB000;
              bdp->cbd_datlen = 0;
              bdp->cbd_bufaddr = (uint) &uart_rx_buf;


      /* 19. Initialize the TxBD */
              bdp = cep->tx_bd_base;
              bdp->cbd_sc = 0x2000;
              bdp->cbd_datlen = 1;
              bdp->cbd_bufaddr = (uint) &uart_tx_buf;

      /* 20. Wrt 0xFFFF to SCCE3 to clr any previous events */
          immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_scce = 0xFFFF;

      /* 21. ?? Wrt 0x0003 to SCCM3 to allow the TX and RX interr */
          immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_sccm = 0x0003;

              /* Install our interrupt handler.*/
         cpm_install_handler(CPMVEC_SILITEK_KB, cpm_silitek_kb_interrupt,
      cep);


      /* 22. p.g. 35-9 Wrt 0x1000_0000 to CPM inter mask reg (CIMR) to allow
      SCC3 to generate a system interrupt. The CICR shud also be init. */
      /* NOTE: Not sure why this is not needed */
              immap->im_cpic.cpic_cimr |= 0x10000000;
              immap->im_cpic.cpic_cicr |= 0x00200000;

      /* 23. pg 22-3 Wrt 0x0000 0020 to GSMR_H3 to configure a small Rx FIFO
      width */
          immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_gsmrh = 0x00000020;


      /* 24. ?? Wrt 0x0002 8004 to GSMR_L3 to configure 16x sampling for tx
      & rx, CTS & CD to
      automatically control transmission and reception (DIAG bits) and the
      SCC for UART mode. Notice that the transmitter (ENT) & receiver (ENR)
      have not been enabled yet.  */
          /* General SCC Mode Register Low */
              immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_gsmrl = 0x00028004;

      /*  25. ?? pg.23-13 Set PSMR3 */
              immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_pmsr = 0x2010;  /* I
think
      it shud be PSMR. possibly typo in linux */

      /* 26. Wrt 0x0002 8034 to GSMR_L3 to enable the tmitter & Rxer. This
      ensures that ENT and ENR are enabled last. */
          /*
           * Enable the Transmitter and Receiver
           * Now that SCC3 is configured, Tx and Rx can be enabled.
           */
          /* General SCC Mode Register Low */

              /* And last, enable the transmit and receive processing.
              */
              immap->im_cpm.cp_scc[SCC3_SILITEK_KB].scc_gsmrl |= 0x00000030;
              return 0;
      }


      --------------end


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
