Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s13.blu139.hotmail.com
	(blu139-omc3-s13.blu139.hotmail.com [65.55.175.213])
	by ozlabs.org (Postfix) with ESMTP id C65B6DDF23
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 00:23:38 +1100 (EST)
Message-ID: <BLU106-W3340DC3BF1A9FD27E9FCD3CA100@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: I2S driver
Date: Tue, 4 Mar 2008 14:23:36 +0100
In-Reply-To: <766668.28874.qm@web23115.mail.ird.yahoo.com>
References: <766668.28874.qm@web23115.mail.ird.yahoo.com>
Content-Type: text/plain; charset="Windows-1252"
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


Ok, here down is the code I told you.
A few considerations before:
 - As I told you, it is very bad commented, sorry. I'm still working on it.
 - It's is not an alsa driver, but it copies data to the PSC working as SPI=
 mode (it is not I2S but you only need to change the PSC configuration).
 - Its purpose is to establish a dma task to copy the data from a buffer to=
 the PSC, where I had attached a Digital to Analog Converter that into soun=
d through a speaker.
 - Data alignment is imposed by DAC requirements.
 - Clock configuration is fixed to 44.1 Khz, so audio data must be sampled =
using that frequency. Data must be also mono (only one converter attached).
 - This module is part of a mayor project to stream audio data through ethe=
rnet, so it provides a function to copy audio data to audio buffers. If the=
re's no data to copy, it copies a null buffer to keep silence.
 - What can you find useful in this code? Configuration steps to establish =
DMA Tasks and PSC configuration.
 - After the module I send you also the code from another module that estab=
lishes PSC as I2S configuration. Clocks where adjusted to send the audio da=
ta also at 44.1 Khz as fine tunned as possible due to communication require=
ments of the attached DAC in that hardware.

And finally, here is the code:

/**************************************************************************=
*
 *   Copyright (C) 2007 by Pedro L. Dom=EDnguez                            =
  *
 *   pedro.dominguez@aed-engineering.com                                   =
*
 *                                                                         =
*
 *   This program is free software; you can redistribute it and/or modify  =
*
 *   it under the terms of the GNU General Public License as published by  =
*
 *   the Free Software Foundation; either version 2 of the License, or     =
*
 *   (at your option) any later version.                                   =
*
 *                                                                         =
*
 *   This program is distributed in the hope that it will be useful,       =
*
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        =
*
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         =
*
 *   GNU General Public License for more details.                          =
*
 *                                                                         =
*
 *   You should have received a copy of the GNU General Public License     =
*
 *   along with this program; if not, write to the                         =
*
 *   Free Software Foundation, Inc.,                                       =
*
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             =
*
 *                                                                         =
*
 *   History                                                               =
*
 *     Original Version by Bernhard Kuhn              *
 *            for 2.6.16 kernel                                            =
*
 **************************************************************************=
*/

#define SPI_DBG

#ifdef SPI_DBG
#define DBG(x...) printk("(debug) " x)
#else
#define DBG(x...)
#endif

#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
#include=20
// #include=20

#define BPF             2      // bytes per frame
#define SLOTS           2
#define SAMPLESIZE      (BPF*SLOTS)
#define FPP             1024   // bytes per copy period=20
#define PERIODS         8      // periods
#define PERIODSIZE      (SAMPLESIZE/2*FPP)
#define BUFSIZE         (SAMPLESIZE*FPP*PERIODS)
#define FPP_HW          128
//512    // 10 ms
#define PERIODS_HW      8      // periods
#define PERIODSIZE_HW   (SAMPLESIZE*FPP_HW)

#define FIFOSIZE	512
#define RX_GRAN		4
#define TX_GRAN		4
#define	RX_ALARM	0x120
#define	TX_ALARM	FIFOSIZE - (TX_GRAN * 4) - 208

#define DELAY_TIME_SLOT 0x20000000
#define GEN_CLK_INT 0x00800000
#define MULTIWD_ENABLE 0x00400000
#define CLK_POL_RISING 0x00200000

#define PROCFS_NAME	"MPC52xx_SPI"
#define MCLKEN_DIV 0x8001
#define DRV_NAME "mpc52xx-psc-spi"
#define PROCFS_MAX_SIZE		1024
#define BUF_FRAMES 300

/* MBAR position */
#define MPC52xx_MBAR		0xf0000000	/* Phys address */
#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
#define MPC52xx_MBAR_SIZE	0x00010000

#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))

/* Registers zone offset/size  */
#define MPC52xx_MMAP_CTL_OFFSET		0x0000
#define MPC52xx_MMAP_CTL_SIZE		0x068
#define MPC52xx_SDRAM_OFFSET		0x0100
#define MPC52xx_SDRAM_SIZE		0x010
#define MPC52xx_CDM_OFFSET		0x0200
#define MPC52xx_CDM_SIZE		0x038
#define MPC52xx_INTR_OFFSET		0x0500
#define MPC52xx_INTR_SIZE		0x04c
#define MPC52xx_GPTx_OFFSET(x)		(0x0600 + ((x)<<buffer.va =3D kmalloc(PERIO=
DSIZE_HW, GFP_DMA);
	FirstNodeFree->buffer.pa =3D virt_to_phys((void *)FirstNodeFree->buffer.va=
);
	node =3D FirstNodeFree;

	for (i=3D1;inext =3D (Node *)kmalloc(sizeof(Node), GFP_KERNEL);=09
		node->next->buffer.va =3D kmalloc(PERIODSIZE_HW, GFP_DMA);
		node->next->buffer.pa =3D virt_to_phys((void *)node->next->buffer.va);
		node =3D node->next;
	}
	LastNodeFree =3D node;
	LastNodeFree->next=3DNULL;
	DBG("SPI_buffers_init()\n");
	// prepare reception buffer=09
	SPI_rx_bufs.va =3D kmalloc(BUFSIZE, GFP_DMA);

	SPI_rx_bufs.pa =3D virt_to_phys((void *)SPI_rx_bufs.va);

	// prepare silence buffer
	SPI_tx_silence.va =3D kmalloc(BUFSIZE, GFP_DMA);

	SPI_tx_silence.pa =3D virt_to_phys((void *)SPI_tx_silence.va);

	memset(SPI_tx_silence.va,0,BUFSIZE);

	return 0;
}

int snd_SPI_pcm_trigger(struct snd_pcm_substream *substream, int cmd) {
#ifdef SND_I2S_DEBUG
	printk("snd_SPI_pcm_trigger\n");
#endif
	switch (cmd) {
		case SNDRV_PCM_TRIGGER_START:
		case SNDRV_PCM_TRIGGER_RESUME:
#ifdef SND_I2S_DEBUG
			printk("START\n");
#endif
			snd_SPI_substream=3Dsubstream;
			snd_SPImgt_started=3D2;
			snd_SPImgt_running=3D1;

			break;
		case SNDRV_PCM_TRIGGER_STOP:
		case SNDRV_PCM_TRIGGER_SUSPEND:
#ifdef SND_I2S_DEBUG
			printk("STOP\n");
#endif
			snd_SPImgt_running=3D0;
			break;

		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
			printk("  PAUSE_PUSH\n");
			break;
		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
			printk("  PAUSE_RELEASE\n");
			break;
		default:
			return -EINVAL;
	}
	return 0;
};

EXPORT_SYMBOL(snd_SPI_pcm_trigger);


static irqreturn_t SPI_rx_irq(int irq, void *dev_id) {
	// no need for TaskIntClear(rxtask), OS masks and acks IRQ

	struct mpc52xx_spi_priv *priv =3D dev_id;

	spin_lock(&priv->dma_lock);
	while (bcom_buffer_done(rx_bcom)) {
		struct bcom_gen_bd *bd;
		bcom_retrieve_buffer(rx_bcom, NULL, NULL);
		/* Submit a new one */
		bd =3D (struct bcom_gen_bd *) bcom_prepare_next_buffer(rx_bcom);
		bd->status =3D 512;
		bd->buf_pa =3D SPI_rx_bufs.pa;
	=09
		bcom_submit_next_buffer(rx_bcom, NULL);
		bcom_enable(rx_bcom);
	}
	spin_unlock(&priv->dma_lock);
	return IRQ_HANDLED;
};

static irqreturn_t SPI_tx_irq(int irq, void *dev_id) {
	// no need for TaskIntClear(txtask), OS masks and acks IRQ
	struct mpc52xx_spi_priv *priv =3D dev_id;
	struct bcom_gen_bd *bd;

	Node *node;

	if(psc->mpc52xx_psc_status&0x1800) {

		printk("PSC Reset\n");
		psc->command =3D MPC52xx_PSC_RST_RX;
		psc->command =3D MPC52xx_PSC_RST_TX;
		psc->command =3D MPC52xx_PSC_SEL_MODE_REG_1;
		psc->command =3D MPC52xx_PSC_RST_ERR_STAT;
		psc->command =3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;
	};
=09
	spin_lock(&priv->dma_lock);
=09
	for(;;)
	{
		if(!bcom_buffer_done(tx_bcom)) {
			break;
		}
		bcom_retrieve_buffer(tx_bcom, NULL, NULL);
		/* Submit a new one */
		bd =3D (struct bcom_gen_bd *) bcom_prepare_next_buffer(tx_bcom);

		if (snd_SPImgt_running)
		{
			if((FirstNode =3D=3D NULL)) {
				bd->status =3D PERIODSIZE_HW;
				bd->buf_pa =3D SPI_tx_silence.pa;
				bcom_submit_next_buffer(tx_bcom, NULL);
			=09
				if(hook_per_elap !=3D NULL) {
					hook_per_elap(SPI_pos, SPI_play);
				}
			}=20
			else
			{
				node=3DFirstNode;
				FirstNode=3Dnode->next;
				if(FirstNode=3D=3DNULL)LastNode=3DNULL;
				bd->status =3D PERIODSIZE_HW;
				bd->buf_pa =3D (void *)(((u32)node->buffer.pa));
				bcom_submit_next_buffer(tx_bcom, NULL);
				node->next=3DNULL;
				if(LastNodeFree!=3DNULL)
					LastNodeFree->next=3Dnode;
				LastNodeFree=3Dnode;				=09
				if(FirstNodeFree=3D=3DNULL)FirstNodeFree=3DLastNodeFree;
				nodecounter--;
			}
			dmablockcounter++;

		} else {
			bd->status =3D PERIODSIZE_HW;
			bd->buf_pa =3D SPI_tx_silence.pa;
			bcom_submit_next_buffer(tx_bcom, NULL);

		}
		bcom_enable(tx_bcom);

	}
	spin_unlock(&priv->dma_lock);

	return IRQ_HANDLED;
};

typedef struct {
	unsigned short l;
	unsigned short r;
} sample_t;

static int frame=3D0;
static Node *nodebuild;
static int counter =3D0;
static int *ptr=3DNULL;

int snd_SPI_pcm_copy(struct snd_pcm_substream *substream,
		int voice,
		snd_pcm_uframes_t pos,
		void *src,
		snd_pcm_uframes_t count) {

	snd_pcm_uframes_t i;
// 	sample_t* data =3D (sample_t*) src;
	UInteger32 *data =3D (UInteger32 *) src;

	int cnt=3Dcount;
// 	unsigned short aux;

//   	printk("1.cnt %d, frame %d\n",cnt, frame);=20
	while (cnt> 0)
	{
		counter++;
		if(counter =3D=3D 1000){

// 			printk("Frames: %d\n",nodecounter);
			counter=3D0;

		}
		if(ptr=3D=3DNULL)
		{=20

			if(FirstNodeFree !=3D NULL)
			{
				nodebuild =3D FirstNodeFree;
				FirstNodeFree =3D FirstNodeFree->next;
				if(FirstNodeFree=3D=3DNULL)LastNodeFree=3DNULL;	=09
			}
			else
			{		=09
				nodebuild =3D (Node *)kmalloc(sizeof(Node), GFP_KERNEL);=09
				nodebuild->buffer.va =3D kmalloc(PERIODSIZE_HW, GFP_DMA);
				nodebuild->buffer.pa =3D virt_to_phys((void *)nodebuild->buffer.va);
				nodebuild->next=3DNULL;
// 				printk("Getting more Frames buffers, num of nodes %d\n",nodecounter)=
;
			}		=09
			ptr=3D(int *)nodebuild->buffer.va;
			frame=3D0;=09
		}
//   		printk("2.cnt %d, frame %d\n",cnt, frame);=20
		if(cnt>=3D (FPP_HW -frame))
		{

			for(i=3D0;il);
// 				printk(" 0x%04x ",data->r);=09
//Big Endian
// 				aux=3D((data->l>>8)&0xff)+((data->l << 8)&0xff00);
// 				*(ptr+(i*SLOTS)+(frame*SLOTS)) =3D (aux<r>>8)&0xff)+((data->r << 8)&=
0xff00);
// 				*(ptr+(i*SLOTS)+(frame*SLOTS)+1) =3D (aux<l<r<next=3DNULL;
			if(LastNode !=3D NULL) LastNode->next =3D nodebuild;
			if(FirstNode =3D=3D NULL) FirstNode =3D nodebuild;
			LastNode =3D nodebuild;
			nodecounter++;
//   			printk("3.cnt %d, frame %d\n",cnt, frame);=20
		}
		else
		{
			for(i=3D0;il);
// 				printk("%04x ",data->r);
//Big Endian
// 				aux=3D((data->l>>8)&0xff)+((data->l << 8)&0xff00);
// 				*(ptr+(i*SLOTS)+(frame*SLOTS)) =3D (aux<r>>8)&0xff)+((data->r << 8)&=
0xff00);
// 				*(ptr+(i*SLOTS)+(frame*SLOTS)+1) =3D (aux<l<r<tfdata =3D 0xF0010000;=
 		 // Power-down [Table 1, MAX5712 Datasheet]=09

	gpio->port_config |=3D PORT_CONFIG_PSC1;

	cdm->clk_enables |=3D PSC1_CLK_EN;

	cdm->mclken_div_psc1 	=3D 0x8010;

	rx_fifo =3D MPC52xx_PA(MPC52xx_PSCx_OFFSET(psc_num))+0x60;
	tx_fifo =3D MPC52xx_PA(MPC52xx_PSCx_OFFSET(psc_num))+0x80;


	spin_lock_init(&priv->dma_lock);

// 	printk("Before Tasks init\n");

	rx_bcom =3D bcom_gen_bd_rx_init(2, (phys_addr_t)rx_fifo, initiator_rx, BCO=
M_IPR_PSC1_RX, 512);

	tx_bcom =3D bcom_gen_bd_tx_init(8, (phys_addr_t)tx_fifo, initiator_tx, BCO=
M_IPR_PSC1_TX);


	r_irq =3D bcom_get_task_irq(rx_bcom);
	t_irq =3D bcom_get_task_irq(tx_bcom);

	printk("r_irq %d 0x%08x t_irq %d 0x%08x, r_tasknum %d, t_tasknum %d\n", r_=
irq, r_irq, t_irq, t_irq, rx_bcom->tasknum, tx_bcom->tasknum);
	psc->command =3D (MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
	psc->command =3D MPC52xx_PSC_RST_RX;
	psc->command =3D MPC52xx_PSC_RST_TX;
	psc->command =3D MPC52xx_PSC_RST_ERR_STAT;

	psc->op1 =3D 0x03;
	udelay(10);
	psc->op0 =3D 0x02;
	udelay(50);
=09
	SICR =3D 0x0F90E000;
=09
	psc->command 	=3D 0x0A;
	psc->sicr	=3D SICR;
	psc->ctur	=3D 0x03;
	psc->ctlr	=3D 0x34;
	psc->ccr	=3D 0x070F0000;

	psc->rfalarm	=3D RX_ALARM;	=09
	psc->tfalarm	=3D TX_ALARM;	=09
	psc->rfcntl	=3D RX_GRAN;	=09
	psc->tfcntl	=3D TX_GRAN;	=09
	psc->isr_imr.isr	=3D 0x00;
	psc->isr_imr.imr	=3D 0x00;=09
	psc->mode	=3D 0x00;			/* set RX interrupt to RxRDY */
	psc->command =3D (MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);

	psc->tfdata =3D 0xF0010000; 	// Power-down [Table 1, MAX5712 Datasheet]
	udelay(100);=09

	psc->tfdata =3D 0xF0000000; 	// Wake-up [Table 1, MAX5712 Datasheet]	=09

	udelay(100);
=09
// 	printk("Before request_irq's\n");
	if (request_irq(r_irq, &SPI_rx_irq, /*IRQF_DISABLED*/0, "SPI rx dma", priv=
)) {
		printk(KERN_ERR "SPI: SDMA rx irq allocation failed\n");
		return;
	}=20
	if (request_irq(t_irq, &SPI_tx_irq, /*IRQF_DISABLED*/0, "SPI tx dma", priv=
)) {
		printk(KERN_ERR "SPI: SDMA tx irq allocation failed\n");
		return;
	}=20

	bcom_gen_bd_tx_reset(tx_bcom);
	bcom_gen_bd_rx_reset(rx_bcom);

// 	printk("Before submitting a buffer\n");
	spin_lock(&priv->dma_lock);
	while (!bcom_queue_full(tx_bcom)) {
		struct bcom_gen_bd *bd;

		/* Submit a new one */
		bd =3D (struct bcom_gen_bd *) bcom_prepare_next_buffer(tx_bcom);
		bd->status =3D PERIODSIZE_HW;
		bd->buf_pa =3D SPI_tx_silence.pa;
		bcom_submit_next_buffer(tx_bcom, NULL);;
	}
	spin_unlock(&priv->dma_lock);

	bd =3D bcom_prepare_next_buffer(rx_bcom);

	bd->status =3D 512;
	bd->data[0] =3D SPI_rx_bufs.pa;

	bcom_submit_next_buffer(rx_bcom, (void *)SPI_rx_bufs.pa);

	psc->command =3D MPC52xx_PSC_RST_RX;
	psc->command =3D MPC52xx_PSC_RST_TX;
	psc->command =3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;


	bcom_enable(tx_bcom);
	bcom_enable(rx_bcom);

	kt_timeup   =3D timeval_to_ktime(tclockup);
	kt_timedown =3D timeval_to_ktime(tclockdown);
	hrtimer_init(&start_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);=09
	start_timer.function =3D timer_funct;
// 	printk("Before exit in Setup_SPI()\n");
}

void register_period_elapsed(void (*funcptr)()) {
/*	printk("Function registered\n");*/
	hook_per_elap =3D funcptr;
};

void register_hook_frames_rcv(UInteger32 (*funcptr)()) {
/*	printk("Function registered\n");*/
	hook_frames_rcv =3D funcptr;
	hrtimer_start(&start_timer, kt_timeup, HRTIMER_MODE_REL);
};

int snd_SPI_pcm_prepare(struct snd_pcm_substream * substream) {
#ifdef SND_I2S_DEBUG
	snd_pcm_runtime_t *runtime =3D substream->runtime;
	printk("snd_I2Smgt_pcm_prepare\n");
	printk("  runtime->buffer_size=3D%i\n",(int)runtime->buffer_size);
	printk("  runtime->period_size=3D%i\n",(int)runtime->period_size);
	printk("  runtime->periods=3D%i\n",(int)runtime->periods);
#endif
	SPI_play =3D SPI_pos =3D 0;
	return 0;
};

EXPORT_SYMBOL(register_period_elapsed);
EXPORT_SYMBOL(register_hook_frames_rcv);
EXPORT_SYMBOL(snd_SPI_pcm_prepare);


int SPIspeaker_init(void) {

	SPI_buffers_init();
	SPI_setup();
	return 0;
}

void SPIspeaker_exit(void) {

	/* Freeing buffer SPIspeaker */
	if (SPI_rx_bufs.va) {
	kfree(SPI_rx_bufs.va);
	}
	if (SPI_tx_silence.va) {
	kfree(SPI_tx_silence.va);
	}
}

module_init(SPIspeaker_init);
module_exit(SPIspeaker_exit);

MODULE_DESCRIPTION("MPC52xx SPI");
MODULE_AUTHOR("Pedro Dom=EDnguez,,,, (pedro.dominguez@aed-engineering.com)"=
);
MODULE_LICENSE("GPL");

-----------------------------
As I told you, here is the configuration routine for the I2S module. Please=
, notice that this module whas built to work on the old 2.6.16 kernel and o=
ld dma driver:

static int I2S_setup(void) {

	int i;
// 	u32 val32;
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
			panic("snd-I2Smgt.o: invalid value for psc_num (%i)\n",psc_num);
			break;
	};

	/* 528MHz/(0x1f+1)=3D16.5 MHz */
	cdm->mclken_div_psc2 =3D 0x8001; // Mhz MCLK ( Khz * )
	psc->command =3D (MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
	/* PSC2 CODEC with Master Clock */
	gpio->port_config |=3D 0x70;
	/* PSC2 clock enable */
	cdm->clk_enables |=3D 0x40;

	// PSC reset
	psc->command =3D MPC52xx_PSC_RST_RX;
	psc->command =3D MPC52xx_PSC_RST_TX;
 	psc->command =3D MPC52xx_PSC_SEL_MODE_REG_1;
 	psc->command =3D MPC52xx_PSC_RST_ERR_STAT;


	// PSC setup I2S
	psc->mode =3D 0;
	psc->rfalarm =3D RX_ALARM;
 	psc->tfalarm =3D TX_ALARM;
	psc->rfcntl =3D RX_GRAN;
 	psc->tfcntl =3D TX_GRAN;
	psc->mpc52xx_psc_imr =3D 0x0000;

	psc->sicr =3D 0x0FE00000;
	psc->ctur =3D 0x1f; //Frame length 0x17

	psc->ccr =3D 0x3f5D; //LRCK  KHz, BitCLK  MHz  0x3f05!

// 	psc->sicr |=3D /* DELAY_TIME_SLOT |*/ MULTIWD_ENABLE | CLK_POL_RISING;
// =09
// 	psc->sicr |=3D GEN_CLK_INT;

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
// 	sdma_gen_bd_rx_init(rx_sdma, (phys_addr_t)&(psc->rfdata), PERIODSIZE_HW=
, initiator_rx, 6);
	sdma_gen_bd_rx_init(0, rx_sdma, (phys_addr_t)&(psc->rfdata), initiator_rx,=
 6, PERIODSIZE_HW);
// 	sdma_gen_bd_tx_init(tx_sdma, (phys_addr_t)&(psc->tfdata), PERIODSIZE_HW=
, initiator_tx, 6);
	sdma_gen_bd_tx_init(0, tx_sdma, (phys_addr_t)&(psc->tfdata), initiator_tx,=
 6);

	printk("txtask is %d rxtask is %d\n", tx_sdma->tasknum, rx_sdma->tasknum);
//=20
	// prepare the ring buffers
	for(i=3D0;itasknum %d\n", sdma_irq(rx_sdma), MPC52xx_SDMA_IRQ_BASE + rx_sd=
ma->tasknum);
	if (request_irq(sdma_irq(rx_sdma), I2S_rx_irq, 0, "SPI rx dma", NULL)) {
		printk(KERN_ERR "SPI: SDMA rx irq allocation failed\n");
		return -EINVAL;
	} else printk("SPI: SDA rx irq allocation succeded\n");
	if (request_irq(sdma_irq(tx_sdma), I2S_tx_irq, 0, "SPI tx dma", NULL)) {
		printk(KERN_ERR "SPI: SDMA tx irq allocation failed\n");
		return -EINVAL;
	} else printk("SPI: SDA tx irq allocation succeded\n");
=09
//=20
// 	// clear any pending interrupts
	sdma_clear_irq(tx_sdma);
	sdma_clear_irq(rx_sdma);
//=20
	printk("Before activating the tasks\n");
// 	// activate the tasks
// 	sdma_enable(tx_sdma);
// 	sdma_enable(rx_sdma);
//=20
// 	printk("about to enable SPI psc\n");
	udelay(100);
//=20
// 	// enable transmitter and receiver
	psc->command =3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;
// //	psc->command =3D MPC52xx_PSC_TX_ENABLE;
//=20
//=20
// // 	I2S_print(__FUNCTION__);
//=20
// // 	pcm1680_read();
// //         pcm1680_configure(44100);
// // 	pcm1680_read();

	return 0;
};



>=20
> Angelo wrote:
>> Timur wrote:
>>>I wrote an ASoC driver for the MPC8610, which also has
>>>an I2S interface.  You can find it in sound/soc/fsl.
>>
>> in my kernel version (2.6.22) there isn't any folder named
>> fsl in sound/soc/
>=20
>> Timur wrote:
>> It's in 2.6.25.
>=20
>=20
> The main problem is that in the feature of MPC8610 you can find:
>   Two synchronous serial interface (SSI) controllers for I2S or AC97
>   audio inputs/outputs
> while in MPC5200b's feature there's only:
>   I2S (up to three)
> However the main difference features:
> MPC5200B: http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=
=3DMPC5200B&nodeId=3D0162468rH3bTdG0898
> MPC8610:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPC8610
>=20
> What do you think on this difference?
>=20
>=20
>=20
> ________________________________
> ________________________________
> L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail

_________________________________________________________________
Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines para=
 estar siempre a la =FAltima
http://newsletters.msn.com/hm/maintenanceeses.asp?L=3DES&C=3DES&P=3DWCMaint=
enance&Brand=3DWL&RU=3Dhttp%3a%2f%2fmail.live.com=
