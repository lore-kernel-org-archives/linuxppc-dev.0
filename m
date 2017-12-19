Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:72ef::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1NmH1KW2zF07B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:34:54 +1100 (AEDT)
Message-ID: <1513700106.26145.16.camel@sipsolutions.net>
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Ellerman <michael@concordia.ellerman.id.au>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jouni Malinen
 <j@w1.fi>,  Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 19 Dec 2017 17:15:06 +0100
In-Reply-To: <87vah29a1m.fsf@concordia.ellerman.id.au>
References: <20171202074155.29146-1-johannes@sipsolutions.net>
 <87vah29a1m.fsf@concordia.ellerman.id.au>
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

Hi,

> This revert seems to have broken networking on one of my powerpc
> machines, according to git bisect.

Fun!

TBH, I only looked at the immediate problem we ran into, and reverted
what was causing it. I don't think we saw the follow-up problem you're
seeing.

> The symptom is DHCP fails and I don't get a link, I didn't dig any
> further than that. I can if it's helpful.
> 
> I think the problem is that 87c320e51519 ("net: core: dev_get_valid_name
> is now the same as dev_alloc_name_ns") only makes sense while
> d6f295e9def0 remains in the tree.
> 
> ie. before the entire series, dev_get_valid_name() would return EEXIST,
> and that was retained when 87c320e51519 was merged, but now that
> d6f295e9def0 has been reverted dev_get_valid_name() is returning ENFILE.
> 
> I can get the network up again if I also revert 87c320e51519 ("net:
> core: dev_get_valid_name is now the same as dev_alloc_name_ns"), or with
> the gross patch below.

Makes sense. I guess that should be reverted too then, or even your
"gross" patch applied.

johannes
