Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsbBN4KzFzDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 18:56:44 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id e199so22541935pfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 01:56:43 -0700 (PDT)
Date: Wed, 13 Sep 2017 18:56:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>, "open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 3/5] powerpc/mce: Hookup derror (load/store) UE errors
Message-ID: <20170913185630.14cb1bd9@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnz=+sY0+dkw8gA2oRMG9g9CqNRqdVrcRU-01qXys9+7O3Q@mail.gmail.com>
References: <20170913061049.13256-1-bsingharora@gmail.com>
 <20170913061049.13256-4-bsingharora@gmail.com>
 <20170913162113.49e80b39@roar.ozlabs.ibm.com>
 <CAKTCnz=+sY0+dkw8gA2oRMG9g9CqNRqdVrcRU-01qXys9+7O3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Sep 2017 16:26:59 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, Sep 13, 2017 at 4:21 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Wed, 13 Sep 2017 16:10:47 +1000
> > Balbir Singh <bsingharora@gmail.com> wrote:
> >  
> >> Extract physical_address for UE errors by walking the page
> >> tables for the mm and address at the NIP, to extract the
> >> instruction. Then use the instruction to find the effective
> >> address via analyse_instr().
> >>
> >> We might have page table walking races, but we expect them to
> >> be rare, the physical address extraction is best effort. The idea
> >> is to then hook up this infrastructure to memory failure eventually.  
> >
> > This all looks pretty good to me, you can probably update these
> > changelogs now because you are hooking it into memory failure.  
> 
> Yep, the eventually can probably go, I meant in the next patch.
> The following patch then hooks this up into memory_failure
> 
> >
> > I wonder if it would be worth skipping the instruction analysis and
> > page table walk if we've recursed up to the maximum MCE depth, just
> > in case we're hitting MCEs in part of that code or data.  
> 
> Yep, good idea. Would you be OK if we did this after this small series
> got merged?

I don't mind much, but I'd have thought being that it's all new code,
adding the check would be pretty easy.

    if (get_paca()->in_mce == 4) {}

(Probably with the '4' appropriately #defined out of here and the
exception-64s.S code)

> Since that would mean that we got a UE error
> while processing the our third machine check exception, I think the
> probability of us running into that is low, but I'd definitely like to do that
> once these changes are merged.

If we're getting UEs in the machine check code or walking kernel
page tables though, it will just keep recurring. Unlikely yes, but
it's still a slight regression.

Thanks,
Nick
