Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vH3yj1JXFzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 21:45:17 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 75so8812209pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 02:45:17 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 6 Feb 2017 16:15:09 +0530
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix spurrious segfaults on radix with Autonuma
Message-ID: <20170206104509.GA26240@dhcp-9-109-223-240.in.ibm.com>
References: <1486102228.4850.52.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486102228.4850.52.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 03, 2017 at 05:10:28PM +1100, Benjamin Herrenschmidt wrote:
> When autonuma marks a PTE inaccessible it clears all the protection
> bits but leave the PTE valid.
> 
> With the Radix MMU, an attempt at executing from such a PTE will
> take a fault with bit 35 of SRR1 set "SRR1_ISI_N_OR_G".
> 
> It is thus incorrect to treat all such faults as errors. We should
> pass them to handle_mm_fault() for autonuma to deal with. The case
> of pages that are really not executable is handled by the existing
> test for VM_EXEC further down.
> 
> That leaves us with catching the kernel attempts at executing user
> pages. We can catch that earlier, even before we do find_vma.
> 
> It is never valid on powerpc for the kernel to take an exec fault
> to begin with. So fold that test with the existing test for the
> kernel faulting on kernel addresses to bail out early.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 1d18ad0 ("powerpc/mm: Detect instruction fetch denied and report")
> Fixes: 0ab5171 ("powerpc/mm: Fix no execute fault handling on pre-POWER5")
> ---
>

Acked-by: Balbir Singh <bsingharora@gmail.com> 
