Return-Path: <dbruce@ll.mit.edu>
Received: from ll.mit.edu (LLMAIL.LL.MIT.EDU [129.55.12.40])
	by ozlabs.org (Postfix) with ESMTP id 33F2567A9C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 02:16:04 +1100 (EST)
Received: (from smtp@localhost) by ll.mit.edu (8.12.10/8.8.8) id j17EkJKf027846
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Feb 2005 09:46:19 -0500 (EST)
Message-ID: <42077F29.3030303@ll.mit.edu>
Date: Mon, 07 Feb 2005 09:46:01 -0500
From: David Bruce <dbruce@ll.mit.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050206010004.3890267A7A@ozlabs.org>
In-Reply-To: <20050206010004.3890267A7A@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: usage of  interruptible_sleep_on( ) function call
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I had the same problem with the i2c-algo-8260.c when loading a module. 
It's the __pa() translation. Replace _ALL_ __pa with iopa. It worked for 
me. I discovered it from this link:
http://ozlabs.org/pipermail/linuxppc-dev/2002-February/013260.html

linuxppc-embedded-request@ozlabs.org wrote:
> Send Linuxppc-embedded mailing list submissions to
> 	linuxppc-embedded@ozlabs.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> 	linuxppc-embedded-request@ozlabs.org
> 
> You can reach the person managing the list at
> 	linuxppc-embedded-owner@ozlabs.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
> 
> 
> Today's Topics:
> 
>    1. question re usage of  interruptible_sleep_on( ) function call
>       in	cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c)
>       (Povolotsky, Alexander)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Sat, 5 Feb 2005 12:30:06 -0500 
> From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
> Subject: question re usage of  interruptible_sleep_on( ) function call
> 	in	cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c)
> To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>,
> 	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>,
> 	"'etux@embeddedtux.org'" <etux@embeddedtux.org>
> Message-ID:
> 	<313680C9A886D511A06000204840E1CF0A6475F1@whq-msgusr-02.pit.comms.marconi.com>
> 	
> Content-Type: text/plain;	charset="ISO-8859-1"
> 
> Hello,
> 
>> 
>>I have MPC880 microprocessor based board with single 24C02 I2C EEPROM,
>>connected to the I2C bus.
>>
>>Currently booting of the board hangs in the I2C driver after invocation of
>>interruptible_sleep_on( )
> 
>  function call  in cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c file).
> 
> Is it appropriate to use the interruptible_sleep_on( ) function at the
> kernel booting stage ?
>  (I personally do not think so - since such usage prevents further kernel
> booting - as observed).
> What should be done in this code to avoid slleping ?
> 
> I presume that the usage of the interruptible_sleep_on( ) function would be
> appropriate if the 
> I2C would be configured as a module (after the kernel booting is completed)
> ?
> Follow up question:  is it really expected to do I2C initialization ONLY as
> a module after the kernel booting ?
> (is it documented anyplace ?) 
> 
> 
>>The (end of) log buffer shows following:
>>....
>><6>i2c /dev entries driver.
>><7>device class 'i2c-dev': registering.
>><7>bus i2c:add driver dev_driver.
>><7>i2c-core: driver dev_driver registered
>><6>i2c-rpx: i2c MPC8xx driver.
>><7>DEV: registering device: ID ='i2c-0'.
>><7>CLASS: registering class device: ID= 'i2c-0'.
>><7>i2c_adapter i2c-0:Registered as minor 0.
>><7>CLASS:registering class device: ID = 'i2c-0'
>><7>i2c_adapter i2c-0: registered as adapter #0.
>><4>cpm_iic_init() - iip=fa203c80.
>><4>cpm_iic_init[132] Install ISR for IRQ 16.
>><6>CPM interrupt c0105d90 replacing c01f7a8c.
>><3>request_irq() returned -22  for CPM vector 32.
>><6> i2c-algo-8xx.o: scanning bus m8xx........
>><4>cpm_iic_tryaddress(cpm=c019b9f8,addr=0).
>><4>iip fa203c80, dp_addr 0x800.
>><4>iic_tbase 2048, r_tbase 2048
>><4>about to sleep
>>.ABOVE LINE IS THE LAST ENTRY IN THE LOG BUFFER - THE BOOT HANGS
>>THEREAFTER ... 
>>
> 
> Here is the fragment of the cpm_iic_tryaddress( ) function in
> i2c-algo-8xx.c,
> where the problem takes place:
> .... 
> //      save_flags(flags); cli();
>         i2c->i2c_i2cer = 0xff;
>         i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
>         i2c->i2c_i2mod = 1;     /* Enable */
>         i2c->i2c_i2com = 0x81;  /* Start master */
> //      restore_flags(flags);
> 
>         if (cpm_debug > 1) printk("about to sleep\n");
> 
>         /* wait for IIC transfer */
> interruptible_sleep_on(&iic_wait);
> if (signal_pending(current))
>         return -EIO;
> 
> if (cpm_debug > 1) printk("back from sleep\n");
> 
> if (tbdf->cbd_sc & BD_SC_NAK) {
>         if (cpm_debug > 1) printk("IIC try; no ack\n");
>         return 0;
> }
> 
> if (tbdf->cbd_sc & BD_SC_READY) {
>         printk("IIC try; complete but tbuf ready\n");
> }
> 
> return 1;
> 
> ........
> 
>>Thanks,
>>Best Regards,
>>Alex 
>>
>>
> 
> 
> 
> ------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> End of Linuxppc-embedded Digest, Vol 6, Issue 12
> ************************************************
> 
> 

-- 
David Bruce
MIT Lincoln Laboratory
244 Wood Street
Lexington, MA 02420
781.981.3863
mailto:dbruce@ll.mit.edu
