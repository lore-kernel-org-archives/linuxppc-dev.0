Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:72ef::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB0Tq6STQzF0TT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 03:52:15 +1100 (AEDT)
Message-ID: <1514911924.10342.1.camel@sipsolutions.net>
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
From: Johannes Berg <johannes@sipsolutions.net>
To: David Miller <davem@davemloft.net>, mpe@ellerman.id.au
Cc: linux@rasmusvillemoes.dk, michael@concordia.ellerman.id.au, j@w1.fi,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Jan 2018 17:52:04 +0100
In-Reply-To: <20180102.115008.2038929402603091054.davem@davemloft.net>
References: <87vah29a1m.fsf@concordia.ellerman.id.au>
 <87efnpnf8b.fsf@rasmusvillemoes.dk>
 <87bmirpf29.fsf@concordia.ellerman.id.au>
 <20180102.115008.2038929402603091054.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-02 at 11:50 -0500, David Miller wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Fri, 22 Dec 2017 15:22:22 +1100
> 
> >> On Tue, Dec 19 2017, Michael Ellerman <michael@concordia.ellerman.id.au> wrote:
> >>> This revert seems to have broken networking on one of my powerpc
> >>> machines, according to git bisect.
> >>>
> >>> The symptom is DHCP fails and I don't get a link, I didn't dig any
> >>> further than that. I can if it's helpful.
> >>>
> >>> I think the problem is that 87c320e51519 ("net: core: dev_get_valid_name
> >>> is now the same as dev_alloc_name_ns") only makes sense while
> >>> d6f295e9def0 remains in the tree.
> >>
> >> I'm sorry about all of this, I really didn't think there would be such
> >> consequences of changing an errno return. Indeed, d6f29 was preparation
> >> for unifying the two functions that do the exact same thing (and how we
> >> ever got into that situation is somewhat unclear), except for
> >> their behaviour in the case the requested name already exists. So one of
> >> the two interfaces had to change its return value, and as I wrote, I
> >> thought EEXIST was the saner choice when an explicit name (no %d) had
> >> been requested.
> > 
> > No worries.
> > 
> >>> ie. before the entire series, dev_get_valid_name() would return EEXIST,
> >>> and that was retained when 87c320e51519 was merged, but now that
> >>> d6f295e9def0 has been reverted dev_get_valid_name() is returning ENFILE.
> >>>
> >>> I can get the network up again if I also revert 87c320e51519 ("net:
> >>> core: dev_get_valid_name is now the same as dev_alloc_name_ns"), or with
> >>> the gross patch below.
> >>
> >> I don't think changing -ENFILE to -EEXIST would be right either, since
> >> dev_get_valid_name() used to be able to return both (-EEXIST in the case
> >> where there's no %d, -ENFILE in the case where we end up calling
> >> dev_alloc_name_ns()). If anything, we could do the check for the old
> >> -EEXIST condition first, and then call dev_alloc_name_ns(). But I'm also
> >> fine with reverting.
> > 
> > Yeah I think a revert would be best, given it's nearly rc5.
> > 
> > My userspace is not exotic AFAIK, just debian something, so presumably
> > this will affect other people too.
> 
> I've just queued up the following revert, thanks!
> 
> ====================
> From 5047543928139184f060c8f3bccb788b3df4c1ea Mon Sep 17 00:00:00 2001
> From: "David S. Miller" <davem@davemloft.net>
> Date: Tue, 2 Jan 2018 11:45:07 -0500
> Subject: [PATCH] Revert "net: core: dev_get_valid_name is now the same as
>  dev_alloc_name_ns"
> 
> This reverts commit 87c320e51519a83c496ab7bfb4e96c8f9c001e89.
> 
> Changing the error return code in some situations turns out to
> be harmful in practice.  In particular Michael Ellerman reports
> that DHCP fails on his powerpc machines, and this revert gets
> things working again.
> 
> Johannes Berg agrees that this revert is the best course of
> action for now.

I'm not sure my voice matters much, I merely did the first revert of
these two patches ... :)

But I agree with Michael that you can't really salvage this without the
other patch, and that one caused problems in wifi ...

Thanks :)

johannes 
