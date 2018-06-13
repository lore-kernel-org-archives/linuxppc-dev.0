Return-Path: <srs0=/7dn=i7=linux.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415CrG4mCFzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 14:07:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 415CrG23BZz8wJ9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 14:07:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 415CrF53Vbz9s2g
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2018 14:07:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5D44F7v113120
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2018 00:07:07 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jjqrtqymj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2018 00:07:07 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 13 Jun 2018 00:07:06 -0400
Subject: Re: [v3 PATCH 4/5] powerpc/pseries: Dump and flush SLB contents on
 SLB MCE errors.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839253238.25118.3114450844744290470.stgit@jupiter.in.ibm.com>
 <87lgbkt8ts.fsf@concordia.ellerman.id.au>
 <c0d4d295-5595-8123-ada0-8e924a98418e@linux.ibm.com>
 <874li7tjo5.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 13 Jun 2018 09:36:54 +0530
MIME-Version: 1.0
In-Reply-To: <874li7tjo5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <884741cf-8e28-9da1-0e0c-0d2869d1b582@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2018 09:36 AM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> On 06/12/2018 07:17 PM, Michael Ellerman wrote:
>>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>>>> index 2edc673be137..e56759d92356 100644
>>>> --- a/arch/powerpc/platforms/pseries/ras.c
>>>> +++ b/arch/powerpc/platforms/pseries/ras.c
>>>> @@ -422,6 +422,31 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>>>>    	return 0; /* need to perform reset */
>>>>    }
>>>>    
>>>> +static int mce_handle_error(struct rtas_error_log *errp)
>>>> +{
>>>> +	struct pseries_errorlog *pseries_log;
>>>> +	struct pseries_mc_errorlog *mce_log;
>>>> +	int disposition = rtas_error_disposition(errp);
>>>> +	uint8_t error_type;
>>>> +
>>>> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
>>>> +	if (pseries_log == NULL)
>>>> +		goto out;
>>>> +
>>>> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
>>>> +	error_type = rtas_mc_error_type(mce_log);
>>>> +
>>>> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
>>>> +			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
>>>> +		slb_dump_contents();
>>>> +		slb_flush_and_rebolt();
>>>
>>> Aren't we back in virtual mode here?
>>>
>>> Don't we need to do the flush in real mode before turning the MMU back
>>> on. Otherwise we'll just take another multi-hit?
>>
>> slb_flush_and_rebolt does slbia, which keeps slb index 0. So kernel code
>> should not get another slb miss. We also make sure we don't touch stack
>> in slb_flush_and_rebolt(). So we flush everything and put vmalloc and
>> stack back. That should be ok with MMU on?
> 
> I don't think so.
> 
> Imagine we take a multi-hit accessing the paca. The machine check is
> delivered in real mode, so we can run and access the paca by it's real
> address. But as soon as we turn the MMU back on, we'll take another
> multi-hit when we access the paca.
> 
> If I'm reading the code right we are turning the MMU back on essentially
> straight away when we rfid to machine_check_common().
> 

yes for linear mapped first 1TB we will take a multi-hit again

-aneesh
