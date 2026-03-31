Return-Path: <linuxppc-dev+bounces-19051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FBDFF60CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 07:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flK7Z6Zhfz2ybR;
	Tue, 31 Mar 2026 18:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774941146;
	cv=none; b=bKh25uKKavIfjvYiQAX7u23pljBv4p0BBXI5t1/wrCAojd6U0WFRyxv5nqI6SGhGSvYpv5rkOAUhLZ1qo5JjnEc28rGCuuUGyKtKo1Q/7UvixdPNdSEIGVGGhhLoRZvHOtvLMvWtW1+GQ0/EiaO/0R+NtiPP5CQlpbPlgFCjtTJ7cEH8XbBVAS9GJloX5wW8WQqa2QYqETmSgxRd5h7JmcJZC6eub7FYtzoafRSy3K2q3ikacDpl4ibOldqpfrOQbZL38O2hZwmdkTAnIIribFw4IxW2ga9o0SYbX9OKEMCP9D1vD9zyTiBxMIKEOh3H2AemX4mnwkOq25Tcyu1HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774941146; c=relaxed/relaxed;
	bh=3iP2TPj18aJwm64GDb8cezFyvgyCXdusMq4tD0QwQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aDoy/ZNV1fLluYFj7Q8T+FVCiTl0EiCjfLYrxS8TK00YAGeqgjeioal2uJ82y6Fi6c8RTDqnsywsda+mn3zzuY4fVmHLTzgRKSxEin99bA6Qy9QAp1oI5L7lxgoGsHVqSohzyZAW7euHfzOCzmijhTbtMkvFZnhuT1zPnlTY9u5UkiZr31KC3NT3hsK7rFLTFoZYjrZ8NjVeFjXofSj8atRDGCmjhZ+fmsdLLbRg3TsvrXRIOV9LlkUnZySnk2opQpdOLUE60zgnzcUaS89GR4cqMQ++XpKmajtkqHXJiz3rwLXECyPfu1GXS0gUqiuqJZh10816tsOtd7+aMApjjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ExUT8FJp; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7k4XU1z; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ExUT8FJp;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7k4XU1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flK7Y1svSz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 18:12:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iP2TPj18aJwm64GDb8cezFyvgyCXdusMq4tD0QwQd0=;
	b=ExUT8FJpXBQsi20FJWe5JzMxBzeKDoqSZNNpdbjNlw1WeelXwMNz2pxp+TP47eYOjSAFbM
	U2vNmwvvnAsQEX04mf7Qu35HV7LHw7cf8diEShWuYw9zSxvBJhJdGPETC85KmUOpw4FxBb
	iQPu+/uVu1p2jahh+BZsOlGWTOJe93w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iP2TPj18aJwm64GDb8cezFyvgyCXdusMq4tD0QwQd0=;
	b=N7k4XU1zG4Rp5QlQG7A7LFixgRfoS/BhzNiv8iFdka2Uam3/evLxI4EH5RcW4FaEbF1Ka9
	b/9LH6KTthcHfFaRm9g/AR2m/y6V9XlEM8dH3R9C4EnP2WEbPZdr4g2anIFgMUFtpepvlG
	YECRVlnqcJ7PHme3AGOTDNmCIXaT5Q8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-0gCAyxwHPt-8xrYN4V4r-w-1; Tue,
 31 Mar 2026 03:12:16 -0400
X-MC-Unique: 0gCAyxwHPt-8xrYN4V4r-w-1
X-Mimecast-MFC-AGG-ID: 0gCAyxwHPt-8xrYN4V4r-w_1774941134
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 412801800464;
	Tue, 31 Mar 2026 07:12:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.177])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D95081800107;
	Tue, 31 Mar 2026 07:12:09 +0000 (UTC)
Date: Tue, 31 Mar 2026 15:12:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] crash_dump/dm-crypt: Don't print in arch-specific
 code
Message-ID: <actzxO1p6OlmK2gp@fedora>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-2-coxu@redhat.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260225060347.718905-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: gDeSSBRx2L8rfWKTY5u94hQot3wMlDRFbANPuEmrP0Y_1774941134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 02/25/26 at 02:03pm, Coiby Xu wrote:
> When the vmcore dumping target is not a LUKS-encrypted target, it's
> expected that there is no dm-crypt key thus no need to return -ENOENT.
> Also print more logs in crash_load_dm_crypt_keys. The benefit is
> arch-specific code can be more succinct.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 6 +-----
>  kernel/crash_dump_dm_crypt.c      | 7 +++++--
>  2 files changed, 6 insertions(+), 7 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 5630c7dca1f3..7e980ea49d8d 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -525,12 +525,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		if (ret)
>  			return ERR_PTR(ret);
>  		ret = crash_load_dm_crypt_keys(image);
> -		if (ret == -ENOENT) {
> -			kexec_dprintk("No dm crypt key to load\n");
> -		} else if (ret) {
> -			pr_err("Failed to load dm crypt keys\n");
> +		if (ret)
>  			return ERR_PTR(ret);
> -		}
>  		if (image->dm_crypt_keys_addr &&
>  		    cmdline_len + MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN >
>  			    header->cmdline_size) {
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 1f4067fbdb94..2f7b42b09673 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -414,14 +414,16 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  
>  	if (key_count <= 0) {
>  		kexec_dprintk("No dm-crypt keys\n");
> -		return -ENOENT;
> +		return 0;
>  	}
>  
>  	if (!is_dm_key_reused) {
>  		image->dm_crypt_keys_addr = 0;
>  		r = build_keys_header();
> -		if (r)
> +		if (r) {
> +			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
>  			return r;
> +		}
>  	}
>  
>  	kbuf.buffer = keys_header;
> @@ -432,6 +434,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	r = kexec_add_buffer(&kbuf);
>  	if (r) {
> +		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>  		kvfree((void *)kbuf.buffer);
>  		return r;
>  	}
> -- 
> 2.53.0
> 


