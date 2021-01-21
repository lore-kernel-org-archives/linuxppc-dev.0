Return-Path: <SRS0=iciS=GY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888BDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 22:39:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F5B21973
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 22:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F5B21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMHPn5nJ5zDrWY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 09:39:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=tyhicks@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=mv27Noc+; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM8fr6n8HzDrNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2021 04:35:09 +1100 (AEDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net
 [162.237.133.238])
 by linux.microsoft.com (Postfix) with ESMTPSA id 42F1420B7192;
 Thu, 21 Jan 2021 09:35:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42F1420B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1611250508;
 bh=a4cCNjrAKs4+vz3aERM9jzdT7vtf1mGZiPbZ15KjmZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mv27Noc+Ifs08rNXx4cDHhfoP90JPBkoo09HeG1CZZO8jknWGmb7GgjeaTSl0oYOi
 v3HioJmVc+b9IQ2c0zBLrpNuOpnG7lpfrEvvg3Jd1Mcmqnm8GrbZme1tiLNFkjyhp4
 jqvT18W+uz0o+3+iGcx6H049pKv3IpwIO+7B5P8A=
Date: Thu, 21 Jan 2021 11:35:05 -0600
From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH 1/2] ima: Free IMA measurement buffer on error
Message-ID: <20210121173505.GE259508@sequoia>
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121173003.18324-1-nramas@linux.microsoft.com>
X-Mailman-Approved-At: Fri, 22 Jan 2021 09:37:35 +1100
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
Cc: sashal@kernel.org, dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org,
 zohar@linux.ibm.com, ebiederm@xmission.com, gregkh@linuxfoundation.org,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2021-01-21 09:30:02, Lakshmi Ramasubramanian wrote:
> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  In error code paths this memory
> is not freed resulting in memory leak.
> 
> Free the memory allocated for the IMA measurement list in
> the error code paths in ima_add_kexec_buffer() function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  security/integrity/ima/ima_kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..212145008a01 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -119,12 +119,14 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}
>  
>  	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}
>  
> -- 
> 2.30.0
> 
