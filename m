Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1006FDDF32
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 02:07:09 +1100 (EST)
Message-Id: <A59AAF78-1AC1-4B67-A0DB-6D2F9CE0FA20@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903161602.33218.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH v4] powerpc/mm: e300c2/c3/c4 TLB errata workaround
Date: Mon, 16 Mar 2009 10:06:59 -0500
References: <1237208538-32597-1-git-send-email-galak@kernel.crashing.org>
	<200903161602.33218.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 10:02 AM, David Jander wrote:

>
> Ok, I was analysing your code (which seems much more compact than  
> mine):
>
> On Monday 16 March 2009 14:02:18 Kumar Gala wrote:
>> [...]
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -587,9 +587,19 @@ DataLoadTLBMiss:
>> 	ori	r1,r1,0xe04		/* clear out reserved bits */
>> 	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
>> 	mtspr	SPRN_RPA,r1
>> +	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
>> +	mtcrf	0x80,r2
>> +BEGIN_MMU_FTR_SECTION
>> +	li	r0,1
>> +	lwz	r1,sw_way_lru@l(0)
>> +	rlwinm	r3,r3,19,25,29		/* Get Address bits 19:15 */
>
> This should be 'rlwinm	r3,r3,17,27,31' now, since you address bits,  
> not ints.

was just copying/pasting what you had :)

> Note that you are trashing r3 (SPRN_DMISS) here!

good catch..

>> +	slw	r0,r0,r3
>> +	xor	r1,r0,r1
>> +	srw	r0,r1,r3
>> +	stw	r1,sw_way_lru@l(0)
>> +	rlwimi	r2,r0,31-14,14,14
>> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
>> 	tlbld	r3
>
> And now you load r3 into the tlb, is this right? It doesn't seem  
> right to
> me....

correct.. I wasn't thinking about the fact that tlbld was using r3.

- k
