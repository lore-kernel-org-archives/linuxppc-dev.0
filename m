Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1b2dv1zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:35 +1100 (AEDT)
In-Reply-To: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Fixup wrong LPCR_VRMASD value
Message-Id: <3v8g1b1FJ5z9t0t@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-08 at 03:42:13 UTC, "Aneesh Kumar K.V" wrote:
> In commit a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated
> LPCR_VRMASD wrongly as below.
> 
> -#define   LPCR_VRMASD  (0x1ful << (63-16))
> +#define   LPCR_VRMASD_SH       47
> +#define   LPCR_VRMASD          (ASM_CONST(1) << LPCR_VRMASD_SH)
> 
> We initialize the VRMA bits in LPCR to 0x00 in kvm. Hence using a different
> mask value as above while updating lpcr should not have any impact.
> 
> This patch updates it to the correct value
> Fixes: a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated
> 
> Reported-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4ab2537c4204b976e4ca350bbdc193

cheers
