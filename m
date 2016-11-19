Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLGlz4qsdzDvmw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 12:01:51 +1100 (AEDT)
Subject: Re: [PATCH 06/13] KVM: PPC: Book3S HV: Set partition table rather
 than SDR1 on POWER9
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-7-git-send-email-paulus@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <dd3ea2d7-2a5c-b8ce-857a-2f597650edf3@gmail.com>
Date: Sat, 19 Nov 2016 12:01:47 +1100
MIME-Version: 1.0
In-Reply-To: <1479454122-26994-7-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/11/16 18:28, Paul Mackerras wrote:
> On POWER9, the SDR1 register (hashed page table base address) is no
> longer used, and instead the hardware reads the HPT base address
> and size from the partition table.  The partition table entry also
> contains the bits that specify the page size for the VRMA mapping,
> which were previously in the LPCR.  The VPM0 bit of the LPCR is
> now reserved; the processor now always uses the VRMA (virtual
> real-mode area) mechanism for guest real-mode accesses in HPT mode,
> and the RMO (real-mode offset) mechanism has been dropped.
> 
> When entering or exiting the guest, we now only have to set the
> LPIDR (logical partition ID register), not the SDR1 register.
> There is also no requirement now to transition via a reserved
> LPID value.
> 

I had similar changes, but did not have the VPM and host SDR switching
bits either.


> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c            | 36 +++++++++++++++++++++++++++------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++++---
>  2 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 40b2b6d..5cbe3c3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -54,6 +54,7 @@
>  #include <asm/dbell.h>
>  #include <asm/hmi.h>
>  #include <asm/pnv-pci.h>
> +#include <asm/mmu.h>
>  #include <linux/gfp.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> @@ -3024,6 +3025,22 @@ static void kvmppc_mmu_destroy_hv(struct kvm_vcpu *vcpu)
>  	return;
>  }
>  
> +static void kvmppc_setup_partition_table(struct kvm *kvm)
> +{
> +	unsigned long dw0, dw1;
> +
> +	/* PS field - page size for VRMA */
> +	dw0 = ((kvm->arch.vrma_slb_v & SLB_VSID_L) >> 1) |
> +		((kvm->arch.vrma_slb_v & SLB_VSID_LP) << 1);
> +	/* HTABSIZE and HTABORG fields */
> +	dw0 |= kvm->arch.sdr1;
> +
> +	/* Second dword has GR=0; other fields are unused since UPRT=0 */
> +	dw1 = 0;

Don't we need to set LPCR_GTSE for legacy guests?

Otherwise

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
