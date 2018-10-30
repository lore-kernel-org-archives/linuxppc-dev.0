Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA939C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:33:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4780A20664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="f2io8mIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4780A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kg9l1CR5zF18l
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="f2io8mIX";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kg723RS2zDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 16:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="f2io8mIX"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42kg7211jhz9s1x; Tue, 30 Oct 2018 16:31:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540877470; bh=vCXcIR/UMEz1AYXUbnf1bgkV3zYpHdIWPiVwpSCjJrg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f2io8mIXGtJB/j1wT5X6GVN7BeEp1nzfE1Kkv0C8GIpjqVnlTPfxYjAMluyhELJ8V
 eAR+ZAPoPTGzimGeZ1oVblmy/9L9sG+rc+nPB8LEb/Dl3IsWJad+KlfvcF2siChWp4
 xb+hNVlI2KvgAh8EGffOk3cpAxNPMIfCUZCHSLnNlsq4HiSTmrTquT2dPBFq/WowGv
 aRVdMKWjcU+PbWf1zLGIdWOwWrrK0LpivJC7vznXMaruOxtOOTKfaQREc0sVZ25H+e
 7+4dl0q8igoc9rN5IZK5Ml6qfEjH+jXbx9Sbvq0T+eweKxv/zackBzb2wwRxeI4qVX
 8CAC8Avcy9AYw==
Date: Tue, 30 Oct 2018 16:29:57 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v1 3/4] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE
 hcalls
Message-ID: <20181030052957.GC11072@blackberry>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-4-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022051837.1165-4-bharata@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org, benh@linux.ibm.com,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 22, 2018 at 10:48:36AM +0530, Bharata B Rao wrote:
> H_SVM_INIT_START: Initiate securing a VM
> H_SVM_INIT_DONE: Conclude securing a VM
> 
> During early guest init, these hcalls will be issued by UV.
> As part of these hcalls, [un]register memslots with UV.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Comments below...

> ---
>  arch/powerpc/include/asm/hvcall.h    |  4 ++-
>  arch/powerpc/include/asm/kvm_host.h  |  1 +
>  arch/powerpc/include/asm/ucall-api.h |  6 ++++
>  arch/powerpc/kvm/book3s_hv.c         | 54 ++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 89e6b70c1857..6091276fef07 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -300,7 +300,9 @@
>  #define H_INT_RESET             0x3D0
>  #define H_SVM_PAGE_IN		0x3D4
>  #define H_SVM_PAGE_OUT		0x3D8
> -#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
> +#define H_SVM_INIT_START	0x3DC
> +#define H_SVM_INIT_DONE		0x3E0
> +#define MAX_HCALL_OPCODE	H_SVM_INIT_DONE

Same comments about hcall number assignments as for patch 1.

>  /* H_VIOCTL functions */
>  #define H_GET_VIOA_DUMP_SIZE	0x01
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 194e6e0ff239..267f8c568bc3 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -292,6 +292,7 @@ struct kvm_arch {
>  	struct dentry *debugfs_dir;
>  	struct dentry *htab_dentry;
>  	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
> +	bool svm_init_start; /* Indicates H_SVM_INIT_START has been called */

That doesn't seem like a good name for the field.  How about just
'secure'?

>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  	struct mutex hpt_mutex;
> diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
> index 2c12f514f8ab..9ddfcf541211 100644
> --- a/arch/powerpc/include/asm/ucall-api.h
> +++ b/arch/powerpc/include/asm/ucall-api.h
> @@ -17,4 +17,10 @@ static inline int uv_page_out(u64 lpid, u64 dw0, u64 dw1, u64 dw2, u64 dw3)
>  	return U_SUCCESS;
>  }
>  
> +static inline int uv_register_mem_slot(u64 lpid, u64 dw0, u64 dw1, u64 dw2,
> +				       u64 dw3)
> +{
> +	return 0;
> +}

Please give the parameters descriptive names.

> +
>  #endif	/* _ASM_POWERPC_UCALL_API_H */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 05084eb8aadd..47f366f634fd 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -819,6 +819,50 @@ static int kvmppc_get_yield_count(struct kvm_vcpu *vcpu)
>  	return yield_count;
>  }
>  
> +#ifdef CONFIG_PPC_SVM
> +#include <asm/ucall-api.h>
> +/*
> + * TODO: Check if memslots related calls here need to be called
> + * under any lock.
> + */
> +static unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
> +{
> +	struct kvm_memslots *slots;
> +	struct kvm_memory_slot *memslot;
> +	int ret;
> +
> +	slots = kvm_memslots(kvm);

I think you need the srcu read lock around this stuff.

> +	kvm_for_each_memslot(memslot, slots) {
> +		ret = uv_register_mem_slot(kvm->arch.lpid,
> +					   memslot->base_gfn << PAGE_SHIFT,
> +					   memslot->npages * PAGE_SIZE,
> +					   0, memslot->id);
> +		if (ret < 0)
> +			return H_PARAMETER;

That doesn't seem like the right error code to use...

> +	}
> +	kvm->arch.svm_init_start = true;
> +	return H_SUCCESS;
> +}
> +
> +static unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
> +{
> +	if (kvm->arch.svm_init_start)
> +		return H_SUCCESS;
> +	else
> +		return H_UNSUPPORTED;
> +}
> +#else
> +static unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
> +{
> +	return H_UNSUPPORTED;
> +}
> +
> +static unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
> +{
> +	return H_UNSUPPORTED;
> +}
> +#endif
> +
>  int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long req = kvmppc_get_gpr(vcpu, 3);
> @@ -950,6 +994,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  					    kvmppc_get_gpr(vcpu, 6),
>  					    kvmppc_get_gpr(vcpu, 7));
>  		break;
> +	case H_SVM_INIT_START:
> +		ret = kvmppc_h_svm_init_start(vcpu->kvm);
> +		break;
> +	case H_SVM_INIT_DONE:
> +		ret = kvmppc_h_svm_init_done(vcpu->kvm);
> +		break;
>  	default:
>  		return RESUME_HOST;
>  	}
> @@ -978,6 +1028,8 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
>  #endif
>  	case H_SVM_PAGE_IN:
>  	case H_SVM_PAGE_OUT:
> +	case H_SVM_INIT_START:
> +	case H_SVM_INIT_DONE:
>  		return 1;
>  	}
>  
> @@ -4413,6 +4465,8 @@ static unsigned int default_hcall_list[] = {
>  #endif
>  	H_SVM_PAGE_IN,
>  	H_SVM_PAGE_OUT,
> +	H_SVM_INIT_START,
> +	H_SVM_INIT_DONE,
>  	0
>  };
>  
> -- 
> 2.17.1

Paul.
