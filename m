Return-Path: <melinda.develey70@yahoo.com>
Received: from web63012.mail.re1.yahoo.com (web63012.mail.re1.yahoo.com
	[69.147.96.223]) by ozlabs.org (Postfix) with SMTP id 0DFDADDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 07:09:38 +1100 (EST)
Message-ID: <20070305200937.70365.qmail@web63012.mail.re1.yahoo.com>
Date: Mon, 5 Mar 2007 12:09:34 -0800 (PST)
From: melinda develey <melinda.develey70@yahoo.com>
Subject: Help Melinda with a 2.6 spi driver for mpc875!
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2060027040-1173125374=:68172"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2060027040-1173125374=:68172
Content-Type: multipart/alternative; boundary="0-1245376340-1173125374=:68172"

--0-1245376340-1173125374=:68172
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I attached a driver for the SPI controller of MPC875 that I'm developing. It's not yet complete, actually, in the mpc8xx_transfer () method simply tries to transmit 3 bytes (the SPI controller is looped) and thus I expect to receive the same three bytes. It works sometimes, but not always and I don't know why. 
In the init I configure the SPI controller, to do this, I do a ioremap_nocache of  physaddr IMMAP address and then write the relevant registers. I also tried to put __iomem qualifier to the SPI registers pointers thinking that the writes to the SPI registers were cached. No success! What could be the problem?

Bye,
Melinda.


 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-1245376340-1173125374=:68172
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I attached a driver for the SPI controller of MPC875 that I'm developing. It's not yet complete, actually, in the mpc8xx_transfer () method simply tries to transmit 3 bytes (the SPI controller is looped) and thus I expect to receive the same three bytes. It works sometimes, but not always and I don't know why. <br>In the init I configure the SPI controller, to do this, I do a ioremap_nocache of&nbsp; physaddr IMMAP address and then write the relevant registers. I also tried to put __iomem qualifier to the SPI registers pointers thinking that the writes to the SPI registers were cached. No success! What could be the problem?<br><br>Bye,<br>Melinda.<br><br><p>&#32;

<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=45083/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-1245376340-1173125374=:68172--

--0-2060027040-1173125374=:68172
Content-Type: text/x-csrc; name="spi_mpc8xx.c"
Content-Description: 453168731-spi_mpc8xx.c
Content-Disposition: inline; filename="spi_mpc8xx.c"

/*
 * MPC83xx SPI controller driver.
 *
 * Maintainer: Kumar Gala
 *
 * Copyright (C) 2006 Polycom, Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#include <linux/module.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/completion.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/irq.h>
#include <linux/dma-mapping.h>
#include <linux/device.h>
#include <linux/spi/spi.h>
#include <linux/spi/spi_bitbang.h>
#include <linux/platform_device.h>
#include <linux/fsl_devices.h>
#include <linux/fs_spi_pd.h>
#include <asm/irq.h>
#include <asm/io.h>
#include <asm/commproc.h>


/* MPC8xx SPI Controller mode register definitions are in commproc.h */
#define	SPMODE_LEN(x)		    ((x-1) << 4)
#define	SPMODE_PM(x)		    ((x))

#define SPI_MAX_BUFFER_SIZE         32
/*
 * Default for SPI Mode:
 * 	SPI MODE 0 (inactive low, phase middle, MSB, 8-bit length, slow clk
 */
#define	SPMODE_INIT_VAL (SPMODE_CI | SPMODE_DIV16 | SPMODE_REV | \
			 SPMODE_MS | SPMODE_LEN(7) | SPMODE_PM(0xf))

/* SPIE/SPIM register values */
#define	SPIE_MME		0x20	/* Multimaster error */
#define	SPIE_TXE		0x10	/* Tx error */
#define	SPIE_BSY		0x04    /* No rx buffer available */
#define	SPIE_TXB		0x02    /* Tx buffer transmitted */
#define	SPIE_NF		        0x01    /* Rx buffer filled */

/* SPCOM values */
#define SPCOM_START             0x80    /* Start transmission command */

#ifndef BD_SC_ME
#define BD_SC_ME        ((ushort)0x0001)    /* Multi Master Error */
#endif

/*************************************************/


int j = 0;
static u8* rxbuffer;
static u8* txbuffer;
void spi_activate_cs(u8 cs, u8 polarity);
void spi_deactivate_cs(u8 cs, u8 polarity);

static car8xx_t     *carp; 
static spi_t	    *spi;  
static immap_t      *immap;
static cpic8xx_t    *cpi;  
static cpm8xx_t     *cp;   
static iop8xx_t     *iop;  
static cbd_t        *tbdf;
static cbd_t        *rbdf;

static  unsigned short r_tbase, r_rbase;

/* SPI Controller driver's private data. */
struct mpc8xx_spi {

	struct completion done;

        dma_addr_t scratchbuf;

        /* lock to avoid contemporaneous transmission */
        spinlock_t lock;

	unsigned int count;
	u32 irq;

	unsigned nsecs;		/* (clock cycle time)/2 */

	u32 inpclk;

        u16 mode; /* spi mode in hardware specific way */

	void (*activate_cs) (u8 cs, u8 polarity);
	void (*deactivate_cs) (u8 cs, u8 polarity);
                
};



static 
u16 mpc8xx_spi_hwmode(u8 mode, int len, u32 inpclk, u32 speedhz)
{
        /* DFBRG is zero */
        u16 modehw = SPMODE_MSTR ;
        
        /* setup spi mode */
        if (mode & SPI_CPOL)
            modehw |= SPMODE_CI;   
        if (mode & SPI_CPHA)
            modehw |= SPMODE_CP; 
        if (!(mode & SPI_LSB_FIRST))
            modehw |= SPMODE_REV;   
       
        modehw |= SPMODE_LEN(len); 

        /* Setting desired speed */
        modehw |= SPMODE_PM((u8)((inpclk/speedhz)/4-1));
                 
        return modehw;
}

static
int mpc8xx_transmit(u8* tx_buf, u8* rx_buf, int tx_size, int rx_size)
{
	int result, i;
	
        // copy data to be sent into the transmit buffer
	if (tx_buf)
          memcpy((void*)(txbuffer), (void*)tx_buf, tx_size);
    
        // BD data length register
        tbdf->cbd_datlen = rbdf->cbd_datlen = tx_size + rx_size;
    

        printk("SPI TX: ");
        for (i = 0; i < tx_size; i++)
          printk("%02X ", txbuffer[i]);
        printk("\n");

	 // BD status/control register
	tbdf->cbd_sc = BD_SC_READY | BD_SC_WRAP | BD_SC_LAST;
	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

	cp->cp_spmode = 0x4678;   // spi mode setting
	cp->cp_spmode |= 0x0100;                // enable SPI
	cp->cp_spie   = 0xff;                   // clear all spi events
	cp->cp_spim   = 0x37;                   // mask all SPI events


	udelay(10); // Wait 5 microsecs

	cp->cp_spcom = 0x80;   // start the transfer

	udelay(100000);

	cp->cp_spmode = 0x00;   // reset spi mode

	udelay(10); // Wait 10 microsecs


	// test receive and transmit buffer descriptor for errors
	if (rbdf->cbd_sc & (BD_SC_EMPTY | BD_SC_OV | BD_SC_ME))
	{
        	result = -EIO;
	}
	if (tbdf->cbd_sc & (BD_SC_READY | BD_SC_UN | BD_SC_ME))
	{
        	result = -EIO;
	}
	
	// copy the received data into the receive buffer
     	if (rx_buf)
	  memcpy((void*)rx_buf, ((u8*)rxbuffer) + tx_size, rx_size);
	
	printk("SPI RX: ");
	for (i = 0; i < tx_size; i++)
	  printk("%02X ", *((u_char*)(((u_char*)rxbuffer) /*+ tx_size*/ + i)));
	printk("\n");

        return result;        
}

static
int mpc8xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
{
	struct mpc8xx_spi *mpc8xx_spi;
	struct spi_transfer	*t = NULL;
        int res = 0, i;
        
        printk("%s\n", __FUNCTION__);
                
	mpc8xx_spi = spi_master_get_devdata(spi->master);
      
        mpc8xx_spi->activate_cs(spi->chip_select, 0);
        udelay(5);

        //list_for_each_entry(t, &msg->transfers, transfer_list) 
        {
	   txbuffer[0] = j;
	   txbuffer[1] = j;
	   txbuffer[2] = j;
	   j++;
	   rxbuffer[0] = 0x55;
	   rxbuffer[1] = 0x55;
	   rxbuffer[2] = 0x55;
	   
	   mpc8xx_transmit(NULL, NULL, 3, 0);	   

	}

        mpc8xx_spi->deactivate_cs(spi->chip_select, 0);
        udelay(5);

	msg->status = -EMSGSIZE;
	msg->complete(msg->context);
        
	return res;
}


static int mpc8xx_spi_setup(struct spi_device *spi)
{
	struct mpc8xx_spi *mpc8xx_spi;

	if (!spi->max_speed_hz)
		return -EINVAL;

	mpc8xx_spi = spi_master_get_devdata(spi->master);


	if (!spi->bits_per_word)
		spi->bits_per_word = 8;

        
	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
		__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
		spi->bits_per_word, 2 * mpc8xx_spi->nsecs);

               

	/* NOTE we _need_ to call chipselect() early, ideally with adapter
	 * setup, unless the hardware defaults cooperate to avoid confusion
	 * between normal (active low) and inverted chipselects.
	 */

	spin_lock(mpc8xx_spi->lock);
	
        mpc8xx_spi->deactivate_cs(spi->chip_select, 0);

        ndelay(mpc8xx_spi->nsecs);
	spin_unlock(mpc8xx_spi->lock);
        
	return 0;
}


irqreturn_t mpc8xx_spi_irq(s32 irq, void *context_data)
{
	struct mpc8xx_spi *mpc8xx_spi = context_data;
	u8 event;
        printk("%s\n", __FUNCTION__);
        event = cp->cp_spie;

        cp->cp_spie    = 0xff;      // reset spi event register
        cpi->cpic_cisr = 0x20;      // clear spi interrupt mask

        complete(&mpc8xx_spi->done);

	return IRQ_HANDLED;
}

static
void mpc8xx_spi_controller_init()
{
	u32 dp_addr;

        // get pointer to processors internal memory map
        immap = ioremap_nocache((immap_t *)IMAP_ADDR, 0x10000);
;
        //  printk("*** spi_read: immap = 0x%08x ***\n",(unsigned int)immap);

        // get pointer to cpm interrupt controller
        cpi = (cpic8xx_t*)&(((volatile immap_t*)immap)->im_cpic);
        //  printk("*** spi_read: cpi = 0x%08x ***\n",(unsigned int)cpi);

        // get pointer to input/output port
        iop = (iop8xx_t *)&(((volatile immap_t *)immap)->im_ioport);
        //  printk("*** spi_read: iop = 0x%08x ***\n",(unsigned int)iop);

        // get pointer to communication processor
        cp = (cpm8xx_t *)&(((volatile immap_t *)immap)->im_cpm);
        //  printk("*** spi_init: cp = 0x%08x ***\n",(unsigned int)cp);

        // get pointer to Serial Peripheral Interface parameter RAM
        spi = (spi_t *)&cp->cp_dparam[PROFF_SPI];
        //  printk("*** spi_init: spi = 0x%08x ***\n",(unsigned int)spi);

        // get pointer to clocks and reset
        carp = (car8xx_t *)&((volatile immap_t *)immap)->im_clkrst;
        //  printk("*** spi_init: carp = 0x%08x ***\n",(unsigned int)carp);

        // ------------------------------------------
        //  SCCR[DFBRG] = 0  -->  BRGCLK = vcoout/1         
        // ------------------------------------------
        carp->car_sccr &= 0xFFFFE7FF;

        //  initialize the parameter ram
        //  we need to make sure many things are initialized to zero
        spi->spi_rstate = 0;
        spi->spi_rdp = 0;
        spi->spi_rbptr = 0;
        spi->spi_rbc = 0;
        spi->spi_rxtmp = 0;
        spi->spi_tstate = 0;
        spi->spi_tdp = 0;
        spi->spi_tbptr = 0;
        spi->spi_tbc = 0;
        spi->spi_txtmp = 0;

        // allocate space for one transmit and one receive buffer descriptor in the DP ram
        dp_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
        // printk("*** spi_init: dp_addr = 0x%08x ***\n",(unsigned int)dp_addr);

        // Set up the SPI parameters in the parameter ram
        spi->spi_rbase = r_rbase = dp_addr;
        spi->spi_tbase = r_tbase = dp_addr + sizeof(cbd_t);

        // ***********IMPORTANT******************
        // setting transmit and receive buffer descriptor
        // pointers initially to rbase and tbase. Only the
        // microcode patches documentation talks about initializing
        // this pointer. This is missing from the sample I2C driver.
        // If you dont initialize these pointers, the kernel hangs.
        spi->spi_rbptr = spi->spi_rbase;
        spi->spi_tbptr = spi->spi_tbase;

        // Set to big endian
        spi->spi_tfcr = SMC_EB;
        spi->spi_rfcr = SMC_EB;

        spi->spi_mrblr = SPI_MAX_BUFFER_SIZE;    // Set maximum receive size
        //  printk("*** spi_init: spi->spi_mrblr = 0x%04x ***\n",spi->spi_mrblr);

        cp->cp_cpcr |= 0x51;    // Setting CPCR

        immap->im_siu_conf.sc_sdcr = 0x0001;    // sets SDMA configuration register
        cpi->cpic_cicr |= 0x00000580;           // enable cpm interrupts, spi has highest priority
        cpi->cpic_cimr |= 0x00000020;           // enable spi interrupts

        cp->cp_spie = 0xff;     // clear all spi events

        //  printk("*** spi_init: iop->iop_pcdat = 0x%04x ***\n", iop->iop_pcdat);

        // ------------------------------------------------
        // initialize Port B SPI pins -> page 34-8 MPC860UM
        // (we are only in master mode !)
        // ------------------------------------------------

        // --------------------------------------------
        // GPIO or per. function
        // PBPAR[28] = 1  -> PERI: (SPIMISO)
        // PBPAR[29] = 1  -> PERI: (SPIMOSI)
        // PBPAR[30] = 1  -> PERI: (SPICLK)
        // --------------------------------------------
        cp->cp_pbpar |= 0x0000000E;  // set bits
       //  printk("*** spi_init: cp->cp_pbpar\n              ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbpar, cp->cp_pbpar);

        // ----------------------------------------------
        // In/Out or per. function 0/1
        // PBDIR[28] = 1  -> PERI1: SPIMISO
        // PBDIR[29] = 1  -> PERI1: SPIMOSI
        // PBDIR[30] = 1  -> PERI1: SPICLK
        // ----------------------------------------------
        cp->cp_pbdir |= 0x0000000E;
        //printk("*** spi_init: cp->cp_pbdir\n              ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbdir, cp->cp_pbdir);

        // -------------------------------------------------------------
        // attention: PBODR is a 32-bit-register,
        // but in the memory-map-struct it is handled as
        // 16-bit-register because lower 16 bit are always 0
        //
        // open drain or active output
        // PBODR[28] = 1  -> open drain: SPIMISO
        // PBODR[29] = 0  -> active output SPIMOSI
        // PBODR[30] = 0  -> active output: SPICLK
        // -------------------------------------------------------------
        //  printk("\n*** cp->cp_pbodr = 0x%08x ***\n",cp->cp_pbodr);
        cp->cp_pbodr |= 0x0008;  // set bits
        cp->cp_pbodr &= 0xFFF9;  // reset bits
        //  printk("*** spi_init: cp->cp_pbodr\n              ADR=0x%08x\n              VAL=0x%04x\n",(unsigned int)&cp->cp_pbodr, cp->cp_pbodr);

        //  printk("*** spi_init: cp->cp_pbdat\n              ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbdat, cp->cp_pbdat);

        // tx and rx buffer descriptors
        tbdf = (cbd_t *)&cp->cp_dpmem[r_tbase];
        rbdf = (cbd_t *)&cp->cp_dpmem[r_rbase];

        // initialize tx and tx bd's
        tbdf->cbd_sc &= ~BD_SC_READY;
        rbdf->cbd_sc &= ~BD_SC_EMPTY;

}

static int __init mpc8xx_spi_probe(struct platform_device *dev)
{
	struct spi_master *master;
	struct mpc8xx_spi *mpc8xx_spi;
	struct fsl_spi_platform_data *pdata;
	struct fs_spi_platform_info *pinfo;
	dma_addr_t physaddr;        
	int status = 0;        

	int ret = 0;

        printk("%s\n", __FUNCTION__);
	/* Get resources(memory, IRQ) associated with the device */
	master = spi_alloc_master(&dev->dev, sizeof(struct mpc8xx_spi));

	if (master == NULL) {
		ret = -ENOMEM;
		goto err;
	}

	platform_set_drvdata(dev, master);
	pinfo = dev->dev.platform_data;

	if (pinfo == NULL) {
		ret = -ENODEV;
		goto free_master;
	}
        
        /* initialize ioports */
	if (pinfo->init_ioports)
		pinfo->init_ioports(pinfo);

        pdata = pinfo->pdata;
        
	mpc8xx_spi = spi_master_get_devdata(master);

        
	mpc8xx_spi->inpclk = pdata->inpclk;
	mpc8xx_spi->activate_cs   = spi_activate_cs;
	mpc8xx_spi->deactivate_cs = spi_deactivate_cs;

	master->transfer = mpc8xx_spi_transfer;
        master->setup = mpc8xx_spi_setup;
        
	init_completion(&mpc8xx_spi->done);


	master->bus_num = pdata->bus_num;
	master->num_chipselect = pdata->max_chipselect;

	mpc8xx_spi_controller_init();
	
	status = spi_register_master(master);
	if (status != 0) {
		printk("problem registering spi master\n");
		goto free_irq;
	}

	mpc8xx_spi->irq = platform_get_irq(dev, 0);

	if (mpc8xx_spi->irq < 0) {
		ret = -ENXIO;
		goto put_master;
	}
                
	printk(KERN_INFO
	       "%s: MPC8xx SPI Controller driver at 0x%p (irq = %d)\n",
	       dev->dev.bus_id, spi, mpc8xx_spi->irq);

        

	/* Register for SPI Interrupt */
	ret = request_irq(mpc8xx_spi->irq, mpc8xx_spi_irq,
			  0, "mpc8xx_spi", mpc8xx_spi);

	if (ret != 0)
		goto free_irq;

    
        dma_alloc_coherent(NULL, PAGE_SIZE, &(mpc8xx_spi->scratchbuf), GFP_KERNEL);
	rxbuffer = __get_free_page(GFP_KERNEL | GFP_DMA);
	txbuffer = rxbuffer + 32;

        tbdf->cbd_bufaddr = __pa(txbuffer); 
        rbdf->cbd_bufaddr = __pa(rxbuffer);         
        
	return ret;

free_irq:
	free_irq(mpc8xx_spi->irq, mpc8xx_spi);
put_master:
	spi_master_put(master);
free_master:
	kfree(master);
err:
	return ret;
}

static int __devexit mpc8xx_spi_remove(struct platform_device *dev)
{
	struct mpc8xx_spi *mpc8xx_spi;
	struct spi_master *master;

	master = platform_get_drvdata(dev);
	mpc8xx_spi = spi_master_get_devdata(master);

	free_irq(mpc8xx_spi->irq, mpc8xx_spi);
	spi_master_put(master);

	return 0;
}

static struct platform_driver mpc8xx_spi_driver = {
	.probe = mpc8xx_spi_probe,
	.remove = __devexit_p(mpc8xx_spi_remove),
	.driver = {
		   .name = "fsl-cpm-spi",
	},
};

static int __init mpc8xx_spi_init(void)
{
	return platform_driver_register(&mpc8xx_spi_driver);
}

static void __exit mpc8xx_spi_exit(void)
{
	platform_driver_unregister(&mpc8xx_spi_driver);
}

module_init(mpc8xx_spi_init);
module_exit(mpc8xx_spi_exit);

MODULE_AUTHOR("Melinda Develey");
MODULE_DESCRIPTION("Simple MPC8xx SPI Driver");
MODULE_LICENSE("GPL");

--0-2060027040-1173125374=:68172--
