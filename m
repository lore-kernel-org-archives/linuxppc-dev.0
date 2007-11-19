Return-Path: <ankur_maheshwari@procsys.com>
Received: from mailsvr.procsys.com (unknown [61.95.199.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D593EDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Nov 2007 16:54:17 +1100 (EST)
Message-ID: <474124BB.7010308@procsys.com>
Date: Mon, 19 Nov 2007 11:22:59 +0530
From: Ankur Maheshwari <ankur_maheshwari@procsys.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: MPC880: i2cer register says tx is done but tx buf descriptor
	is	still	ready
References: <F1F6EC0C8B75034F9E3A79FC85122E8EB7C778@aquib01a>	<473F33BB.7050006@scram.de>
	<F1F6EC0C8B75034F9E3A79FC85122E8E2649F4@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E2649F4@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Antonio,

Check  how is your tx_buf is allocated, if its 2.4 kernel , then try 
allocating  using following function

tx_buf = (u_char *)m8xx_cpm_hostalloc(512);

512 is the size, also dump and check the difference in start address.

I more recommendation, check how your Serial/Network driver has 
allocated memory, try using same method.

thanks,
Ankur



DI BACCO ANTONIO - technolabs wrote:
>
> A porting of the driver included in kernel 2.4.
>
> Here is an excerpt of the method to send bytes over the i2c bus:
> ________________________________________________________________________
>   i2c->i2c_i2cmr = 0x00;        /* Disable I2C interupts */
>   i2c->i2c_i2cer = 0xff;
>   i2c->i2c_i2mod |= 1;  /* Enable */
>   i2c->i2c_i2com |= 0x80;       /* Begin transmission */
>   tmo = jiffies + 1*HZ;
>   /* Busy wait, with a timeout */
>   while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo)));
>  
>
>   if (signal_pending(current) || !tmo){
>     force_close(algo_8xx_data);
>     if (!tmo)
>         printk("IIC write: timeout!\n");
>
>     return -EIO;
>   }
>
>   if ((tbdf[0]->cbd_sc | tbdf[1]->cbd_sc) & BD_SC_NAK) {
>       printk(KERN_INFO "IIC write; no ack\n");
>       if (cpm_debug > 0)
>         printk("tx0 sc %04x, tx1 sc %04x\n", 
> tbdf[0]->cbd_sc,tbdf[1]->cbd_sc);
>    
>     return 0;
>   }
>
>   if ((tbdf[0]->cbd_sc | tbdf[1]->cbd_sc) & BD_SC_READY) {
>       printk(KERN_INFO "IIC write; complete but tbuf ready\n");
>       if (cpm_debug > 0)
>         printk("tx0 sc %04x, tx1 sc %04x\n", 
> tbdf[0]->cbd_sc,tbdf[1]->cbd_sc);
>
>     return 0;
>   }
>
>
> -----Original Message-----
> From: Jochen Friedrich [mailto:jochen@scram.de]
> Sent: Sat 17/11/2007 19.32
> To: DI BACCO ANTONIO - technolabs
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC880: i2cer register says tx is done but tx buf 
> descriptor is still      ready
>
> Hi Antonio,
>
> > How could it be possible? It happens during the first i2c transactions
> > and then no more.
> >  
>
> What linux version? Which driver?
>
> Thanks,
> Jochen
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
