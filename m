Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s2.bay0.hotmail.com (bay0-omc2-s2.bay0.hotmail.com
	[65.54.246.138]) by ozlabs.org (Postfix) with ESMTP id ACCB9DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 01:38:47 +1000 (EST)
Message-ID: <BAY122-W20D0E87A907D16670F5F2ECADF0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: BestComm Task enable
Date: Thu, 16 Aug 2007 17:38:45 +0200
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

I=B4m trying to develop an SPI audio driver for a Phytec 5200b tiny platfor=
m. For this purpose, I=B4m reusing a working I2S driver that was working in=
 a Lite5200b platform. This I2S driver was developed for 2.6.16 kernel, usi=
ng the PPC arch. The kernel used by the new platform is a 2.6.20 version, u=
sing the powerpc arch.
This kernel does not include the gen_bd files for the BestComm to set up a =
generic task for the DMA, so I had to patch this kernel with the files from=
 Sylvain 2.6.20 tree (gen_bd.h, gen_bd.c, sdma_gen_bd_rx_task.c and sdma_ge=
n_bd_tx_task.c) and compile them so now, the functions are available. As it=
 was working with the old platform, my main goal is to stablish two interru=
pt routines for the dma to read and copy data from the PSC1 configured as a=
n SPI master device..
The question is: when I enable the sdma task (with sdma_enable() function),=
 the system seems to halt for a while and then continue (so I guess it is d=
oing something...) and I have also noticed that the interrupt routines that=
 I requested for transmission and reception are not called (a simple printk=
 with a character is not printed). May be a problem of setting up the inter=
rupts? I have no clue, but the irq allocation seems to be a success
Any hint will be appreciated.

Here is the Setup function that configures the PSC and the DMA tasks:

static int SPI_setup(void) {

	int i;
	// CDM
	struct mpc52xx_cdm __iomem *cdm;
//=20
// 	/* GPIO Modification */
	struct mpc52xx_gpio __iomem *gpio;

// 	/* END GPIO Modification */
//=20
	cdm =3D ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
	gpio =3D ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
//=20
	printk("psc_num %d\n", psc_num);

	/* Phytec, PSC1*/
	switch(psc_num) {
		case 1:
			initiator_tx =3D SDMA_INITIATOR_PSC1_TX;
			initiator_rx =3D SDMA_INITIATOR_PSC1_RX;
			break;
		case 2:
			initiator_tx =3D SDMA_INITIATOR_PSC2_TX;
			initiator_rx =3D SDMA_INITIATOR_PSC2_RX;
			break;
		default:
			panic("snd-SPImgt.o: invalid value for psc_num (%i)\n",psc_num);
			break;
	};

	/* 528MHz/(0x1f+1)=3D16.5 MHz */
	cdm->mclken_div_psc1 =3D 0x8001; // Mhz MCLK ( Khz * )
	psc->command =3D (MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
	/* PSC1 CODEC with Master Clock */
	printk("GPIO->port_config 0x%08x\n", gpio->port_config);
	gpio->port_config |=3D 0x00000007;
	printk("GPIO->port_config 0x%08x\n", gpio->port_config);
	/* PSC1 clock enable */
	cdm->clk_enables |=3D 0x20;

	// PSC reset
	psc->command =3D MPC52xx_PSC_RST_RX;
	psc->command =3D MPC52xx_PSC_RST_TX;
 	psc->command =3D MPC52xx_PSC_SEL_MODE_REG_1;
 	psc->command =3D MPC52xx_PSC_RST_ERR_STAT;


	// PSC setup SPI
	psc->mode =3D 0;
	psc->rfalarm =3D RX_ALARM;
 	psc->tfalarm =3D TX_ALARM;
	psc->rfcntl =3D RX_GRAN;
 	psc->tfcntl =3D TX_GRAN;
	psc->mpc52xx_psc_imr =3D 0x0000;
=09
	psc->sicr =3D 0x0290E000;
=09

	psc->ccr =3D 0x3f00; //LRCK  KHz, BitCLK  MHz  0x3f05!

	psc->command =3D MPC52xx_PSC_RST_RX;
	psc->command =3D MPC52xx_PSC_RST_TX;
	psc->command =3D MPC52xx_PSC_SEL_MODE_REG_1;
	psc->command =3D MPC52xx_PSC_RST_ERR_STAT;
//=20
// 	// setup the sdma tasks
	tx_sdma =3D sdma_alloc(PERIODS_HW+1);
	rx_sdma =3D sdma_alloc(PERIODS_HW+1);

	if (!tx_sdma || !rx_sdma) {
		printk("sdma_alloc failed\n");
		return -ENOMEM;
	}
//=20
	sdma_gen_bd_rx_init(0, rx_sdma, (phys_addr_t)&(psc->rfdata), initiator_rx,=
 6, PERIODSIZE_HW);
	sdma_gen_bd_tx_init(1, tx_sdma, (phys_addr_t)&(psc->tfdata), initiator_tx,=
 6);

	printk("txtask is %d rxtask is %d\n", tx_sdma->tasknum, rx_sdma->tasknum);
//=20
	// prepare the ring buffers
	for(i=3D0;itasknum %d\n", sdma_irq(rx_sdma), MPC52xx_SDMA_IRQ_BASE + rx_sd=
ma->tasknum);
	if (request_irq(sdma_irq(rx_sdma), SPI_rx_irq, IRQF_DISABLED, "SPI rx dma"=
, NULL)) {
		printk(KERN_ERR "SPI: SDMA rx irq allocation failed\n");
		return -EINVAL;
	} else printk("SPI: SDA rx irq allocation was a success\n");
	if (request_irq(sdma_irq(tx_sdma), SPI_tx_irq, IRQF_DISABLED, "SPI tx dma"=
, NULL)) {
		printk(KERN_ERR "SPI: SDMA tx irq allocation failed\n");
		return -EINVAL;
	} else printk("SPI: SDA tx irq allocation was a success\n");
=09
//=20
// 	// clear any pending interrupts
	sdma_clear_irq(tx_sdma);
	sdma_clear_irq(rx_sdma);
//=20
	printk("Before activating the tasks\n");
// 	// activate the tasks
	sdma_enable(tx_sdma);  /*Halts or gets stucked here for a while */
	sdma_enable(rx_sdma);  /*Halts or gets stucked here for a while */
//=20
// 	printk("about to enable SPI psc\n");
	udelay(100);
//=20
// 	// enable transmitter and receiver
	psc->command =3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;

	return 0;
};

And here the interrupt routines:

static irqreturn_t SPI_tx_irq(int irq, void *dev_id) {

	if(psc->mpc52xx_psc_status&0x1800) {
		SPI_panic(__FUNCTION__);
		return 0;
	};
	printk("I");
	for (;;) {
		if (!sdma_buffer_done(tx_sdma)) {
			break;
		}
		sdma_retrieve_buffer(tx_sdma, NULL);
		if(snd_SPImgt_running) {
			sdma_submit_buffer(tx_sdma, NULL, (void *)(((u32)SPI_tx_bufs.pa) + (SPI_=
play*SAMPLESIZE)), PERIODSIZE_HW);
// 			printk("Ti %d ",SPI_play);
			SPI_play +=3D FPP_HW;
			if(SPI_play =3D=3D FPP*PERIODS) SPI_play=3D0;
			if(snd_SPImgt_started) {
				snd_SPImgt_started--;
			}
			else {
				SPI_pos +=3D FPP_HW;
				if(SPI_pos =3D=3D FPP*PERIODS) SPI_pos=3D0;
// 				snd_pcm_period_elapsed(snd_SPImgt_substream);
			};
		}
		else {
			sdma_submit_buffer(tx_sdma, NULL, (void *)SPI_tx_silence.pa, PERIODSIZE_=
HW);
		};
	};
=09
	if(snd_SPImgt_running &&(!snd_SPImgt_started)){
		snd_pcm_period_elapsed(snd_SPImgt_substream);
	}
	return IRQ_HANDLED;
};


static irqreturn_t SPI_rx_irq(int irq, void *dev_id) {

	//SPI_print(__FUNCTION__);
	if(psc->mpc52xx_psc_status&0x1800) {
		SPI_panic(__FUNCTION__);
		return 0;
	};
 	printk("R");	=09
	for (;;) {
		if (!sdma_buffer_done(rx_sdma)) {
			break;
		}
		sdma_retrieve_buffer(rx_sdma, NULL);
		sdma_submit_buffer(rx_sdma, NULL, (void *)SPI_rx_bufs.pa, PERIODSIZE_HW);
	};
	return IRQ_HANDLED;
};

Regards,
Pedro.

_________________________________________________________________
Llama a tus amigos de PC a PC: =A1Es GRATIS!
http://get.live.com/messenger/overview=
