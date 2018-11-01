Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40670C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:51:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AF6204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsY91xcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AF6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m28B3mbbzF3Nj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:51:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsY91xcs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsY91xcs"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m25S2GkwzF3N0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 21:49:32 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id j13-v6so5648248pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 03:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZaJRY7NGDH3ndAVZdE/7wdkdOv01vquUq8ouh1Ne1Ns=;
 b=LsY91xcsWx5PAHniNR6dgdjdAuINCg5gz69GzAh2csxu2qLNN6cVQ4ttW40v2bVqhj
 5WNGza+ivhBstm57kwcGGF6J6VFayPKsY9xca635RbRhd4SGATneZrnHCxn1o7LtwVai
 dpEDrlEgT9lUrOPsDqmM272XvOAF7GXCJ5F3ZpAUnWD3x30sWTSpdfNtjm6kETCyCxJS
 4Awt0iHUwHeItQMIyjmrW894gaW76X1dPxcTdztuWIsAlgD9RK87RQHj1hR21hjT644E
 yRBIs6gSqvJEfkF5jgB9CN/OJcAz+LDTJrBy63SE18janVfyGg3861WrOd/yERM9D4Qa
 gKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZaJRY7NGDH3ndAVZdE/7wdkdOv01vquUq8ouh1Ne1Ns=;
 b=N9UPJnv1GhZsvzg+yO63InkBAzp34REbnzqrBIayp5bTiO2mmdawnVPYxnVNwIO4OU
 I0+Z4X7KU8nCZSmODWctoQPWLE3stC22zhVpCjxeHHpvrzwmXosxr0bv0CO3SgAannAI
 JFVvUoyJ3xo1ow1aDzEAIx2GxyoR5zal9dep3pWK4gxTifbOhts6HzVydsGV9tR0ZCnt
 hJ8nMU4CmH1AkZvf0pniu/ZWxE1at0b2hArN0OdLpSk26QStyo8DWV/Xr6L0hQqL1Ws3
 N9ZoQcArI2LyYbt5oQ5/TEbPBcxCvrPIvd+2hu+6tZXpGODuxHLw1FeN7TVqSXtZk6ED
 w/dQ==
X-Gm-Message-State: AGRZ1gLaaLdesuFhASmN/s9mQuPCMbDsaZtzAPe/YF0PLY6S2OnS8MeB
 gmct9Dj7KK/4IeiGRW/1l60=
X-Google-Smtp-Source: AJdET5d8hbJnUjl9XgK8aoNyGrF83jRXS7G4c127V1SSYWh1TXHzAHuP6xRcvKonsh5t+wTYbbi0og==
X-Received: by 2002:a63:2045:: with SMTP id
 r5-v6mr6662290pgm.328.1541069370060; 
 Thu, 01 Nov 2018 03:49:30 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 s2-v6sm72161188pfk.133.2018.11.01.03.49.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Nov 2018 03:49:29 -0700 (PDT)
Date: Thu, 1 Nov 2018 21:49:26 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [RFC PATCH v1 3/4] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE
 hcalls
Message-ID: <20181101104926.GF16399@350D>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-4-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022051837.1165-4-bharata@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
>  
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
> +	kvm_for_each_memslot(memslot, slots) {
> +		ret = uv_register_mem_slot(kvm->arch.lpid,
> +					   memslot->base_gfn << PAGE_SHIFT,
> +					   memslot->npages * PAGE_SIZE,
> +					   0, memslot->id);

For every memslot their is a corresponding registration in the ultravisor?
Is there a corresponding teardown?

> +		if (ret < 0)
> +			return H_PARAMETER;
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
> 
