Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3hyZ3jtJzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:50:46 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0IMiDp4086063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 17:50:44 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 282br7pgw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 17:50:43 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 19 Jan 2017 08:50:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 177D22BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:50:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0IModBu19136570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:50:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0IMocnf015562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:50:38 +1100
Date: Thu, 19 Jan 2017 09:50:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 ruscur@russell.cc
Subject: Re: [PATCH] powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1484104609-22129-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <87wpdsapdl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wpdsapdl.fsf@concordia.ellerman.id.au>
Message-Id: <20170118225038.GA5397@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2017 at 04:49:58PM +1100, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> In __eeh_clear_pe_frozen_state(), we should pass the flag's value
>> instead of its address to eeh_unfreeze_pe(). This doesn't introduce
>> any problems, but the code is just wrong.
>
>It means any caller that passes false, will be getting the wrong
>behaviour. eg. I see at least one call in eeh_reset_device() which
>passes false to eeh_clear_pe_frozen_state(), which is then passed to
>__eeh_clear_pe_frozen_state().
>

Yes, when __eeh_clear_pe_frozen_state() succeeds on all child PEs, the
isolated flag is cleared. No failure from __eeh_clear_pe_frozen_state()
was observed previously.

>But I guess you're saying that caller doesn't actually see a bug because
>of this?
>

Yes, I'll update the changelog accordingly, to give more details as above.

>> This fixes the code by passing flag's value to eeh_unfreeze_pe().
>>
>> Cc: stable@vger.kernel.org #3.18+
>> Fixes: 5cfb20b96f6 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index d88573b..fa15fa6 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -549,7 +549,7 @@ static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
>
>	bool *clear_sw_state = flag;
>
>>  	int i, rc = 1;
>>  
>>  	for (i = 0; rc && i < 3; i++)
>> -		rc = eeh_unfreeze_pe(pe, clear_sw_state);
>> +		rc = eeh_unfreeze_pe(pe, *clear_sw_state);
>
>
>I think it would be better to just do the dereference once:
>
>	bool clear_sw_state = *(bool *)flag;
>	int i, rc = 1;
>
>	for (i = 0; rc && i < 3; i++)
>		rc = eeh_unfreeze_pe(pe, clear_sw_state);
>

Thanks, Michael. I'll update in v2.

Thanks,
Gavin
