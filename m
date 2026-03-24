Return-Path: <linuxppc-dev+bounces-18662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7648F532D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:57:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffzpF2s0Tz2yj3;
	Tue, 24 Mar 2026 16:57:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774331845;
	cv=none; b=of3/e6mFQvfjRHYDZalJxuZxiXIuQobp94WVUa/M/ag/2MUCcvF57B3TY3nCGllAMCFK2xFNLEJ1tGt2tweBNbFltixGRD4E75N5lg+KU6iJqXpG/8K6nxoUezadRfWvr2+JHkzUAJXJc3wN8CExUS+EIQiF3yiPgRIQYU/FXaQyXZXjlvDPrHZAwOTMTjaDmZRWvxWnTg6sbpq1ttg3s8skRMg3VYPASOCsHY8X1biLPp/d83DhFbOB8p/Xhxx7TzRvdwSaRvgNpEU6btoaJmH2LdHFNVNgwsNE8+C9NYOsRlpK3u5f7RjHb5n9vR5niRpeHasm858GzVuEfyVSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774331845; c=relaxed/relaxed;
	bh=2oor+MYF8TomBMgmD+lB129UgQOGofcdbJEhp1qK72c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XboORoNdCfSQiDWP0S9Mtq3Y6BxuaVKMnpgCuet/Hbr8A50xGuXrbwdi5xOEWqh/WLVHoiy2EZiMl/aKmTVJ/nCGWV1wyw/KhSg91te6nsELIbB+L0vTLbHQ189YnvkMgYcQAsvaqR+KNYpERVE9jcqVhCq8ErO/RuW//38pF6AWsMkbzC83jdyWQbhJnzCPGQ1wEzord9GZDfygjprkGCASqq/WrC0H87FqpYTVcbEygjMAXBfc5PqT7ocB5M0qZUWjMkC1gGphiKPrNz1KRKBiWNiSz4EK0LcLhE3Ftfs9nggRlenZASIOYEWl7bCLB2OsTkjS8sPARd3USPQGJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KpHZJ0Vs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KpHZJ0Vs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffzpC5YqBz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 16:57:23 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NI8Yht1073850;
	Tue, 24 Mar 2026 05:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2oor+M
	YF8TomBMgmD+lB129UgQOGofcdbJEhp1qK72c=; b=KpHZJ0Vst3lT0gTOsrwbEq
	ablXwJ9FV9RXJ/eNHXusk1EHsYgpp0oKXJKwbBcbWt5YMafckPqyMoxXY9AZI7bz
	jC4mTLT/KtfhdPLLRu95tovaljR8ReGNYI+RjDwkuzPAg6y/GjmdHDW4uh86PBrL
	ADlrhhznDvuYTRL9188a5Cq/mjmvDTIeQj4jRso427vauQvNWyRnZBqVG12F/gGS
	TG24BPY5QFpigP/wcfa1UUnj2qN929XLrgEaz/nKNhOsh0NcLrbGm9KKliv09gVq
	w7b9G9hBqi/DP4n7Q+evKtvTmXpp1sHarHnp5zOFXrn1+7+akDngF48EEaXop7bg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky01fsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 05:57:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O40RbH026797;
	Tue, 24 Mar 2026 05:57:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kr9te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 05:57:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62O5v9JV46137696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 05:57:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7439620043;
	Tue, 24 Mar 2026 05:57:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEEF120040;
	Tue, 24 Mar 2026 05:57:06 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.4.235])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Mar 2026 05:57:06 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fXcZVxKcfV5giqDWxBPm53cNYLGhrTL8Q=uibrqJPmzgw@mail.gmail.com>
Date: Tue, 24 Mar 2026 11:26:54 +0530
Cc: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Venkat <venkat88@linux.ibm.com>,
        jolsa@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E333DED-B88A-4071-9828-C46F50EB0090@linux.ibm.com>
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
 <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
 <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
 <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com>
 <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
 <CAP-5=fXcZVxKcfV5giqDWxBPm53cNYLGhrTL8Q=uibrqJPmzgw@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0NiBTYWx0ZWRfX5hRJqtc2Q/7f
 GCI9OfYgB4pUFYeXbLqTP2eVKwFdEk0Bf/DozhyEcR9nqGGWF69cClOCtH/oes5o8PhlPWqohFC
 b4xkzJd2+UTVp75wjzzQRZubq9/DvbXIKteqb2klLabpnw9CUhNKDNwYWTxl1f09WFVnJ9A5alT
 iaESwUS72iteo3SXiL/rZ0yc85sXRqBbZ/0BoK9RBnRCe5ZkVv6GP5/uWXpyrzz2B462rA5/YXT
 75QkiNNOGA4h/N7I4EYYEnVcOJiZpqVHyK0f0UrJLE/Uhxr5ktEciYYwVSzFP5TYDevDxdwK/MU
 uepdBjFB3dd5vIe2KGKcgvtLxtiznRRVwQqCA34WpRZY6Por07KONeYm2flz7aFFYSDckgSR0ny
 4gHlNApZPNT5cxcqoWRfdI5Ytv3FpVZ/2iK4O4/n3p67y3i1lTMpm+BrjeaymrcCTrHabPa+bWG
 qGnCsobCbj7QxcTY8yA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c227ba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=nCd-JXeiIYM9aWHwyxEA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: k5wI-MpocaYuIziLe-HpwAr26jhw8kZj
X-Proofpoint-GUID: 77GLMpzA58N8BDtWJ-qY5FZPmGE1kHaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240046



> On 24 Mar 2026, at 12:17=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Mon, Mar 23, 2026 at 5:19=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 18 Mar 2026, at 12:05=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 17 Mar 2026, at 9:39=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>>>=20
>>>> On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat =
<venkat88@linux.ibm.com> wrote:
>>>>>=20
>>>>>> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>>>>=20
>>>>>> The format_alias() function in util/pmu.c has a check to
>>>>>> detect whether the event has parameterized field ( =3D? ).
>>>>>> The string alias->terms contains the event and if the event
>>>>>> has user configurable parameter, there will be presence of
>>>>>> sub string "=3D?" in the alias->terms.
>>>>>>=20
>>>>>> Snippet of code:
>>>>>>=20
>>>>>> /* Paramemterized events have the parameters shown. */
>>>>>>     if (strstr(alias->terms, "=3D?")) {
>>>>>>             /* No parameters. */
>>>>>>             snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>>>>>=20
>>>>>> if "strstr" contains the substring, it returns a pointer
>>>>>> and hence enters the above check which is not the expected
>>>>>> check. And hence "perf list" doesn't have the parameterized
>>>>>> fields in the result.
>>>>>>=20
>>>>>> Fix this check to use:
>>>>>>=20
>>>>>> if (!strstr(alias->terms, "=3D?")) {
>>>>>>=20
>>>>>> With this change, perf list shows the events correctly with
>>>>>> the strings showing parameters.
>>>>>>=20
>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>=20
>>>> Thanks Athira, Sashiko is noting in its review:
>>>> =
https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux.ibm=
.com
>>>=20
>>> Thanks Ian for pointing this. Its interesting to see this review.
>>> I will check through the review.
>>>=20
>>> Thanks
>>> Athira
>>>>=20
>>>> By inverting this check, parameterized events now proceed to
>>>> parse_events_terms() and the rest of format_alias().
>>>>=20
>>>> If a parameterized event uses a built-in perf keyword for its =
parameter name
>>>> (e.g., config=3D?), the lexer parses it as a predefined term token, =
which sets
>>>> term->config to NULL.
>>=20
>> Hi All,
>>=20
>> sashiko brought up a scenario :
>>=20
>> =E2=80=9CIf a parameterized event uses a built-in perf keyword for =
its parameter name
>> (e.g., config=3D?), the lexer parses it as a predefined term token, =
which sets
>> term->config to NULL."
>>=20
>> Existing usage for parameterized events in perf:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> In perf,  =E2=80=9C?=E2=80=9D is often used in event aliases to =
indicate that a parameter needs to be provided
>> by the user (e.g., param1=3D?). This information is exposed via =
=E2=80=9Cformat=E2=80=9D in sysfs too.  The current way,
>> how this is consumed in different PMU drivers is: example:
>>=20
>>  # cat /sys/devices/pmu/format/param1
>>    config:12-15
>>=20
>>   # cat /sys/devices/pmu/format/param2
>>    config1:0-17
>>=20
>> Here param1 uses bits 12:15 in config and param2 used bits 0:17 in =
config1
>>=20
>> And event will use these parameterized fields:
>>    #cat /sys/devices/pmu/events/event1       =
domain=3D1,param1=3D?,param2=3D?
>>=20
>> =E2=80=9CPerf list=E2=80=9D expects "param1=3D?,param2=3D?=E2=80=9D =
In the event listing
>>   # perf list|grep event1
>>   pmu/event1,param1=3D?,param2=3D?/                       [Kernel PMU =
event]
>>=20
>> The patch here address fix in =E2=80=9Cstrstr=E2=80=9D check in =
format_alias for =E2=80=9Cperf list=E2=80=9D to display these user =
expected =E2=80=9C?=E2=80=9D fields
>> in event alias.  Traditionally, perf treats config, config1, and =
config2 etc as hardcoded numeric
>> keywords or builtin keyword.
>>=20
>> The scneario sashiko brought up is interesting. Where a parameterized =
event
>> uses a built-in perf keyword  for its parameter name.
>>=20
>> sashiko review : Scenario where parameterized event uses a built-in =
perf keyword
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Example, having =E2=80=9Cconfig2=E2=80=9D in sysfs format-driven =
logic. Below is an example case.
>>=20
>>    #cat /sys/devices/pmu/events/event1
>>     config2=3D?,domain=3D1,param1=3D?,param2=3D?
>>=20
>>      # cat /sys/devices/hv_24x7/format/config2
>>         config2:0-16
>>=20
>> Here =E2=80=9Cperf list=E2=80=9D will show as (null) or might crash =
too as sashiko review pointed out.
>>=20
>>    # perf list|grep event1
>>    pmu/event1,(null)=3D?,param1=3D?,param2=3D?/                    =
[Kernel PMU event]
>>=20
>> This is because term->config is null for built-in keywords. perf =
lexer sets this to NULL
>> for predefined keywords ( like 'config', 'period'), storing the type =
in the enum instead.
>>=20
>> To fix displaying the =E2=80=9C=3D?=E2=80=9D in =E2=80=9Cperf list=E2=80=
=9D for keywords like config2,  format_alias() function needs to handle
>> null term->config , ie by using parse_events__term_type_str() to map =
NULL config
>> pointers back to their string keywords
>>=20
>> But this only will fix the =E2=80=9Cperf list=E2=80=9D part of it.  =
=E2=80=9CPerf stat=E2=80=9D or record will still fail since
>> currently these keywords are not considered as placeholders for =
=E2=80=9C?=E2=80=9D values.
>>=20
>> If a PMU wants to use any builtin-keywords in parameters and want to =
ensure
>> it is set by user, this could be useful.  Again considering this as a =
use case, we need other changes
>> to allow these built-in keywords to function as placeholders (e.g., =
config2=3D?) within a PMU alias.
>>=20
>> I am adding changes which I have identified needed for this support.
>> If it is better to post this separately as patch set and discuss, =
definitely will do that.
>> I wanted to run the idea of this new scenario with everyone. =
Apologies for the long text.
>>=20
>> Thanks and looking for comments.
>>=20
>>=20
>> =46rom 21179a76be97ef81c69a9492f0f432dec5b5361c Mon Sep 17 00:00:00 =
2001
>> From: Athira Rajeev <atrajeev@linux.ibm.com>
>> Date: Mon, 23 Mar 2026 08:38:30 -0400
>> Subject: [PATCH] tools/perf: Enable parameterized values for keywords =
like
>> config1
>>=20
>> PMU defines events that require user-supplied parameters (like chip
>> or core) are packed into specific bit-fields of the different config
>> registers. Traditionally, perf treats config, config1, and config2
>> as hardcoded numeric keywords, causing it to bypass the sysfs
>> format-driven bit-masking logic.
>>=20
>> This patch allows these built-in keywords to function as placeholders
>> (e.g., config2=3D?) within a PMU alias.
>>=20
>> Changes includes:
>> - Updated config_term_pmu in parse-events.c to recognize string
>>  placeholders for event terms. otherwise it will expect those to
>>  be of type PARSE_EVENTS__TERM_TYPE_NUM
>> - Updated pmu_config_term in pmu.c to make sure if keywords are used
>>  as placeholders , they pass through sysfs based format logic
>> (pmu_find_format) and pmu_resolve_param_term() logic
>> - Modified format_alias() to ensure "perf list" display the =
parameterized
>>  events correctly
>> - Replace snprintf with scnprintf in buffer offset calculations to
>>   ensure the 'used' count will not exceed the "len"
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> tools/perf/util/parse-events.c |  5 +++++
>> tools/perf/util/pmu.c          | 37 =
+++++++++++++++++++++++++---------
>> 2 files changed, 33 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/tools/perf/util/parse-events.c =
b/tools/perf/util/parse-events.c
>> index b9efb296bba5..282b0a0a5340 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1051,6 +1051,11 @@ static int config_term_pmu(struct =
perf_event_attr *attr,
>>                 */
>>                return 0;
>>        }
>> +
>> +       if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR && =
term->val.str)
>> +               if (strstr(term->val.str, "?"))
>> +                       return 0;
>=20
> nit: Since the nested if spans more than two lines, could you add
> curly braces {} to the outer if statement. Could you also add a
> comment explaining why the runtime parameter causes an early return
> and why you used `strstr` instead of `strcmp`?


Hi Ian

Thanks for checking and responding with review comments.
Sure I will handle this.
>=20
>> +
>>        return config_term_common(attr, term, parse_state);
>> }
>>=20
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 23337d2fa281..2c4503e1a11b 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1442,10 +1442,19 @@ static int pmu_resolve_param_term(struct =
parse_events_term *term,
>>                                  __u64 *value)
>> {
>>        struct parse_events_term *t;
>> +       const char *name =3D term->config;
>> +
>> +       if (!term->config)
>=20
> I think you meant "if (!name)" here.
Yes, will correct this=20
>=20
>> +               name =3D =
parse_events__term_type_str(term->type_term);
>>=20
>>        list_for_each_entry(t, &head_terms->terms, list) {
>> +               const char *t_name =3D t->config;
>> +
>> +               if (!t_name)
>> +                       t_name =3D =
parse_events__term_type_str(t->type_term);
>> +
>>                if (t->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM &&
>> -                   t->config && !strcmp(t->config, term->config)) {
>> +                   t_name && name && !strcmp(t_name, name)) {
>>                        t->used =3D true;
>>                        *value =3D t->val.num;
>>                        return 0;
>> @@ -1453,7 +1462,7 @@ static int pmu_resolve_param_term(struct =
parse_events_term *term,
>>        }
>>=20
>>        if (verbose > 0)
>> -               printf("Required parameter '%s' not specified\n", =
term->config);
>> +               printf("Required parameter '%s' not specified\n", =
name);
>>=20
>>        return -1;
>> }
>> @@ -1494,6 +1503,7 @@ static int pmu_config_term(const struct =
perf_pmu *pmu,
>>        struct perf_pmu_format *format;
>>        __u64 *vp;
>>        __u64 val, max_val;
>> +       const char *name;
>>=20
>>        /*
>>         * If this is a parameter we've already used for =
parameterized-eval,
>> @@ -1507,7 +1517,8 @@ static int pmu_config_term(const struct =
perf_pmu *pmu,
>>         * traditionally have had to handle not having a PMU. An alias =
may
>>         * have hard coded config values, optionally apply them below.
>>         */
>> -       if (parse_events__is_hardcoded_term(term)) {
>> +       if (parse_events__is_hardcoded_term(term) &&
>> +                      term->type_val !=3D =
PARSE_EVENTS__TERM_TYPE_STR) {
>=20
> What is being guarded against in this case? Could you update or add a =
comment.

Sure
>=20
>>                /* Config terms set all bits in the config. */
>>                DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
>>=20
>> @@ -1576,7 +1587,11 @@ static int pmu_config_term(const struct =
perf_pmu *pmu,
>>                return 0;
>>        }
>>=20
>> -       format =3D pmu_find_format(&pmu->format, term->config);
>> +       name =3D term->config;
>> +       if (!name)
>> +               name =3D =
parse_events__term_type_str(term->type_term);
>> +
>> +       format =3D pmu_find_format(&pmu->format, name);
>>        if (!format) {
>>                char *pmu_term =3D pmu_formats_string(&pmu->format);
>>                char *unknown_term;
>> @@ -2117,7 +2132,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>>                                                   =
skip_duplicate_pmus);
>>=20
>>        /* Paramemterized events have the parameters shown. */
>> -       if (strstr(alias->terms, "=3D?")) {
>> +       if (!strstr(alias->terms, "=3D?")) {
>=20
> I wonder if it would be safer if we did a `str_ends_with(alias->terms,
> "=3D?")`. This likely applies to the other strstr usage.
Ok ,=20

I will post a V2 patchset with all changes, splitting the fix patch =
which address the =E2=80=9Cstr=E2=80=9D check above
and changes to allow using the builtin-keywords as place holders within =
PMU event alias

Thanks
Athira
>=20
> Thanks,
> Ian
>=20
>>                /* No parameters. */
>>                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>                return buf;
>> @@ -2129,15 +2144,19 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>>                pr_err("Failure to parse '%s' terms '%s': %d\n",
>>                        alias->name, alias->terms, ret);
>>                parse_events_terms__exit(&terms);
>> -               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>> +               scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>                return buf;
>>        }
>> -       used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>> +       used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>>=20
>>        list_for_each_entry(term, &terms.terms, list) {
>> +               const char *name =3D term->config;
>> +
>> +               if (!name)
>> +                       name =3D =
parse_events__term_type_str(term->type_term);
>>                if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>> -                       used +=3D snprintf(buf + used, =
sub_non_neg(len, used),
>> -                                       ",%s=3D%s", term->config,
>> +                       used +=3D scnprintf(buf + used, =
sub_non_neg(len, used),
>> +                                       ",%s=3D%s", name,
>>                                        term->val.str);
>>        }
>>        parse_events_terms__exit(&terms);
>> --  2.47.3
>>=20
>>=20
>>=20
>> Thanks
>> Athira
>>=20
>>>>=20
>>>> Does this cause a NULL pointer dereference in the term iteration =
loop?
>>>>=20
>>>> list_for_each_entry(term, &terms.terms, list) {
>>>> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>>>>  used +=3D snprintf(buf + used, sub_non_neg(len, used),
>>>>    ",%s=3D%s", term->config,
>>>>    term->val.str);
>>>> }
>>>>=20
>>>> Passing a NULL pointer to the %s format specifier for term->config =
might
>>>> cause a segmentation fault or formatting corruption.
>>>>=20
>>>> Can this also lead to a stack buffer overflow due to how snprintf() =
return
>>>> values are accumulated?
>>>>=20
>>>> snprintf() returns the number of characters that would have been =
written.
>>>> If the event names and terms are long enough, the "used" variable =
can exceed
>>>> "len" (which is typically 1024 bytes).
>>>>=20
>>>> When evaluating "buf + used" in the same loop:
>>>>=20
>>>> used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);
>>>>=20
>>>> If "used" exceeds 1024, this creates an out-of-bounds pointer. =
Modern
>>>> compilers can use this undefined behavior to infer that "used" <=3D =
1024
>>>> must be true, which optimizes out the safety check inside =
sub_non_neg():
>>>>=20
>>>> static int sub_non_neg(int a, int b)
>>>> {
>>>> if (b > a)
>>>>  return 0;
>>>> return a - b;
>>>> }
>>>>=20
>>>> The compiler can reduce this to simply "a - b" (or "len - used").
>>>> If "used" is actually greater than 1024, "len - used" evaluates to =
a
>>>> negative integer. This negative value is implicitly cast to size_t =
for
>>>> snprintf(), resulting in a massive size limit.
>>>>=20
>>>> Would this cause snprintf() to write past the end of the stack =
buffer
>>>> without bounds checking? Using scnprintf() might prevent "used" =
from
>>>> exceeding "len".
>>>>=20
>>>> Thanks,
>>>> Ian
>>>>=20
>>>>>> ---
>>>>>> tools/perf/util/pmu.c | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>>>> index 23337d2fa281..0b8d58543f17 100644
>>>>>> --- a/tools/perf/util/pmu.c
>>>>>> +++ b/tools/perf/util/pmu.c
>>>>>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int =
len, const struct perf_pmu *pmu,
>>>>>> skip_duplicate_pmus);
>>>>>>=20
>>>>>> /* Paramemterized events have the parameters shown. */
>>>>>> - if (strstr(alias->terms, "=3D?")) {
>>>>>> + if (!strstr(alias->terms, "=3D?")) {
>>>>>> /* No parameters. */
>>>>>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>>>>>> return buf;
>>>>>> --
>>>>>> 2.47.3
>>>>>>=20
>>>>>=20
>>>>> Tested this patch, and its working as expected.
>>>>>=20
>>>>> Before Patch:
>>>>>=20
>>>>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>>>>> hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU =
event]
>>>>>=20
>>>>> After Patch:
>>>>>=20
>>>>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>>>>> hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
>>>>>=20
>>>>>=20
>>>>> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
>>>>>=20
>>>>>=20
>>>>> Performance counter stats for 'system wide':
>>>>>=20
>>>>>      2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
>>>>>=20
>>>>>   229.938231314 seconds time elapsed
>>>>>=20
>>>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>>>=20
>>>>> Regards,
>>>>> Venkat.



