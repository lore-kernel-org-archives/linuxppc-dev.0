Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFLK074nPzF0SM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 14:26:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Miller <davem@davemloft.net>
Cc: linux@rasmusvillemoes.dk, michael@concordia.ellerman.id.au, j@w1.fi,
 netdev@vger.kernel.org, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org, johannes.berg@intel.com
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
In-Reply-To: <20180102.115008.2038929402603091054.davem@davemloft.net>
References: <87vah29a1m.fsf@concordia.ellerman.id.au>
 <87efnpnf8b.fsf@rasmusvillemoes.dk> <87bmirpf29.fsf@concordia.ellerman.id.au>
 <20180102.115008.2038929402603091054.davem@davemloft.net>
Date: Mon, 08 Jan 2018 14:26:12 +1100
Message-ID: <874lnx2fqj.fsf@concordia.ellerman.id.au>
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

David Miller <davem@davemloft.net> writes:

> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Fri, 22 Dec 2017 15:22:22 +1100
>
>>> On Tue, Dec 19 2017, Michael Ellerman <michael@concordia.ellerman.id.au> wrote:
>>>> This revert seems to have broken networking on one of my powerpc
>>>> machines, according to git bisect.
>>>>
>>>> The symptom is DHCP fails and I don't get a link, I didn't dig any
>>>> further than that. I can if it's helpful.
>>>>
>>>> I think the problem is that 87c320e51519 ("net: core: dev_get_valid_name
>>>> is now the same as dev_alloc_name_ns") only makes sense while
>>>> d6f295e9def0 remains in the tree.
>>>
>>> I'm sorry about all of this, I really didn't think there would be such
>>> consequences of changing an errno return. Indeed, d6f29 was preparation
>>> for unifying the two functions that do the exact same thing (and how we
>>> ever got into that situation is somewhat unclear), except for
>>> their behaviour in the case the requested name already exists. So one of
>>> the two interfaces had to change its return value, and as I wrote, I
>>> thought EEXIST was the saner choice when an explicit name (no %d) had
>>> been requested.
>> 
>> No worries.
>> 
>>>> ie. before the entire series, dev_get_valid_name() would return EEXIST,
>>>> and that was retained when 87c320e51519 was merged, but now that
>>>> d6f295e9def0 has been reverted dev_get_valid_name() is returning ENFILE.
>>>>
>>>> I can get the network up again if I also revert 87c320e51519 ("net:
>>>> core: dev_get_valid_name is now the same as dev_alloc_name_ns"), or with
>>>> the gross patch below.
>>>
>>> I don't think changing -ENFILE to -EEXIST would be right either, since
>>> dev_get_valid_name() used to be able to return both (-EEXIST in the case
>>> where there's no %d, -ENFILE in the case where we end up calling
>>> dev_alloc_name_ns()). If anything, we could do the check for the old
>>> -EEXIST condition first, and then call dev_alloc_name_ns(). But I'm also
>>> fine with reverting.
>> 
>> Yeah I think a revert would be best, given it's nearly rc5.
>> 
>> My userspace is not exotic AFAIK, just debian something, so presumably
>> this will affect other people too.
>
> I've just queued up the following revert, thanks!

Thanks.

I don't see it in rc7, will it get to Linus sometime before the release?

cheers
