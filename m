Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyZlK3cN0zDrhr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 13:54:21 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id j14so5315135uag.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 18:54:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215124457.69841739@roar.ozlabs.ibm.com>
References: <20171215012740.30291-1-bsingharora@gmail.com>
 <20171215012740.30291-2-bsingharora@gmail.com>
 <20171215124457.69841739@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 15 Dec 2017 13:54:18 +1100
Message-ID: <CAKTCnzm+Ha2SLqp1q4W0i82TFP3wjZzPjLsyP2qdCAZf34o9CA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] powerpc/powernv: Identify scom driven system reset
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 1:44 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Fri, 15 Dec 2017 12:27:39 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> In irq_set_pending_from_srr1() we were missing 0x2 as system
>> reset identified from SRR1 caused by back to back system
>> resets or when interrupts are caused by SCOM when the thread
>> is not in power saving mode.
>>
>> This helps us get to NMI handling in both the case where NMI
>> is caused when in power-saving and not in power-saving mode.
>> The actual exploitation is expected when we are doing a kdump
>> and an offline CPU might not be in power-saving mode due to
>> an already spurious IPI or any other reason.
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>
> When not in power saving mode, we don't look at SRR1 at all, so
> we don't need this. You should never be getting it returned as the
> result of your idle instruction (except on DD1 which has a bug,
> but firmware doesn't implement the NMI IPI).
>

I added this for the next patch. We call irq_set_pending_from_srr1
while coming out of CPU idle, but if for any reason the IPI was spurious
and then we see an NMI during kdump, I did want to detect that
and callback into the NMI handler.

> It's possible we could pay more attention to the reason, for
> example in the powernv system reset handle we might only call
> the NMI IPI handler if it was a scom sreset... but that would
> be a regs->msr test.

regs->msr is the same as SRR1 in my kdump case, but your
right in general we want to look at regs->msr

Balbir Singh
