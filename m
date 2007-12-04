Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7BCCDE031
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:34:06 +1100 (EST)
Message-ID: <4755D5C7.5050307@freescale.com>
Date: Tue, 04 Dec 2007 16:33:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712042313.58252.arnd@arndb.de>
In-Reply-To: <200712042313.58252.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> Can you use the driver on CPUs without this particular bug when it's built
> in Soft-UART mode?

No, you have to build with Soft-UART mode turned off.  Soft-UART mode actually 
uses the HMC mode of the QE and hacks it up to act like a UART.

The only way to know at runtime whether Soft-UART is required is to check the 
SOC model/revision and compare it to a list.

I could add code to check this list and enable Soft-UART if when there's a known 
CPU with the problem.  However, I can't know whether I need to upload the 
microcode.  I also have a U-Boot version of qe_upload_firmware(), so it's 
conceivable that U-Boot could have uploaded the microcode but I still need the 
Linux driver to use Soft-UART.

I also have no control over which Soft-UART microcodes are available.  It's 
possible that some SOCs could have this bug but Freescale won't produce a 
microcode to fix it.

> Try to reduce the number of #ifdefs in your code. In particular, you should
> not do conditional #includes and #defines, as they often lead to subtle bugs.

Ok, I can remove those #defines, but my main concern was to clearly isolate the 
Soft-UART code, since it is an ugly hack.  I didn't want to mesh the Soft-UART 
code with the normal UART code.  I don't know what more I could do to limit the 
number of #ifdefs.


>> +struct ucc_uart_pram {
>> +	struct ucc_slow_pram common;
>> +	u8 res1[8];     	/* reserved */
>> +	__be16 maxidl;  	/* Maximum idle chars */
>> +	__be16 idlc;    	/* temp idle counter */
>> +	__be16 brkcr;   	/* Break count register */
>> +	__be16 parec;   	/* receive parity error counter */
>> +	__be16 frmec;   	/* receive framing error counter */
>> +	__be16 nosec;   	/* receive noise counter */
>> +	__be16 brkec;   	/* receive break condition counter */
>> +	__be16 brkln;   	/* last received break length */
>> +	__be16 uaddr[2];	/* UART address character 1 & 2 */
>> +	__be16 rtemp;   	/* Temp storage */
>> +	__be16 toseq;   	/* Transmit out of sequence char */
>> +	__be16 cchars[8];       /* control characters 1-8 */
>> +	__be16 rccm;    	/* receive control character mask */
>> +	__be16 rccr;    	/* receive control character register */
>> +	__be16 rlbc;    	/* receive last break character */
>> +	__be16 res2;    	/* reserved */
>> +	__be32 res3;    	/* reserved, should be cleared */
>> +	u8 res4;		/* reserved, should be cleared */
>> +	u8 res5[3];     	/* reserved, should be cleared */
>> +	__be32 res6;    	/* reserved, should be cleared */
>> +	__be32 res7;    	/* reserved, should be cleared */
>> +	__be32 res8;    	/* reserved, should be cleared */
>> +	__be32 res9;    	/* reserved, should be cleared */
>> +	__be32 res10;   	/* reserved, should be cleared */
>> +	__be32 res11;   	/* reserved, should be cleared */
>> +	__be32 res12;   	/* reserved, should be cleared */
>> +	__be32 res13;   	/* reserved, should be cleared */
>> +#ifdef CONFIG_SERIAL_QE_SOFT_UART
>> +	__be16 supsmr;  	/* 0x90, Shadow UPSMR */
>> +	__be16 res92;   	/* 0x92, reserved, initialize to 0 */
>> +	__be32 rx_state;	/* 0x94, RX state, initialize to 0 */
>> +	__be32 rx_cnt;  	/* 0x98, RX count, initialize to 0 */
>> +	u8 rx_length;   	/* 0x9C, Char length, set to 1+CL+PEN+1+SL */
>> +	u8 rx_bitmark;  	/* 0x9D, reserved, initialize to 0 */
>> +	u8 rx_temp_dlst_qe;     /* 0x9E, reserved, initialize to 0 */
>> +	u8 res14[0xBC - 0x9F];  /* reserved */
>> +	__be32 dump_ptr;	/* 0xBC, Dump pointer */
>> +	__be32 rx_frame_rem;    /* 0xC0, reserved, initialize to 0 */
>> +	u8 rx_frame_rem_size;   /* 0xC4, reserved, initialize to 0 */
>> +	u8 tx_mode;     	/* 0xC5, mode, 0=AHDLC, 1=UART */
>> +	u16 tx_state;   	/* 0xC6, TX state */
>> +	u8 res15[0xD0 - 0xC8];  /* reserved */
>> +	__be32 resD0;   	/* 0xD0, reserved, initialize to 0 */
>> +	u8 resD4;       	/* 0xD4, reserved, initialize to 0 */
>> +	__be16 resD5;   	/* 0xD5, reserved, initialize to 0 */
>> +#endif
>> +} __attribute__ ((packed));
> 
> The structure is perfectly packed even without your __attribute__ ((packed)),
> so you should leave out the attribute in order to get more efficient code
> accessing it.

If the structure is packed either way, why would the code differ?  I don't see 
how the code would be more efficient if I removed "__attribute__ ((packed))". 
If gcc does something differently, that's news to me.

> Do you really need the debugging function like this in the code?
> Usually they are rather pointless once the code works, and will
> suffer from bitrot because nobody enables the code.

Well, I'm hesitant to remove it because I have a feeling that if I do, the next 
day I'll want it.

>> +#ifdef CONFIG_SERIAL_QE_SOFT_UART
>> +#define UCC_UART_SUPSMR_SL      	0x8000
>> +#define UCC_UART_SUPSMR_RPM_MASK	0x6000
>> +#define UCC_UART_SUPSMR_RPM_ODD 	0x0000
>> +#define UCC_UART_SUPSMR_RPM_LOW 	0x2000
> 
> again, the #ifdef should be left out if it can.

Alright.

> 
>> + * Given the virtual address for a character buffer, this function returns
>> + * the physical (DMA) equivalent.
>> + */
>> +static inline dma_addr_t cpu2qe_addr(void *addr, struct uart_qe_port *qe_port)
>> +{
>> +	if (likely((addr >= qe_port->bd_virt)) &&
>> +	    (addr < (qe_port->bd_virt + qe_port->bd_size)))
>> +		return qe_port->bd_phys + (addr - qe_port->bd_virt);
>> +
>> +	/* something nasty happened */
>> +	printk(KERN_ERR "%s: addr=%p\n", __FUNCTION__, addr);
>> +	BUG();
>> +	return 0;
>> +}
> 
> I'm guessing that you don't really mean dma_addr_t here, but rather
> phys_addr_t, which is something different.

Now that I think about it, I think I really mean unsigned, since the returned 
value is just an offset.  I need to think about that.

-- 
Timur Tabi
Linux kernel developer at Freescale
