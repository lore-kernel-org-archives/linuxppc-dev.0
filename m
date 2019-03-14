Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:24:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3BB21019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3BB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KrYq6KFvzDqPc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 01:24:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.210.193; helo=mail-pf1-f193.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KrWz6MfKzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 01:22:38 +1100 (AEDT)
Received: by mail-pf1-f193.google.com with SMTP id n125so3940636pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=POuKTkkOp6hpixOyLDOSStCD0dO0pbIsQZmjw5z0GA0=;
 b=KVes4GzyHdWouACFWeFDfPbkhN9ugj9IGRcVIcGy0a0vyZl2wDKUssiHRgOF4R4d3v
 13zRaTWnmi533nx8Sk65hmhIj8Kto1mpUBr/K0VbdfeN2TwvD9H3y/VkHgUNLiw1VjBA
 OiUqX2b7RMUHuQLxFAOZNUgQsEyn55DTvu1LmSYO5nVPuJ+c104+d1pxoey4iVbyPQ+K
 SEK2MYJK79WCDJdegBDV+x1U0xs5Ustwq6TdrBSY0bzGm/O+xmjN8Wv2LvQyHs0/m07t
 WDi0di1nBpHAteoadPLXGOg7NlFZ8kRsXnhfzRqA5rGsHnfz3eBVVJ2Ruq+Z20reKESq
 6ipQ==
X-Gm-Message-State: APjAAAXNzOmbzJk1x6cQv6oRk7FJkSwzezLz61RXka80bIKXPAfDiLAg
 YTs3x/zsABCgeZipY9IN/u03fA==
X-Google-Smtp-Source: APXvYqzqkNXgmj9z2vZwc+Uhr8GESRGGe/Ikis+IAXgJdivIUvGI9O9nWRKw5QEAQJ5FF7xHmYeR9w==
X-Received: by 2002:a63:da43:: with SMTP id l3mr45865521pgj.164.1552573355724; 
 Thu, 14 Mar 2019 07:22:35 -0700 (PDT)
Received: from localhost.localdomain ([106.215.118.61])
 by smtp.gmail.com with ESMTPSA id f65sm23771178pff.21.2019.03.14.07.22.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Mar 2019 07:22:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <6dac3aec-3f18-de67-f620-aed063986a17@redhat.com>
Date: Thu, 14 Mar 2019 19:52:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 James Morse <james.morse@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Kazu,

On 03/13/2019 01:17 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
>> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
>> supported by underlying kernel.
>>
>> This value is used in user-space code to calculate the bit-space
>> required to store a section for SPARESMEM (similar to the existing
>> calculation method used in the kernel implementation):
>>
>>    #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
>>
>> Now, regressions have been reported in user-space utilities
>> like 'makedumpfile' and 'crash' on arm64, with the recently added
>> kernel support for 52-bit physical address space, as there is
>> no clear method of determining this value in user-space
>> (other than reading kernel CONFIG flags).
>>
>> As per suggestion from makedumpfile maintainer (Kazu), it makes more
>> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
>> rather than in arch-specific code, so that the user-space code for other
>> archs can also benefit from this addition to the vmcoreinfo and use it
>> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
>>
>> A reference 'makedumpfile' implementation which reads the
>> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
>> is available here:
>>
>> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471
>>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   kernel/crash_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 093c9f917ed0..44b90368e183 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>>   	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>>   #endif
>> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> 
> Some architectures define MAX_PHYSMEM_BITS only with CONFIG_SPARSEMEM,
> so we need to move this to the #ifdef section that exports some
> mem_section things.
> 
> Thanks!
> Kazu

Sorry for the late response, I wanted to make sure I check almost all  
archs to understand if a proposal would work for all.

As per my current understanding, we can protect the export of  
'MAX_PHYSMEM_BITS' via a #ifdef section against CONFIG_SPARSEMEM, and it  
should work for all archs. Here are some arguments to support the same,  
would request maintainers of various archs (in Cc) to correct me if I am  
missing something here:

1. SPARSEMEM is dependent upon on (!SELECT_MEMORY_MODEL &&  
ARCH_SPARSEMEM_ENABLE) || SPARSEMEM_MANUAL:

config SPARSEMEM
	def_bool y
	depends on (!SELECT_MEMORY_MODEL && ARCH_SPARSEMEM_ENABLE) ||  
SPARSEMEM_MANUAL

2. For a couple of archs, this option is already turned on by default in  
their respective defconfigs:

$ grep -nrw "CONFIG_SPARSEMEM_MANUAL" *
arch/ia64/configs/gensparse_defconfig:18:CONFIG_SPARSEMEM_MANUAL=y
arch/powerpc/configs/ppc64e_defconfig:30:CONFIG_SPARSEMEM_MANUAL=y

3. Note that other archs use ARCH_SPARSEMEM_DEFAULT to define if  
CONFIG_SPARSEMEM_MANUAL is set by default:

choice
	prompt "Memory model"
         ..
	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT

3a.

$ grep -nrw -A 2 "ARCH_SPARSEMEM_DEFAULT" *
arch/s390/Kconfig:621:config ARCH_SPARSEMEM_DEFAULT
arch/s390/Kconfig-622-	def_bool y
--
arch/x86/Kconfig:1623:config ARCH_SPARSEMEM_DEFAULT
arch/x86/Kconfig-1624-	def_bool y
arch/x86/Kconfig-1625-	depends on X86_64
--
arch/powerpc/Kconfig:614:config ARCH_SPARSEMEM_DEFAULT
arch/powerpc/Kconfig-615-	def_bool y
arch/powerpc/Kconfig-616-	depends on PPC_BOOK3S_64
--
arch/arm64/Kconfig:850:config ARCH_SPARSEMEM_DEFAULT
arch/arm64/Kconfig-851-	def_bool ARCH_SPARSEMEM_ENABLE
--
arch/sh/mm/Kconfig:138:config ARCH_SPARSEMEM_DEFAULT
arch/sh/mm/Kconfig-139-	def_bool y
--
arch/sparc/Kconfig:315:config ARCH_SPARSEMEM_DEFAULT
arch/sparc/Kconfig-316-	def_bool y if SPARC64
--
arch/arm/Kconfig:1591:config ARCH_SPARSEMEM_DEFAULT
arch/arm/Kconfig-1592-	def_bool ARCH_SPARSEMEM_ENABLE

Since most archs (except MIPS) set  
CONFIG_ARCH_SPARSEMEM_DEFAULT/CONFIG_ARCH_SPARSEMEM_ENABLE to y in the  
default configurations, so even though they don't protect  
'MAX_PHYSMEM_BITS' define in CONFIG_SPARSEMEM ifdef sections, we still  
would be ok protecting the 'MAX_PHYSMEM_BITS' vmcoreinfo export inside a  
CONFIG_SPARSEMEM ifdef section.

Thanks for your inputs, I will include this change in the v3.

Regards,
Bhupesh
