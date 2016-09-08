Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVF9H6qfDzDsVf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:17:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc/fadump: Make ELF eflags depend on endian
In-Reply-To: <2cc58c5b-9465-207d-60d8-f09dff6ca0c8@linux.vnet.ibm.com>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <1473139963-7496-4-git-send-email-dja@axtens.net>
 <2cc58c5b-9465-207d-60d8-f09dff6ca0c8@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2016 19:17:38 +1000
Message-ID: <87inu6lphp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 09/06/2016 11:02 AM, Daniel Axtens wrote:
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 0638b82ce294..457f08e544c6 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -779,7 +779,11 @@ static int fadump_init_elfcore_header(char *bufp)
>>  	elf->e_entry = 0;
>>  	elf->e_phoff = sizeof(struct elfhdr);
>>  	elf->e_shoff = 0;
>> -	elf->e_flags = ELF_CORE_EFLAGS;
>> +#ifdef __LITTLE_ENDIAN__
>
> Wouldn't '#ifdef PPC64_ELF_ABI_v2' be more appropriate here ?

Yes! I forgot we had added that and told Daniel to use LITTLE_ENDIAN.

I'll fix it up when I apply it.

cheers
