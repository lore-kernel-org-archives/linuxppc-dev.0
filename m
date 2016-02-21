Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96F5B1A096C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:46:13 +1100 (AEDT)
Date: Mon, 22 Feb 2016 09:45:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 3/9] powerpc/mm/64: Use physical addresses in upper
 page table tree levels
Message-ID: <20160221224553.GE30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-4-git-send-email-paulus@samba.org>
 <87y4af730x.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y4af730x.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 20, 2016 at 10:05:58PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > This changes the Linux page tables to store physical addresses
> > rather than kernel virtual addresses in the upper levels of the
> > tree (pgd, pud and pmd) for all 64-bit machines.
> >
> > This frees up some high order bits, and will be needed with book3s
> > PowerISA v3.0 machines which read the page table tree in hardware
> > in radix mode.
> 
> 
> Should we not update pmd_pgtable ?

Not sure what you mean by this - the patch does update pmd_pgtable
for the 64k page case (the 4k case is already fine).

> I have the below patch in my series.
> 
> http://mid.gmane.org/1455814254-10226-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com

That looks like a reasonable thing to do.

Paul.
