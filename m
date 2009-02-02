Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B6F0DDF35
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:38:05 +1100 (EST)
Subject: Re: [PATCH 1/3] drm: Use resource_size_t for
	drm_get_resource_{start,  len}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Airlie <airlied@gmail.com>
In-Reply-To: <21d7e9970902020508y77384e5ak4d348decb536e887@mail.gmail.com>
References: <20090202055557.57CECDDF4A@ozlabs.org>
	<21d7e9970902020508y77384e5ak4d348decb536e887@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 07:36:28 +1100
Message-Id: <1233606988.18767.98.camel@pasglop>
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org,
	dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>    2009-02-02 14:16:04.000000000 +1100
> > @@ -599,8 +599,8 @@ int savage_driver_firstopen(struct drm_d
> >                            drm_mtrr_add(dev_priv->mtrr[2].base,
> >                                         dev_priv->mtrr[2].size, DRM_MTRR_WC);
> >                } else {
> > -                       DRM_ERROR("strange pci_resource_len %08lx\n",
> > -                                 drm_get_resource_len(dev, 0));
> > +                       DRM_ERROR("strange pci_resource_len %08llx\n",
> > +                                 (unsigned long long)drm_get_resource_len(dev, 0));
> 
> Don't we have a printk specifier for this now?

If we do I've missed it. We have a specifier for a struct resource *,
but not for an individual resource_size_t afaik.

Cheers,
Ben.
