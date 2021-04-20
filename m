Return-Path: <SRS0=xixs=JR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AECCC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 01:33:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC93D61221
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 01:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC93D61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPR6L26w4z30KJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 11:33:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=JkeWr15e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=JkeWr15e; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FPR5r1y2Hz2xZR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 11:33:20 +1000 (AEST)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1A67020B8001;
 Mon, 19 Apr 2021 18:33:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A67020B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1618882398;
 bh=JpKoSRIhjAwwrj5WZF4k0/uhpNQqdIHge3YUwLmCw6g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JkeWr15eHXH+BqGcoux3YBinokOR9h5F9IETVqdSFBIeEdR7I5TopOqEMzhyW0VYd
 NBMuute88WTB0RPx1kSYmCMVn08ilR/dfW0/6qGWeqVrmfbh7f3jVArxaLyFTbVwzL
 qDFx1kZiebGubjtQfEJghUyc4fx8RZ7NhnJLCYxI=
Subject: Re: [PATCH] powerpc: Initialize local variable fdt to NULL in
 elf64_load()
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>,
 robh@kernel.org, dan.carpenter@oracle.com
References: <20210415191437.20212-1-nramas@linux.microsoft.com>
 <4edb1433-4d1e-5719-ec9c-fd232b7cf71f@linux.microsoft.com>
 <87eefag241.fsf@linkitivity.dja.id.au> <87tuo6eh0j.fsf@mpe.ellerman.id.au>
 <2817d674-d420-580f-a0c1-b842da915a80@linux.microsoft.com>
 <87pmypdf93.fsf@mpe.ellerman.id.au>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7f5da2c7-13ff-237c-87ba-a456cbac2bca@linux.microsoft.com>
Date: Mon, 19 Apr 2021 18:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pmypdf93.fsf@mpe.ellerman.id.au>
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
 kbuild-all@lists.01.org, bauerman@linux.ibm.com, lkp@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/19/21 4:30 PM, Michael Ellerman wrote:
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
>> On 4/16/21 2:05 AM, Michael Ellerman wrote:
>>
>>> Daniel Axtens <dja@axtens.net> writes:
>>>>> On 4/15/21 12:14 PM, Lakshmi Ramasubramanian wrote:
>>>>>
>>>>> Sorry - missed copying device-tree and powerpc mailing lists.
>>>>>
>>>>>> There are a few "goto out;" statements before the local variable "fdt"
>>>>>> is initialized through the call to of_kexec_alloc_and_setup_fdt() in
>>>>>> elf64_load(). This will result in an uninitialized "fdt" being passed
>>>>>> to kvfree() in this function if there is an error before the call to
>>>>>> of_kexec_alloc_and_setup_fdt().
>>>>>>
>>>>>> Initialize the local variable "fdt" to NULL.
>>>>>>
>>>> I'm a huge fan of initialising local variables! But I'm struggling to
>>>> find the code path that will lead to an uninit fdt being returned...
>>>>
>>>> The out label reads in part:
>>>>
>>>> 	/* Make kimage_file_post_load_cleanup free the fdt buffer for us. */
>>>> 	return ret ? ERR_PTR(ret) : fdt;
>>>>
>>>> As far as I can tell, any time we get a non-zero ret, we're going to
>>>> return an error pointer rather than the uninitialised value...
>>
>> As Dan pointed out, the new code is in linux-next.
>>
>> I have copied the new one below - the function doesn't return fdt, but
>> instead sets it in the arch specific field (please see the link to the
>> updated elf_64.c below).
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/arch/powerpc/kexec/elf_64.c?h=for-next
>>
>>>>
>>>> (btw, it does look like we might leak fdt if we have an error after we
>>>> successfully kmalloc it.)
>>>>
>>>> Am I missing something? Can you link to the report for the kernel test
>>>> robot or from Dan?
>>
>> /*
>>            * Once FDT buffer has been successfully passed to
>> kexec_add_buffer(),
>>            * the FDT buffer address is saved in image->arch.fdt. In that
>> case,
>>            * the memory cannot be freed here in case of any other error.
>>            */
>>           if (ret && !image->arch.fdt)
>>                   kvfree(fdt);
>>
>>           return ret ? ERR_PTR(ret) : NULL;
>>
>> In case of an error, the memory allocated for fdt is freed unless it has
>> already been passed to kexec_add_buffer().
> 
> It feels like the root of the problem is that the kvfree of fdt is in
> the wrong place. It's only allocated later in the function, so the error
> path should reflect that. Something like the patch below.
> 
> cheers
> 
> 
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index 5a569bb51349..02662e72c53d 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -114,7 +114,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
>   				  initrd_len, cmdline);
>   	if (ret)
> -		goto out;
> +		goto out_free_fdt;
>   
>   	fdt_pack(fdt);
>   
> @@ -125,7 +125,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
>   	if (ret)
> -		goto out;
> +		goto out_free_fdt;
>   
>   	/* FDT will be freed in arch_kimage_file_post_load_cleanup */
>   	image->arch.fdt = fdt;
> @@ -140,18 +140,14 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	if (ret)
>   		pr_err("Error setting up the purgatory.\n");
>   
> +	goto out;
> +
> +out_free_fdt:
> +	kvfree(fdt);
>   out:
>   	kfree(modified_cmdline);
>   	kexec_free_elf_info(&elf_info);
>   
> -	/*
> -	 * Once FDT buffer has been successfully passed to kexec_add_buffer(),
> -	 * the FDT buffer address is saved in image->arch.fdt. In that case,
> -	 * the memory cannot be freed here in case of any other error.
> -	 */
> -	if (ret && !image->arch.fdt)
> -		kvfree(fdt);
> -
>   	return ret ? ERR_PTR(ret) : NULL;
>   }
>   
> 

This looks good to me. Thanks Michael.

I'll post the updated patch shortly.

  -lakshmi

