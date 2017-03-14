Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj2465fWbzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:36:06 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g2so17194702pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 21:36:06 -0700 (PDT)
Date: Tue, 14 Mar 2017 14:35:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
Message-ID: <20170314143553.3bb2dab9@roar.ozlabs.ibm.com>
In-Reply-To: <1489463840.2174.25.camel@kernel.crashing.org>
References: <20170312171327.21088-1-npiggin@gmail.com>
 <1489447868.2174.16.camel@kernel.crashing.org>
 <20170314114950.6d197c80@roar.ozlabs.ibm.com>
 <1489458878.2174.23.camel@kernel.crashing.org>
 <20170314125318.5f227517@roar.ozlabs.ibm.com>
 <1489463840.2174.25.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Mar 2017 14:57:20 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2017-03-14 at 12:53 +1000, Nicholas Piggin wrote:
> > >   - Load all
> > >   - For each byte if set
> > >      - clear byte
> > >      - then call handler  
> > 
> > Yes. I think that will be okay because we shouldn't get any load-hit-
> > store
> > issues. I'll do some benchmarking anyway.  
> 
> We might need a sync still between clearing the byte and calling the
> handler no ? Or at least a smp_wmb() to ensure that the clear is
> visible before any action of the handler.

Yes I have exactly that (smp_wmb).

At first I checked and cleared each byte then did a single smp_wmb, but
I changed my mind because most of the time the IPI will fire with only
one message set, so it does not seem like it's worth the extra branches
to avoid a lwsync in the rare case of 2 messages.

Thanks,
Nick
