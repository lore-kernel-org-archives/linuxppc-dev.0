Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A6606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AMvuSRuV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTxt5VVCz2xmk;
	Wed, 18 Nov 2026 03:01:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794931314;
	cv=none; b=GYKlXkDnVyxYPQMA0fVBgzVowQYUnf3EJM9Xptb0LKvGgnR4PPcc/D5jGxMJ7euG0V4A8hNivlQk+duubPZk1xe8uYU3FlJF1pc/3jblmie4c7mxTcZZ/9ly3f7o5S5/+7KUxUGCC3g2Z0c6a+P8bG/Q/gzitsZDr66qzR2uTzEkdx0/FC94BGIoUK51YoQYNcarfjL8er4xIevU7wVlaSZIAgHVcPTXe5SVF1pfiN/JVGWnH363704pmx+piRysc7aUERQ7Vn15ojf+Ns9sIUz1Xb8oklq6sI8FpTKkA9evbuuUrP0r2u1AGes3dtEVxdaKr6qti/tBz281q/UahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794931314; c=relaxed/relaxed;
	bh=1OnHU0seERuEycQNK8uBpZOqL+Tv+FjJvuQQijO5KaA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=S1MEteWpTRb8qaBRu9P8GpwRerUOClGPB0/cTYw9D8rZApeVXCgW2GhihH5RlIdQ6kUOWbnZd5t8OxEH7U64RiMdMDGELj5pJXc3mFzEaWfrD2VVsgsvFAYBeqi5jkhOB0p9o75yC3TRF1x0q4T6xiW134EwNyQYwmOE2D3FZCeRFv5fhYMB/d6E2oiABxsQb6Spu7ZknEN/4fEcQ98ZHviMxlPqa845N/ppj+gyxnl1YDQAAriQc7KPX3CgopnrbHjjLcS/z9Q7QO8JVF86K83ujF6g4SEfASQOb+tKq1BxCWULTBwbqzLjPP/vAeFlElhr3pfLqvROKbhtaA/28w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AMvuSRuV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AMvuSRuV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTxs37Zxz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:01:52 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQqra2730792;
	Tue, 17 Nov 2026 16:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1OnHU0seERuEycQNK8uBpZOqL+Tv+F
	jJvuQQijO5KaA=; b=AMvuSRuVBk0VT6wFRIDV+pM70gfpOBFiwm0O32I4Clkay4
	6Yd5yIoO2eWoKkxXvZd6wBYOmyGLHSkpdoT2ktsfx0D6p6EqKxmYpklLYwjzFHP0
	ne/QVVZeVgrqKX+YFcH7Y7WzoRr+w6jh92jg6UIfRSc2WL2uGPPHOxWhjg2dSqqi
	Fw647QrsiOZn5Jn7VOSd1FelCvSNuACzsQQnPByG1kkRaEkQIdHGl6VnR4HHGQSC
	KnnSKOO1fTPHx6PWp3E+H8LhbkfFEr1FHQ5z+5vIYaIhSd6NEbM9D2pfKn0u/Wsp
	bXKDDy0j+6s+y4sRWiB58r7axIRnQxs414dWSLNA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc546bn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:01:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYwgt657695;
	Tue, 17 Nov 2026 16:01:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nse8jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:01:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHG0Zaj26739306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 16:00:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CA6158054;
	Tue, 17 Nov 2026 16:01:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE015803F;
	Tue, 17 Nov 2026 16:01:20 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 16:01:20 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------jmLpT8MlYk4fRdra02LmStFb"
Message-ID: <d57c0f47-ace6-4fad-893a-4dca02fce24f@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:31:18 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] powerpc/perf: mpc7450: Export the event format in
 sysfs
To: Matt Turner <mattst88@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
 <20261109-ppc32-perf-v1-6-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-6-a6e8a55b3b48@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX7v3LLI5JKkG1
 zT6NBgkVU6Pd8Lgm64M/5PDS+b3z0AdwcQMvpVqj78cPTCkBX42k8gvEDcEuKxLHi8qY6TXcqfW
 iqH1JDWOGg3H85pyf/GZcRVLw+iOvQc=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afc7a58 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=KyYSnaSw0mPyKxjWQ4IA:9 a=QEXdDO2ut3YA:10
 a=AejV3YCIVs1Q-CqgyRQA:9 a=7wnFsAnpmLjnVeaI:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX7/jWXMeNUesT
 0OJS18t2YWXqr7K7M6aTH0yaldlSzBkLFPpfI0h9V+39c/wI7d6GIuJKjFSL6ONXpwX9Lg90x8u
 E3sizAH2gGutYWbGhRJoTZmfHly+aPjFvS/Xe+tTstMzKjbL8BTirQpZ/zcXV4pfB7gI9kNFpAn
 ZDe3Rq03eqDtZZDIqoAwXX9GMEdxBT8TgMBMYupNkQt96hmoUXYwEI/QjkvVGdtA7TYC6jhuQeb
 HDku6a+53JbKt4fJeyvMw78RKTXCWwGY4l0NlfnozAV6p8wYZrO9XwoPaBgj6cbkqGjaLGUQ/dx
 6bd4palKKhhv31TpwyUeeZx5SihiTxpNtPFzS3YJ20gHNQI/28sNUHYw9CpoiCYd5lCW1eAhRyg
 FTwf3nqyoVZJ/oGH13LHxW++IYRQYg==
X-Proofpoint-GUID: u8gegLB8pm-OB7mFino9a6bnD1QZn_Go
X-Proofpoint-ORIG-GUID: GspMD47sWXREhupnqatEZHItYRj_NGLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611170063
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------jmLpT8MlYk4fRdra02LmStFb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/26 7:17 AM, Matt Turner wrote:
> The MPC7450 PMU has no format/ directory, so perf can take its events
> only as raw codes, and cannot set the threshold by name.
>
> Describe the fields of the event code: the PMC select (bits 0-6), the
> PMC (bits 8-10), the threshold (bits 12-17) and the threshold multiplier
> (bit 18).  A threshold event can then be written as, e.g.,
> cpu/event=0x12b,thresh=20/.
>
> Signed-off-by: Matt Turner<mattst88@gmail.com>
Hi Matt, I checked the new format fields against the existing event 
encoding in mpc7450-pmu.c pmcsel config:0-6 (PM_PMCSEL_MSK 0x7f) pmc 
config:8-10 (PM_PMC_SH 8, PM_PMC_MSK 7) thresh config:12-17 
(PM_THRESH_SH 12, PM_THRESH_MSK 0x3f) thresh_mult config:18 
(PM_THRMULT_MSKS 0x40000) They match what the driver already decodes and 
the field widths in the

manual.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah


> ---
>   arch/powerpc/perf/mpc7450-pmu.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index b2fe977cea16..9bed5c238f45 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -398,6 +398,31 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>   	},
>   };
>   
> +PMU_FORMAT_ATTR(event,		"config:0-18");
> +PMU_FORMAT_ATTR(pmcsel,		"config:0-6");
> +PMU_FORMAT_ATTR(pmc,		"config:8-10");
> +PMU_FORMAT_ATTR(thresh,		"config:12-17");
> +PMU_FORMAT_ATTR(thresh_mult,	"config:18");
> +
> +static struct attribute *mpc7450_pmu_format_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_pmcsel.attr,
> +	&format_attr_pmc.attr,
> +	&format_attr_thresh.attr,
> +	&format_attr_thresh_mult.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group mpc7450_pmu_format_group = {
> +	.name = "format",
> +	.attrs = mpc7450_pmu_format_attr,
> +};
> +
> +static const struct attribute_group *mpc7450_pmu_attr_groups[] = {
> +	&mpc7450_pmu_format_group,
> +	NULL,
> +};
> +
>   struct power_pmu mpc7450_pmu = {
>   	.name			= "MPC7450 family",
>   	.n_counter		= N_COUNTER,
> @@ -411,6 +436,7 @@ struct power_pmu mpc7450_pmu = {
>   	.n_generic		= ARRAY_SIZE(mpc7450_generic_events),
>   	.generic_events		= mpc7450_generic_events,
>   	.cache_events		= &mpc7450_cache_events,
> +	.attr_groups		= mpc7450_pmu_attr_groups,
>   };
>   
>   static int __init init_mpc7450_pmu(void)
>
--------------jmLpT8MlYk4fRdra02LmStFb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/10/26 7:17 AM, Matt Turner wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20261109-ppc32-perf-v1-6-a6e8a55b3b48@gmail.com">
      <pre wrap="" class="moz-quote-pre">The MPC7450 PMU has no format/ directory, so perf can take its events
only as raw codes, and cannot set the threshold by name.

Describe the fields of the event code: the PMC select (bits 0-6), the
PMC (bits 8-10), the threshold (bits 12-17) and the threshold multiplier
(bit 18).  A threshold event can then be written as, e.g.,
cpu/event=0x12b,thresh=20/.

Signed-off-by: Matt Turner <a class="moz-txt-link-rfc2396E" href="mailto:mattst88@gmail.com">&lt;mattst88@gmail.com&gt;</a></pre>
    </blockquote>
    <font face="monospace"><span
style="color: rgb(32, 32, 32); font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Hi Matt,

I checked the new format fields against the existing event encoding in
mpc7450-pmu.c

  pmcsel       config:0-6   (PM_PMCSEL_MSK 0x7f)
  pmc          config:8-10  (PM_PMC_SH 8, PM_PMC_MSK 7)
  thresh       config:12-17 (PM_THRESH_SH 12, PM_THRESH_MSK 0x3f)
  thresh_mult  config:18    (PM_THRMULT_MSKS 0x40000)

They match what the driver already decodes and the field widths in the
</span></font>
    <p><font face="monospace"><span
style="color: rgb(32, 32, 32); font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">manual.</span></font></p>
    <p><font face="monospace">Reviewed-by: Tanushree Shah <a
          class="moz-txt-link-rfc2396E"
          href="mailto:tshah@linux.ibm.com">&lt;tshah@linux.ibm.com&gt;</a>
        <br>
      </font>
      <font face="monospace"><br>
      </font>
      <font face="monospace"><br>
        Thanks
        <br>
        Tanushree Shah</font></p>
    <p><font face="monospace"><span
style="color: rgb(32, 32, 32); font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span></font></p>
    <br>
    <blockquote type="cite"
      cite="mid:20261109-ppc32-perf-v1-6-a6e8a55b3b48@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---
 arch/powerpc/perf/mpc7450-pmu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index b2fe977cea16..9bed5c238f45 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -398,6 +398,31 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 };
 
+PMU_FORMAT_ATTR(event,		"config:0-18");
+PMU_FORMAT_ATTR(pmcsel,		"config:0-6");
+PMU_FORMAT_ATTR(pmc,		"config:8-10");
+PMU_FORMAT_ATTR(thresh,		"config:12-17");
+PMU_FORMAT_ATTR(thresh_mult,	"config:18");
+
+static struct attribute *mpc7450_pmu_format_attr[] = {
+	&amp;format_attr_event.attr,
+	&amp;format_attr_pmcsel.attr,
+	&amp;format_attr_pmc.attr,
+	&amp;format_attr_thresh.attr,
+	&amp;format_attr_thresh_mult.attr,
+	NULL,
+};
+
+static const struct attribute_group mpc7450_pmu_format_group = {
+	.name = "format",
+	.attrs = mpc7450_pmu_format_attr,
+};
+
+static const struct attribute_group *mpc7450_pmu_attr_groups[] = {
+	&amp;mpc7450_pmu_format_group,
+	NULL,
+};
+
 struct power_pmu mpc7450_pmu = {
 	.name			= "MPC7450 family",
 	.n_counter		= N_COUNTER,
@@ -411,6 +436,7 @@ struct power_pmu mpc7450_pmu = {
 	.n_generic		= ARRAY_SIZE(mpc7450_generic_events),
 	.generic_events		= mpc7450_generic_events,
 	.cache_events		= &amp;mpc7450_cache_events,
+	.attr_groups		= mpc7450_pmu_attr_groups,
 };
 
 static int __init init_mpc7450_pmu(void)

</pre>
    </blockquote>
  </body>
</html>

--------------jmLpT8MlYk4fRdra02LmStFb--


