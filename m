Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id 7B32CDDF50
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 08:54:14 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v6 1/4] USB: add Cypress c67x00 low level interface code
Date: Fri, 1 Feb 2008 13:54:11 -0800
References: <20080129122430.070266000@sunsite.dk>
	<20080129123119.273749000@sunsite.dk>
In-Reply-To: <20080129123119.273749000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802011354.11819.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 January 2008, Peter Korsgaard wrote:
> This patch adds the low level support code for the Cypress c67x00 family of
> OTG controllers.  The low level code is responsible for register access and
> implements the software protocol for communicating with the 16bit
> microcontroller inside the c67x00 device.
> 
> Communication is done over the HPI interface (16bit SRAM-like parallel bus).
>     
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

If you fix the issues I note below:

Acked-by: David Brownell <dbrownell@users.sourceforge.net>



> +/**
> + * struct c67x00_sie - Common data associated with a SIE
> + * @lock: lock to protect this struct

"and the associated chip registers"

> + * @private_data: subdriver dependent data
> + * @irq: subdriver dependent irq handler, set NULL when not used
> + * @dev: link to common driver structure
> + * @sie_num: SIE number on chip, starting from 0
> + * @mode: SIE mode (host/peripheral/otg/not used)
> + */
> +struct c67x00_sie {
> +	/* Entries to be used by the subdrivers */
> +	spinlock_t lock;	/* protect this structure */
> +	void *private_data;
> +	void (*irq) (struct c67x00_sie *sie, u16 int_status, u16 msg);
> +
> +	/* Read only: */
> +	struct c67x00_device *dev;
> +	int sie_num;
> +	int mode;
> +};


In the C file:

> +static inline u16 hpi_read_word(struct c67x00_device *dev, u16 reg)
> +{
> +	u16 value;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	value = hpi_read_word_nolock(dev, reg);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +
> +	return value;
> +}
> +
> +static inline void hpi_write_word_nolock(struct c67x00_device *dev, u16 reg,
> +					 u16 value)
> +{
> +	hpi_write_reg(dev, HPI_ADDR, reg);
> +	hpi_write_reg(dev, HPI_DATA, value);
> +}
> +
> +static inline void hpi_write_word(struct c67x00_device *dev, u16 reg, u16 value)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	hpi_write_word_nolock(dev, reg, value);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +}
> +
> +/*
> + * Only data is little endian, addr has cpu endianess
> + */
> +static inline void hpi_write_words_le16(struct c67x00_device *dev, u16 addr,
> +					u16 *data, u16 count)
> +{
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +
> +	hpi_write_reg(dev, HPI_ADDR, addr);
> +	for (i = 0; i < count; i++)
> +		hpi_write_reg(dev, HPI_DATA, cpu_to_le16(*data++));
> +
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +}
> +
> +/*
> + * Only data is little endian, addr has cpu endianess
> + */
> +static inline void hpi_read_words_le16(struct c67x00_device *dev, u16 addr,
> +				       u16 *data, u16 count)
> +{
> +	unsigned long flags;
> +	int i;
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	hpi_write_reg(dev, HPI_ADDR, addr);
> +	for (i = 0; i < count; i++)
> +		*data++ = le16_to_cpu(hpi_read_reg(dev, HPI_DATA));
> +
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +}
> +
> +static inline void hpi_set_bits(struct c67x00_device *dev, u16 reg, u16 mask)
> +{
> +	u16 value;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	value = hpi_read_word_nolock(dev, reg);
> +	hpi_write_word_nolock(dev, reg, value | mask);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +}
> +
> +static inline void hpi_clear_bits(struct c67x00_device *dev, u16 reg, u16 mask)
> +{
> +	u16 value;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	value = hpi_read_word_nolock(dev, reg);
> +	hpi_write_word_nolock(dev, reg, value & ~mask);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +}
> +
> +static inline u16 hpi_recv_mbox(struct c67x00_device *dev)
> +{
> +	u16 value;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	value = hpi_read_reg(dev, HPI_MAILBOX);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +
> +	return value;
> +}
> +
> +static inline u16 hpi_send_mbox(struct c67x00_device *dev, u16 value)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->hpi.lock, flags);
> +	hpi_write_reg(dev, HPI_MAILBOX, value);
> +	spin_unlock_irqrestore(&dev->hpi.lock, flags);
> +
> +	return value;
> +}

Strike the "inline" from all the above, and let the compiler decide
if the space savings are worthwhile.  (I'd guess:  mostly not.)
Given icache, time savings are likely negligible.
