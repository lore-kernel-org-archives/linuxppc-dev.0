Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A714EB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 05:35:10 +1100 (EST)
Received: by ywe10 with SMTP id 10so1382680ywe.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 10:35:07 -0800 (PST)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <20101209030924.GC11856@yookeroo>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192944.GE32473@mentor.com>
	<20101208150102.69b8062b@udp111988uds.am.freescale.net>
	<1291858402.2962.2.camel@concordia>
	<20101209030924.GC11856@yookeroo>
Date: Wed, 15 Dec 2010 10:35:06 -0800
Message-ID: <AANLkTimPhs4AZ74e4SZfkyboeDJQaoybL+FGmwy_+bLJ@mail.gmail.com>
Subject: Re: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
From: Hollis Blanchard <hollis@penguinppc.org>
To: Michael Ellerman <michael@ellerman.id.au>,
	Scott Wood <scottwood@freescale.com>,
	devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 8, 2010 at 7:09 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Thu, Dec 09, 2010 at 12:33:22PM +1100, Michael Ellerman wrote:
>> On Wed, 2010-12-08 at 15:01 -0600, Scott Wood wrote:
>> > On Wed, 8 Dec 2010 11:29:44 -0800
>> > Deepak Saxena <deepak_saxena@mentor.com> wrote:
>> >
>> > > We only return the next child if the device is available.
>> > >
>> > > Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
>> > > Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
>> > > ---
>> > > =A0drivers/of/base.c | =A0 =A04 +++-
>> > > =A01 files changed, 3 insertions(+), 1 deletions(-)
>> > >
>> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
>> > > index 5d269a4..81b2601 100644
>> > > --- a/drivers/of/base.c
>> > > +++ b/drivers/of/base.c
>> > > @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct de=
vice_node *node)
>> > > =A0 *
>> > > =A0 * =A0 =A0 =A0 Returns a node pointer with refcount incremented, =
use
>> > > =A0 * =A0 =A0 =A0 of_node_put() on it when done.
>> > > + *
>> > > + * =A0 =A0 =A0 Does not return nodes marked unavailable by a status=
 property.
>> > > =A0 */
>> > > =A0struct device_node *of_get_next_child(const struct device_node *n=
ode,
>> > > =A0 struct device_node *prev)
>> > > @@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const stru=
ct device_node *node,
>> > > =A0 read_lock(&devtree_lock);
>> > > =A0 next =3D prev ? prev->sibling : node->child;
>> > > =A0 for (; next; next =3D next->sibling)
>> > > - =A0 =A0 =A0 =A0 if (of_node_get(next))
>> > > + =A0 =A0 =A0 =A0 if (of_device_is_available(next) && of_node_get(ne=
xt))
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > > =A0 of_node_put(prev);
>> > > =A0 read_unlock(&devtree_lock);
>> >
>> > This seems like too low-level a place to put this. =A0Some code may kn=
ow
>> > how to un-disable a device in certain situations, or it may be part of
>> > debug code trying to dump the whole device tree, etc. =A0Looking
>> > further[1], I see a raw version of this function, but not other things
>> > like of_find_compatible_node.
>>
>> Yeah I agree. I think we'll eventually end up with __ versions of all or
>> lots of them. Not to mention there might be cases you've missed where
>> code expects to see unavailable nodes. The right approach is to add
>> _new_ routines that don't return unavailable nodes, and convert code
>> that you know wants to use them.
>
> Actually, I don't think we really want these status-skipping
> iterators at all. =A0The device tree iterators should give us the device
> tree, as it is. =A0Those old-style drivers which seach for a node rather
> than using the bus probing logic can keep individual checks of the
> status property until they're converted to the new scheme.

So the patch should look something like this?

@@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct
device_node *node)
 *
 *     Returns a node pointer with refcount incremented, use
 *     of_node_put() on it when done.
+ *
+ *     Do not use this function.
 */
 struct device_node *of_get_next_child(const struct device_node *node,
       struct device_node *prev)

...

+ struct device_node *of_get_next_available_child(const struct
device_node *node,
+       struct device_node *prev)
+ ...
+ }

And then (almost) all the of_get_next_child() sites should be changed
to call the new function?

-Hollis
