Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DA0CB7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 06:00:31 +1100 (EST)
Date: Wed, 3 Feb 2010 11:00:19 -0800
From: Greg KH <greg@kroah.com>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller
	driver flag
Message-ID: <20100203190019.GA12637@kroah.com>
References: <1265221840-25634-1-git-send-email-albert_herranz@yahoo.es>
	<1265221840-25634-2-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265221840-25634-2-git-send-email-albert_herranz@yahoo.es>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 03, 2010 at 07:30:39PM +0100, Albert Herranz wrote:
> +/**
> + * hcd_memcpy32_to_coherent - copy data to a bounce buffer
> + * @dst: destination dma bounce buffer
> + * @src: source buffer
> + * @len: number of bytes to copy
> + *
> + * This function copies @len bytes from @src to @dst in 32 bit chunks.
> + * The caller must guarantee that @dst length is 4 byte aligned and
> + * that @dst length is greater than or equal to @src length.
> + */
> +static void *hcd_memcpy32_to_coherent(void *dst, const void *src, size_t len)

Why isn't there platform-specific functions for this already?  It seems
a bit odd to bury them in the USB hcd core, when I'm sure that other
people need these, if they haven't already created them.

thanks,

greg k-h
