Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A929C43461
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 16:15:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5345D21D41
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNX9tn2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5345D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrSxh64R1zDq8t
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 02:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=bNX9tn2d; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BrShX2nC5zDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 02:03:55 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FG1SIm119032; Tue, 15 Sep 2020 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=SwR/NUKjqj9dDzt+IBXdDhZdkVJA83w5Z/hX3YGGBtg=;
 b=bNX9tn2dIB06r/QNkD5Z9DLDAagvsRbcmLjoJfX0CzPGwULtLI9ElgZMox9XII3f9J92
 WPfHApxMgXnOcgSpxJmPC15ZJD2twQDseo/O3oP3K7AO0ZT57Msk1/tXrfKXAqEH7pOE
 xclHhdydaLG+Z6lonLx9NH+HEXkymdf18IC05+kZsz61nzCHVZIXlh5yYdSfUBT7FQHh
 8R64Q6e+OynWC4/UQLxyH/s8gi72wsLrZZq5RGfNhpv4/YcSIjg9yBZi/W4Dy6tLEtcE
 +Boik+/aDj//fbi71B5fPMcY5U1m3YSbgcZwheZOYq6AvBISvykvBH+3onESOGSwKvme 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33k0ah0rkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 12:03:44 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FG1oRB120083;
 Tue, 15 Sep 2020 12:03:44 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33k0ah0rhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 12:03:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FG2xdo008654;
 Tue, 15 Sep 2020 16:03:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 33guvm1tad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 16:03:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FG3dma16253300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 16:03:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33DDD42041;
 Tue, 15 Sep 2020 16:03:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E66434203F;
 Tue, 15 Sep 2020 16:03:35 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.46.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 15 Sep 2020 16:03:35 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Tue, 15 Sep 2020 21:33:34 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] powerpc/papr_scm: Fix warning triggered by
 perf_stats_show()
In-Reply-To: <87imcfp9a7.fsf@mpe.ellerman.id.au>
References: <20200912081451.66225-1-vaibhav@linux.ibm.com>
 <87imcfp9a7.fsf@mpe.ellerman.id.au>
Date: Tue, 15 Sep 2020 21:33:34 +0530
Message-ID: <87mu1rdo2x.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_11:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=1 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150128
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Santosh Sivaraj <santosh@fossix.org>, Oliver O'Halloran <oohall@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>> A warning is reported by the kernel in case perf_stats_show() returns
>> an error code. The warning is of the form below:
>>
>>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>>  	  Failed to query performance stats, Err:-10
>>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
>>
>> On investigation it looks like that the compiler is silently truncating the
>> return value of drc_pmem_query_stats() from 'long' to 'int', since the
>> variable used to store the return code 'rc' is an 'int'. This
>> truncated value is then returned back as a 'ssize_t' back from
>> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
>> unsigned number and triggers this warning..
>>
>> To fix this we update the type of variable 'rc' from 'int' to
>> 'ssize_t' that prevents the compiler from truncating the return value
>> of drc_pmem_query_stats() and returning correct signed value back from
>> perf_stats_show().
>>
>> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
>>        stats from PHYP')
>
> Please don't word wrap the Fixes tag it breaks b4.
>
> I've fixed it up this time.

Thanks Mpe

>
> cheers

-- 
Cheers
~ Vaibhav
