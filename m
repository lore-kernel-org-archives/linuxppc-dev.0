Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBDYS2RcvzDqFk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 14:55:24 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id c26so5782638itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:55:24 -0700 (PDT)
Date: Mon, 24 Apr 2017 14:55:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar  <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix opal entry/exit MSR_RI coverage
Message-ID: <20170424145500.7a3cb11b@roar.ozlabs.ibm.com>
In-Reply-To: <1492998468.25766.195.camel@kernel.crashing.org>
References: <20170330121004.11991-1-npiggin@gmail.com>
 <1492998468.25766.195.camel@kernel.crashing.org>
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

On Mon, 24 Apr 2017 11:47:48 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2017-03-30 at 22:10 +1000, Nicholas Piggin wrote:
> > There are some windows in opal entry/exit that can not recover from a
> > re-entrant interrupt (e.g., machine check) due to using SRR registers,
> > but they currently do not have MSR_RI clear.
> > 
> > These were found by machine check injection coverage tests using the
> > powerpc system simulator (Mambo).  
> 
> So you make us enter/exit OPAL with RI off with your patch.

It should hrfid to opal with MSR_RI set. It seems to be doing the right
thing when stepping through it with the simulator.

> 
> OPAL currently won't re-enable it (which is a problem... we need to
> deal with MCEs happening while in OPAL, especially the ones with
> the special recovery table).
> 
> So if we do that we need to make OPAL turn it back on. In that case
> I would suggest making OPAL also turn it back off, thus avoiding
> touching FIXUP_ENDIAN...
