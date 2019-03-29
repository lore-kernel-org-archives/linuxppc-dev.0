Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:25:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4D8206B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4D8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VyXt5HvszDqGL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:25:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VyWC55FJzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:23:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44VyWC3tj1z8t1D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:23:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44VyWC33vrz9sPx; Fri, 29 Mar 2019 21:23:35 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44VyWB5y4Wz9sQm
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 21:23:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2TAJDun106981
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 06:23:32 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rhgdrve9y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 06:23:31 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 29 Mar 2019 10:23:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Mar 2019 10:23:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2TANPcS53412050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2019 10:23:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDE1352065;
 Fri, 29 Mar 2019 10:23:25 +0000 (GMT)
Received: from [9.85.92.96] (unknown [9.85.92.96])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 267A25204E;
 Fri, 29 Mar 2019 10:23:25 +0000 (GMT)
Subject: Re: [RFC PATCH 1/3] powernv/mce: reduce mce console logs to lesser
 lines.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
 <87bm1uo7iw.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 29 Mar 2019 15:53:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <87bm1uo7iw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032910-0016-0000-0000-00000268C9E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032910-0017-0000-0000-000032C412DD
Message-Id: <cdfb484e-0468-edb3-3d8f-306c50ddceca@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-29_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290075
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/29/19 5:50 AM, Michael Ellerman wrote:
> Hi Mahesh,
> 
> Thanks for doing this series.
> 
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Also add cpu number while displaying mce log. This will help cleaner logs
>> when mce hits on multiple cpus simultaneously.
> 
> Can you include some examples of the output before and after, so it's
> easier to compare what the changes are.

Sure will add that in next revision.

> 
> I think you have an example in patch 3, but it would be good to have it here.
> 
>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> index b5fec1f9751a..44614462cb34 100644
>> --- a/arch/powerpc/kernel/mce.c
>> +++ b/arch/powerpc/kernel/mce.c
>> @@ -384,101 +387,100 @@ void machine_check_print_event_info(struct machine_check_event *evt,
>>  		break;
>>  	}
>>  
>> -	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
> 
> I think I'd still like the first line at least to include "machine
> check" somewhere, I'm not sure everyone will understand what "MCE" means.

I reduced it to MCE so that I can pack in more stuff in 80 columns. But
you are right, let me see.

> 
> ...
>> +
>> +	if (ea && evt->srr0 != ea)
>> +		sprintf(dar_str, "DAR: %016llx ", ea);
>> +	else
>> +		memset(dar_str, 0, sizeof(dar_str));
> 
> Just dar_str[0] = '\0' would work wouldn't it?

Yeah, that also should be enough.

> 
>> +	if (in_guest || user_mode) {
>> +		printk("%sMCE: CPU%d: (%s) %s %s %s at %016llx %s[%s]\n",
>> +			level, evt->cpu, sevstr,
>> +			in_guest ? "Guest" : "Host",
>> +			err_type, subtype, evt->srr0, dar_str,
>> +			evt->disposition == MCE_DISPOSITION_RECOVERED ?
>> +			"Recovered" : "Not recovered");
>> +		printk("%sMCE: CPU%d: PID: %d Comm: %s\n",
>> +			level, evt->cpu, current->pid, current->comm);
>> +	} else {
>> +		printk("%sMCE: CPU%d: (%s) Host %s %s at %016llx %s[%s]\n",
>> +			level, evt->cpu, sevstr, err_type, subtype, evt->srr0,
>> +			dar_str,
>> +			evt->disposition == MCE_DISPOSITION_RECOVERED ?
>> +			"Recovered" : "Not recovered");
>> +		printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
>> +			level, evt->cpu, evt->srr0, (void *)evt->srr0);
>> +	}
> 
> The first printf in the two cases is quite similar, seems like they
> could be consolidated.
> 
> I also think it'd be clearer to print the NIP on the 2nd line in all
> cases, rather than the first.

Sure, and I will then put "machine check" on 1st line like below ?

printk("%sMCE: CPU%d: machine check (%s) %s %s %s %s[%s]\n",


> 
> What about (untested) ?
> 
>   printk("%sMCE: CPU%d: (%s) %s %s %s %s[%s]\n",
> 	 level, evt->cpu, sevstr,
> 	 in_guest ? "Guest" : "Host",
> 	 err_type, subtype, dar_str,
> 	 evt->disposition == MCE_DISPOSITION_RECOVERED ?
> 	 "Recovered" : "Not recovered");
>   
>   if (in_guest || user_mode) {
> 	printk("%sMCE: CPU%d: PID: %d Comm: %s %sNIP: [%016llx]\n",
> 	       level, evt->cpu, current->pid, current->comm,
> 	       in_guest ? "Guest " : "", evt->srr0);
>   } else {
> 	printk("%sMCE: CPU%d: NIP: [%016llx] %pS\n",
> 		level, evt->cpu, evt->srr0, (void *)evt->srr0);
>   }

Sure, will make these changes.

Thanks,
-Mahesh.

