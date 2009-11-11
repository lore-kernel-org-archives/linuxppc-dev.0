Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 08AB4B7B61
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 09:25:39 +1100 (EST)
Received: by ywh37 with SMTP id 37so1564536ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 14:25:37 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1b8be32b-f557-4013-8443-4cff999e3b80@VA3EHSMHS013.ehs.local>
References: <4AFACC6A.304@mocean-labs.com>
	<1b8be32b-f557-4013-8443-4cff999e3b80@VA3EHSMHS013.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 15:25:17 -0700
Message-ID: <fa686aa40911111425x4a6b2d85uf2ccbff6e88c0e68@mail.gmail.com>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	=?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>,
	dbrownell@users.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 3:19 PM, John Linn <John.Linn@xilinx.com> wrote:
>> -----Original Message-----
>> From: Richard R=F6jfors [mailto:richard.rojfors@mocean-labs.com]
>> Sent: Wednesday, November 11, 2009 7:39 AM
[...]
>> -static void xspi_init_hw(void __iomem *regs_base)
>> +/* to follow are some functions that does little of big endian read and
>> + * write depending on the config of the device.
>> + */
>> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 va=
l)
>> +{
>> + =A0 =A0 iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0)=
);
>> +}
>> +
>> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 =
val)
>> +{
>> + =A0 =A0 if (xspi->big_endian)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite16be(val, xspi->regs + offs + 2);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(val, xspi->regs + offs);
>> +}
>> +
>> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 =
val)
>> +{
>> + =A0 =A0 if (xspi->big_endian)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32be(val, xspi->regs + offs);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(val, xspi->regs + offs);
>> +}
>> +
>> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
>> +{
>> + =A0 =A0 return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0=
));
>> +}
>> +
>> +static inline u16 xspi_read16(struct xilinx_spi *xspi, u32 offs)
>> +{
>> + =A0 =A0 if (xspi->big_endian)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ioread16be(xspi->regs + offs + 2);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ioread16(xspi->regs + offs);
>> +}
>> +
>> +static inline u32 xspi_read32(struct xilinx_spi *xspi, u32 offs)
>> +{
>> + =A0 =A0 if (xspi->big_endian)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ioread32be(xspi->regs + offs);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ioread32(xspi->regs + offs);
>> +}
>> +
>
> Hi Richard,
>
> The registers of the device should all be accessible as 32 bit operations=
.
>
> It seems like it would be simpler to do that.

If all register accesses can be converted to 32bits, then definitely
you should just do that and make your patch simpler.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
