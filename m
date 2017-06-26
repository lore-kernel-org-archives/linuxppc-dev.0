Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx7b46l9SzDr24
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 22:26:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/sysfs: Expose MMCR2 spr in sysfs
In-Reply-To: <1498417372-27137-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1498417372-27137-1-git-send-email-maddy@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2017 22:26:39 +1000
Message-ID: <87bmpbdjeo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> Monitor Mode Control Register 2 (MMCR2) is a 64-bit
> register that contains 9-bit control fields for
> controlling the operation of PMC1 - PMC6. Patch
> to expose the MMCR2 spr in sysfs.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 4437c70c7c2b..587eb3a7b5da 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -482,6 +482,7 @@ SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
>  SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
>  
>  SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
> +SYSFS_PMCSETUP(mmcr2, SPRN_MMCR2);

We already have it under an #ifdef:

#ifdef HAS_PPC_PMC_G4
SYSFS_PMCSETUP(mmcr2, SPRN_MMCR2);
#endif


Can you reuse that somehow, or rework the #ifdefs.

cheers
