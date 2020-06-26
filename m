Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B48C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 08:04:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C292B2080C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 08:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C292B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tTv14rGqzDr4N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 18:04:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tTs32xL5zDqx0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 18:03:03 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05Q82oEE052172; Fri, 26 Jun 2020 04:02:58 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux04bp9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 04:02:56 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05Q80Knp015187;
 Fri, 26 Jun 2020 08:02:42 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 31uuryjeys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 08:02:42 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05Q82dkN5702186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 08:02:39 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFDE1BE053;
 Fri, 26 Jun 2020 08:02:40 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1422FBE04F;
 Fri, 26 Jun 2020 08:02:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.52.29])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2020 08:02:37 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] powerpc/hv-24x7: Add sysfs files inside hv-24x7
 device to show cpumask
To: ego@linux.vnet.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20200624101754.169612-1-kjain@linux.ibm.com>
 <20200624101754.169612-3-kjain@linux.ibm.com>
 <20200624105603.GD31972@in.ibm.com>
 <a6a626e6-22eb-f1c2-4356-dfe1caf8db46@linux.ibm.com>
 <20200626074521.GA13159@in.ibm.com>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <6bc35fd9-33b8-0588-d645-02a59b589d04@linux.ibm.com>
Date: Fri, 26 Jun 2020 13:32:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626074521.GA13159@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-26_04:2020-06-26,
 2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260058
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
Cc: nathanl@linux.ibm.com, maddy@linux.vnet.ibm.com, suka@us.ibm.com,
 anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 6/26/20 1:15 PM, Gautham R Shenoy wrote:
> On Wed, Jun 24, 2020 at 05:58:31PM +0530, Madhavan Srinivasan wrote:
>>
>>
>> On 6/24/20 4:26 PM, Gautham R Shenoy wrote:
>>> Hi Kajol,
>>>
>>> On Wed, Jun 24, 2020 at 03:47:54PM +0530, Kajol Jain wrote:
>>>> Patch here adds a cpumask attr to hv_24x7 pmu along with ABI documentation.
>>>>
>>>> command:# cat /sys/devices/hv_24x7/cpumask
>>>> 0
>>> Since this sysfs interface is read-only, and the user cannot change
>>> the CPU which will be making the HCALLs to obtain the 24x7 counts,
>>> does the user even need to know if currently CPU X is the one which is
>>> going to make HCALLs to retrive the 24x7 counts ? Does it help in any
>>> kind of trouble-shooting ?
>> Primary use to expose the cpumask is for the perf tool.
>> Which has the capability to parse the driver sysfs folder
>> and understand the cpumask file. Having cpumask
>> file will reduce the number of perf commandline
>> parameters (will avoid "-C" option in the perf tool
>> command line). I can also notify the user which is
>> the current cpu used to retrieve the counter data.
> 
> Fair enough. Can we include this in the patch description ?

Sure will update in next version of patchset.

Thanks,
Kajol Jain

> 
>>
>>> It would have made sense if the interface was read-write, since a user
>>> can set this to a CPU which is not running user applications. This
>>> would help in minimising jitter on those active CPUs running the user
>>> applications.
>>
>> With cpumask backed by hotplug
>> notifiers, enabling user write access to it will
>> complicate the code with more additional check.
>> CPU will come to play only if the user request for
>> counter data. If not, then there will be no HCALLs made
>> using the CPU.
> 
> Well, I was wondering if you could make the interface writable because
> I couldn't think of the use of a read-only interface. With the
> perf-use case you have provided, I guess it makes sense. I am ok with
> it being a read-only interface.
> 
>>
>> Maddy
> 
> --
> Thanks and Regards
> gautham.
> 
