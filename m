Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHcVm3mZqzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 16:12:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 15/25] powerpc: Program HPTE key protection bits
In-Reply-To: <20171018221212.GP5617@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-16-git-send-email-linuxram@us.ibm.com>
 <24a039cb-526c-6baa-15b8-906963ae62b7@linux.vnet.ibm.com>
 <20171018221212.GP5617@ram.oc3035372033.ibm.com>
Date: Thu, 19 Oct 2017 16:12:15 +1100
Message-ID: <87376fn2kw.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> On Wed, Oct 18, 2017 at 06:15:40PM +0200, Laurent Dufour wrote:
>> On 31/07/2017 02:12, Ram Pai wrote:
>> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
>> > index 1ded6df..4b7e3f4 100644
>> > --- a/arch/powerpc/include/asm/pkeys.h
>> > +++ b/arch/powerpc/include/asm/pkeys.h
>> > @@ -72,6 +72,19 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>> >  #define AMR_RD_BIT 0x1UL
>> >  #define AMR_WR_BIT 0x2UL
>> >  #define IAMR_EX_BIT 0x1UL
>> > +
>> > +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
>> > +{
>> > +	if (!pkey_inited)
>> > +		return 0x0UL;
>> 
>> Why making such a check here, is it to avoid the following check during the
>> boot process only ?
>> IIUC, there is no way to get H_PAGE_PKEY_BIT* set when pkey_inited is false.
>
> I know its a little paronia. Trying to avoid a case where the
> uninitialized pkey bits in the pte are erroneously interpreted as valid
> by this function. Remember that the caller of this function will use the
> return value to program the hpte. Nothing really bad should happen
> since none of the keys are enabled. But ... just playing it safe.

I think that's probably over-paranoid. It's not like it adds much
overhead, but it is a hot path, so no need to make it slower than it
needs to be.

cheers
