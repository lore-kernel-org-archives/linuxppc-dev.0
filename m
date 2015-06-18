Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F1C51A0E3B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 14:16:00 +1000 (AEST)
Message-ID: <1434600960.25157.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Change the swap encoding in pte.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org
Date: Thu, 18 Jun 2015 14:16:00 +1000
In-Reply-To: <1434575662.2353.107.camel@freescale.com>
References: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87616ngi8x.fsf@linux.vnet.ibm.com>
 <1434534342.28933.5.camel@ellerman.id.au>
 <1434575662.2353.107.camel@freescale.com>
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

On Wed, 2015-06-17 at 16:14 -0500, Scott Wood wrote:
> On Wed, 2015-06-17 at 19:45 +1000, Michael Ellerman wrote:
> > On Wed, 2015-06-17 at 08:21 +0530, Aneesh Kumar K.V wrote:
> > > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> > > 
> > > 
> > > Hi Scott,
> > > 
> > > > Current swap encoding in pte can't support large pfns
> > > > above 4TB. Change the swap encoding such that we put
> > > > the swap type in the PTE bits. Also add build checks
> > > > to make sure we don't overlap with HPTEFLAGS.
> > > > 
> > > 
> > > Can you please review this w.r.t 64bit booke ? 
> 
> It looks OK.
> 
> I'm curious why _PAGE_BIT_SWAP_TYPE is 2 -- it seems like it could be 
> any value >= 1 that isn't large enough to cause a conflict. Does 
> something get stored in that second bit?
> 
> > I booted it on our p5020ds FWIW.
> 
> Actively using swap?

Yeah good point, it wasn't.

I ran 4 make -j kernel builds in parallel which seemed to do the trick:

               total       used       free     shared    buffers     cached
  Mem:       4053952    4038324      15628        344       2880      26932
  -/+ buffers/cache:    4008512      45440
  Swap:      7918588    6102800    1815788


Of course it went OOM not long after that, but it's still pinging and it's
running fine, just spending all its time printing the OOM kill info to the
console.

cheers
