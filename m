Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4212ch31JdzF346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 09:57:55 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id b12-v6so2995531plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 16:57:55 -0700 (PDT)
Date: Thu, 30 Aug 2018 09:57:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling
 in fork
Message-ID: <20180830095747.491f7770@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-3-npiggin@gmail.com>
 <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
 <20180830091213.78b64354@roar.ozlabs.ibm.com>
 <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
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

On Wed, 29 Aug 2018 16:15:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 29, 2018 at 4:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Dirty micro fault seems to be the big one for my Skylake, takes 300
> > nanoseconds per access. Accessed takes about 100. (I think, have to
> > go over my benchmark a bit more carefully and re-test).  
> 
> Yeah, but they only happen for shared areas after fork, which sounds
> like it shouldn't be a big deal in most cases.

You might be right there.

> 
> And I'm not entirely objecting to your patch per se, I just would want
> to keep the accessed bit changes separate from the dirty bit ones.
> 
> *If* somebody has bisectable issues with it (performance or not), it
> will then be clearer what the exact issue is.

Yeah that makes a lot of sense. I'll do a bit more testing and send
Andrew a respin at least with those split (and a good comment for
the dirty bit vs unmap handling that you pointed out).

Thanks,
Nick
