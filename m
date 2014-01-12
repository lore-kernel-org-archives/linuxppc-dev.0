Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96EFB2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 11:08:46 +1100 (EST)
Message-ID: <1389566806.4672.108.camel@pasglop>
Subject: Re: [PATCH -V3 1/2] powerpc: mm: Move ppc64 page table range
 definitions to separate header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 13 Jan 2014 09:46:46 +1100
In-Reply-To: <87mwj8wn3e.fsf@linux.vnet.ibm.com>
References: <1388999012-14424-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1389050101.12906.13.camel@pasglop> <87mwj8wn3e.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 kirill.shutemov@linux.intel.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-07 at 07:49 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Mon, 2014-01-06 at 14:33 +0530, Aneesh Kumar K.V wrote:
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> This avoid mmu-hash64.h including pagetable-ppc64.h. That inclusion
> >> cause issues like
> >
> > I don't like this. We have that stuff split into too many includes
> > already it's a mess.
> 
> I understand. Let me know, if you have any suggestion on cleaning that
> up. I can do that.
> 
> >
> > Why do we need to include it from mmu*.h ?
> 
> in mmu-hash64.h added by me via 78f1dbde9fd020419313c2a0c3b602ea2427118f
> 
> /*
>  * This is necessary to get the definition of PGTABLE_RANGE which we
>  * need for various slices related matters. Note that this isn't the
>  * complete pgtable.h but only a portion of it.
>  */
> #include <asm/pgtable-ppc64.h>

For now, instead, just do fwd def of the spinlock, I don't like the
inclusion of spinlock.h there anyway.

Cheers,
Ben,
