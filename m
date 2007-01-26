Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD4E2DE066
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 14:12:47 +1100 (EST)
Date: Fri, 26 Jan 2007 04:12:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Message-ID: <20070126031236.GG18537@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 06:48:04PM +0100, Geert Uytterhoeven wrote:
> +EXPORT_SYMBOL(ps3av_set_audio_mode);

not _GPL?  This module seems like a very deeply internal helper for
other ps3 driver and not a general kernel API.

Btw, the Kconfig and/or top of file comment really needs a better
explanation what this "driver" is for.  I also wonder why it's
selectable in Kconfig at all given it has no visible user interface.
Shouldn't the users of the exported symbols simply pull it in or the
code made part of the unconditional build bits in the ps3 platform
directory?

> +static int ps3av_at_exit(struct notifier_block *self,
> +			 unsigned long state, void *data)
> +{
> +	/* fin avsetting modules */
> +	ps3av_cmd_fin();
> +
> +	if (!ps3av.available)
> +		return NOTIFY_OK;
> +
> +	ps3av.available = 0;
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block ps3av_reboot_nb = {
> +	.notifier_call = ps3av_at_exit
> +};

Please implement this as ->shutdown method of the driver instead.
In case ps3_vuart_port_driver doesn't have that method yet please
add it as a forwarder for the generic driver model ->shutdown method.

> +#ifdef __KERNEL__

Why would you want to export the rest of this header to userspace?
(And in case you really want that you also have to add it to the Kbuild
file to actually be exported..)



and btw, please beat up the folks who designed this awfully stupid API..
