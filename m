Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7B0BE1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:58:27 +1100 (EST)
Message-ID: <1322513899.23348.48.camel@pasglop>
Subject: Re: MPIC cleanup series
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 29 Nov 2011 07:58:19 +1100
In-Reply-To: <CAGZ=bqJZdN-gpeBW+EdE7Dd=qsNzhwbFr8hBCRqMM72VkT8W7g@mail.gmail.com>
References: <1322437884.23348.30.camel@pasglop>
 <CAGZ=bqJZdN-gpeBW+EdE7Dd=qsNzhwbFr8hBCRqMM72VkT8W7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-11-28 at 15:48 -0500, Kyle Moffett wrote:
> On Sun, Nov 27, 2011 at 18:51, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Overall I really look your series. It doesn't quite apply cleanly
> > anymore so I'll as you for a new shoot after you address the comments
> > below, at which point, if you're fast enough, I'll stick it in -next :-)
> 
> Awesome! Thanks!
> 
> As I mentioned before, I have precious little of the hardware to test
> this all on, so I hope I don't break anything.  At minimum I need to
> do a final build-and-run test on my e500 boards before I send it out.
> :-D

That's ok, I was planning on letting it simmer in -test for a week or
so, giving myself time to test on a range of powermacs etc...

> > Just a couple of comments on some of the patches:
> >
> >  - 5/10: search for open-pic device-tree node if NULL
> >
> > The idea is fine, however most callers ignore the device-type and only
> > compare on compatible, while you replace that with a match entry that
> > seems to require matching on both. This is likely to break stuff. The
> > "type" part of te march entry should be NULL I believe.
> 
> If you re-read that, the match table used if no of_node is passed in
> has *two* separate entries, one of them with a "type" and the other
> with a "compatible", as opposed to a single entry which matches both
> "type" and "compatible".

Oh, my bad. Ok.

> There are a lot of callers which do:
>   dnp = of_find_node_by_type(NULL, "open-pic");
> 
> So I doubt I can remove the "type" entry all together, unfortunately.
> 
> 
> >  - 9/10: cache the node
> >
> > of_node_get() is your friend.
> 
> Yes, I actually messed this one up in the prior patch too, thanks for
> noticing.  It should all be fixed now.
> 
> 
> >  - 10/10: Makes me a bit nervous. It 'looks' right but I wouldn't bet on
> > Apple device-trees being sane vs. chaining. I would like a test that
> > doesn't do the cascade if the mpic is a primary to at least limit the
> > risk of messup.
> 
> Oh, you mean to wrap that block like this?
> 
> if (mpic->flags & MPIC_SECONDARY) {
>   virq = irq_of_parse_and_map(mpic->node, 0);
>   ...
> }

Yes.

> Sure, makes sense to me.  I've made that change.
> 
> Thanks for the review!

Thanks. Re-post the whole series and I'll merge it.

Cheers,
Ben.
