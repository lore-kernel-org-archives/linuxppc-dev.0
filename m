Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FBPS1p0dzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 13:30:03 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id r24-v6so14556455ioh.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 20:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
 <1529912859-10475-3-git-send-email-kernelfans@gmail.com>
 <20180625104505.GA3058@kroah.com>
In-Reply-To: <20180625104505.GA3058@kroah.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 26 Jun 2018 11:29:48 +0800
Message-ID: <CAFgQCTt6MTwXbbcQCcJroM3wGdx+5c7A+eVy+dXJscu1JtfA-w@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] drivers/base: reorder consumer and its children
 behind suppliers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2018 at 6:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 25, 2018 at 03:47:39PM +0800, Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > introduces supplier<-consumer order in devices_kset. The commit tries
> > to cleverly maintain both parent<-child and supplier<-consumer order by
> > reordering a device when probing. This method makes things simple and
> > clean, but unfortunately, breaks parent<-child order in some case,
> > which is described in next patch in this series.
>
> There is no "next patch in this series" :(
>
Oh, re-arrange the patches, and forget the comment in log

> > Here this patch tries to resolve supplier<-consumer by only reordering a
> > device when it has suppliers, and takes care of the following scenario:
> >     [consumer, children] [ ... potential ... ] supplier
> >                          ^                   ^
> > After moving the consumer and its children after the supplier, the
> > potentail section may contain consumers whose supplier is inside
> > children, and this poses the requirement to dry out all consumpers in
> > the section recursively.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> > note: there is lock issue in this patch, should be fixed in next version
>
> Please send patches that you know are correct, why would I want to
> review this if you know it is not correct?
>
> And if the original commit is causing problems for you, why not just
> revert that instead of adding this much-increased complexity?
>
Revert the original commit, then it will expose the error  order
"consumer <- supplier" again.
This patch tries to resolve the error and fix the following scenario:
step0:  before the consumer device's probing,  (note child_a is a
supplier of consumer_a, etc)
[ consumer-X,  child_a, ...., child_z]     [.... consumer_a, ...,
consumer_z, ....]    supplier-X
                                                             ^^^
affected range during moving^^^
step1: When probing, moving consumer-X after supplier-X
[ child_a, ...., child_z]     [.... consumer_a, ...,     consumer_z,
....]   supplier-X, consumer-X
But it breaks "parent <-child" seq now, and should be fixed like:
step2:
[.... consumer_a, ...,     consumer_z, ....]  supplier-X  [
consumer-X,  child_a, ...., child_z]    <---
descendants_reorder_after_pos() does it.
Again, the seq "consumer_a <- child_a" breaks the "supplier<-consumer"
 order, should be fixed like:
step3:
[....  consumer_z, .....]  supplier-X  [ consumer-X,  child_a,
consumer_a ...., child_z]   <--- __device_reorder_consumer() does it.
^^ affected range^^
The moving of consumer_a brings us to face the same scenario of step1,
hence we need an external recursion.

Each round of step3,  __device_reorder_consumer() resolves its "local
affected range", which is a fraction of the "whole affected range".
Hence finally, we have all potential consumers in affected range resolved.
(Maybe I can split patch at step2 and step3 to ease the review for the
next version)

Since __device_reorder_consumer() has already hold devices_kset's spin
lock, and need to get srcu lock on devices->links.consumers.
This needs a breakage of spin lock, and will incur much effort. If the
above algorithm is fine, I can do it.
>
>
> >
> > ---
> >  drivers/base/core.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 129 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 66f06ff..db30e86 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -123,12 +123,138 @@ static int device_is_dependent(struct device *dev, void *target)
> >       return ret;
> >  }
> >
> > -/* a temporary place holder to mark out the root cause of the bug.
> > - * The proposal algorithm will come in next patch
> > +struct pos_info {
> > +     struct device *pos;
> > +     struct device *tail;
> > +};
> > +
> > +/* caller takes the devices_kset->list_lock */
> > +static int descendants_reorder_after_pos(struct device *dev,
> > +     void *data)
>
> Why are you wrapping lines that do not need to be wrapped?
>
OK, will fix.

> What does this function do?
>
As the name implies, reordering dev and its children after a position.
When moving a consumer after a supplier, we break down the order
of  "parent <-child" order of consumer and its children in devices_kset.
Hence we should move the children too.
The param "data"  contains the position info, and its name is not
illuminated :(,
since the func proto is required by device_for_each_child(), may be better to
name it as postion_info

> > +{
> > +     struct device *pos;
> > +     struct pos_info *p = data;
> > +
> > +     pos = p->pos;
> > +     pr_debug("devices_kset: Moving %s after %s\n",
> > +              dev_name(dev), dev_name(pos));
>
> You have a device, use it for debugging, i.e. dev_dbg().
>
But here we have two devices.

> > +     device_for_each_child(dev, p, descendants_reorder_after_pos);
>
> Recursive?
>
Yes, in order to move all children of the consumer.

> > +     /* children at the tail */
> > +     list_move(&dev->kobj.entry, &pos->kobj.entry);
> > +     /* record the right boundary of the section */
> > +     if (p->tail == NULL)
> > +             p->tail = dev;
> > +     return 0;
> > +}
>
> I really do not understand what the above code is supposed to be doing :(
>
The moved consumer's children may be  suppliers of devices,
[.... consumer_a, ...,     consumer_z, ....]    supplier-X      [
consumer-X,  child_a, ............, child_z]
^^^    potential consumers  ^^^^^^

                                           ^^potential suppliers^^
Now,  consumer_a and its supplier child_a  violate the order
"supplier<-consumer".
To pick out such violation, we need to check the potential suppliers
against potential
consumers. And p->tail helps to record the new moved position of child_z.

> > +
> > +/* iterate over an open section */
> > +#define list_opensect_for_each_reverse(cur, left, right)     \
> > +     for (cur = right->prev; cur == left; cur = cur->prev)
> > +
> > +static bool is_consumer(struct device *query, struct device *supplier)
> > +{
> > +     struct device_link *link;
> > +     /* todo, lock protection */
>
> Always run checkpatch.pl on patches so you do not get grumpy maintainers
> telling you to run checkpatch.pl :(
>
Yes, I had run it, and only got a warning:
WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
rather than BUG() or BUG_ON()
#167: FILE: drivers/base/core.c:245:
+ BUG_ON(!ret);

total: 0 errors, 1 warnings, 141 lines checked

> > +     list_for_each_entry(link, &supplier->links.consumers, s_node)
> > +             if (link->consumer == query)
> > +                     return true;
> > +     return false;
> > +}
> > +
> > +/* recursively move the potential consumers in open section (left, right)
> > + * after the barrier
>
> What barrier?
>
A position that moved devices can not cross before.

> I'm stopping here as I have no idea what is going on, and this needs a
> lot more work at the basic level of "it handles locking correctly"...
>
> If you are working on this for power9, I'm guessing you work for IBM?

No. I just hit this bug.

> If so, please run this through your internal patch review process before
> sending it out again...
>
I will try my best to find some guys to review. But is the assumption
of step0 and
the following algorithm worth to try?

Thanks and regards,
Pingfan
