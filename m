Return-Path: <albert_herranz@yahoo.es>
Received: from smtp125.mail.ukl.yahoo.com (smtp125.mail.ukl.yahoo.com
	[77.238.184.56]) by ozlabs.org (Postfix) with SMTP id A41C8B7D49
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Feb 2010 05:23:11 +1100 (EST)
Message-ID: <4B6B1089.6070708@yahoo.es>
Date: Thu, 04 Feb 2010 19:23:05 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller driver
	flag
References: <Pine.LNX.4.44L0.1002031429430.1321-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1002031429430.1321-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: USB list <linux-usb@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alan,

Alan Stern wrote:
> This description sounds hopelessly confused.  Maybe you're just
> misusing the term "coherent".  The patch itself doesn't affect the
> coherent DMA mappings anyway; it affects the streaming mappings.  Or to
> put it another way, what's the justification for replacing a call to
> dma_map_single() with a call to dma_alloc_coherent()?
> 
> Since the patch doesn't affect any of the coherent mappings (see for 
> example the calls to dma_pool_create() in ehci-mem.c), I don't see how 
> it can possibly do what you claim.
> 

Thanks for your comments. Let's try to hopefully clarify this a bit.

I've used the term "coherent" as described in Documentation/DMA-API.txt (aka "consistent" as used in PCI-related functions).
I've tried to describe first the limitations of the platform that I'm working on. Basically, one of the annoying things of that platform is that writes to uncached memory (as used in "coherent" memory) can only be reliably performed in 32-bit accesses.

The USB subsystem ends up using "coherent" memory for buffers and/or other structures in different ways.

The "coherent" memory allocated in dma_pool_create() in ehci-mem.c that you report is not a problem at all because it is always accessed in 32-bit chunks (it hasn't been always like that but since commit 3807e26d69b9ad3864fe03224ebebc9610d5802e "USB: EHCI: split ehci_qh into hw and sw parts" this got addressed as a side effect, so I didn't need to post another patch for that).

Other possible interactions with "coherent" memory are those involving buffers used in USB transactions, which may be allocated via the USB subsystem (at usb_buffer_alloc() or when bounced via hcd_alloc_coherent()) or which may come already allocated and ready for use (URB_NO_{SETUP,TRANSFER}_DMA_MAP).

The patch, as posted, allocates normal memory for USB buffers _within_ the USB subsystem and invariably bounces all buffers to new "coherent" buffers.
So, basically, what the patch claims (avoid 32-bit writes for "coherent" memory within the USB subsystem) is "done" (hey, it actually works ;-).

But I think you have raised valid points here :)

If the "coherent" memory is already allocated and passed (as already dma-mapped) to the USB subsystem then there is no gain in bouncing the buffer:
- if a non-32 bit write was done to that "coherent" memory the damage is already done
- if the "coherent" memory was written always in 32-bit accesses then we can just safely use it
So bouncing here should be avoided as it is unneeded.

On the other hand, we can control USB buffers managed by the USB subsystem itself.
That's what the patch "does". It avoids access restrictions to USB buffers by allocating them from normal memory (leaving USB drivers free to access those buffers in whatever bus width they need, as they do today) ... and bouncing them.
The thing here is that it makes no sense to bounce them to "coherent" memory if they can be dma-mapped directly (as you point in your dma_map_single-vs-dma_alloc_coherent comment).

So... that's what RFCs are for :)
I'll take a look again at the patch.

>> +/**
>> + * hcd_memcpy32_to_coherent - copy data to a bounce buffer
>> + * @dst: destination dma bounce buffer
>> + * @src: source buffer
>> + * @len: number of bytes to copy
>> + *
>> + * This function copies @len bytes from @src to @dst in 32 bit chunks.
>> + * The caller must guarantee that @dst length is 4 byte aligned and
>> + * that @dst length is greater than or equal to @src length.
>> + */
>> +static void *hcd_memcpy32_to_coherent(void *dst, const void *src, size_t len)
>> +{
>> +	u32 *q = dst, *p = (void *)src;
>> +	u8 *s;
>> +
>> +	while (len >= 4) {
>> +		*q++ = *p++;
>> +		len -= 4;
>> +	}
>> +	s = (u8 *)p;
>> +	switch (len) {
>> +	case 3:
>> +		*q = s[0] << 24 | s[1] << 16 | s[2] << 8;
>> +		break;
>> +	case 2:
>> +		*q = s[0] << 24 | s[1] << 16;
>> +		break;
>> +	case 1:
>> +		*q = s[0] << 24;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return dst;
>> +}
> 
> What happens if somebody tries to use this code on a little-endian CPU?
> 

It will fail.


> It seems that every time somebody comes up with a new kind of 
> memory-access restriction, this function grows by a factor of 2.  After 
> a few more iterations it will be larger than the rest of the kernel!
> 
> There must be a better way to structure the requirements here.
> 

Hopefully I didn't miss any of your concerns and managed to explain the problem.

> Alan Stern
> 
> 

Thanks,
Albert
