Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD4C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 05:05:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8DD20832
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 05:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8DD20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434T9R0hQtzDqZC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 16:04:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434T746bCCzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 16:02:56 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAS4xF5n128784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 00:02:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p1kyr11cr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 00:02:54 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 28 Nov 2018 05:02:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Nov 2018 05:02:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAS52k2G5112102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Nov 2018 05:02:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D40C542049;
 Wed, 28 Nov 2018 05:02:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22FD942041;
 Wed, 28 Nov 2018 05:02:45 +0000 (GMT)
Received: from [9.124.31.178] (unknown [9.124.31.178])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 28 Nov 2018 05:02:44 +0000 (GMT)
Subject: Re: [PATCH RESEND] powerpc/perf: Update perf_regs structure to
 include SIER
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20181126193821.GD18491@kernel.org> <878t1dho3x.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 28 Nov 2018 10:32:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <878t1dho3x.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18112805-0012-0000-0000-000002D145BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112805-0013-0000-0000-0000210688FF
Message-Id: <7e8d41eb-9f8d-4d9b-2aeb-1670d582f529@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-28_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280045
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, Thomas Richter <tmricht@linux.vnet.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 28/11/18 9:04 AM, Michael Ellerman wrote:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
>> Em Mon, Nov 26, 2018 at 11:34:08PM +0530, Madhavan Srinivasan escreveu:
>>> On each sample, Sample Instruction Event Register (SIER) content
>>> is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
>>> but instead, SIER content is saved in the "dar" register of pt_regs.
>>>
>>> Patch adds another entry to the perf_regs structure to include the "SIER"
>>> printing which internally maps to the "dar" of pt_regs.
>> I think the patch is ok, when we talked in Vancouver I thought I saw
>> something like this before, i.e. adding more registers to a perf_regs.h
>> file, this was the cset:
>>
>>    commit 0da0017f72554c005c1a04c3adc5da9eb64fa7e5
>>    Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>>    Date:   Wed Nov 8 07:30:15 2017 +0100
>>
>>        s390/perf: extend perf_regs support to include floating-point registers
>>
>> That I came across because it broke the perf build, making me add this
>> cset:
>>
>>    commit 10b9baa701d5023897f70a4acb3bf0235da3dc4f
>>    Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>    Date:   Tue Nov 28 11:08:41 2017 -0300
>>
>>      tools arch s390: Do not include header files from the kernel sources
>>
>> :-)
>>
>> Michael? What about the ppc specific details?
> The only possible objection is that not all CPUs have an SIER register,
> so on CPUs without it you'll get the content of the DAR register rather
> than the SIER (because we (ab)use the DAR slot of pt_regs for the SIER).
>
> Perhaps we should make sure that we return 0 on CPUs that don't have the
> register?


Yes this make sense. We should make it zero instead of having the DAR
value. I will respin the patch with that change.

Thanks for the review comments.

Maddy

>
> cheers
>

