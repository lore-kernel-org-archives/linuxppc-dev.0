Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s37.bay0.hotmail.com (bay0-omc2-s37.bay0.hotmail.com
	[65.54.246.173]) by ozlabs.org (Postfix) with ESMTP id 8C0FADDE27
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 00:06:42 +1000 (EST)
Message-ID: <BLU106-W193487503D177C3889D5CACAB60@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: DMA Generic Task API
Date: Mon, 24 Sep 2007 16:06:40 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

As I wrote before, I'm trying to use the DMA API to copy audio data to the =
PSC1 which has a digital - analog - converter attached to it.
I read the explanation that Sylvain wrote at: http://ozlabs.org/pipermail/l=
inuxppc-dev/2007-May/036229.html and programmed the following code:


static void SPI_setup(void)
{

	int psc_num =3D 1;
	phys_addr_t rx_fifo;
	phys_addr_t tx_fifo;
	struct bcom_bd *bd;

	uint32 SICR;

	psc =3D ioremap(MPC52xx_PA(MPC52xx_PSCx_OFFSET(1)), MPC52xx_PSC_SIZE);
=09
	gpio =3D ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
=09
	cdm =3D ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);

	switch(psc_num) {
		case 1:
			initiator_tx =3D BCOM_INITIATOR_PSC1_TX;
			initiator_rx =3D BCOM_INITIATOR_PSC1_RX;
			break;
		case 2:
			initiator_tx =3D BCOM_INITIATOR_PSC2_TX;
			initiator_rx =3D BCOM_INITIATOR_PSC2_RX;
			break;
		default:
			panic("snd-SPImgt.o: invalid value for psc_num (%i)\n",psc_num);
			break;
	};
=09
	printk("Before gpio->port_config\n");

	gpio->port_config 		|=3D PORT_CONFIG_PSC1;
	printk("Before cdm->clk_enables\n");
	cdm->clk_enables 		|=3D PSC1_CLK_EN;
	printk("Before cdm->mclken_div_psc1\n");
	cdm->mclken_div_psc1 	=3D MCLKEN_DIV;
=09
	SICR =3D 0x02000000;
	SICR |=3D 0x00002000;
	SICR |=3D 0x0090C000;
=09
	psc->command 	=3D 0x0A;
	psc->sicr	=3D SICR;
	psc->ctur	=3D 0x00;
	psc->ctlr	=3D 0x84;
	psc->ccr	&=3D 0xFF0000FF;
	psc->rfalarm	=3D 0x000C;		/* alarm occurs if 12 bytes space in the RxFIFO =
*/
	psc->tfalarm	=3D 0x0010;		/* alarm occurs if 16 bytes are in the TxFIFO */
	psc->rfcntl	&=3D 0xF8;		/* set granularity to 0 */
	psc->tfcntl	&=3D 0xF8;		/* set granularity to 0 */
	psc->isr_imr.isr	=3D 0x01;
	psc->isr_imr.imr	=3D 0x00;		/* enable TxRDY interrupt */=20
	psc->mode	=3D 0x00;			/* set RX interrupt to RxRDY */
	psc->command	=3D 0x05;			/* enable Tx and Rx */

	psc->tfdata =3D 0xF001;
	wait(1000);
	psc->tfdata =3D 0xF000;

	printk("Before bcom_gen_bd_rx_init\n");
 	rx_bcom =3D bcom_gen_bd_rx_init(64, (phys_addr_t)&(psc->rfdata), initiato=
r_rx, 6, 1024);
	printk("Before bcom_gen_bd_tx_init\n");
 	tx_bcom =3D bcom_gen_bd_tx_init(64, (phys_addr_t)&(psc->tfdata), initiato=
r_tx, 6);

	printk("txtask is %d rxtask is %d\n", tx_bcom->tasknum, rx_bcom->tasknum);

	r_irq =3D bcom_get_task_irq(rx_bcom);
	t_irq =3D bcom_get_task_irq(tx_bcom);
=09
	printk("t_irq is %d r_irq is %d\n", t_irq, r_irq);

	if (request_irq(r_irq, &SPI_rx_irq, IRQF_DISABLED, "SPI rx dma", NULL)) {
		printk(KERN_ERR "SPI: SDMA rx irq allocation failed\n");
		return;
	} else printk("SPI: SDA rx irq allocation succeded\n");
	if (request_irq(t_irq, &SPI_tx_irq, IRQF_DISABLED, "SPI tx dma", NULL)) {
		printk(KERN_ERR "SPI: SDMA tx irq allocation failed\n");
		return;
	} else printk("SPI: SDA tx irq allocation succeded\n");

	bcom_gen_bd_tx_reset(tx_bcom);
	bcom_gen_bd_rx_reset(rx_bcom);

	bcom_retrieve_buffer(tx_bcom, NULL, NULL);
	bd =3D bcom_prepare_next_buffer(tx_bcom);
	bd->status =3D 1024;
	bd->data[0] =3D (void *)SPI_tx_silence.pa;
	bcom_submit_next_buffer(tx_bcom, (void *)SPI_tx_silence.pa);

	bcom_dump_bdring(tx_bcom);
	bcom_dump_bdring(rx_bcom);

	printk("Tasks enabled\n");

 	psc->command =3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;
=09
}


Although everything seems to be executed without problems, the interrupt ro=
utines are never called, and no data seems to be copied to the PSC.
Could it be that  I don=B4t understand the purpose of bd->data and bd->stat=
us correctly? Is there any other Documentation or example code I can take a=
 look and learn how to use the API?

Thanks,

Pedro L. Dominguez
carcadiz@hotmail.com
_________________________________________________________________
Consigue el nuevo Windows Live Messenger
http://get.live.com/messenger/overview=
