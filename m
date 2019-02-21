Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D06C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 06:28:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224112084F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 06:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224112084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444l0D0LMpzDqNG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:28:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444kyL5tvFzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 17:26:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444kyL1XLWz9sBF;
 Thu, 21 Feb 2019 17:26:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] KVM: PPC: Improve KVM reference counting
In-Reply-To: <20190221034414.41777-1-aik@ozlabs.ru>
References: <20190221034414.41777-1-aik@ozlabs.ru>
Date: Thu, 21 Feb 2019 17:26:33 +1100
Message-ID: <87h8cxwtba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The anon fd's ops releases the KVM reference in the release hook.
> However we reference the KVM object after we create the fd so there is
> small window when the release function can be called and
> dereferenced the KVM object which potentially may free it.
  dereference
>
> It is not a problem at the moment as the file is created and KVM is
> referenced under the KVM lock and the release function obtains the same
> lock before dereferencing the KVM (although the lock is not held when
> calling kvm_put_kvm()) but it is a fragile against future changes.
>
> This references the KVM object before creating a file.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> The original bug is described here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfa393811
> But in this case kvm_put_kvm() is called straight away with no locks before/after/around.
>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 532ab797..d68c969 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -338,14 +338,15 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  		}
>  	}
>  
> +	kvm_get_kvm(kvm);
>  	if (!ret)
>  		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>  				       stt, O_RDWR | O_CLOEXEC);
>  
> -	if (ret >= 0) {
> +	if (ret >= 0)
>  		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> -		kvm_get_kvm(kvm);
> -	}
> +	else
> +		kvm_put_kvm(kvm);
>  
>  	mutex_unlock(&kvm->lock);

This looks correct to me. But I feel like the logic could be cleaner,
perhaps like this (patch below):

	mutex_lock(&kvm->lock);

	/* Check this LIOBN hasn't been previously allocated */
	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
		if (siter->liobn == args->liobn) {
			ret = -EBUSY;
			goto fail_unlock;
		}
	}

	kvm_get_kvm(kvm);
	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
				stt, O_RDWR | O_CLOEXEC);

	if (ret < 0) {
		kvm_put_kvm(kvm);
		goto fail_unlock;
	}

	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);

	mutex_unlock(&kvm->lock);

	return ret;

 fail_unlock:
	mutex_unlock(&kvm->lock);
 fail:


cheers

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 532ab79734c7..5d74602db0d0 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -296,7 +296,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	struct kvmppc_spapr_tce_table *siter;
 	unsigned long npages, size = args->size;
-	int ret = -ENOMEM;
+	int ret;
 	int i;
 
 	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
@@ -330,28 +330,30 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	mutex_lock(&kvm->lock);
 
 	/* Check this LIOBN hasn't been previously allocated */
-	ret = 0;
 	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
 		if (siter->liobn == args->liobn) {
 			ret = -EBUSY;
-			break;
+			goto fail_unlock;
 		}
 	}
 
-	if (!ret)
-		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
-				       stt, O_RDWR | O_CLOEXEC);
+	kvm_get_kvm(kvm);
+	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
+				stt, O_RDWR | O_CLOEXEC);
 
-	if (ret >= 0) {
-		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
-		kvm_get_kvm(kvm);
+	if (ret < 0) {
+		kvm_put_kvm(kvm);
+		goto fail_unlock;
 	}
 
+	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
+
 	mutex_unlock(&kvm->lock);
 
-	if (ret >= 0)
-		return ret;
+	return ret;
 
+ fail_unlock:
+	mutex_unlock(&kvm->lock);
  fail:
 	for (i = 0; i < npages; i++)
 		if (stt->pages[i])
