Return-Path: <srs0=31td=i7=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415CMV5qcvzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 13:45:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 415CMV5FNgz8vF5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 13:45:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 415CMT4TStz9s2g
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2018 13:45:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5D3iLx2073461
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2018 23:45:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jjpc69wet-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2018 23:45:37 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 13 Jun 2018 04:45:35 +0100
Subject: Re: [v3 PATCH 4/5] powerpc/pseries: Dump and flush SLB contents on
 SLB MCE errors.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839253238.25118.3114450844744290470.stgit@jupiter.in.ibm.com>
 <87lgbkt8ts.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2018 09:15:30 +0530
MIME-Version: 1.0
In-Reply-To: <87lgbkt8ts.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <0e1134c4-6727-2240-ffc6-d4ed4b4ecf04@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2018 07:17 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>> index 2edc673be137..e56759d92356 100644
>> --- a/arch/powerpc/platforms/pseries/ras.c
>> +++ b/arch/powerpc/platforms/pseries/ras.c
>> @@ -422,6 +422,31 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>>  	return 0; /* need to perform reset */
>>  }
>>  
>> +static int mce_handle_error(struct rtas_error_log *errp)
>> +{
>> +	struct pseries_errorlog *pseries_log;
>> +	struct pseries_mc_errorlog *mce_log;
>> +	int disposition = rtas_error_disposition(errp);
>> +	uint8_t error_type;
>> +
>> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
>> +	if (pseries_log == NULL)
>> +		goto out;
>> +
>> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
>> +	error_type = rtas_mc_error_type(mce_log);
>> +
>> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
>> +			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
>> +		slb_dump_contents();
>> +		slb_flush_and_rebolt();
> 
> Aren't we back in virtual mode here?
> 
> Don't we need to do the flush in real mode before turning the MMU back
> on. Otherwise we'll just take another multi-hit?

Yeah for duplicate entries for kernel segment "0xc00", we will end up
with another multi-hit. For other segments we won't. I think I need to
move the fetching of rtas error log and handling part into real mode to
avoid a loop, and do only printing part in virtual mode.

> 
> cheers
> 
