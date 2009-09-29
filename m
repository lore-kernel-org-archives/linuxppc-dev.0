Return-Path: <richard.rojfors@mocean-labs.com>
Received: from proxy1.bredband.net (proxy1.bredband.net [195.54.101.71])
	by ozlabs.org (Postfix) with ESMTP id 39AC6B7B7E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 16:55:00 +1000 (EST)
Received: from iph1.telenor.se (195.54.127.132) by proxy1.bredband.net
	(7.3.140.3) id 49F5A15203D24AA8 for linuxppc-dev@ozlabs.org;
	Tue, 29 Sep 2009 08:34:43 +0200
Message-ID: <4AC1AA82.3040406@mocean-labs.com>
Date: Tue, 29 Sep 2009 08:34:42 +0200
From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
 <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH v4] xilinx_spi: Splitted into generic, of and platform
	driver, added support for DS570
References: <4AC0C699.2070506@mocean-labs.com>
	<8741a4f8-b490-4754-a674-71ea2ee1385a@SG2EHSMHS011.ehs.local>
In-Reply-To: <8741a4f8-b490-4754-a674-71ea2ee1385a@SG2EHSMHS011.ehs.local>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/28/09 5:41 PM, John Linn wrote:
>> -----Original Message-----
>> From: Richard Röjfors [mailto:richard.rojfors@mocean-labs.com]
>> Sent: Monday, September 28, 2009 8:22 AM
>> To: spi-devel-general@lists.sourceforge.net
>> Cc: linuxppc-dev@ozlabs.org; dbrownell@users.sourceforge.net; Andrew Morton; John Linn
>> Subject: [PATCH v4] xilinx_spi: Splitted into generic, of and platform driver, added support for
>> DS570
>>
>> This patch splits xilinx_spi into three parts, an OF and a platform
>> driver and generic part.
>>
>> The generic part now also works on X86, it supports accessing the IP
>> booth big and little endian. There is also support for 16 and 32 bit
>> SPI for the Xilinx SPI IP DS570
>>
>> Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
>> ---
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 2c733c2..ecabc12 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -218,8 +218,8 @@ config SPI_TXX9
>>  	  SPI driver for Toshiba TXx9 MIPS SoCs
>>
> 
> <snip>
> 
>>
>> -struct xilinx_spi {
>> -	/* bitbang has to be first */
>> -	struct spi_bitbang bitbang;
>> -	struct completion done;
>> +/* to follow are some functions that does little of big endian read and
>> + * write depending on the config of the device.
>> + */
>> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 val)
>> +{
>> +	iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
>> +}
>>
>> -	void __iomem	*regs;	/* virt. address of the control registers */
>> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 val)
>> +{
>> +	if (xspi->big_endian)
>> +		iowrite16be(val, xspi->regs + offs + 2);
>> +	else
>> +		iowrite16(val, xspi->regs + offs);
>> +}
> 
> 
> Hi Richard,

Hi John,

Thanks for the quick feedback.

> If you're worried about efficiency (the reason for 16 and 32 bit xfers), why wouldn't you do the big-endian vs little endian I/O decision at compile time rather than run time?

I'm afraid we can't do it compile time, if we want to be flexible. As
example;
The IP is big endian, in our case the PCI interface flips the byte
order. But the PCI interface might be setup differently ->would be
accessed big endian even on a little endian machine.

We could use callbacks set up during probe, instead of having the
if-sentence. But I don't think the callback solution could be slower (if
talking performance), since the compiler can't inline them, the current
functions could be inlined if the compiler feels like it.


> The big_endian variable is not a constant boolean, I don't know if that could help so that the compiler optimizes this check away?  Or maybe it is already and I'm just missing that?
> 
>>
>> -	u32		irq;
>> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 val)
>> +{
>> +	if (xspi->big_endian)
>> +		iowrite32be(val, xspi->regs + offs);
>> +	else
>> +		iowrite32(val, xspi->regs + offs);
>> +}
>>
>> -	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
>> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
>> +{
>> +	return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
>> +}
>>
>> -	u8 *rx_ptr;		/* pointer in the Tx buffer */
>> -	const u8 *tx_ptr;	/* pointer in the Rx buffer */
>> -	int remaining_bytes;	/* the number of bytes left to transfer */
>> -};
> 
> <snip>
> 
>> -
>>  /* This driver supports single master mode only. Hence Tx FIFO Empty
>>   * is the only interrupt we care about.
>>   * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave Mode
>> @@ -237,32 +298,50 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
>>  	u32 ipif_isr;
>>
>>  	/* Get the IPIF interrupts, and clear them immediately */
>> -	ipif_isr = in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
>> -	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
>> +	ipif_isr = xspi_read32(xspi, XIPIF_V123B_IISR_OFFSET);
>> +	xspi_write32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);
>>
>>  	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
>>  		u16 cr;
>>  		u8 sr;
>> +		u8 rsize;
>> +		if (xspi->bits_per_word == 8)
>> +			rsize = 1;
>> +		else if (xspi->bits_per_word == 16)
>> +			rsize = 2;
>> +		else
>> +			rsize = 4;
>>
>>  		/* A transmit has just completed. Process received data and
>>  		 * check for more data to transmit. Always inhibit the
>>  		 * transmitter while the Isr refills the transmit register/FIFO,
>>  		 * or make sure it is stopped if we're done.
>>  		 */
>> -		cr = in_be16(xspi->regs + XSPI_CR_OFFSET);
>> -		out_be16(xspi->regs + XSPI_CR_OFFSET,
>> -			 cr | XSPI_CR_TRANS_INHIBIT);
>> +		cr = xspi_read16(xspi, XSPI_CR_OFFSET);
>> +		xspi_write16(xspi, XSPI_CR_OFFSET, cr | XSPI_CR_TRANS_INHIBIT);
>>
>>  		/* Read out all the data from the Rx FIFO */
>> -		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
>> +		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
>>  		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
>> -			u8 data;
>> +			u32 data;
>> +			if (rsize == 1)
>> +				data = xspi_read8(xspi, XSPI_RXD_OFFSET);
>> +			else if (rsize == 2)
>> +				data = xspi_read16(xspi, XSPI_RXD_OFFSET);
>> +			else
>> +				data = xspi_read32(xspi, XSPI_RXD_OFFSET);
>>
>> -			data = in_8(xspi->regs + XSPI_RXD_OFFSET);
>>  			if (xspi->rx_ptr) {
>> -				*xspi->rx_ptr++ = data;
>> +				if (rsize == 1)
>> +					*xspi->rx_ptr = data & 0xff;
>> +				else if (rsize == 2)
>> +					*(u16 *)(xspi->rx_ptr) = data & 0xffff;
>> +				else
>> +					*((u32 *)(xspi->rx_ptr)) = data;
>> +				xspi->rx_ptr += rsize;
> 
> Maybe I'm out of line here...
> 
> I'm wondering if this is going to be any more efficient that just using 8 bit accesses

We can not do 8 bit accesses if the IP is set up to do 16/32bit SPI,
then the TX/RX registers are as wide as the bit setup.

We could do 32 bit reads from the registers, then we waste some cycles
on the PLB bus, but have slightly simpler code.

> as it seems like the amount of run-time decisions being made is quite a few.  I guess it depends on how many bytes are being transferred as with big transfers maybe it will pay off.
> 
> In my opinion, which isn't worth much many times :), sometimes the flexibility with soft logic, like this is a pain for testability and increases complexity. If there's reasonable performance gains then maybe it's a good tradeoff.  
> 
> Do you know how much performance gain there is or is expected as maybe you've seen the pay off already?

I haven't done any measurements, and we are basically only controlling
GPIO so performance is not an issue for us. I just didn't want do make
it slower. I think you have more experience here. Do you think it's
better to just do 32bit reads to make the code simple? If so I will
update the code.

Thanks
--Richard
