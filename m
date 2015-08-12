Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 824F61A1D48
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 05:06:21 +1000 (AEST)
Subject: Re: [PATCH] kvm:powerpc:Fix return statements for wrapper functions
 in the file book3s_64_mmu_hv.c
To: Nicholas Krause <xerofoify@gmail.com>, gleb@kernel.org
References: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 pbonzini@redhat.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
From: Alexander Graf <agraf@suse.de>
Message-ID: <55CB9927.8050400@suse.de>
Date: Wed, 12 Aug 2015 21:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10.08.15 17:27, Nicholas Krause wrote:
> This fixes the wrapper functions kvm_umap_hva_hv and the function
> kvm_unmap_hav_range_hv to return the return value of the function
> kvm_handle_hva or kvm_handle_hva_range that they are wrapped to
> call internally rather then always making the caller of these
> wrapper functions think they always run successfully by returning
> the value of zero directly.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Paul, could you please take on this one?

Thanks,

Alex

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index dab68b7..0905c8f 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -774,14 +774,12 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
>  
>  int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva)
>  {
> -	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
> -	return 0;
> +	return kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
>  }
>  
>  int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start, unsigned long end)
>  {
> -	kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
> -	return 0;
> +	return kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
>  }
>  
>  void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
> 
