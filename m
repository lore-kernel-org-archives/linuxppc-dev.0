Return-Path: <SRS0=BLMX=3S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982EC33CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 09:58:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFACA20708
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 09:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFACA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486zT91LTCzDqHW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 20:58:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sandipan@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486zR560rPzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2020 20:56:49 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00T9s3DH005271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2020 04:56:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xu5qav51r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2020 04:56:45 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 29 Jan 2020 09:56:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 29 Jan 2020 09:56:39 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00T9ucht53870796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 09:56:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DBC0AE045;
 Wed, 29 Jan 2020 09:56:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DC17AE04D;
 Wed, 29 Jan 2020 09:56:36 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jan 2020 09:56:36 +0000 (GMT)
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
From: Sandipan Das <sandipan@linux.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
 <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Date: Wed, 29 Jan 2020 15:26:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012909-0008-0000-0000-0000034DB7CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012909-0009-0000-0000-00004A6E343F
Message-Id: <3c7b6d98-da08-29c7-cd5b-39d2903b24a2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-29_01:2020-01-28,
 2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290081
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
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com,
 x86@kernel.org, linuxram@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 linux-kselftest@vger.kernel.org, msuchanek@suse.de, shuah@kernel.org,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dave,

On 28/01/20 3:08 pm, Sandipan Das wrote:
> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>
>> How have you tested this patch (and the whole series for that matter)?
>>
> 
> I replaced the second patch with this one and did a build test.
> Till v16, I had tested the whole series (build + run) on both a POWER8
> system (with 4K and 64K page sizes) and a Skylake SP system but for
> x86_64 only. Following that, I could only do a build test locally on
> my laptop for i386 and x86_64 on my laptop as I did not have access to
> the Skylake system anymore.
> 
> 

I got a chance to use the Skylake system today and tested (build + run)
the whole series (v17 with the fixed Makefile) for both i386 and x86_64.
Everything passed.

- Sandipan

