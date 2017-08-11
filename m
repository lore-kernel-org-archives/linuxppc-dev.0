Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTFbJ0yNJzDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:34:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com,
 mhocko@kernel.org
Subject: Re: [RFC v7 09/25] powerpc: store and restore the pkey state across
 context switches
In-Reply-To: <874ltfkv64.fsf@linux.vnet.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-10-git-send-email-linuxram@us.ibm.com>
 <874ltfkv64.fsf@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 16:34:19 +1000
Message-ID: <87fucyd34k.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Ram Pai <linuxram@us.ibm.com> writes:
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/hw_breakpoint.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/elf-randomize.h>
>> +#include <linux/pkeys.h>
>>
>>  #include <asm/pgtable.h>
>>  #include <asm/io.h>
>> @@ -1096,6 +1097,13 @@ static inline void save_sprs(struct thread_struct *t)
>>  		t->tar = mfspr(SPRN_TAR);
>>  	}
>>  #endif
>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> +	if (arch_pkeys_enabled()) {
>> +		t->amr = mfspr(SPRN_AMR);
>> +		t->iamr = mfspr(SPRN_IAMR);
>> +		t->uamor = mfspr(SPRN_UAMOR);
>> +	}
>> +#endif
>>  }
>
> Is it worth having a flag in thread_struct saying whether it has every
> called pkey_alloc and only do the mfsprs if it did?

Yes, in fact there's a programming note in the UAMOR section of the arch
that says exactly that.

On the write side you have to be a bit more careful. You have to make
sure you set the UAMOR to 0 when you're switching from a process that
has used keys to one that isn't.

cheers
