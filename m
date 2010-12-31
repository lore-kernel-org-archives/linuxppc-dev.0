Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1DA0B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 18:39:31 +1100 (EST)
Received: by iwn42 with SMTP id 42so12710442iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 23:39:28 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 31 Dec 2010 00:39:24 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
Message-ID: <20101231073924.GA4195@angua.secretlab.ca>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192944.GE32473@mentor.com>
	<20101208150102.69b8062b@udp111988uds.am.freescale.net>
	<1291858402.2962.2.camel@concordia>
	<20101209030924.GC11856@yookeroo>
	<AANLkTimPhs4AZ74e4SZfkyboeDJQaoybL+FGmwy_+bLJ@mail.gmail.com>
	<1292452855.6133.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292452855.6133.5.camel@concordia>
Cc: Scott Wood <scottwood@freescale.com>, devicetree-discuss@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 16, 2010 at 09:40:55AM +1100, Michael Ellerman wrote:
> On Wed, 2010-12-15 at 10:35 -0800, Hollis Blanchard wrote:
> > On Wed, Dec 8, 2010 at 7:09 PM, David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> > > On Thu, Dec 09, 2010 at 12:33:22PM +1100, Michael Ellerman wrote:
> > >> On Wed, 2010-12-08 at 15:01 -0600, Scott Wood wrote:
> > >> > On Wed, 8 Dec 2010 11:29:44 -0800
> > >> > Deepak Saxena <deepak_saxena@mentor.com> wrote:
> > >> >
> > >> > > We only return the next child if the device is available.
> > >> > >
> > >> > > Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> > >> > > Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
> > >> > > ---
> > >> > >  drivers/of/base.c |    4 +++-
> > >> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > >> > >
> > >> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > >> > > index 5d269a4..81b2601 100644
> > >> > > --- a/drivers/of/base.c
> > >> > > +++ b/drivers/of/base.c
> > >> > > @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct device_node *node)
> > >> > >   *
> > >> > >   *       Returns a node pointer with refcount incremented, use
> > >> > >   *       of_node_put() on it when done.
> > >> > > + *
> > >> > > + *       Does not return nodes marked unavailable by a status property.
> > >> > >   */
> > >> > >  struct device_node *of_get_next_child(const struct device_node *node,
> > >> > >   struct device_node *prev)
> > >> > > @@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const struct device_node *node,
> > >> > >   read_lock(&devtree_lock);
> > >> > >   next = prev ? prev->sibling : node->child;
> > >> > >   for (; next; next = next->sibling)
> > >> > > -         if (of_node_get(next))
> > >> > > +         if (of_device_is_available(next) && of_node_get(next))
> > >> > >                   break;
> > >> > >   of_node_put(prev);
> > >> > >   read_unlock(&devtree_lock);
> > >> >
> > >> > This seems like too low-level a place to put this.  Some code may know
> > >> > how to un-disable a device in certain situations, or it may be part of
> > >> > debug code trying to dump the whole device tree, etc.  Looking
> > >> > further[1], I see a raw version of this function, but not other things
> > >> > like of_find_compatible_node.
> > >>
> > >> Yeah I agree. I think we'll eventually end up with __ versions of all or
> > >> lots of them. Not to mention there might be cases you've missed where
> > >> code expects to see unavailable nodes. The right approach is to add
> > >> _new_ routines that don't return unavailable nodes, and convert code
> > >> that you know wants to use them.
> > >
> > > Actually, I don't think we really want these status-skipping
> > > iterators at all.  The device tree iterators should give us the device
> > > tree, as it is.  Those old-style drivers which seach for a node rather
> > > than using the bus probing logic can keep individual checks of the
> > > status property until they're converted to the new scheme.
> > 
> > So the patch should look something like this?
> > 
> > @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct
> > device_node *node)
> >  *
> >  *     Returns a node pointer with refcount incremented, use
> >  *     of_node_put() on it when done.
> > + *
> > + *     Do not use this function.
> >  */
> >  struct device_node *of_get_next_child(const struct device_node *node,
> >        struct device_node *prev)
> 
> Haha. No it should say "this function doesn't lie to you".
> 
> And the patch should say "this patch _doesn't_ subtly change all callers
> of of_get_next_child() without carefully auditing them".

Heh, Yes. The comments made on this patch are totally on-base.  Not
all nodes are devices, and not all callers will want to skip nodes;
regardless of the reason for skipping.  Case in point: the
/proc/device-tree support code.

If a caller needs a version of the function that skips unavailable
nodes, then that behaviour should be explicitly asked for.  In this
case it should be a new function with a new name.  Don't change the
behaviour out from under the existing users.

g.
