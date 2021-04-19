Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CBAC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 10:26:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7F661008
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 10:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7F661008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP2zY2DK1z30DW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 20:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ci3v8RAv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Ci3v8RAv; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP2z34c0Bz2xMw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 20:26:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13JA5WE3128267; Mon, 19 Apr 2021 06:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/Q/z9CmIU0bc14oP77ckvkImt3QVaQuoxewGw0EqTWM=;
 b=Ci3v8RAv3cTeQ71JjVZv7fCXmw6dVqRtCJRtiBS0YuFZWgSCJ05UHnk0hpll/5Jj2aaB
 5YpQhzn31HOt95rG08JKcKXff3+Ym4yQ/GdJ6qEc3xgsQUC20B4tOHc3g6yJ0mO/d/lj
 e+LNryu+ZS/umTfzD2JBtrVXI8k1OeGiCnvb0r5SP4+OcSvmIYHu7t66meZLixfhgkUl
 A6cqxwSBjYmTHEfNVCTOMsBY1XHdIF74D5F9z/6bHSQYvC2iLhevUsQ2ALhSgr34aD/O
 S1Hd0YJl3djiee3wM9esp2gnRXHtFhsy4VhAyn3MX36T+880/ljcDzURuOtf3t9sOq0M dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 380cramc05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Apr 2021 06:26:00 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JA5XFG128312;
 Mon, 19 Apr 2021 06:25:59 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 380crambyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Apr 2021 06:25:59 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JAM6U7000940;
 Mon, 19 Apr 2021 10:25:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01wdc.us.ibm.com with ESMTP id 37yqa8h4u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Apr 2021 10:25:58 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13JAPwA627394500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Apr 2021 10:25:58 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B2ACAE05C;
 Mon, 19 Apr 2021 10:25:58 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12F1EAE05F;
 Mon, 19 Apr 2021 10:25:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.38.52])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 19 Apr 2021 10:25:54 +0000 (GMT)
Subject: Re: [PATCH] perf vendor events: Initial json/events list for power10
 platform
To: "Paul A. Clarke" <pc@us.ibm.com>
References: <20210417091850.596023-1-kjain@linux.ibm.com>
 <20210418210838.GA1845018@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <130f4181-a5ba-a24a-5d1f-7694999c324a@linux.ibm.com>
Date: Mon, 19 Apr 2021 15:55:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210418210838.GA1845018@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jRQIvlOWSQIoGOZd15OC992mM78ZyOeH
X-Proofpoint-GUID: otI7imAesBe4e_OgYg6xLLBfZi7Eco3r
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-19_07:2021-04-16,
 2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190069
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
Cc: ravi.bangoria@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 linux-perf-users@vger.kernel.org, maddy@linux.vnet.ibm.com, jolsa@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 4/19/21 2:38 AM, Paul A. Clarke wrote:
> On Sat, Apr 17, 2021 at 02:48:50PM +0530, Kajol Jain wrote:
>> Patch adds initial json/events for POWER10.
> 
> I was able to apply, build, and run perf with these changes,
> and every new event at least ran successfully with
> `perf stat`.
> 
> Pedantically, there is a lot of inconsistency as to whether
> the `BriefDescription` ends with a period or not, and whether
> there is an extra space at the end.

Hi Paul,
Thanks for reviewing the patch. Sure I will remove this inconsistency
and send v2 patch for the same, with your Tested-by and Reviewed-by tag.

Thanks,
Kajol Jain

> 
> Regardless, LGTM.
> 
> Tested-by: Paul A. Clarke <pc@us.ibm.com>
> Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
> 
> PC
> 
