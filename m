Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:59:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0C361439
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0C361439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQMcF1lztz30Gj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QkbDRwQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=QkbDRwQS; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FQMbm36FMz2xZS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:58:59 +1000 (AEST)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id B0CC720B8001;
 Wed, 21 Apr 2021 06:58:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0CC720B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1619013537;
 bh=m/kK3hlA5gjTlmfPwq8+rli37UA5JEYnAZZ4rdCLBsU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QkbDRwQS19YcuVzqMsWNIFqyU3/MHfOTDxmIb5o8XtK/UmWfdKYxCbZ32j3Wxq0oR
 t7uR8hYLemQjyvQwkq+loCQiD8ZNZTIQTUDeXFTq3BikbxZtEGUJiVoD5z2reBzFmM
 5dcUkJxxOoA6BL/Bjkd59lghVvyLTYIbJc/j/2qc=
Subject: Re: [PATCH 1/2] powerpc: Free fdt on error in elf64_load()
To: Santosh Sivaraj <santosh@fossix.org>, robh@kernel.org,
 dan.carpenter@oracle.com, mpe@ellerman.id.au
References: <20210420190355.10059-1-nramas@linux.microsoft.com>
 <871rb4yzca.fsf@fossix.org>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <407a9f66-8f91-9c6e-9653-738ba79a97b2@linux.microsoft.com>
Date: Wed, 21 Apr 2021 06:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rb4yzca.fsf@fossix.org>
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
Cc: devicetree@vger.kernel.org, kbuild-all@lists.01.org, lkp@intel.com,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/20/21 10:35 PM, Santosh Sivaraj wrote:
Hi Santosh,

> 
>> There are a few "goto out;" statements before the local variable "fdt"
>> is initialized through the call to of_kexec_alloc_and_setup_fdt() in
>> elf64_load().  This will result in an uninitialized "fdt" being passed
>> to kvfree() in this function if there is an error before the call to
>> of_kexec_alloc_and_setup_fdt().
>>
>> If there is any error after fdt is allocated, but before it is
>> saved in the arch specific kimage struct, free the fdt.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   arch/powerpc/kexec/elf_64.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index 5a569bb51349..02662e72c53d 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -114,7 +114,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>   	ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
>>   				  initrd_len, cmdline);
>>   	if (ret)
>> -		goto out;
>> +		goto out_free_fdt;
> 
> Shouldn't there be a goto out_free_fdt if fdt_open_into fails?

You are likely looking at elf_64.c in the mainline branch. The patch I 
have submitted is based on Rob's device-tree for-next branch. Please see 
the link below:

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/arch/powerpc/kexec/elf_64.c?h=for-next

> 
>>   
>>   	fdt_pack(fdt);
>>   
>> @@ -125,7 +125,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret)
>> -		goto out;
>> +		goto out_free_fdt;
>>   
>>   	/* FDT will be freed in arch_kimage_file_post_load_cleanup */
>>   	image->arch.fdt = fdt;
>> @@ -140,18 +140,14 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>   	if (ret)
>>   		pr_err("Error setting up the purgatory.\n");
>>   
>> +	goto out;
>> +
>> +out_free_fdt:
>> +	kvfree(fdt);
> 
> Can just use kfree here?
"fdt" is allocated through kvmalloc(). So it is freed using kvfree.

thanks,
  -lakshmi

>>   out:
>>   	kfree(modified_cmdline);
>>   	kexec_free_elf_info(&elf_info);
>>   
>> -	/*
>> -	 * Once FDT buffer has been successfully passed to kexec_add_buffer(),
>> -	 * the FDT buffer address is saved in image->arch.fdt. In that case,
>> -	 * the memory cannot be freed here in case of any other error.
>> -	 */
>> -	if (ret && !image->arch.fdt)
>> -		kvfree(fdt);
>> -
>>   	return ret ? ERR_PTR(ret) : NULL;
>>   }
>>   
>> -- 
>> 2.31.0

