Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 736001A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 14:29:47 +1000 (EST)
Date: Wed, 2 Jul 2014 14:28:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] KVM: PPC: BOOK3S: HV: Use new functions for
 mapping/unmapping hpte in host
Message-ID: <20140702042831.GB16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404040655-12076-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 29, 2014 at 04:47:33PM +0530, Aneesh Kumar K.V wrote:
> We want to use virtual page class key protection mechanism for
> indicating a MMIO mapped hpte entry or a guest hpte entry that is swapped out
> in the host. Those hptes will be marked valid, but have virtual page
> class key set to 30 or 31. These virtual page class numbers are
> configured in AMR to deny read/write. To accomodate such a change, add
> new functions that map, unmap and check whether a hpte is mapped in the
> host. This patch still use HPTE_V_VALID and HPTE_V_ABSENT and don't use
> virtual page class keys. But we want to differentiate in the code
> where we explicitly check for HPTE_V_VALID with places where we want to
> check whether the hpte is host mapped. This patch enables a closer
> review for such a change.

[...]

>  		/* Check for pending invalidations under the rmap chain lock */
>  		if (kvm->arch.using_mmu_notifiers &&
>  		    mmu_notifier_retry(kvm, mmu_seq)) {
> -			/* inval in progress, write a non-present HPTE */
> -			pteh |= HPTE_V_ABSENT;
> -			pteh &= ~HPTE_V_VALID;
> +			/*
> +			 * inval in progress in host, write host unmapped pte.
> +			 */
> +			host_unmapped_hpte = 1;

This isn't right.  We already have HPTE_V_VALID set here, and you now
don't clear it here, and it doesn't get cleared by the
__kvmppc_unmap_host_hpte() call below either.

Paul.
