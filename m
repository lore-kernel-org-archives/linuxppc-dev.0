Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2B573hKFzDrbc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 10:37:13 +1100 (AEDT)
Received: by mail-wm0-x22a.google.com with SMTP id 9so12872911wme.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 15:37:13 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Michael Ellerman <michael@concordia.ellerman.id.au>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
 "netdev\@vger.kernel.org" <netdev@vger.kernel.org>, "Jouni Malinen" <j@w1.fi>,
 "Johannes Berg" <johannes.berg@intel.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
References: <20171202074155.29146-1-johannes@sipsolutions.net>
 <87vah29a1m.fsf@concordia.ellerman.id.au>
Date: Thu, 21 Dec 2017 00:37:08 +0100
In-Reply-To: <87vah29a1m.fsf@concordia.ellerman.id.au> (Michael Ellerman's
 message of "Tue, 19 Dec 2017 23:28:21 +1100")
Message-ID: <87efnpnf8b.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19 2017, Michael Ellerman <michael@concordia.ellerman.id.au> wrote:

> Hi Johannes,
>
>> From: Johannes Berg <johannes.berg@intel.com>
>> 
>> This reverts commit d6f295e9def0; some userspace (in the case
>
> This revert seems to have broken networking on one of my powerpc
> machines, according to git bisect.
>
> The symptom is DHCP fails and I don't get a link, I didn't dig any
> further than that. I can if it's helpful.
>
> I think the problem is that 87c320e51519 ("net: core: dev_get_valid_name
> is now the same as dev_alloc_name_ns") only makes sense while
> d6f295e9def0 remains in the tree.

I'm sorry about all of this, I really didn't think there would be such
consequences of changing an errno return. Indeed, d6f29 was preparation
for unifying the two functions that do the exact same thing (and how we
ever got into that situation is somewhat unclear), except for
their behaviour in the case the requested name already exists. So one of
the two interfaces had to change its return value, and as I wrote, I
thought EEXIST was the saner choice when an explicit name (no %d) had
been requested.

> ie. before the entire series, dev_get_valid_name() would return EEXIST,
> and that was retained when 87c320e51519 was merged, but now that
> d6f295e9def0 has been reverted dev_get_valid_name() is returning ENFILE.
>
> I can get the network up again if I also revert 87c320e51519 ("net:
> core: dev_get_valid_name is now the same as dev_alloc_name_ns"), or with
> the gross patch below.

I don't think changing -ENFILE to -EEXIST would be right either, since
dev_get_valid_name() used to be able to return both (-EEXIST in the case
where there's no %d, -ENFILE in the case where we end up calling
dev_alloc_name_ns()). If anything, we could do the check for the old
-EEXIST condition first, and then call dev_alloc_name_ns(). But I'm also
fine with reverting.

Again, sorry :(

Rasmus
