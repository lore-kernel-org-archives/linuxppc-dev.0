Return-Path: <eranian@google.com>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7CB72C00F0
 for <linuxppc-dev@ozlabs.org>; Thu,  9 May 2013 07:33:54 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id k1so2627809oag.28
 for <linuxppc-dev@ozlabs.org>; Wed, 08 May 2013 14:33:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130508155929.GA8459@dyad.programming.kicks-ass.net>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
Date: Wed, 8 May 2013 23:33:52 +0200
Message-ID: <CABPqkBRSMxQK8LJWhD39yo8EQZBd3-dRkeMqvwhWwLiHa6m66g@mail.gmail.com>
Subject: Re: Invalid perf_branch_entry.to entries question
From: Stephane Eranian <eranian@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, LKML <linux-kernel@vger.kernel.org>,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 8, 2013 at 5:59 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 07, 2013 at 11:35:28AM +1000, Michael Neuling wrote:
>> Peter & Stephane,
>>
>> We are plumbing the POWER8 Branch History Rolling Buffer (BHRB) into
>> struct perf_branch_entry.
>>
>> Sometimes on POWER8 we may not be able to fill out the "to" address.
>
> Just because I'm curious.. however does that happen? Surely the CPU knows where
> next to fetch instructions?
>
>> We
>> initially thought of just making this 0, but it's feasible that this
>> could be a valid address to branch to.
>
> Right, while highly unlikely, x86 actually has some cases where 0 address is
> valid *shudder*..
>
>> The other logical value to indicate an invalid entry would be all 1s
>> which is not possible (on POWER at least).
>>
>> Do you guys have a preference as to what we should use as an invalid
>> entry?  This would have some consequences for the userspace tool also.
>>
>> The alternative would be to add a flag alongside mispred/predicted to
>> indicate the validity of the "to" address.
>
> Either would work with me I suppose.. Stephane do you have any preference?

But if the 'to' is bogus, why not just drop the sample?
That happens on x86 if the HW captured branches which do not correspond to
user filter settings (due to bug).
