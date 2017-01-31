Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCJzZ01kpzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 19:18:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support
 for interrupts
In-Reply-To: <20170131080152.GA2112@fergus.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-4-npiggin@gmail.com>
 <20170131080152.GA2112@fergus.ozlabs.ibm.com>
Date: Tue, 31 Jan 2017 19:17:57 +1100
Message-ID: <87inovve16.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Thu, Dec 22, 2016 at 04:29:27AM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index 11882aac8216..c18ce740452b 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -1151,7 +1152,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>>  11:	stw	r3,VCPU_HEIR(r9)
>>  
>>  	/* these are volatile across C function calls */
>> +#ifdef CONFIG_RELOCATABLE
>> +	ld	r3, HSTATE_SCRATCH1(r13)
>
> The problem is here.  Depending on what sort of interrupt it is, we
> can end up going back to the guest via fast_guest_return, which
> doesn't reload CTR.  Adding
>
> 	mtctr	r3
>
> at this point makes things work.

I folded this in.

cheers
