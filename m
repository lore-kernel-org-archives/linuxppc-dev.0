Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsJLh3wxPzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:47:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K6l2Y4130438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:47:37 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qen7hfy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:47:37 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 16:47:34 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K6lNG83801550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:47:31 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K6kxjO012006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:46:59 +1000
Subject: Re: [RFC v2 10/12] powerpc: Read AMR only if pkey-violation caused
 the exception.
To: Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-11-git-send-email-linuxram@us.ibm.com>
 <87bmpkuti2.fsf@concordia.ellerman.id.au>
 <20170619175919.GD5845@ram.oc3035372033.ibm.com>
Cc: linux-kernel@vger.kernel.org, dave.hansen@intel.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 12:16:40 +0530
MIME-Version: 1.0
In-Reply-To: <20170619175919.GD5845@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d403fa09-4eaa-a8ff-26f6-caf407538253@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2017 11:29 PM, Ram Pai wrote:
> On Mon, Jun 19, 2017 at 09:06:13PM +1000, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>>
>>> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/exceptions-64s.S | 16 ++++++++++------
>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>>> index 8db9ef8..a4de1b4 100644
>>> --- a/arch/powerpc/kernel/exceptions-64s.S
>>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>>> @@ -493,13 +493,15 @@ EXC_COMMON_BEGIN(data_access_common)
>>>  	ld	r12,_MSR(r1)
>>>  	ld	r3,PACA_EXGEN+EX_DAR(r13)
>>>  	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
>>> +	std	r3,_DAR(r1)
>>> +	std	r4,_DSISR(r1)
>>>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	andis.  r0,r4,DSISR_KEYFAULT@h /* save AMR only if its a key fault */
>>> +	beq+	1f
>>
>> This seems to be incremental on top of one of your other patches.
>>
>> But I don't see why, can you please just squash this into whatever patch
>> adds this code in the first place.
> 
> It was an optimization added later. But yes it can be squashed into an
> earlier patch.

Could you please explain what is the optimization this achieves ?
