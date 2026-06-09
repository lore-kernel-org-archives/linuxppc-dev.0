Return-Path: <linuxppc-dev+bounces-22313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4432CD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:12:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZM8d1DSTz2xR4;
	Tue, 09 Jun 2026 18:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780992753;
	cv=none; b=Q+RoN47vxhdIUTx0ezom8KBE7w1g0a3QPKaxZp8xhF16XEdokK6S/hh0xTxIftfJLOD2eKRAplTa2NmLdZeg3ZbdVhbdxqyHSt/EA8EZMGAcOjNAKpEP4nytar/GfwPpU8VHicASwqpiGxfHgHHymQDkfeVcSl/TZdBpRou4+Vl8GUJd+20Ej/EZNc7aLjUAyPjdAQqj6JT/3lRPSrp37U/Rs97uTnUlZtDu5riuWIrHrLfA7ibLudYBo1LpJHxWoNcWnB6LigUsb7T4h0GkuHxTd6VR2CFLdOmLE1IRrWbT1zs3iKJyUbiV6W6Qvo+awfS+Z28d5OYCN2p5IGl3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780992753; c=relaxed/relaxed;
	bh=z0tGhHMXsUILMgGHh1vlXD0KW0G+N0bhRSPUOPI4/L8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JqavW7puGYKIdCgnVGlo1e2JnQkfb6qkf66UtAHI5GnPylbtpK7quXUy23XfSCGYlkJrtHPU1w7LK2BT3gf1F1bvvc+z74lKPHRSIB3scttxUCsG1Jref/Y+QpS+xJmcif4mtZLqKwklsNjtcPjHjYygSt8QOGhnZrKPgH5pZa2KSYtyaJdvbD4RzIy6Ut+XwRt+/iV6bV4a62xWgPqLcDVPy9iPIrYDnjK4t+GAfMOEqzLphs2tUbxCsd0zr8IolC73Qt7HBDn8zF+MEFMr+/I2PsdOmRiXsi9icQopPm7YctLCZGLrRDpR2Otoy0xP8zmSQTOhF8oarMAuGg4uUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iEeMoQWh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iEeMoQWh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZM8b44T3z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 18:12:31 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658HF09m1423793;
	Tue, 9 Jun 2026 08:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z0tGhH
	MXsUILMgGHh1vlXD0KW0G+N0bhRSPUOPI4/L8=; b=iEeMoQWh82hcNBCzFuQov/
	64vDhhJoI1Ky9FuXNnSh8O0mdcDvq+Q0nFeh+1QHdtKdC13jiSqAw1qDbthzXKT4
	H/V00gUInLdd/JhHHPErwR+deEsodB8qgHOiSnAReNWKouNSAk9wrfTLoj/fSykH
	fuOn+vSODfpaxQHEfN/X4WTLRcB3TuuEWA6XzjXtDp9yECppYDaGrOCH3e+HnH1L
	50ASgzRHiMfD4K9NCi1zzCEelrLoSKGULe3+i3Dtb/t41K74HCAbK6kqg2oqAS1y
	N5myGREqtktJJulMUHuZ0kzN8Kz1E2xYiygBQBnAmRVzkyIbeVVDUTaz202GNclg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye319x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:12:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659851Ck026931;
	Tue, 9 Jun 2026 08:12:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjs2j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:12:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6598CJl850135520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 08:12:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B4D20043;
	Tue,  9 Jun 2026 08:12:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7677E2004B;
	Tue,  9 Jun 2026 08:12:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.212.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 08:12:16 +0000 (GMT)
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
In-Reply-To: <aiGZOn1P92CEABv3@x1>
Date: Tue, 9 Jun 2026 13:42:04 +0530
Cc: Anubhav Shelat <ashelat@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, jolsa@kernel.org,
        adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <42382891-344B-48C6-B66C-10564F34C144@linux.ibm.com>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
 <ae76k1BvfgcYI18K@google.com>
 <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com> <ag8UFqPmRu8v4g_9@x1>
 <aiGI--j2nJ_kas60@x1> <5ECBB4A2-57DE-48A0-BCFE-1B99DC4AABEE@linux.ibm.com>
 <aiGZOn1P92CEABv3@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NiBTYWx0ZWRfX6rlaF8yANUHz
 rYrKMAxXk7WQdQiM2wYyThrjilor9OUH0GlzIHBAHMPOZ4GuOMYjosMbgHJyjX3+v5zkjoikT/7
 ScGD28clumKuLzPP1/ZqVzFXzdKC/lwbnVLo05KzKMHnDwskXjSh+cAu7kklv+LSyeCwMz93pxY
 PrY5L1Dqd6GIH/4RyN0KgDrQyF83QdxjtAAUE7Y/aA8GwfujkqQrgROAQxam6VgvhwoFU5VWqLn
 uHMPumKZOAF92O46+0t8eMMkyY2RxA5kyyypkDF9Q4dnuxxYgVx8L3COgDFGBFRp9ueqivi/E1Y
 5Z2z+QImhgBBZfwkFCDuil0rW9MQyExCjE/zgezv2PixSOm+xo3U0yJIfnYRuA0KTxDIsuT+NG0
 HXfgOIyaxXmGSADYbGLI6k/vnB+uToGJMzLE9LhHeEDzoy+6CkYJ3d+Ldk4aTXpT7c0iXMXMKB3
 ky83kpCPwC4Vg639HOA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27cae8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x5QCPqNzQhPJdF4W:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=NNr4SFREUjnCiy3GEqcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zdOLePdxsP0RQsQHdGauLEYHIzYPBrjE
X-Proofpoint-ORIG-GUID: IxGzxzmLjIc8Vd40aGKd4MnvrR7wFrzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090076



> On 4 Jun 2026, at 8:56=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Thu, Jun 04, 2026 at 08:38:46PM +0530, Athira Rajeev wrote:
>>> On 4 Jun 2026, at 7:47=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>>>=20
>>> On Thu, May 21, 2026 at 11:17:58AM -0300, Arnaldo Carvalho de Melo =
wrote:
>>>> On Thu, May 21, 2026 at 02:02:53PM +0530, Athira Rajeev wrote:
>>>>>> On 27 Apr 2026, at 11:26=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>>>>>> On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
>>>>>>> In redhat perftool testsuite, observed fail for this test:
>>>>>>>  -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary =
(output regexp parsing)
>>>>>>>=20
>>>>>>> This led to analysis of "perf sched timehist" summary options.
>>>>>>>=20
>>>>>>> # perf sched record -a -o ./perf.data -- sleep 0.1
>>>>>>> This will record using perf sched record
>>>>>>>=20
>>>>>>> perf sched timeliest has two options "-s" and "-S"
>>>>>>> # perf sched -i ./perf.data timehist -S
>>>>>>> -S : Captures summary also at the end
>>>>>>>=20
>>>>>>> # perf sched -i ./perf.data timehist -s
>>>>>>> -s : Captures only summary
>>>>>>>=20
>>>>>>> The test saves -s result which has only summary and compares =
with
>>>>>>> summary which comes at the end from -S . Since there is a =
difference
>>>>>>> in these two, test fails.
>>>>>>>=20
>>>>>>> Checking the behaviour change in -S and -s results, difference =
is:
>>>>>>>=20
>>>>>>>                rcu_sched[16]       2          4        0.013     =
 0.001       0.003       0.006   33.23       0
>>>>>>>             migration/11[73]       2          1        0.006     =
 0.006       0.006       0.006    0.00       0
>>>>>>>              migration/3[33]       2          1        0.006     =
 0.006       0.006       0.006    0.00       0
>>>>>>> -               :216753[216753]      -1          1        0.041  =
    0.041       0.041       0.041    0.00       0
>>>>>>> +                 sleep[216753]      -1          1        0.041  =
    0.041       0.041       0.041    0.00       0
>>>>>>>              migration/8[58]       2          1        0.005     =
 0.005       0.005       0.005    0.00       0
>>>>>>>          NetworkManager[811]       1          2        0.089     =
 0.028       0.044       0.060   36.06       0
>>>>>>>             migration/13[83]       2          1        0.005     =
 0.005       0.005       0.005    0.00       0
>>>>>>>=20
>>>>>>> Here 216753 is pid for sleep which is a zombie process. This is
>>>>>>> happening in latest kernel due to an update in "-S" result.
>>>>>>> In -S, the process name appears in the results "sleep[216753]",
>>>>>>> where as in the -s, only pid is present in the summary result
>>>>>>> ":216753[216753]".
>>>>>>>=20
>>>>>>> After commit 39f473f6d0b2 ("perf sched timehist: decode process =
names
>>>>>>> of processes in zombie state")
>>>>>>> for -S option, if process name is using pid, it uses different =
way to
>>>>>>> set it. So that we get the process name and not just Pid.
>>>>>>>=20
>>>>>>> This change went in only for timehist_print_sample() function.
>>>>>>> Add this improvement in generic place so that even -s option =
(which
>>>>>>> captures summary) also will have meaningful information.
>>>>>>>=20
>>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>>>=20
>>>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>>>>=20
>>>>>> Thanks,
>>>>>> Namhyung
>>>>> Hi,
>>>>>=20
>>>>> Can we please have this pulled in, if the patch looks fine ?
>>>>=20
>>>> Can you please check applying it on top of current perf-tools-next?
>>>=20
>>> So, this seems to be also addressed by:
>>>=20
>>> commit 39f473f6d0b24cf375893f2110b1cc9d8a079a42
>>> Author: Anubhav Shelat <ashelat@redhat.com>
>>> Date:   Wed Jul 16 16:39:15 2025 -0400
>>>=20
>>>   perf sched timehist: decode process names of processes in zombie =
state
>>>=20
>>>   Previously when running perf trace timehist --state, when =
recording
>>>   processes in the zombie state the process name would not be =
decoded
>>>   properly and appears with just the PID:
>>>=20
>>>   1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956   =
   0.019      0.041      S
>>>   1140057.412222 [0012]  :1248612[1248612]                   0.000   =
   0.000      0.332      Z
>>>   1140057.412275 [0004]  <idle>                              0.052   =
   0.052      0.953      I
>>>   1140057.412284 [0008]  <idle>                              0.070   =
   0.070      0.932      I
>>>   1140057.412333 [0004]  KMS thread[3126/3104]               0.953   =
   0.112      0.058      S
>>>=20
>>>   Now some extra processing has been added to decode the process =
name:
>>>=20
>>>   1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956   =
   0.019      0.041      S
>>>   1140057.412222 [0012]  sleep[1248612]                      0.000   =
   0.000      0.332      Z
>>>   1140057.412275 [0004]  <idle>                              0.052   =
   0.052      0.953      I
>>>   1140057.412284 [0008]  <idle>                              0.070   =
   0.070      0.932      I
>>>   1140057.412333 [0004]  KMS thread[3126/3104]               0.953   =
   0.112      0.058      S
>>>=20
>>>   Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
>>>   Link: =
https://lore.kernel.org/r/20250716203914.45772-2-ashelat@redhat.com
>>>   Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>=20
>>>=20
>>> No? It is not applying to perf-tools-next, a quick look found the =
patch
>>> above.
>>=20
>> Hi Arnaldo
>>=20
>> commit 39f473f6d0b2 ("perf sched timehist: decode process names
>> of processes in zombie state=E2=80=9D)
>> added change for -S option. The patch I submitted is to add change in =
process name for =E2=80=9C-s=E2=80=9D option as well
>>=20
>> I will check applying this on top of current perf-tools-next
>=20
> Thanks for looking into this!
>=20
> - Arnaldo


Hi Arnaldo

I have posted rebased patch on top of perf-tools-next here : =
https://lore.kernel.org/linux-perf-users/20260607140245.95706-1-atrajeev@l=
inux.ibm.com/

Thanks
Athira


