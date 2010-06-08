Return-Path: <cbouatmailru@gmail.com>
Date: Tue, 8 Jun 2010 20:46:45 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100608164645.GA15216@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
	<AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 08, 2010 at 10:02:49AM -0600, Grant Likely wrote:
> On Tue, Jun 8, 2010 at 9:57 AM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> > On Tue, Jun 08, 2010 at 08:26:43AM -0600, Grant Likely wrote:
> > [...]
> >> +     dev = kzalloc(sizeof(*dev) + (sizeof(struct resource) * i), GFP_KERNEL);
> >>       if (!dev)
> >>               return NULL;
> >> -
> >>       dev->dev.of_node = of_node_get(np);
> >>       dev->dev.dma_mask = &dev->archdata.dma_mask;
> >>       dev->dev.parent = parent;
> >>       dev->dev.release = of_release_dev;
> >>
> >> +     /* Populate the resource table */
> >> +     if (num_irq || num_reg) {
> >> +             dev->resource = (void*)&dev[1];
> >
> > This is ugly. Why not allocate the memory specifically for
> > dev->resource? Is this because you plan to get rid of
> > of_release_dev(), and the generic release_dev() won't
> > know if it should free the dev->resource? There must
> > be a better way to handle this.
> 
> Allocating in one big block means less potential memory fragmentation,
> and the kernel can free it all at once.

Are there any numbers of saved amount of memory so that we
could compare?

The "less memory fragmentation" is indeed potential, but
introduction of obscure code is going on now at this precise
moment.

> This is a common pattern.

This can't be true because it produces ugly casts and fragile
code all over the place -- which is exactly what everybody
tries to avoid in the kernel.

Such a pattern is common when a driver allocates e.g. tx and rx
buffers (of the same type) together, and then split the buffer
into two pointers.

But I heard of no such pattern for 'struct device + struct
resources' allocation without even some kind of _priv struct,
which is surely something new, and ugly.

If you really want to avoid (an unproven) memory fragmentation,
you could do:

struct of_device_with_resources {
	struct device dev;
	struct resource resourses[0];
};

This at least will get rid of the casts and incomprehensible
"dev->resource = (void*)&dev[1];" construction.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
