Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEFDB2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 21:47:26 +1000 (EST)
Message-ID: <1370087236.3766.43.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Sat, 01 Jun 2013 21:47:16 +1000
In-Reply-To: <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
 <1369995080.3928.140.camel@pasglop>
 <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-01 at 18:59 +0800, Kevin Hao wrote:

> The effect of this change is that the isa_io_base will be 0 and the IO
> resource are equal to the virtual address of the IO space. But the IO
> functions such as outx/inx should work as well. This is why I ask the
> above question. What do you think about this? Are there any subtle bugs
> that will be triggered by this?

I don't see any obvious reason why that wouldn't work but like anything
in that area, it needs a bit of testing & hammering to be sure ;-)

In fact it would work on pmac32 as well since those generally don't have
legacy crap either.

So I have no fundamental objection, it just needs testing. My worry is
that we need to make sure we don't break old chrp and I don't have any
to test with. I'm happy to drop support for stuff nobody uses anymore
(we did drop PReP after all and I'm *that* close to drop power3) but as
long as somebody is still using a CHRP RS6K or a Pegasos I can't quite
drop those... And they do have legacy ISA crap to deal with.

Cheers,
Ben.
