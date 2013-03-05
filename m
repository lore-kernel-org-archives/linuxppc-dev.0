Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by ozlabs.org (Postfix) with ESMTP id D26092C0342
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 12:40:45 +1100 (EST)
Date: Tue, 5 Mar 2013 10:40:44 +0900
From: Simon Horman <horms@verge.net.au>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH] kexec/ppc: Fix kernel program entry point while changing
 the load addr
Message-ID: <20130305014043.GD16128@verge.net.au>
References: <20130303073540.12040.16854.stgit@suzukikp>
 <20130304014152.GB9007@verge.net.au> <51343788.7070503@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51343788.7070503@in.ibm.com>
Cc: Matthew McClintock <msm@freescale.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 04, 2013 at 11:26:24AM +0530, Suzuki K. Poulose wrote:
> On 03/04/2013 07:11 AM, Simon Horman wrote:
> >[ Cc: linuxppc-dev@lists.ozlabs.org ]
> >
> >On Sun, Mar 03, 2013 at 01:06:00PM +0530, Suzuki K. Poulose wrote:
> >>From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >>
> >>uImage probe fills the entry point (ep) based on the load_addr
> >>from the uImage headers. If we change the load_addr, we should
> >>accordingly update the entry point.
> >>
> >>For ELF, calculate the offset of e_entry from the virtual start
> >>address and add it to the physical start address to find the
> >>physical address of kernel entry.
> >>
> >>i.e,
> >>   pa (e_entry) = pa(phdr[0].p_vaddr) + (e_entry - phdr[0].p_vaddr)
> >>                = kernel_addr + (e_entry - phdr[0].p_vaddr)
> >
> >Would it be possible for someone to provide a review of this change?
> To make it bit more clear :
> 
> The entry point of the kernel is usually at 0 offset from the first
> PT_LOAD section. The current code makes this assumption and uses the
> pa(phdr[0].p_vaddr) as the kernel entry.
> 
> But this *may* not be true always, in such a case the kexec would fail.
> While I fixed the uImage case, I thought it would be better to
> handle the same case in ELF.
> 
> Btw, this calculation is not specific to ppc32.

Thanks, I have applied the patch.
