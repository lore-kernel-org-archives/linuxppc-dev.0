Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80108C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 01:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAF9207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bXoo+FTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAF9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445DRj0v8pzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 12:35:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bXoo+FTo"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445DPy6RYrzDq67
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 12:33:40 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i19so322234pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 17:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ftMBCNsYRBZFDnn6nl2A6xDP0zEZYFGH09DXT4rGnSw=;
 b=bXoo+FTo9RoBWOt1cI1yg6fgFAErWyM4nxrz6dCxAtZSGJPAvTmPwAfktXuUamrMjM
 +Rse6BPPW2tsvlnxQbhIdPQP1gXcG9AOHCi3/NG5AzFWrZxwKx7gkStO/pgtWYh0zXxv
 qQLtERI7dry8aAKv/raW3OiIHi1eTdUxHqhw/ANJDr1VC3Va5WHM+iA67jLUcnt9FNOW
 rdu0I0Oc5KplEecbSlisPXDKcmA8eEXsXNG31SS+UkM62IKh5d34A/TlGBPjVCKzbywU
 kTK02gOYi1HFRFJiPd9d0UsubxuNavpcC6PUiL/ZFvU6G5kmIVrZ/NCdrytay0AU75qe
 RpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ftMBCNsYRBZFDnn6nl2A6xDP0zEZYFGH09DXT4rGnSw=;
 b=RHcKtzj4fjlRLfjimLZ+GG4TapFn1iGyKflavT8Dn01lqz/+C7Q5cZHorpcGYihEIP
 Fm3ZEF8bpK7dLg1DFCVpZEBir/Ahde1F7uhy99Vv9evr8uXsgEjfeHIt7Iasvu/Hz7d0
 2E6CvRR3mAJCCSqFaSqadLprCZq03u22uTBk71SJGQecBReiVUzNiHOnSTqNNTTI6xa4
 vbereBK0+sDO5kVnVDVNszVV/Ggsfv+X0C9JBJSFW22PQyMmbbeLfgH5WP7iaYYM6s9S
 BEYT2OQm345UU9DiloSfLex/BlBEoy+u5rBofx5FNb2EOz1fn7CrX9UedpUzg7k4A+4M
 KOog==
X-Gm-Message-State: AHQUAubWXP3q/g3EGNXTeehpyK+hj5187PvOp4Y4LbE4MBEGWHi5aCqO
 FB2xk50hDK01xV+C53WPQaDeCA==
X-Google-Smtp-Source: AHgI3IZZrGX/fC33HBwHSMIpguRC0uccVaUdcZzxWSDAnVGqVU3ic0SxocexXf0AnVgdptzWIrSPUQ==
X-Received: by 2002:a63:b447:: with SMTP id n7mr1431816pgu.401.1550799219010; 
 Thu, 21 Feb 2019 17:33:39 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p29sm38799pgm.78.2019.02.21.17.33.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 17:33:38 -0800 (PST)
Subject: Re: [PATCH kernel] KVM: PPC: Improve KVM reference counting
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20190221034414.41777-1-aik@ozlabs.ru>
 <87h8cxwtba.fsf@concordia.ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <1d77c917-857f-536b-8b07-85878b7767e3@ozlabs.ru>
Date: Fri, 22 Feb 2019 12:33:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87h8cxwtba.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 21/02/2019 17:26, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> The anon fd's ops releases the KVM reference in the release hook.
>> However we reference the KVM object after we create the fd so there is
>> small window when the release function can be called and
>> dereferenced the KVM object which potentially may free it.
>   dereference
>>
>> It is not a problem at the moment as the file is created and KVM is
>> referenced under the KVM lock and the release function obtains the same
>> lock before dereferencing the KVM (although the lock is not held when
>> calling kvm_put_kvm()) but it is a fragile against future changes.
>>
>> This references the KVM object before creating a file.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> The original bug is described here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfa393811
>> But in this case kvm_put_kvm() is called straight away with no locks before/after/around.
>>
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 532ab797..d68c969 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -338,14 +338,15 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>  		}
>>  	}
>>  
>> +	kvm_get_kvm(kvm);
>>  	if (!ret)
>>  		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>>  				       stt, O_RDWR | O_CLOEXEC);
>>  
>> -	if (ret >= 0) {
>> +	if (ret >= 0)
>>  		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>> -		kvm_get_kvm(kvm);
>> -	}
>> +	else
>> +		kvm_put_kvm(kvm);
>>  
>>  	mutex_unlock(&kvm->lock);
> 
> This looks correct to me. But I feel like the logic could be cleaner,
> perhaps like this (patch below):


And I feel that 1) your patch tries to hide what it actually does 2)
having 2 unlocks for one lock is an invite for future bugs imho, I'd
think the whole point of adding new gotos is exactly to have 1 unlock.


> 
> 	mutex_lock(&kvm->lock);
> 
> 	/* Check this LIOBN hasn't been previously allocated */
> 	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
> 		if (siter->liobn == args->liobn) {
> 			ret = -EBUSY;
> 			goto fail_unlock;
> 		}
> 	}
> 
> 	kvm_get_kvm(kvm);
> 	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> 				stt, O_RDWR | O_CLOEXEC);
> 
> 	if (ret < 0) {
> 		kvm_put_kvm(kvm);
> 		goto fail_unlock;
> 	}
> 
> 	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> 
> 	mutex_unlock(&kvm->lock);
> 
> 	return ret;
> 
>  fail_unlock:
> 	mutex_unlock(&kvm->lock);
>  fail:
> 
> 
> cheers
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 532ab79734c7..5d74602db0d0 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -296,7 +296,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	struct kvmppc_spapr_tce_table *stt = NULL;
>  	struct kvmppc_spapr_tce_table *siter;
>  	unsigned long npages, size = args->size;
> -	int ret = -ENOMEM;
> +	int ret;
>  	int i;
>  
>  	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
> @@ -330,28 +330,30 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	mutex_lock(&kvm->lock);
>  
>  	/* Check this LIOBN hasn't been previously allocated */
> -	ret = 0;
>  	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
>  		if (siter->liobn == args->liobn) {
>  			ret = -EBUSY;
> -			break;
> +			goto fail_unlock;
>  		}
>  	}
>  
> -	if (!ret)
> -		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> -				       stt, O_RDWR | O_CLOEXEC);
> +	kvm_get_kvm(kvm);
> +	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> +				stt, O_RDWR | O_CLOEXEC);
>  
> -	if (ret >= 0) {
> -		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> -		kvm_get_kvm(kvm);
> +	if (ret < 0) {
> +		kvm_put_kvm(kvm);
> +		goto fail_unlock;
>  	}
>  
> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> +
>  	mutex_unlock(&kvm->lock);
>  
> -	if (ret >= 0)
> -		return ret;
> +	return ret;
>  
> + fail_unlock:
> +	mutex_unlock(&kvm->lock);
>   fail:
>  	for (i = 0; i < npages; i++)
>  		if (stt->pages[i])
> 

-- 
Alexey
