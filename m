Return-Path: <SRS0=OfUe=KV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AA6C47088
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 08:46:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00ABD613B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 08:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ABD613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fql0f3HSjz308X
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 May 2021 18:46:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kWmqFGpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=kWmqFGpZ; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fql012JLqz2y8Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2021 18:45:36 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14Q8WgEo070256; Wed, 26 May 2021 04:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HVeUcYXlful+b6a4wRWi1RS15JlEiihXe60vxwCunHA=;
 b=kWmqFGpZ1eKi5r7/TFsEts7AExVdFgNg9CX4ulkEhtjFGhx3L8QVk9+E/BSvt4zUvnsC
 mCDIuw7pG8yB/+R2pcaWxL40LO9BZdYesj9WoStABq+NGYceijyczM+5jiRmQGaKx3Nm
 TkYaEGtaNRWYqLKd9rhu+QmMCW+f5DDmO6TV7+O9/UzDw4DbC5nYH9qNNtuO9uwI6an0
 vzJFKRKx7Pg9002D7R7Op1bfZj3a1HpCjC6PfSy3lIJr2IOPX9va9LL7rnZMnk9swgeb
 1pXYWDBgDzAryYOwcZGLMARQs2lNnbNQHPBK2qSCoMpCDJlhn/EZeLUfTvL+A6au8ruq ag== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38sjnj90ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 May 2021 04:45:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q8jGZ6011101;
 Wed, 26 May 2021 08:45:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 38sba2r5ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 May 2021 08:45:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 14Q8jCir14746080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 May 2021 08:45:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D345B52057;
 Wed, 26 May 2021 08:45:11 +0000 (GMT)
Received: from [9.85.86.138] (unknown [9.85.86.138])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E75CA52052;
 Wed, 26 May 2021 08:45:08 +0000 (GMT)
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for nvdimm
 pmu device
To: kajoljain <kjain@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
 <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
 <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <569ee30d-29c0-37c4-6f3e-9dd1345f837e@linux.ibm.com>
Date: Wed, 26 May 2021 14:15:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PZ3iGSmsrXTcwPv1frRIUKlpIS2kuaac
X-Proofpoint-ORIG-GUID: PZ3iGSmsrXTcwPv1frRIUKlpIS2kuaac
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-26_06:2021-05-25,
 2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=865 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260055
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
Cc: santosh@fossix.org, maddy@linux.vnet.ibm.com, ira.weiny@intel.com,
 linux-nvdimm@lists.01.org, rnsastry@linux.ibm.com,
 linux-kernel@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/26/21 12:56 PM, kajoljain wrote:
> 
> 
> On 5/25/21 7:46 PM, Peter Zijlstra wrote:
>> On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:
>>> Patch here adds cpu hotplug functions to nvdimm pmu.
>>
>> I'm thinking "Patch here" qualifies for "This patch", see
>> Documentation/process/submitting-patches.rst .
>>
> Hi Peter,
>     I will reword this commit message.
> 
>>> It adds cpumask to designate a cpu to make HCALL to
>>> collect the counter data for the nvdimm device and
>>> update ABI documentation accordingly.
>>>
>>> Result in power9 lpar system:
>>> command:# cat /sys/devices/nmem0/cpumask
>>> 0
>>
>> Is this specific to the papr thing, or should this be in generic nvdimm
>> code?
> 
> This code is not specific to papr device and we can move it to
> generic nvdimm interface. But do we need to add some checks on whether
> any arch/platform specific driver want that support or we can assume
> that this will be something needed by all platforms?
> 

It says the cpu that should be used to make the hcall. That makes it 
PAPR specific.

-aneesh

