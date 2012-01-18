Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 898DCB6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 11:39:21 +1100 (EST)
Received: by pbaa12 with SMTP id a12so1772172pba.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 16:39:20 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <keep-irq-is-domain@mdm.bga.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-7-git-send-email-grant.likely@secretlab.ca>
 <keep-irq-is-domain@mdm.bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 17 Jan 2012 17:38:59 -0700
Message-ID: <CACxGe6v-owMiuGj2XVVQXH7TBv-5H0oS8O8T8OVRCcUe-JR+fg@mail.gmail.com>
Subject: Re: [RFC 06/14] irq_domain/powerpc: Eliminate virq_is_host()
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2012 at 3:17 AM, Milton Miller <miltonm@bga.com> wrote:
> On Wed Jan 11 2012 about 15:24:34 EST, Grant Likely wrote:
>> There is only one user, and it is trivial to open-code.
>
> I added virq_is_host because I had planned to change how we find the
> host (domain) from a virq.
>
> Instead of storing a pointer in irq_desc (a pointer for every irq),
> I planned to use a NR_IRQ(+extra) bitmap per domain. =A0This should be
> a win storage-wise when the number of irq controllers is less than the
> number of bits in a long.
>
> This would also convert scanning for a reverse map from walking every
> irqdesc to walking find_next_bit over the irqs assigned to the host.
>
> Thus my rule was "code outside kernel/irq must not touch domain";
> both the contents and how it was associated were abstracted.
>
> Other planned changes included splitting the reverse lookup into
> domain dependent pieces, creating the ida for sparse map at domain
> creation time (init irq is after radix_tree_init as its used by the
> current irq code) so we never fall back to linear search. =A0Linear
> populated the reverse map as the irq was assigned, and changed to
> a seperate subtype if it mapped an irq above the map size.
>
> I thought some of the domains would be split into seperate files
> selected by Kconfig, at least the sparse tree.
>
> There was also a nomap varient to handle iseries (and one of the cell
> varients) where the interrupt number to use for an event is controlled
> by the guest, that led to the discussion with tlgx about how to
> disallow the extra irqs above the limit set by the arch callback.
>
> Actually making virq-is-domain a domain callback could eliminate the
> need for the bitmap on legacy (range limited) domains.
>
>
> I have my work in progress patches from 2.6.39 if you would like to
> see them. =A0I was trying to clean up powerpc before pushing it over,
> and didn't get all the concepts written. =A0So I just sent Ben what
> was ready at the time and haven't had time to get back to it.

Go ahead and send me your patches.  I'll see what I can add into my series.

> Overall, I think most of the other concepts are ok, although I would
> have chosen to remove NO_IRQ before moving the code, and probably
> the rename from host to domain.

Haha.  Yeah, I debated reordering those a bit, but it would have
created a bunch of rebase work for little benefit.  Unless someone
really complains loudly, I'm going to leave it in the order as is.

> =A0I haven't studied the patches in
> detail since your tree is based on linux-next and my drive doesn't
> have space for that. =A0It took me a while to realize the code removed
> from the header file in 4/14 (powerpc use commmon host) was actually
> moved to irq-domain in 1/14 (a comment to that effect would be nice).

Okay, I'll add a comment to that effect.  If I rebase to Linus' tree
after 3.3-rc1 is released, can you help me test?

g.
