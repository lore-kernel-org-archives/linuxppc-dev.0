Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 3DEAEDDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 15:25:55 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Xilinx SystemACE device driver
Date: Mon, 16 Apr 2007 07:28:15 +0200
References: <1176600194262-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1176600194262-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200704160728.16608.sr@denx.de>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

On Sunday 15 April 2007 03:23, Grant Likely wrote:
> Add support for block device access to the Xilinx SystemACE Compact
> flash interface
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> I think this driver is in pretty good shape.  I've got a few things to
> clean up a bit.  Specifically, I'm still working on error handling and
> making sure that the state machine is sane at all times.

I tested the driver on my system (Katmai 440SPe). Both CF's work correctly 
regarding reading and writing. No problems so far.

> I would appreciate any review/comments.  One area where I am undecided is
> the format of the state machine.  The current code uses one big function
> with a large switch() statment for each state.  I'm considering breaking
> this up into a seperate function for each state, and adding a static
> state table with pointers to each state function.

I have no real preference here. I don't mind if the code stays in this large 
switch statement. It's not that much code.

Two small issues though:

> +config XILINX_SYSACE
> +     tristate "Xilinx SystemACE support"
> +     depends on XILINX_VIRTEX
> +     help
> +       Include support for the Xilinx SystemACE CompactFlash interface

Please remove the XILINX_VIRTEX dependency here. It makes it impossible to use 
the driver on my 440SPe system.

> +/* register access macros */
> +#if 1 /* Little endian 16-bit regs */
> +#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
> +#define ace_reg_read16(ace, reg) in_le16(ace->baseaddr + reg)
> +#define ace_reg_readdata(ace, reg) in_be16(ace->baseaddr + reg)
> +#define ace_reg_read32(ace, reg) ((in_le16(ace->baseaddr + reg+2) << 16) |
> \ +                                  (in_le16(ace->baseaddr + reg)))
> +#define ace_reg_write16(ace, reg, val) out_le16(ace->baseaddr + reg, val)
> +#define ace_reg_writedata(ace, reg, val) out_be16(ace->baseaddr + reg,
> val) +#define ace_reg_write32(ace, reg, val) { \
> +                           out_le16(ace->baseaddr + reg+2, (val) >> 16); \
> +                           out_le16(ace->baseaddr + reg, val); \
> +                       }
> +#else /* Big endian 16-bit regs */
> +#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
> +#define ace_reg_read16(ace, reg) in_be16(ace->baseaddr + reg)
> +#define ace_reg_readdata(ace, reg) in_le16(ace->baseaddr + reg)
> +#define ace_reg_read32(ace, reg) ((in_be16(ace->baseaddr + reg+2) << 16) |
> \ +                                  (in_be16(ace->baseaddr + reg)))
> +#define ace_reg_write16(ace, reg, val) out_be16(ace->baseaddr + reg, val)
> +#define ace_reg_writedata(ace, reg, val) out_le16(ace->baseaddr + reg,
> val) +#define ace_reg_write32(ace, reg, val) { \
> +                           out_be16(ace->baseaddr + reg+2, (val) >> 16); \
> +                           out_be16(ace->baseaddr + reg, val); \
> +                       }
> +#endif

We should make the endianess selectable (I need big endian). You talked about 
autodetecting the endianess once, but that would add extra code on every 
register access. So I suggest to just add a configuration option for the 
endianess selection.

> I feel this driver is pretty close to done, and I'd like to get it into
> mainline for the 2.6.22 timeframe.

Yes, please.

Best regards,
Stefan
