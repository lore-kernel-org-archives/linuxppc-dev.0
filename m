Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100608155702.GA5419@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Jun 2010 10:02:49 -0600
Message-ID: <AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 8, 2010 at 9:57 AM, Anton Vorontsov <cbouatmailru@gmail.com> wr=
ote:
> On Tue, Jun 08, 2010 at 08:26:43AM -0600, Grant Likely wrote:
> [...]
>> + =A0 =A0 dev =3D kzalloc(sizeof(*dev) + (sizeof(struct resource) * i), =
GFP_KERNEL);
>> =A0 =A0 =A0 if (!dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> -
>> =A0 =A0 =A0 dev->dev.of_node =3D of_node_get(np);
>> =A0 =A0 =A0 dev->dev.dma_mask =3D &dev->archdata.dma_mask;
>> =A0 =A0 =A0 dev->dev.parent =3D parent;
>> =A0 =A0 =A0 dev->dev.release =3D of_release_dev;
>>
>> + =A0 =A0 /* Populate the resource table */
>> + =A0 =A0 if (num_irq || num_reg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->resource =3D (void*)&dev[1];
>
> This is ugly. Why not allocate the memory specifically for
> dev->resource? Is this because you plan to get rid of
> of_release_dev(), and the generic release_dev() won't
> know if it should free the dev->resource? There must
> be a better way to handle this.

Allocating in one big block means less potential memory fragmentation,
and the kernel can free it all at once.  This is a common pattern.

> p.s.
>
> Just wonder what happened to of_gpio stuff? You blocked it
> in 2.6.34 for no reason saying "I'll pick it into my OF
> tree before the 2.6.35 merge window" and it's 2.6.36 merge
> window quite soon.

It's in my test-devicetree branch.  I'll be posting for 2nd review in
the next few days and then adding to my devicetree-next branch
probably before the end of the week.

g.
