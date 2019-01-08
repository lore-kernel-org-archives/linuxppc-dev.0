Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C481C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:13:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926CE20883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926CE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z4kP4rKhzDqc7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:13:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z4hC3fcRzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 08:11:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Z4h75NkPz9v0Vv;
 Tue,  8 Jan 2019 22:11:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WAb5xZwDqBye; Tue,  8 Jan 2019 22:11:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Z4h74hYBz9v0Vt;
 Tue,  8 Jan 2019 22:11:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C7D748B844;
 Tue,  8 Jan 2019 22:11:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uCOIc08gOkAF; Tue,  8 Jan 2019 22:11:51 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 452628B7DF;
 Tue,  8 Jan 2019 22:11:51 +0100 (CET)
Subject: Re: [PATCH v2 1/2] mm: add probe_user_read()
To: Andrew Morton <akpm@linux-foundation.org>
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <20190108114803.583f203b86d4a368ac9796f3@linux-foundation.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <19c99d33-b796-72df-4212-20255f84efa0@c-s.fr>
Date: Tue, 8 Jan 2019 22:11:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190108114803.583f203b86d4a368ac9796f3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/01/2019 à 20:48, Andrew Morton a écrit :
> On Tue,  8 Jan 2019 07:37:44 +0000 (UTC) Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> In powerpc code, there are several places implementing safe
>> access to user data. This is sometimes implemented using
>> probe_kernel_address() with additional access_ok() verification,
>> sometimes with get_user() enclosed in a pagefault_disable()/enable()
>> pair, etc. :
>>      show_user_instructions()
>>      bad_stack_expansion()
>>      p9_hmi_special_emu()
>>      fsl_pci_mcheck_exception()
>>      read_user_stack_64()
>>      read_user_stack_32() on PPC64
>>      read_user_stack_32() on PPC32
>>      power_pmu_bhrb_to()
>>
>> In the same spirit as probe_kernel_read(), this patch adds
>> probe_user_read().
>>
>> probe_user_read() does the same as probe_kernel_read() but
>> first checks that it is really a user address.
>>
>> ...
>>
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>>   #define probe_kernel_address(addr, retval)		\
>>   	probe_kernel_read(&retval, addr, sizeof(retval))
>>   
>> +/**
>> + * probe_user_read(): safely attempt to read from a user location
>> + * @dst: pointer to the buffer that shall take the data
>> + * @src: address to read from
>> + * @size: size of the data chunk
>> + *
>> + * Returns: 0 on success, -EFAULT on error.
>> + *
>> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
>> + * happens, handle that and return -EFAULT.
>> + *
>> + * We ensure that the copy_from_user is executed in atomic context so that
>> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
>> + * probe_user_read() suitable for use within regions where the caller
>> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
>> + */
>> +
>> +#ifndef probe_user_read
>> +static __always_inline long probe_user_read(void *dst, const void __user *src,
>> +					    size_t size)
>> +{
>> +	long ret;
>> +
>> +	if (!access_ok(src, size))
>> +		return -EFAULT;
>> +
>> +	pagefault_disable();
>> +	ret = __copy_from_user_inatomic(dst, src, size);
>> +	pagefault_enable();
>> +
>> +	return ret ? -EFAULT : 0;
>> +}
>> +#endif
> 
> Why was the __always_inline needed?
> 
> This function is pretty large.  Why is it inlined?
> 

Kees told to do that way, see https://patchwork.ozlabs.org/patch/986848/

Christophe
