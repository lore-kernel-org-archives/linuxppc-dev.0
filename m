Return-Path: <linuxppc-dev+bounces-22046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8031DCD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:09:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWSdk08bDz2yT0;
	Fri, 05 Jun 2026 01:09:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585753;
	cv=none; b=I7OTj6VDV6dCjAJ80K5nyY6szQR2NYtPP0BjObOkFXd7Xre8CBJrCQpPigcuY8oVDNLNyiXvSvOgAd55SlQ4jNf5mweL9I6RUpy16cOXqLhPE/rMXIPyyI3BJeSpDHa1swFqqo/Tc9gNcvZ2qGVj7y3Z1I7HNfV367esD2bgwOcGLiugoNZGSiJD1X9p57RVL8Fpj9P48POMJ4hdthxWXqCg/hxOqW1SlQVOONXd7znt0FnbXrT41SxcT7idzpfxKLlpmQo9wjIanfUk8uxV4g69lhatElMQNCwUkyWgPi3AsuBdK6QcwErnElMGoIsl5QNByhxdZK9L0Tm1Aac6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585753; c=relaxed/relaxed;
	bh=80v4uHqSQWjs1QUxSMf7ZHQ3G4mekbXDDvyja00+SQQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mSGTadbSgqdHDfBiqnNttL53X4XJpkVjxOBfj7s3EFQBUOPzHlZNRiT0BxtS3f51pLIItlaB4+BWwkT6X7KjVgTZ3rw9MGHOrHFtPpqQAT4vBg8RROZRYOZ60VRNVuMn/7jl8xfKOyJO3bWCNkpSPZ0j4KHEqC/dddn30PMJDRM8lezjgr52A0kEpww93glzJsaqbEHLsh2MubVZcPzFKrmoeCJxyKYyixq+c2+f+QSpCp9fpDsATRCvweft5OTref1ZMlKHSbdjh5rF3rz7hmTZCqc5WrKfgX/rDiWGTmMokoM1ObcL3xZW9LIPLGhQ8pU16ZyGXdKXXCsuouwjgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zs03Dpbg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zs03Dpbg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSdj1VTPz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:09:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Ax2VQ2292050;
	Thu, 4 Jun 2026 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=80v4uH
	qSQWjs1QUxSMf7ZHQ3G4mekbXDDvyja00+SQQ=; b=Zs03DpbgKMPWjgcFHncOZz
	ly1DZK29DsL3ykX7o8zNpzyMiYAe3Ikmq4zf8c5Va9z/VK9IVczFKbxMuznttor0
	vJKBeK5VMJrVvGWpk4yk3g5iNRPgarsxBqsmPlVqYE+Jdr1UCKbV4SKwqqmeUQRB
	+7qCt0IugkxI4zc32X/3sXcelq5pEVlTEZnTsWaty7JRk1N7FmF57jmqXZll5nbn
	IlwSykSw4Ixve8Vkihbw+M1WIiEY3u8S6xQGJ1QcZHgBfj3rTm1jJQMRBFrXAqto
	PkO9uQhRa2nOqL1xbQrsFaXkifiwjMNNmc3fEqmjeoulwKFN4uSK/q3cAXVrNJrg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqgcvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 15:09:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654F97OH030200;
	Thu, 4 Jun 2026 15:09:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kdm6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 15:09:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654F935357278786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 15:09:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3B220043;
	Thu,  4 Jun 2026 15:09:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4F9F20040;
	Thu,  4 Jun 2026 15:08:59 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.24.150])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jun 2026 15:08:59 +0000 (GMT)
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
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aiGI--j2nJ_kas60@x1>
Date: Thu, 4 Jun 2026 20:38:46 +0530
Cc: Anubhav Shelat <ashelat@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, jolsa@kernel.org,
        adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5ECBB4A2-57DE-48A0-BCFE-1B99DC4AABEE@linux.ibm.com>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
 <ae76k1BvfgcYI18K@google.com>
 <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com> <ag8UFqPmRu8v4g_9@x1>
 <aiGI--j2nJ_kas60@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AZngkdncW9jMhErMkJXV6V-Ku-RzAFVb
X-Proofpoint-GUID: bXRfT7jvrwITSiD1bXE-5NQKXGBv6zdA
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a219515 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x5QCPqNzQhPJdF4W:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=E_gX7XLpPc_Ef3h5YmsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0NyBTYWx0ZWRfXyT+HBWZQL77H
 o3p3ki/AVl2IRZxnnCafyEpjqTWmlwahiDL25DjoP30vdxR1WAqPLZM5d/nhBB3SbuL56ITTj16
 2cQ7vf3L7IQHaHVpaApb4/IHtuZI7iKuvFBplaQTX+fcyyQJ0BN63m4hGs3dAGXK8SJKsiq1boe
 2KNrOyM+gjpTtkkPzthFoou79V6B3w+eVYO0a9Wtji93b3lSWIQjhOJscHIDU+eBWYdPl1ynnuM
 5zP1Ql9fAOLPBXMNpGZrtVIwV68KPgzj3FFxd+P995+lTxNGyoHXNj9LfgxyA4ppjaMueX2c55T
 vyqTBtFOPqJNrDpAcwcuJEATM9aSgQI1PlxbZ2x6wORjK9GzaXAxAG27Wn2307MMynbJbe1Db7I
 psKib+PlPH6mtxGHNVC5VupQy24F8o4LUFuJ0uC62wWt2CNdNm++sJ1oq02QKnMH5GgVGCTnDXh
 OVkp3vXXnE9MHNuTZ8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040147



> On 4 Jun 2026, at 7:47=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Thu, May 21, 2026 at 11:17:58AM -0300, Arnaldo Carvalho de Melo =
wrote:
>> On Thu, May 21, 2026 at 02:02:53PM +0530, Athira Rajeev wrote:
>>>> On 27 Apr 2026, at 11:26=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>>>> On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
>>>>> In redhat perftool testsuite, observed fail for this test:
>>>>>   -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary =
(output regexp parsing)
>>>>>=20
>>>>> This led to analysis of "perf sched timehist" summary options.
>>>>>=20
>>>>> # perf sched record -a -o ./perf.data -- sleep 0.1
>>>>>  This will record using perf sched record
>>>>>=20
>>>>> perf sched timeliest has two options "-s" and "-S"
>>>>> # perf sched -i ./perf.data timehist -S
>>>>> -S : Captures summary also at the end
>>>>>=20
>>>>> # perf sched -i ./perf.data timehist -s
>>>>> -s : Captures only summary
>>>>>=20
>>>>> The test saves -s result which has only summary and compares with
>>>>> summary which comes at the end from -S . Since there is a =
difference
>>>>> in these two, test fails.
>>>>>=20
>>>>> Checking the behaviour change in -S and -s results, difference is:
>>>>>=20
>>>>>                 rcu_sched[16]       2          4        0.013      =
0.001       0.003       0.006   33.23       0
>>>>>              migration/11[73]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>>>>>               migration/3[33]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>>>>> -               :216753[216753]      -1          1        0.041    =
  0.041       0.041       0.041    0.00       0
>>>>> +                 sleep[216753]      -1          1        0.041    =
  0.041       0.041       0.041    0.00       0
>>>>>               migration/8[58]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>>>>>           NetworkManager[811]       1          2        0.089      =
0.028       0.044       0.060   36.06       0
>>>>>              migration/13[83]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>>>>>=20
>>>>> Here 216753 is pid for sleep which is a zombie process. This is
>>>>> happening in latest kernel due to an update in "-S" result.
>>>>> In -S, the process name appears in the results "sleep[216753]",
>>>>> where as in the -s, only pid is present in the summary result
>>>>> ":216753[216753]".
>>>>>=20
>>>>> After commit 39f473f6d0b2 ("perf sched timehist: decode process =
names
>>>>> of processes in zombie state")
>>>>> for -S option, if process name is using pid, it uses different way =
to
>>>>> set it. So that we get the process name and not just Pid.
>>>>>=20
>>>>> This change went in only for timehist_print_sample() function.
>>>>> Add this improvement in generic place so that even -s option =
(which
>>>>> captures summary) also will have meaningful information.
>>>>>=20
>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>=20
>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>>=20
>>>> Thanks,
>>>> Namhyung
>>> Hi,
>>>=20
>>> Can we please have this pulled in, if the patch looks fine ?
>>=20
>> Can you please check applying it on top of current perf-tools-next?
>=20
> So, this seems to be also addressed by:
>=20
> commit 39f473f6d0b24cf375893f2110b1cc9d8a079a42
> Author: Anubhav Shelat <ashelat@redhat.com>
> Date:   Wed Jul 16 16:39:15 2025 -0400
>=20
>    perf sched timehist: decode process names of processes in zombie =
state
>=20
>    Previously when running perf trace timehist --state, when recording
>    processes in the zombie state the process name would not be decoded
>    properly and appears with just the PID:
>=20
>    1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956    =
  0.019      0.041      S
>    1140057.412222 [0012]  :1248612[1248612]                   0.000    =
  0.000      0.332      Z
>    1140057.412275 [0004]  <idle>                              0.052    =
  0.052      0.953      I
>    1140057.412284 [0008]  <idle>                              0.070    =
  0.070      0.932      I
>    1140057.412333 [0004]  KMS thread[3126/3104]               0.953    =
  0.112      0.058      S
>=20
>    Now some extra processing has been added to decode the process =
name:
>=20
>    1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956    =
  0.019      0.041      S
>    1140057.412222 [0012]  sleep[1248612]                      0.000    =
  0.000      0.332      Z
>    1140057.412275 [0004]  <idle>                              0.052    =
  0.052      0.953      I
>    1140057.412284 [0008]  <idle>                              0.070    =
  0.070      0.932      I
>    1140057.412333 [0004]  KMS thread[3126/3104]               0.953    =
  0.112      0.058      S
>=20
>    Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
>    Link: =
https://lore.kernel.org/r/20250716203914.45772-2-ashelat@redhat.com
>    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>=20
>=20
> No? It is not applying to perf-tools-next, a quick look found the =
patch
> above.

Hi Arnaldo

commit 39f473f6d0b2 ("perf sched timehist: decode process names
of processes in zombie state=E2=80=9D)
added change for -S option. The patch I submitted is to add change in =
process name for =E2=80=9C-s=E2=80=9D option as well

I will check applying this on top of current perf-tools-next

Thanks
Athira


>=20
> - Arnaldo



