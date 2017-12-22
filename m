Return-Path: <groug@kaod.org>
Received: from 15.mo1.mail-out.ovh.net (15.mo1.mail-out.ovh.net
 [188.165.38.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3Gp542v5zDx5j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 05:12:59 +1100 (AEDT)
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id D1F77B75D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 13:19:06 +0100 (CET)
Date: Fri, 22 Dec 2017 13:18:59 +0100
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
Message-ID: <20171222131859.5dff1697@bahia.lan>
In-Reply-To: <20171222125847.1e5a4f5f@bahia.lan>
References: <20171212120204.6799-1-clg@kaod.org>
 <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
 <878tdvpeib.fsf@concordia.ellerman.id.au>
 <20171222075430.GB6945@fergus.ozlabs.ibm.com>
 <87wp1fnh27.fsf@concordia.ellerman.id.au>
 <20171222125847.1e5a4f5f@bahia.lan>
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

On Fri, 22 Dec 2017 12:58:47 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 22 Dec 2017 22:22:08 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Paul Mackerras <paulus@ozlabs.org> writes:
[...]
> > >
> > > Thanks for doing that.
> > >
> > > If you felt like merging Alexey's patch "KVM: PPC: Book3S PR: Fix WIMG
> > > handling under pHyp" with my acked-by, that would be fine too.  The
> > > commit message needs a little work - the reason for using HPTE_R_M is
> > > not just because it seems to work, but because current POWER
> > > processors require M set on mappings for normal pages, and pHyp
> > > enforces that.    
> > 
> > OK. I saw this too late, but I'll pick that one up next week. If someone
> > sends me an updated change log I will merge all of their patches for
> > ever.
> >   
> 
> Really ? Opportunity makes the thief, so here's my take :P
> 
> 8<---------------------------------------------------------------------->8
> KVM: PPC: Book3S: fix XIVE migration of pending interrupts

Oops! Paste error... Title should be:

KVM: PPC: Book3S PR: Fix WIMG handling under pHyp

> 
> 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits" added WIMG
> bits preserving but it missed 2 special cases:
> - a magic page in kvmppc_mmu_book3s_64_xlate() and
> - guest real mode in kvmppc_handle_pagefault().
> 
> For these ptes WIMG were 0 and pHyp failed on these causing a guest to
> stop in the very beginning at NIP=0x100 (due to bd9166ffe
> "KVM: PPC: Book3S PR: Exit KVM on failed mapping").
> 
> According to LoPAPR v1.1 14.5.4.1.2 H_ENTER:
> 
>  The hypervisor checks that the WIMG bits within the PTE are appropriate
>  for the physical page number else H_Parameter return. (For System Memory
>  pages WIMG=0010, or, 1110 if the SAO option is enabled, and for IO pages
>  WIMG=01**.)
> 
> This hence initializes WIMG to non-zero value HPTE_R_M (0x10), as expected
> by pHyp.
> 
> Fixes: 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 8<---------------------------------------------------------------------->8
> 
> Cheers,
> 
> --
> Greg
> 
> > cheers
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
