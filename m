Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Mv50Jr5zDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:18:24 +1000 (AEST)
Message-ID: <1470813494.3015.92.camel@kernel.crashing.org>
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christian Kujau
 <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Aug 2016 17:18:14 +1000
In-Reply-To: <87inv9te2n.fsf@concordia.ellerman.id.au>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-10 at 14:58 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > 
> > On Tue, 2016-08-09 at 02:06 -0700, Christian Kujau wrote:
> > > 
> > > On Mon, 8 Aug 2016, Christian Kujau wrote:
> > > > 
> > > > 
> > > > while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-
> > > > rc1,
> > > > it's 
> > > > unable to boot the Yaboot (v1.3.16 from Debian/stable) boot
> > > > loader:
> > 
> > There should already be a fix for that:
> > 
> > http://patchwork.ozlabs.org/patch/654560/
> > 
> > It should be in Michael's tree if not already in Linus.
> 
> That fix is in rc1, so this must be a different bug.

It's all the jump label cruft that landed in apply_feature_fixups()

You can't call random call there. On ppc32, it's running in that
weirdo environment where the kernel isn't running at its linked
address and we need to manually RELOC() everything.

I'm moving them to a separate init call, patch on its way...

Cheers,
Ben.
