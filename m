Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25479C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 19:46:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512E8207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 19:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512E8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x5K31d77zDqZw
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 06:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x5GH2vnkzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 06:43:50 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x18JYCen066003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2019 14:43:48 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qhdyudgje-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 14:43:48 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 8 Feb 2019 19:43:47 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Feb 2019 19:43:45 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x18JhiPL29098026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2019 19:43:44 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61FF3BE051
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 19:43:44 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0F52BE053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 19:43:43 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.85.229.16])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 19:43:43 +0000 (GMT)
Subject: Re: [PATCH v03] powerpc/numa: Perform full re-add of CPU for
 PRRN/VPHN topology update
To: linuxppc-dev@lists.ozlabs.org
References: <305ed693-ea85-8a70-1d3c-ae405aebc0ad@linux.vnet.ibm.com>
 <20190208054403.GA24971@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Fri, 8 Feb 2019 13:43:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208054403.GA24971@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020819-0012-0000-0000-00001707391D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010560; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158212; UDB=6.00604311; IPR=6.00938744; 
 MB=3.00025496; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 19:43:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020819-0013-0000-0000-000056215E6C
Message-Id: <019970a2-88d7-d4e0-107c-f3dac4214874@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-08_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080134
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/7/19 11:44 PM, Srikar Dronamraju wrote:
>>
>>  int arch_update_cpu_topology(void)
>>  {
>> -	return numa_update_cpu_topology(true);
>> +	int changed = topology_changed;
>> +
>> +	topology_changed = 0;
>> +	return changed;
>>  }
>>
> 
> Do we need Powerpc override for arch_update_cpu_topology() now?  That
> topology_changed sometime back doesn't seem to have help. The scheduler
> atleast now is neglecting whether the topology changed or not.

I was dealing with a a concurrency problem.  Revisiting again.
> 
> Also we can do away with the new topology_changed.
> 
>>  static void topology_work_fn(struct work_struct *work)
>>  {
>> -	rebuild_sched_domains();
>> +	lock_device_hotplug();
>> +	if (numa_update_cpu_topology(true))
>> +		rebuild_sched_domains();
>> +	unlock_device_hotplug();
>>  }
> 
> Should this hunk be a separate patch by itself to say why
> rebuild_sched_domains with a changelog that explains why it should be under
> lock_device_hotplug? rebuild_sched_domains already takes cpuset_mutex. 
> So I am not sure if we need to take device_hotplug_lock.

topology_work_fn runs in its own thread like the DLPAR operations.
This patch adds calls to Nathan's 'dlpar_cpu_readd' from the topology_work_fn
thread.  The lock/unlock_device_hotplug guard against concurrency issues
with the DLPAR operations, grabbing that lock here to avoid overlap with
those other operations.  This mod is dependent upon using dlpar_cpu_readd.

> 
>>  static DECLARE_WORK(topology_work, topology_work_fn);
>>
>> -static void topology_schedule_update(void)
>> +void topology_schedule_update(void)
>>  {
>> -	schedule_work(&topology_work);
>> +	if (!topology_update_in_progress)
>> +		schedule_work(&topology_work);
>>  }
>>
>>  static void topology_timer_fn(struct timer_list *unused)
>>  {
>> +	bool sdo = false;
> 
> Is sdo any abbrevation?

'for do the schedule update'.  Will remove per below.

> 
>> +
>> +	if (topology_scans < 1)
>> +		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
>> +			    nr_cpumask_bits);
> 
> Why do we need topology_scan? Just to make sure
> cpu_associativity_changes_mask is populated only once?
> cant we use a static bool inside the function for the same?

I was running into a race condition.  On one of my test systems,
start_topology_update via shared_proc_topology_init and the PHYP did
not provide any change info about the CPUs that early in the boot.
The first run erased the cpu bits in cpu_associativity_changes_mask,
and subsequent runs did not pay attention to the reported updates.
Taking another look.
> 
> 
>> +
>>  	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
>> -		topology_schedule_update();
>> -	else if (vphn_enabled) {
>> +		sdo =  true;
>> +	if (vphn_enabled) {
> 
> Any reason to remove the else above?
When vphn_enabled and prrn_enabled, it was not calling 'update_cpu_associativity_changes_mask()',
so was not getting the necessary change info.

>>  		if (update_cpu_associativity_changes_mask() > 0)
>> -			topology_schedule_update();
>> +			sdo =  true;
>>  		reset_topology_timer();
>>  	}
>> +	if (sdo)
>> +		topology_schedule_update();
>> +	topology_scans++;
>>  }
> 
> Are the above two hunks necessary? Not getting how the current changes are
> different from the previous.
Not important.  Will undo.
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

