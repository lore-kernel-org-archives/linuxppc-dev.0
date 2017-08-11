Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTDMn1ky4zDqrw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 15:39:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com,
 mhocko@kernel.org
Subject: Re: [RFC v7 02/25] powerpc: track allocation status of all pkeys
In-Reply-To: <8760dvkw58.fsf@linux.vnet.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
 <8760dvkw58.fsf@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 15:39:14 +1000
Message-ID: <87inhud5od.fsf@concordia.ellerman.id.au>
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
>>  static inline void pkey_initialize(void)
>>  {
>> +	int os_reserved, i;
>> +
>>  	/* disable the pkey system till everything
>>  	 * is in place. A patch further down the
>>  	 * line will enable it.
>>  	 */
>>  	pkey_inited = false;
>> +
>> +	/* Lets assume 32 keys */
>> +	pkeys_total = 32;
>> +
>> +#ifdef CONFIG_PPC_4K_PAGES
>> +	/*
>> +	 * the OS can manage only 8 pkeys
>> +	 * due to its inability to represent
>> +	 * them in the linux 4K-PTE.
>> +	 */
>> +	os_reserved = pkeys_total-8;
>> +#else
>> +	os_reserved = 0;
>> +#endif
>> +	/*
>> +	 * Bits are in LE format.
>> +	 * NOTE: 1, 0 are reserved.
>> +	 * key 0 is the default key, which allows read/write/execute.
>> +	 * key 1 is recommended not to be used.
>> +	 * PowerISA(3.0) page 1015, programming note.
>> +	 */
>> +	initial_allocation_mask = ~0x0;
>> +	for (i = 2; i < (pkeys_total - os_reserved); i++)
>> +		initial_allocation_mask &= ~(0x1<<i);
>>  }
>>  #endif /*_ASM_PPC64_PKEYS_H */
>
> In v6, key 31 was also reserved, but it's not in this version. Is this
> intentional?

That whole thing could be replaced with two constants.

Except it can't, because we can't just hard code the number of keys. It
needs to come either from the device tree or be based on the CPU we're
running on.

> Isn't it better for this function to be in pkeys.c? Ideally, functions
> should be in .c files not in headers unless they're very small or
> performance sensitive IMHO.

Yes. No reason for that to be in a header AFAICS.

cheers
