Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEEB71A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 20:00:21 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1ADF140774
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2015 20:00:20 +1000 (AEST)
Date: Fri, 17 Jul 2015 04:59:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V3 2/2] powerpc/kexec: Reset HILE before entering target
 kernel
Message-ID: <20150717095957.GB15502@gate.crashing.org>
References: <1436505599-32109-1-git-send-email-sam.mj@au1.ibm.com>
 <1436505599-32109-3-git-send-email-sam.mj@au1.ibm.com>
 <1437098018.28088.62.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437098018.28088.62.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2015 at 11:53:38AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2015-07-10 at 15:19 +1000, Samuel Mendoza-Jonas wrote:
> > +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_POWERNV)
> > +       li      r3,(FW_FEATURE_OPAL >> 16)
> > +       rldicr  r3,r3,16,63
> > +       and.    r3,r3,r26
> > +       cmpwi   r3,0
> > +       beq     99f
> 
> If FW_FEATRURE_OPAL is 0x80000000 then the li will sign extend.
> 
> The rldicr has a mask of all F's so it will keep all the bits you
> don't care about.
> 
> So together, you'll get compares happening on bits above the 16 you care
> about that might change the result of your comparison incorrectly.
> 
> Since FW_FEATURE_* bits aren't ABI, they can change, so we don't want
> to impose a constraint on them.
> 
> Thus I would recommend using an rdlicl r3,r3,16,48 (aka srdi r3,r3,48)
> instead which is going to clear all bits above 0xffff.

Or the other way around: instead of loading and masking, load zero and
OR the bits in:

+       li      r3,0
+       ori     r3,(FW_FEATURE_OPAL >> 16)
+       rldicr  r3,r3,16,63
+       and.    r3,r3,r26
+       cmpwi   r3,0
+       beq     99f

which of course is better written as

+       li      r3,0
+       oris    r3,(FW_FEATURE_OPAL >> 16)
+       and.    r3,r3,r26
+       cmpwi   r3,0
+       beq     99f

which is

+       andis.  r3,r26,(FW_FEATURE_OPAL >> 16)
+       cmpwi   r3,0
+       beq     99f

which is

+       andis.  r3,r26,(FW_FEATURE_OPAL >> 16)
+       beq     99f

> Now, that being said, FW_FEATURE_* can be 64-bit

All of the code above only works for single-bit constants inside
0xffff0000 though (or 0x7fff0000 for the original).

> and this isn't perf
> critical so why not just load the full 64-bit constant into r3 and
> be done with it ? There's a macro to do that:
> 
> 	LOAD_REG_IMMEDIATE(r3,FW_FEATURE_OPAL)

And as you say later, use C.  Yeah.


Segher
