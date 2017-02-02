Return-Path: <edumazet@google.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDS466ChZzDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:40:54 +1100 (AEDT)
Received: by mail-it0-x233.google.com with SMTP id 203so32227425ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 20:40:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87y3xpb5li.fsf@concordia.ellerman.id.au>
References: <1485968734.6360.154.camel@edumazet-glaptop3.roam.corp.google.com>
 <1485981445.4850.8.camel@kernel.crashing.org>
 <87y3xpb5li.fsf@concordia.ellerman.id.au>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Feb 2017 20:40:51 -0800
Message-ID: <CANn89iKVtGt=mL32BVryzSCHcuNR93jO+GzR+pgr-1NHast26g@mail.gmail.com>
Subject: Re: [RFC] implement QUEUED spinlocks on powerpc
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Kevin Hao <haokexin@gmail.com>, Torsten Duwe <duwe@suse.de>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 1, 2017 at 8:04 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> On Wed, 2017-02-01 at 09:05 -0800, Eric Dumazet wrote:
>>> Hi all
>>>
>>> Is anybody working on adding QUEUED spinlocks to powerpc 64bit ?
>>>
>>> I've seen past attempts with ticket spinlocks
>>> ( https://patchwork.ozlabs.org/patch/449381/ and other related links
>>> )
>>>
>>> But it looks ticket spinlocks are a thing of the past.
>>
>> Yes, we have a tentative implementation of qspinlock and pv variants:
>>
>> https://patchwork.ozlabs.org/patch/703139/
>> https://patchwork.ozlabs.org/patch/703140/
>> https://patchwork.ozlabs.org/patch/703141/
>> https://patchwork.ozlabs.org/patch/703142/
>> https://patchwork.ozlabs.org/patch/703143/
>> https://patchwork.ozlabs.org/patch/703144/
>>
>> Michael, what's the status with getting that merged ?
>
> Needs a good review, and the benchmark results were not all that
> compelling - though perhaps they were just the wrong benchmarks.

A typical benchmark would be to use 200 concurrent netperf -t TCP_RR,
through a single qdisc (protected by a spinlock)

Non ticket/queued spinlocks behave quite bad in this scenario.

I can try this next week if you want.
