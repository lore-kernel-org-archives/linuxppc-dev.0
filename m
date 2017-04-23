Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9lKQ0bz9zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 19:58:18 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id x188so8191606itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 02:58:17 -0700 (PDT)
Date: Sun, 23 Apr 2017 19:57:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V\"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <20170423195755.43e36953@roar.ozlabs.ibm.com>
In-Reply-To: <1492907951.25766.191.camel@kernel.crashing.org>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <1492848130.25766.185.camel@kernel.crashing.org>
 <20170423091428.16fc298f@roar.ozlabs.ibm.com>
 <1492907951.25766.191.camel@kernel.crashing.org>
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

On Sun, 23 Apr 2017 10:39:11 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2017-04-23 at 09:14 +1000, Nicholas Piggin wrote:
> > I think we were going to take another look at moving the setup code
> > later, but I think that might wait until 4.13.  
> 
> Except without that we won't boot a post-P9 CPU right ? So we'll end up
> having to chase distros to backport it :-( Oh well...

Okay, well what if we just move the TLB flushing to somewhere like
early_init_mmu(_secondary) for power CPUs first?

Non-local tlbie does not seem to have this requirement, so would it
make it more robust just to execute that once during boot with the
primary thread?
