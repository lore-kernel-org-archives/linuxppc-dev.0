Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 0509BB7D52
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 03:44:52 +1100 (EST)
Received: by ywh37 with SMTP id 37so192595ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 08:44:50 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AF99298.9020207@mocean-labs.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
	<4AF99298.9020207@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 09:44:30 -0700
Message-ID: <fa686aa40911100844q19789297h8e6713e915185a7@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 10, 2009 at 9:19 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> Grant Likely wrote:
>> Oops, I replied to the original version, but missed the subsequent
>> versions. =A0Looks like some of my comments still apply though.
>> Overall, the patch changes too many things all at once. =A0You should
>> look at splitting it up. =A0At the very least the io accessor changes
>> should be done in a separate patch.

Hi Richard.  Please do another spin of this patch.  I don't have any
particular problem with the changes, but it needs to be in a more
granular form so I can review it properly.

>>> +struct xilinx_spi {
>>> + =A0 =A0 =A0 /* bitbang has to be first */
>>> + =A0 =A0 =A0 struct spi_bitbang bitbang;
>>> + =A0 =A0 =A0 struct completion done;
>>> + =A0 =A0 =A0 struct resource mem; /* phys mem */
>>> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0/* virt. address of the con=
trol registers */
>>> + =A0 =A0 =A0 u32 irq;
>>> + =A0 =A0 =A0 u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the Tx =
buffer */
>>> + =A0 =A0 =A0 const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buffer=
 */
>>> + =A0 =A0 =A0 int remaining_bytes; =A0 =A0/* the number of bytes left t=
o transfer */
>>> + =A0 =A0 =A0 /* offset to the XSPI regs, these might vary... */
>>> + =A0 =A0 =A0 u8 bits_per_word;
>>> + =A0 =A0 =A0 bool big_endian; =A0 =A0 =A0 =A0/* The device could be ac=
cessed big or little
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* endi=
an
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> +};
>>> +
>>
>> Why is the definition of xilinx_spi moved?
>
> I liked the idea of heaving the struct defined in the top of the file.

... which is completely unrelated to the patch purpose, and is not
mentioned in the patch header.  If you really want to move it then put
it in a completely separate patch and describe the change properly.
As it is right now it is just noise that makes the stated purpose of
the patch hard to review.

>> Ah, you changed these to functions instead of macros. =A0I like.
>> However, as you suggested elsewhere in this thread, you could change
>> these to callbacks and then eliminate the if/else statements. =A0I think
>> that is the approach you should use. =A0I don't think you need to worry
>> about it being slower. =A0Any extra cycles for jumping to a callback
>> will be far dwarfed by the number of cycles it takes to complete an
>> SPI transfer.
>
> Sure that can be updated. I prefer to do that in an incremental patch, wo=
uld be great to get this
> big one merged first.

As already commented on, this patch is too big and does too many
unrelated things.  Please split into discrete changes so it can be
reviewed properly.

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
