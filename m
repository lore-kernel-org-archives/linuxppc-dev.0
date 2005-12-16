Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E4BCE688D6
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 08:22:40 +1100 (EST)
In-Reply-To: <E9EFF872-D403-437F-9B73-595D10BD71AF@kernel.crashing.org>
References: <Pine.LNX.4.61.0512151953550.14329@ld0175-tx32.am.freescale.net>
	<E9EFF872-D403-437F-9B73-595D10BD71AF@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C875D9FB-AA2A-4036-A132-547673071807@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Fri, 16 Dec 2005 15:22:42 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] G4+ oprofile support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2005, at 21:42, Kumar Gala wrote:


>
> Why hard code this, num_ctrs is passed in?

It's passed in, true, but only because that's the common interface.   
There is no 7450 derivative with less than or greater than 6  
counters.  I made it a constant to avoid the use (in the other  
models) of a global variable.  If you look at the next function down,  
it doesn't get num_ctrs passed in, but needs to loop, anyway.  And  
there's another function which needs it, too.


>
> Does, classic include ppc64? if so you should be more explicit in  
> the comment.

ppc64 and ppc32.  All non-Freescale-book-e parts.  Would:

Classic PPC parts (both 64 and 32 bit) don't support per-counter user/ 
kernel selection

be better?

>
>> +	/* Classic doesn't support per-counter user/kernel selection */
>>  	unsigned long kernel;
>> -#ifdef __powerpc64__
>> -	/* We dont support per counter user/kernel selection */
>> -#endif
>>  	unsigned long user;
>>  	unsigned long unit_mask;
>>  };
>>



>
> Are these ifdef's really worth it?


I don't really like them, but the alternative is to define SPRN_PMC 
[7,8] for PPC 32, which would be bogus, since PPC 32 doesn't have  
them.  If both architectures used the same SPR numbers, that wouldn't  
be an issue, but they don't, so I would have to make up the SPR numbers.


>
>> +
>> +/* No PPC32 chip has more than 6 so far */
>> +#ifdef CONFIG_PPC64
>>  	case 6:
>>  		return mfspr(SPRN_PMC7);
>>  	case 7:
>>  		return mfspr(SPRN_PMC8);
>> +#endif
>>  	default:
>>  		return 0;
>>  	}
>> @@ -108,16 +117,20 @@ static inline void ctr_write(unsigned in
>>  	case 5:
>>  		mtspr(SPRN_PMC6, val);
>>  		break;
>> +
>> +/* No PPC32 chip has more than 6, yet */
>> +#ifdef CONFIG_PPC64
>>  	case 6:
>>  		mtspr(SPRN_PMC7, val);
>>  		break;
>>  	case 7:
>>  		mtspr(SPRN_PMC8, val);
>>  		break;
>> +#endif
>>  	default:
>>  		break;
>>  	}
>>  }
>> -#endif /* __powerpc64__ */
>> +#endif /* !CONFIG_FSL_BOOKE */
>



> Why not move all MMCR0_ defines up ?
>


There are two reasons:
1) All of these registers have different SPR numbers on 32 and 64 bit  
classic architectures, so the SPRN definitions would have to be  
separate anyway
2) A number of the bit fields are different, too.  There's overlap,  
but it seemed more readable to group the bitfield definitions with  
the SPRNs, rather than split the #defines into three groups.  I could  
do that, if the current solution is unacceptable, but my personal  
opinion is that it's cleaner this way.


>>  /* Bit definitions for MMCR0 and PMC1 / PMC2. */
>>  #define MMCR0_PMC1_CYCLES	(1 << 7)
>> @@ -458,7 +481,6 @@
>>  #define MMCR0_PMC2_CYCLES	0x1
>>  #define MMCR0_PMC2_ITLB		0x7
>>  #define MMCR0_PMC2_LOADMISSTIME	0x5
>> -#define MMCR0_PMXE	(1 << 26)
>>  #endif


Andy
