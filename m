Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD83V1C1czDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 17:39:33 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R7ck95102210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 03:39:20 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a39dneru0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 03:39:20 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 17:39:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R7d7Sj4129126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 17:39:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R7cgna001597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 17:38:42 +1000
Subject: Re: [PATCH v4 2/3] powerpc/fadump: Use the correct
 VMCOREINFO_NOTE_SIZE for phdr
To: Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>
References: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
 <1492688374-27903-2-git-send-email-xlpang@redhat.com>
 <20170426071114.GC5381@dhcp-128-65.nay.redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 13:08:24 +0530
MIME-Version: 1.0
In-Reply-To: <20170426071114.GC5381@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8a4b3bcc-466c-4f8c-c813-c57a600bf038@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2017 12:41 PM, Dave Young wrote:
> Ccing ppc list
> On 04/20/17 at 07:39pm, Xunlei Pang wrote:
>> vmcoreinfo_max_size stands for the vmcoreinfo_data, the
>> correct one we should use is vmcoreinfo_note whose total
>> size is VMCOREINFO_NOTE_SIZE.
>>
>> Like explained in commit 77019967f06b ("kdump: fix exported
>> size of vmcoreinfo note"), it should not affect the actual
>> function, but we better fix it, also this change should be
>> safe and backward compatible.
>>
>> After this, we can get rid of variable vmcoreinfo_max_size,
>> let's use the corresponding macros directly, fewer variables
>> means more safety for vmcoreinfo operation.
>>
>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

>> ---
>> v3->v4:
>> -Rebased on the latest linux-next
>>
>>  arch/powerpc/kernel/fadump.c | 3 +--
>>  include/linux/crash_core.h   | 1 -
>>  kernel/crash_core.c          | 3 +--
>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 466569e..7bd6cd0 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -893,8 +893,7 @@ static int fadump_create_elfcore_headers(char *bufp)
>>  
>>  	phdr->p_paddr	= fadump_relocate(paddr_vmcoreinfo_note());
>>  	phdr->p_offset	= phdr->p_paddr;
>> -	phdr->p_memsz	= vmcoreinfo_max_size;
>> -	phdr->p_filesz	= vmcoreinfo_max_size;
>> +	phdr->p_memsz	= phdr->p_filesz = VMCOREINFO_NOTE_SIZE;
>>  
>>  	/* Increment number of program headers. */
>>  	(elf->e_phnum)++;
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index ba283a2..7d6bc7b 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -55,7 +55,6 @@
>>  
>>  extern u32 *vmcoreinfo_note;
>>  extern size_t vmcoreinfo_size;
>> -extern size_t vmcoreinfo_max_size;
>>  
>>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>>  			  void *data, size_t data_len);
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 0321f04..43cdb00 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -16,7 +16,6 @@
>>  /* vmcoreinfo stuff */
>>  static unsigned char *vmcoreinfo_data;
>>  size_t vmcoreinfo_size;
>> -size_t vmcoreinfo_max_size = VMCOREINFO_BYTES;
>>  u32 *vmcoreinfo_note;
>>  
>>  /*
>> @@ -343,7 +342,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>>  	r = vscnprintf(buf, sizeof(buf), fmt, args);
>>  	va_end(args);
>>  
>> -	r = min(r, vmcoreinfo_max_size - vmcoreinfo_size);
>> +	r = min(r, VMCOREINFO_BYTES - vmcoreinfo_size);
>>  
>>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>>  
>> -- 
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> Reviewed-by: Dave Young <dyoung@redhat.com>
> 
> Thanks
> Dave
> 
