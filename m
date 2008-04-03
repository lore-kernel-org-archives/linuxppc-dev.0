Return-Path: <hollisb@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8113DDDECA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 05:47:59 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m33Iltph018043
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 14:47:55 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m33IltbP313156
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 14:47:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m33IltNv009137
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 14:47:55 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Date: Thu, 3 Apr 2008 13:47:54 -0500
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804031347.54517.hollisb@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008 01:52:36 Kumar Gala wrote:
> Wanted to get any feedback on this initial port of the fixmap support over
> from x86.  There are a few TODOs:
>
> * change HIGHMEM support to use fixmap
> * fixup up VMALLOC config to respect fixmap
>
> (after initial powerpc patch is in tree/accepted):
> * rework a few bits of fixmap.h into an asm-generic/fixmap.h
>
> The reason for introducing fixmap into ppc32 is it provides us with a
> clean way of getting fixed compile time virtual addresses for things.
>
> Beyond the HIGHMEM usage.  Ben and I have discussed cleaning up the PCIe
> 44x config code (and 83xx PCIe cfg) to use it.  Also, Dale's kexec/kdump
> support on ppc32 can take advantage of it.  I'm also told this is useful
> for hypervisor interactions.
>
> One question for the guys looking at hypervisor.  The x86 code also has a
> function called reserve_top_address (see arch/x86/mm/pgtable_32.c).  Is
> this functionality something useful on ppc?  If so for what?

x86 virtualization implementations often needs a trampoline that's mapped into 
both host and guest virtual address space, so that's part of what you're 
seeing.

In general though, it can be very useful for the host to own a piece of the 
guest's virtual address space. For example, the host could rewrite 
problematic guest instructions to branch to host-optimized code which avoids 
hypercalls. However, this is impossible unless the host knows it can 
overwrite some portion of the guest's effective address space.

reserve_top_address() doesn't look complicated, so we might as well keep it?

-- 
Hollis Blanchard
IBM Linux Technology Center
