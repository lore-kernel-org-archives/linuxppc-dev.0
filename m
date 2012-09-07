Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B89842C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 11:44:03 +1000 (EST)
Message-ID: <1346982235.2385.33.camel@pasglop>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 07 Sep 2012 11:43:55 +1000
In-Reply-To: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-06 at 20:59 +0530, Aneesh Kumar K.V wrote:
> Hi,
> 
> This patchset include patches for supporting 64TB with ppc64. I haven't booted
> this on hardware with 64TB memory yet. But they boot fine on real hardware with
> less memory. Changes extend VSID bits to 38 bits for a 256MB segment
> and 26 bits for 1TB segments.

Your series breaks the embedded 64-bit build. You seem to be hard wiring
dependencies on slice stuff all over 64-bit stuff regardless of the MMU
type or the value of CONFIG_MM_SLICES.

Also all these:

> +/* 4 bits per slice and we have one slice per 1TB */
> +#if 0 /* We can't directly include pgtable.h hence this hack */
> +#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
> +#else
> +/* Right now we only support 64TB */
> +#define SLICE_ARRAY_SIZE  32
> +#endif

Things are just too horrible. Find a different way of doing it, if
necessary create a new range define somewhere, whatever but don't leave
that crap as-is, it's too wrong.

Dropping the series for now.

Cheers,
Ben. 

> Changes from V7:
>  * Address review feedback
> 
> Changes from V6:
>  * rebase to latest upstream (5b716ac728bcc01b1f2a7ed6e437196602237c27)
> 
> Changes from v5:
>  * Address review feedback
> 
> Changes from v4:
>  * Drop patch "arch/powerpc: properly offset the context bits for 1T segemnts"
>    based on review feedback
>  * split CONTEXT_BITS related changes from patch 12
>  * Add a new doc update patch
> 
> Changes from v3:
>  * Address review comments.
>  * Added new patch to ensure proto-VSID isolation between kernel and user space
> 
> Changes from V2:
>  * Fix few FIXMEs in the patchset. I have added them as separate patch for
>    easier review. That should help us to drop those changes if we don't agree.
> 
> Changes from V1:
> * Drop the usage of structure (struct virt_addr) to carry virtual address.
>   We now represent virtual address via vpn which is virtual address shifted
>   right 12 bits.
> 
> Thanks,
> -aneesh
> 
