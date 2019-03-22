Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 07:40:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EF1218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 07:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EF1218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QbDX4yPgzDqWT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 18:40:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QbBd0gH5zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 18:39:04 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2M7Xlam001765
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 03:39:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rcs7wd5kn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 03:39:02 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Fri, 22 Mar 2019 07:38:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Mar 2019 07:38:50 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2M7ctMm47579268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2019 07:38:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B94DC42042;
 Fri, 22 Mar 2019 07:38:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 343D742045;
 Fri, 22 Mar 2019 07:38:52 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.102.30.3])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2019 07:38:51 +0000 (GMT)
Subject: Re: [PATCH 0/2] Auto-promotion logic for cpuidle states
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
References: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Fri, 22 Mar 2019 13:08:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19032207-0008-0000-0000-000002D03C99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032207-0009-0000-0000-0000223C5B90
Message-Id: <6131c0d7-bb2f-04fb-9700-4c6655a1c56e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-22_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=670 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220058
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
Cc: daniel.lezcano@linaro.org, rjw@rjwysocki.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Please ignore this set as this is incomplete. I have resent the patches.

--Abhishek

On 03/22/2019 11:55 AM, Abhishek Goel wrote:
> Currently, the cpuidle governors (menu/ladder) determine what idle state a
> idling CPU should enter into based on heuristics that depend on the idle
> history on that CPU. Given that no predictive heuristic is perfect, there
> are cases where the governor predicts a shallow idle state, hoping that
> the CPU will be busy soon. However, if no new workload is scheduled on
> that CPU in the near future, the CPU will end up in the shallow state.
>
> Motivation
> ----------
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-core
> can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.
>
> Experiment
> ----------
> Without this patch -
> It was seen that for a idle system, a cpu may remain in stop0_lite for few
> seconds and then directly goes to a deeper state such as stop2.
>
> With this patch -
> A cpu will not remain in stop0_lite for more than the residency of next
> available state, and thus it will go to a deeper state in conservative
> fashion. Using this, we may spent even less than 20 milliseconds if
> susbsequent stop states are enabled. In the worst case, we may end up
> spending more than a second, as was the case without this patch. The
> worst case will occur in the scenario when no other shallow states are
> enbaled, and only deep states are available for auto-promotion.
>
> Abhishek Goel (2):
>    cpuidle : auto-promotion for cpuidle states
>    cpuidle : Add auto-promotion flag to cpuidle flags
>
>   arch/powerpc/include/asm/opal-api.h |  1 +
>   drivers/cpuidle/Kconfig             |  4 ++++
>   drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
>   drivers/cpuidle/cpuidle.c           |  3 ---
>   4 files changed, 16 insertions(+), 5 deletions(-)
>

