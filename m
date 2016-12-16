Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg4dM4NfczDw5v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 20:24:23 +1100 (AEDT)
Subject: Re: [PATCH 03/11] powerpc/kvm: Gather HPT related variables into
 sub-structure
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-4-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c797b46a-60af-b860-4bfe-3a1c1d75c974@redhat.com>
Date: Fri, 16 Dec 2016 10:24:17 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:53, David Gibson wrote:
> Currently, the powerpc kvm_arch structure contains a number of variables
> tracking the state of the guest's hashed page table (HPT) in KVM HV.  This
> patch gathers them all together into a single kvm_hpt_info substructure.
> This makes life more convenient for the upcoming HPT resizing
> implementation.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_host.h | 16 ++++---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 90 ++++++++++++++++++-------------------
>  arch/powerpc/kvm/book3s_hv.c        |  2 +-
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c | 62 ++++++++++++-------------
>  4 files changed, 87 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index e59b172..2673271 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -241,12 +241,20 @@ struct kvm_arch_memory_slot {
>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  };
>  
> +struct kvm_hpt_info {
> +	unsigned long virt;
> +	struct revmap_entry *rev;
> +	unsigned long npte;
> +	unsigned long mask;
> +	u32 order;
> +	int cma;
> +};

While you're at it, it would be really great if you could add a comment
at the end of each line with a short description of what the variables
are about. E.g. if I just read "virt" and do not have much clue of the
code yet, I have a hard time to figure out what this means...

 Thomas
