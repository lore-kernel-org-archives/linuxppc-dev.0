Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100608164645.GA15216@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
	<AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
	<20100608164645.GA15216@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Jun 2010 12:41:47 -0600
Message-ID: <AANLkTinHH-YhdWpH60Z2BYsiEjzLb_imrk6KUmQRH07P@mail.gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Jun 8, 2010 at 10:46 AM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Tue, Jun 08, 2010 at 10:02:49AM -0600, Grant Likely wrote:
>> On Tue, Jun 8, 2010 at 9:57 AM, Anton Vorontsov <cbouatmailru@gmail.com>=
 wrote:
>> > On Tue, Jun 08, 2010 at 08:26:43AM -0600, Grant Likely wrote:
>> > [...]
>> >> + =A0 =A0 dev =3D kzalloc(sizeof(*dev) + (sizeof(struct resource) * i=
), GFP_KERNEL);
>> >> =A0 =A0 =A0 if (!dev)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> >> -
>> >> =A0 =A0 =A0 dev->dev.of_node =3D of_node_get(np);
>> >> =A0 =A0 =A0 dev->dev.dma_mask =3D &dev->archdata.dma_mask;
>> >> =A0 =A0 =A0 dev->dev.parent =3D parent;
>> >> =A0 =A0 =A0 dev->dev.release =3D of_release_dev;
>> >>
>> >> + =A0 =A0 /* Populate the resource table */
>> >> + =A0 =A0 if (num_irq || num_reg) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev->resource =3D (void*)&dev[1];
>> >
>> > This is ugly. Why not allocate the memory specifically for
>> > dev->resource? Is this because you plan to get rid of
>> > of_release_dev(), and the generic release_dev() won't
>> > know if it should free the dev->resource? There must
>> > be a better way to handle this.
>>
>> Allocating in one big block means less potential memory fragmentation,
>> and the kernel can free it all at once.
>
> Are there any numbers of saved amount of memory so that we
> could compare?
>
> The "less memory fragmentation" is indeed potential, but
> introduction of obscure code is going on now at this precise
> moment.

It's not obscure.  It's smaller and simpler code with fewer error paths.

>> This is a common pattern.
>
> This can't be true because it produces ugly casts and fragile
> code all over the place -- which is exactly what everybody
> tries to avoid in the kernel.

Fragile?  How?  &var[1] *always* gives you a pointer to the first
address after a structure.  If the structure changes, then so does the
offset.  Heck, if the type of 'var' changes, then the offset changes
in kind too.  If anything, I should have also used sizeof(*res) in the
kzalloc call so that the allocated size is protected against a type
change to 'res' too.

If you prefer, I can move the dev->resource assignment to immediately
after the kzalloc to keep everything contained within 4 lines of each
other.

> Such a pattern is common when a driver allocates e.g. tx and rx
> buffers (of the same type) together, and then split the buffer
> into two pointers.

tx & rx buffers are different because they must be DMAable.  That
imposes alignment requirements with kzalloc() guarantees.

> But I heard of no such pattern for 'struct device + struct
> resources' allocation without even some kind of _priv struct,
> which is surely something new, and ugly.

git grep '\*).*&[a-z1-9_]*\[1\]'

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
