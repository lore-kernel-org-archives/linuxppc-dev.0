Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 978B8DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 18:30:11 +1000 (EST)
Date: Fri, 21 Sep 2007 10:29:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 09/11] [POWERPC] iSeries: move detection of virtual tapes
Message-ID: <20070921082952.GA5607@lst.de>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
	<20070921143647.7ceebabc.sfr@canb.auug.org.au>
	<20070921143750.4114b0b5.sfr@canb.auug.org.au>
	<20070921143841.37ad2a2f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921143841.37ad2a2f.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#if defined(CONFIG_VIOTAPE) || defined(CONFIG_VIOTAPE_MODULE)
> +/* Handle interrupt events for tape */
> +static void __init handle_tape_event(struct HvLpEvent *event)
> +{
> +	struct vio_waitevent *we;
> +	struct viotapelpevent *tevent = (struct viotapelpevent *)event;

I think we should generate these device tree entires unconditionally.
They're just a conversion of what the iseries firmware/hypervisor
provides and not dependent on a specific driver.

(dito for the other patches with the same scheme)
