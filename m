Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r96K13nn4zDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:09:40 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: John Youn <John.Youn@synopsys.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Wed, 18 May 2016 23:09:14 +0200
Message-ID: <11140228.TZs2tGKv86@wuerfel>
In-Reply-To: <1569777.jHIobOl9fm@debian64>
References: <4231696.iL6nGs74X8@debian64> <573BAE58.1010206@synopsys.com>
 <1569777.jHIobOl9fm@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 18 May 2016 21:14:55 Christian Lamparter wrote:
> On Tuesday, May 17, 2016 04:50:48 PM John Youn wrote:
> > On 5/14/2016 6:11 AM, Christian Lamparter wrote:

> Hey, that's really nice of you to do that :-D. Please keep me in the
> loop (Cc) for those then. 
> 
> Yes, this needs definitely testing on all the affected ARCHs. 
> I've attached a diff to a updated version of the patch. It
> drops the special MIPS case (as requested by Arnd).

Ok, thanks!

> BTW, I looked into the ioread32_rep and iowrite32_rep again. I'm
> not entirely convinced that the hardware FIFOs are actually endian
> neutral. But I can't verify it since my Western Digital My Book Live
> only supports the host configuration (forces host mode), so I don't
> know what a device in dual-mode or peripheral do here.

I think it's highly unlikely that designware would have screwed up
their part in such an unusual way, by intentionally adding a
byte-reversal on something that is not connected to a 32-bit
register.

Note that the reason why ioread32_rep() doesn't swap is not that
the registers are endian neutral, but that they use endianess in
the same way that the memory does: If you want to look at the first
byte of a (theoretical) four-byte USB data packet, we read four
bytes from the FIFO register using __raw_readl() (a pointer dereference)
and store it to memory using a 32-bit write:

	*(u32 *)buffer = __raw_readl(FIFO);

Then we expect the first byte of the packet to be at the start:

	byte0 = *(u8*)buffer;

If you replace the __raw_readl() with ioread32(), it gets byteswapped
on big-endian *CPUs*, and then written to memory without an extra
swap. This means that now you get the wrong data depending on the
kernel endianess configuration, and independent of the device endianess.

If the big-endian mode of the dwc2 block indeed contains a byteswap
on the FIFO, that would mean not having to use ioread32_be() for
the FIFO, but using

fifo_read32(void *buffer)
{
	u32 data = __raw_readl(FIFO_ADDRESS);
	if (big_endian_registers)
		data = bswap32(data);
	*(u32*)buffer = data;
}

so we byteswap the FIFO contents back, regardless of the CPU
endianess. As I said, it's unlikely that the hardware is this broken,
but not impossible.

> The reason why I think it was broken is because there's a PIO copy
> to and from the HCFIFO(x) in dwc2_hc_write_packet and
> dwc2_hc_read_packet access in the hcd.c file as well... And there,
> the code was using the dwc2_readl and dwc2_writel to access the data.

Well, we know for a fact that those functions get endianess wrong,
see dwc2_hc_write_packet:

        if (((unsigned long)data_buf & 0x3) == 0) {
                /* xfer_buf is DWORD aligned */
                for (i = 0; i < dword_count; i++, data_buf++)
                        dwc2_writel(*data_buf, data_fifo);
        } else {
                /* xfer_buf is not DWORD aligned */
                for (i = 0; i < dword_count; i++, data_buf++) {
                        u32 data = data_buf[0] | data_buf[1] << 8 |
                                   data_buf[2] << 16 | data_buf[3] << 24;
                        dwc2_writel(data, data_fifo);
                }
        }

On big-endian machines, unaligned case performs a byte swap while the
aligned case does not. My best guess is that this function never
got called on either the MIPS machine that first got the fix or
your PowerPC machine.

Another possibility is that you are right that there is a byteswap
on the FIFO register in big-endian mode, and that this function
always gets unaligned buffers, so the byteswap here cancels out
the byteswap on the FIFO when both the CPU and the device are
big-endian.

> -	if (((unsigned long)data_buf & 0x3) == 0) {
> -		/* xfer_buf is DWORD aligned */
> -		for (i = 0; i < dword_count; i++, data_buf++)
> -			dwc2_writel(hsotg, *data_buf, HCFIFO(chan->hc_num));
> -	} else {
> -		/* xfer_buf is not DWORD aligned */
> -		for (i = 0; i < dword_count; i++, data_buf++) {
> -			u32 data = data_buf[0] | data_buf[1] << 8 |
> -				   data_buf[2] << 16 | data_buf[3] << 24;
> -			dwc2_writel(hsotg, data, HCFIFO(chan->hc_num));
> -		}
> -	}
> +	dwc2_writel_rep(hsotg, HCFIFO(chan->hc_num), data_buf, byte_count);
>  

and here you are dropping the byteswap on big-endian.

	Arnd
