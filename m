Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C07C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:02:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE1B64DD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 04:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE1B64DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DR6Hl1kD1zDqD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 15:02:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=XjFkrXhH; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DR6Ff5LKYzDrBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 15:00:37 +1100 (AEDT)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 68AA620B7192;
 Wed, 27 Jan 2021 20:00:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68AA620B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1611806436;
 bh=j2ytaqRDLSxdVnbORmC1VmYaP/7+dbpAQywJI7b00gU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XjFkrXhHnyR53rne7WHNJDhhws91IZ+fiKsrlIcQYw4OfuqWziuNTJejFWJTYWfsT
 ReANiquNaEdr2UmAt9OkF/LasShgVDZT0lsMWLATFdmIKswUBTiXWvyfHyzINMiQoG
 QWAg7xvg2QTc/vkCRwtttTKCyBKFBTiHrO28Yypo=
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Will Deacon <will@kernel.org>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
 <871re5soof.fsf@manicouagan.localdomain>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <58d3ffbf-4d80-c893-34d6-366ebfac55bd@linux.microsoft.com>
Date: Wed, 27 Jan 2021 20:00:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871re5soof.fsf@manicouagan.localdomain>
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
Cc: mark.rutland@arm.com, bhsharma@redhat.com, tao.li@vivo.com,
 zohar@linux.ibm.com, paulus@samba.org, vincenzo.frascino@arm.com,
 frowand.list@gmail.com, sashal@kernel.org, robh@kernel.org,
 masahiroy@kernel.org, jmorris@namei.org, takahiro.akashi@linaro.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 serge@hallyn.com, devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org, allison@lohutok.net,
 christophe.leroy@c-s.fr, mbrugger@suse.com, balajib@linux.microsoft.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, james.morse@arm.com,
 dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/27/21 7:52 PM, Thiago Jung Bauermann wrote:
> 
> Will Deacon <will@kernel.org> writes:
> 
>> On Wed, Jan 27, 2021 at 09:59:38AM -0800, Lakshmi Ramasubramanian wrote:
>>> On 1/27/21 8:52 AM, Will Deacon wrote:
>>>
>>> Hi Will,
>>>
>>>> On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
>>>>> create_dtb() function allocates kernel virtual memory for
>>>>> the device tree blob (DTB).  This is not consistent with other
>>>>> architectures, such as powerpc, which calls kmalloc() for allocating
>>>>> memory for the DTB.
>>>>>
>>>>> Call kmalloc() to allocate memory for the DTB, and kfree() to free
>>>>> the allocated memory.
>>>>>
>>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>>> ---
>>>>>    arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>>>> index 7de9c47dee7c..51c40143d6fa 100644
>>>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>>>> @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>>>>>    int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>>>>    {
>>>>> -	vfree(image->arch.dtb);
>>>>> +	kfree(image->arch.dtb);
>>>>>    	image->arch.dtb = NULL;
>>>>>    	vfree(image->arch.elf_headers);
>>>>> @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>>>>>    			+ cmdline_len + DTB_EXTRA_SPACE;
>>>>>    	for (;;) {
>>>>> -		buf = vmalloc(buf_size);
>>>>> +		buf = kmalloc(buf_size, GFP_KERNEL);
>>>>
>>>> Is there a functional need for this patch? I build the 'dtbs' target just
>>>> now and sdm845-db845c.dtb is approaching 100K, which feels quite large
>>>> for kmalloc().
>>>
>>> Changing the allocation from vmalloc() to kmalloc() would help us further
>>> consolidate the DTB setup code for powerpc and arm64.
>>
>> Ok, but at the risk of allocation failure. Can powerpc use vmalloc()
>> instead?
> 
> I believe this patch stems from this suggestion by Rob Herring:
> 
>> This could be taken a step further and do the allocation of the new
>> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
>> arm64 version also retries with a bigger allocation. That seems
>> unnecessary.
> 
> in https://lore.kernel.org/linux-integrity/20201211221006.1052453-3-robh@kernel.org/
> 
> The problem is that this patch implements only part of the suggestion,
> which isn't useful in itself. So the patch series should either drop
> this patch or consolidate the FDT allocation between the arches.
> 
> I just tested on powernv and pseries platforms and powerpc can use
> vmalloc for the FDT buffer.
> 

Thanks for verifying on powerpc platform Thiago.

I'll update the patch to do the following:

=> Use vmalloc for FDT buffer allocation on powerpc
=> Keep vmalloc for arm64, but remove the retry on allocation.
=> Also, there was a memory leak of FDT buffer in the error code path on 
arm64, which I'll fix as well.

Did I miss anything?

thanks,
  -lakshmi
