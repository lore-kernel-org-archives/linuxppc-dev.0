Date: Tue, 30 Mar 2004 11:20:20 +0500 (GMT+0500)
From: Ashish R Dhawane <ashish@cdotb.ernet.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SMC for 8260
Message-ID: <Pine.OSF.4.21.0403221122570.10350-100000@ws9.cdotb.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am new to the linux porting. I am trying to port linux kernel 2.4 on MPC
8260. I am facing the following problem while configuring SMC for UART on
MPC 8260 based board.

As soon as I execute the follwoing stmt, it will continiously start
sending IDLE characters, and the screen on Hyperterminal(Windows)/minicom
terminal(Linux) will scroll on printing some junk characters.

    immr->im_smc[SMC].smc_smcmr |= 0x0003;

The code is given below for configuring SMC.
If anybody is already having a standalone testing code for SMC on MPC 8260
based board is highly welcomed.

regards,
-Ashish

###########################################################################
Ashish R Dhawane
Research Engineer
W-CDMA Group (3G RAN)

Contacts:
---------
Tel(O)	   :+91-80-2282168 (Direct Line)
Tel(O/Lab) :+91-80-2263399 X 329
Fax(O)	   :+91-80-2282168
Mobile	   :98455 36814
E-Mail(s)  :ashishdhawane@yahoo.com, ashish@cyberspace.org

Surface Address (O):			Surface Address (R):
--------------------			--------------------
Centre for Development of Telematics,	#50, Ground Floor, 12th Cross,
71/1, Sneha Complex, 			Ayyappa Block, Manorayan Palya,
Millers Road,				Sultan Palya Main Road,
Bangalore-560052,			RT Nagar Post,Bangalore-560032,
Karnataka, India.			Karnataka, India.
###########################################################################

#define IMMAP_ADDR 0xf0000000

void configure_smc()
{
    smc_uart_t *uart_param;
    smc_t *smc_param;
    immap_t *immap;

    int i = 0;

    immr=(immap_t *)IMAP_ADDR;

    immap=immr;

    /*
     *	1. Initialize the port D dedicated mode pins for Tx and Rx
     *     It also clear pdird and psord for D Port.
     */

    immr->im_ioport.iop_ppard |= 0x00c00000;  //set 8 9
    immr->im_ioport.iop_pdird |= 0x00400000;  //set 9

    immr->im_ioport.iop_pdird &= 0xff7fffff; // clear 8
    immr->im_ioport.iop_psord &= 0xff3fffff; // clear 8 9

    /* 2. configure brg1 */

    immr->im_brgc1 = 0x00010438;

    /* 3. connect brgc1 */

    immr->im_cpmux.cmx_smr &= 0x0f;   //brg1

    /* 4. Set up UART params in the parameter RAM                 */
    /* Initialize the Transmit and Receive Buffer Descriptor      */
    /* Allocate space for two Buffer Descriptor in the DP RAM     */

    uart_param=(smc_uart_t *)0xf00087fc;   //SMC1 88FC for SMC2

    dp_addr=(uint)0xf0000000;

    uart_param->smc_rbase=dp_addr;
    uart_param->smc_tbase=dp_addr+sizeof(cbd_t);

    /* 6. init cpcr INIT RX TX PARAMS  SMC1 */

    immr->im_cpm.cp_cpcr=0x1d010000;

    /* 7. Write RFCR and TFCR with 0x10 */

    uart_param->smc_rfcr = 0x10;
    uart_param->smc_tfcr = 0x10;

    /* 8. Writing the maximum number of bytes per Receive packet */

    uart_param->smc_mrblr = 0x0010;

    /* 9. To disable the MAX_IDL functionality */

    uart_param->smc_maxidl = 0x0000;

    /* 10. Clear BRKLN and BRKEC */

    uart_param->smc_brklen = 0x0000;
    uart_param->smc_brkec = 0x0000;

    /* 11. Stop transmit command send only one break character */

    uart_param->smc_brkcr = 0x0001;


    /* 12. Initialize the RxBD */

    bdp=(cbd_t *)dp_addr;

    bdp->cbd_sc=0xb000;
    bdp->cbd_datlen=0x0000;
    bdp->cbd_bufaddr=0x00001000;

    /* 13. Initialize the TxBD */

    (bdp+1)->cbd_sc=0xb000;
    (bdp+1)->cbd_datlen=0x0005;
    (bdp+1)->cbd_bufaddr=0x00002000;

    /* 14. Clear any previous events on SMC1 */

    immr->im_smc[SMC].smc_smce = 0xff;

    /* 15. Allow All Possible inerrupts; allow tx and rx interrupts */

    immr->im_smc[SMC].smc_smcm = 0x57;
    //immr->im_smc[SMC].smc_smcm = 0x00;

    /* 16. Write 0x0000_1000 to simrl;
     *     Write 0xffff_ffff to sipnrl;
     *     Initialize the scc1 interrupt generation
     */

    immr->im_intctl.ic_simrl = 0x00001000;
    immr->im_intctl.ic_sipnrl = 0xffffffff;

    /* 17. Write 0x4820 to SMCMR */

#ifdef SMC_UART_INTERNAL_LOOPBACK
    immr->im_smc[SMC].smc_smcmr = 0x4824;    // internal loopback
#else
    immr->im_smc[SMC].smc_smcmr = 0x4820;    // normal
#endif

    /* 18. Write 0x4823 to ensure that TEN and REN bits are enabled */

    immr->im_smc[SMC].smc_smcmr |= 0x0003 ;

}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
