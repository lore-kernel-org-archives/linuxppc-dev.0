Return-Path: <SRS0=H68/=JM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE03C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 19:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF4261152
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF4261152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FLpzv5x4wz3btb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 05:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CtwSi4up;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=CtwSi4up; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FLpzR6Q2nz2yRy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 05:18:43 +1000 (AEST)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6706420B8001;
 Thu, 15 Apr 2021 12:18:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6706420B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1618514320;
 bh=oyFzwjqkQUSMMuJGF+BPS7fDUWKbfKx4hV8I/ckQs5A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=CtwSi4uptCk042u834hYAeLfhdQdIUHrBndx6yJJXS16i0c0YTri5i4Y0vAHP0n0B
 mxZcAVjPsGATh47mM7jTp+caG+GuwTDJz+o4P8hFa2YbqkDdgVBjJVktpuV9zIvwGc
 6/tnQ9IckAa0xc4yOwSKZWxSDZ9XWjq64xkg8Rho=
Subject: Re: [PATCH] powerpc: Initialize local variable fdt to NULL in
 elf64_load()
To: robh@kernel.org, dan.carpenter@oracle.com
References: <20210415191437.20212-1-nramas@linux.microsoft.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4edb1433-4d1e-5719-ec9c-fd232b7cf71f@linux.microsoft.com>
Date: Thu, 15 Apr 2021 12:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415191437.20212-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 kbuild-all@lists.01.org, lkp@intel.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/15/21 12:14 PM, Lakshmi Ramasubramanian wrote:

Sorry - missed copying device-tree and powerpc mailing lists.

> There are a few "goto out;" statements before the local variable "fdt"
> is initialized through the call to of_kexec_alloc_and_setup_fdt() in
> elf64_load(). This will result in an uninitialized "fdt" being passed
> to kvfree() in this function if there is an error before the call to
> of_kexec_alloc_and_setup_fdt().
> 
> Initialize the local variable "fdt" to NULL.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   arch/powerpc/kexec/elf_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index 5a569bb51349..0051440c1f77 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -32,7 +32,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	int ret;
>   	unsigned long kernel_load_addr;
>   	unsigned long initrd_load_addr = 0, fdt_load_addr;
> -	void *fdt;
> +	void *fdt = NULL;
>   	const void *slave_code;
>   	struct elfhdr ehdr;
>   	char *modified_cmdline = NULL;
> 

thanks,
  -lakshmi
