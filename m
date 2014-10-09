Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 503541A0982
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 21:03:30 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 9 Oct 2014 04:03:28 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F0256C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 05:52:07 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s99A3N9959637870
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Oct 2014 10:03:24 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s99A3NWW032684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Oct 2014 06:03:23 -0400
Message-ID: <54365D64.5060702@linux.vnet.ibm.com>
Date: Thu, 09 Oct 2014 15:33:16 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/3] powerpc/kvm/book3s_hv: Enable CPUs to run guest
 after waking up from fast-sleep
References: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1412149560-2953-3-git-send-email-shreyas@linux.vnet.ibm.com>
 <1412658682.30859.137.camel@pasglop>
In-Reply-To: <1412658682.30859.137.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/07/2014 10:41 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-01 at 13:15 +0530, Shreyas B. Prabhu wrote:
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index 050f79a..c64f3cc0 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -100,25 +100,8 @@ system_reset_pSeries:
>>  	SET_SCRATCH0(r13)
>>  #ifdef CONFIG_PPC_P7_NAP
>>  BEGIN_FTR_SECTION
>> -	/* Running native on arch 2.06 or later, check if we are
>> -	 * waking up from nap. We only handle no state loss and
>> -	 * supervisor state loss. We do -not- handle hypervisor
>> -	 * state loss at this time.
>> -	 */
>> -	mfspr	r13,SPRN_SRR1
>> -	rlwinm.	r13,r13,47-31,30,31
>> -	beq	9f
>>  
>> -	/* waking up from powersave (nap) state */
>> -	cmpwi	cr1,r13,2
>> -	/* Total loss of HV state is fatal, we could try to use the
>> -	 * PIR to locate a PACA, then use an emergency stack etc...
>> -	 * OPAL v3 based powernv platforms have new idle states
>> -	 * which fall in this catagory.
>> -	 */
>> -	bgt	cr1,8f
>>  	GET_PACA(r13)
>> -
>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>  	li	r0,KVM_HWTHREAD_IN_KERNEL
>>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
>> @@ -131,13 +114,27 @@ BEGIN_FTR_SECTION
>>  1:
>>  #endif
> 
> So you moved the state loss check to after the KVM check ? Was this
> reviewed by Paul ? Is that ok ? (Does this match what we have in
> PowerKVM ?). Is it possible that we end up calling kvm_start_guest
> after a HV state loss or do we know for sure that this won't happen
> for a reason or another ? If that's the case, then that reason needs
> to be clearly documented here in a comment.

This wont happen because the first thread in the core which comes out of
an idle state which has a state loss will not enter into KVM since the
HSTATE_HWTHREAD_STATE is not yet set. It continues on to restore the
lost state.

This thread sets the HSTATE_HWTHREAD_STATE and wakes up the remaining
threads in the core. These sibling threads enter kvm directly not
requiring to restore lost state since the first thread has restored it
anyway. So we are safe. We will certainly add a comment there.

Thanks

Regards
Preeti U Murthy
