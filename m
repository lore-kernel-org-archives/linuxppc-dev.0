Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7179BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 18:06:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC74764DB1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 18:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC74764DB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbSP44MPnzDscy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 05:06:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=iLPpwBjL; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DbSH80mJ8zDspc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2021 05:00:52 +1100 (AEDT)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id A95AE2078945;
 Wed, 10 Feb 2021 10:00:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A95AE2078945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1612980050;
 bh=R9xpAEULLlRloLEZ3aDp0NwjBNcG/EJw+NYFrjbxovk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=iLPpwBjLdWwIRAhzbc9LVKfkXHca9jl+5BYxYtIL/Nw2utUjaWoz3J/q4Khaingxp
 9g+ioSTJJfSpxELua3hENK89gsOkGTSQniJuV52oPiEB0xSN23m+EYsm2a7+KTq4dr
 1Fl6I+Swrn54OePYZFnQpIO72FEz7BkMY+hiVBu0=
Subject: Re: [PATCH v17 05/10] powerpc: Move ima buffer fields to struct kimage
To: Rob Herring <robh@kernel.org>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-6-nramas@linux.microsoft.com>
 <20210210172018.GA2361245@robh.at.kernel.org>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a508a7b9-ce90-a68a-8b07-7fc65052d98a@linux.microsoft.com>
Date: Wed, 10 Feb 2021 10:00:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210172018.GA2361245@robh.at.kernel.org>
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, zohar@linux.ibm.com,
 paulus@samba.org, vincenzo.frascino@arm.com, frowand.list@gmail.com,
 sashal@kernel.org, masahiroy@kernel.org, jmorris@namei.org,
 takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, serge@hallyn.com, devicetree@vger.kernel.org,
 pasha.tatashin@soleen.com, will@kernel.org, prsriva@linux.microsoft.com,
 hsinyi@chromium.org, allison@lohutok.net, christophe.leroy@c-s.fr,
 mbrugger@suse.com, balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, gregkh@linuxfoundation.org,
 joe@perches.com, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/10/21 9:20 AM, Rob Herring wrote:
> On Tue, Feb 09, 2021 at 10:21:55AM -0800, Lakshmi Ramasubramanian wrote:
>> The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
>> for powerpc are used to carry forward the IMA measurement list across
>> kexec system call.  These fields are not architecture specific, but are
>> currently limited to powerpc.
>>
>> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
>> sets ima_buffer_addr and ima_buffer_size for the kexec system call.
>> This function does not have architecture specific code, but is
>> currently limited to powerpc.
>>
>> Move ima_buffer_addr and ima_buffer_size to "struct kimage".
>> Rename arch_ima_add_kexec_buffer() to of_ima_add_kexec_buffer()
>> and move it in drivers/of/kexec.c.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Will Deacon <will@kernel.org>
>> ---
>>   arch/powerpc/include/asm/ima.h     |  3 ---
>>   arch/powerpc/include/asm/kexec.h   |  5 -----
>>   arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
>>   drivers/of/kexec.c                 | 23 +++++++++++++++++++++++
>>   include/linux/kexec.h              |  3 +++
>>   include/linux/of.h                 |  5 +++++
>>   security/integrity/ima/ima_kexec.c |  3 ++-
>>   7 files changed, 39 insertions(+), 32 deletions(-)

>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 469e09613cdd..9f33d215b9f2 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -63,6 +63,29 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
>>   	return -ENOENT;
>>   }
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +/**
>> + * of_ima_add_kexec_buffer - Add IMA buffer for next kernel
>> + *
>> + * @image: kimage struct to set IMA buffer data
>> + * @load_addr: Starting address where IMA buffer is loaded at
>> + * @size: Number of bytes in the IMA buffer
>> + *
>> + * Use this function to pass on the IMA buffer information to
>> + * the next kernel across kexec system call.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +int of_ima_add_kexec_buffer(struct kimage *image,
>> +			    unsigned long load_addr, size_t size)
>> +{
>> +	image->ima_buffer_addr = load_addr;
>> +	image->ima_buffer_size = size;
>> +
> 
> There's nothing DT specific about this function, so this is the wrong
> place for it. I would just remove it and directly set the members.

Will do.

  -lakshmi


