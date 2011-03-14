Return-Path: <swise@opengridcomputing.com>
Received: from smtp.opengridcomputing.com (smtp.opengridcomputing.com
	[209.198.142.2]) by ozlabs.org (Postfix) with ESMTP id B8E1DB6FA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 06:01:27 +1100 (EST)
Message-ID: <4D7E5FF9.3030702@opengridcomputing.com>
Date: Mon, 14 Mar 2011 13:35:37 -0500
From: Steve Wise <swise@opengridcomputing.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc: Add pgprot_writecombine
References: <20110301170047.601c83b7@kryten> <20110314183300.GA2932@us.ibm.com>
In-Reply-To: <20110314183300.GA2932@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
	swise@chelsio.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03/14/2011 01:33 PM, Nishanth Aravamudan wrote:
> On 01.03.2011 [17:00:47 +1100], Anton Blanchard wrote:
>> A number of drivers are using pgprot_writecombine() to enable write
>> combining on userspace mappings. Implement it on powerpc.
> Given this patch, should drivers/infiniband/hw/cxgb4/t4.h
>
> be updated?:
>

Yes.

> static inline pgprot_t t4_pgprot_wc(pgprot_t prot)
> {
> #if defined(__i386__) || defined(__x86_64__)
>          return pgprot_writecombine(prot);
> #elif defined(CONFIG_PPC64)
>          return __pgprot((pgprot_val(prot) | _PAGE_NO_CACHE)&
>                          ~(pgprot_t)_PAGE_GUARDED);
> #else
>          return pgprot_noncached(prot);
> #endif
> }
>
> Thanks,
> Nish
>
>> Signed-off-by: Anton Blanchard<anton@samba.org>
>> ---
>>
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 89f1587..88b0bd9 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -170,6 +170,7 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
>>   #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot)&  ~_PAGE_CACHE_CTL) | \
>>   				            _PAGE_COHERENT | _PAGE_WRITETHRU))
>>
>> +#define pgprot_writecombine pgprot_noncached_wc
>>
>>   struct file;
>>   extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
