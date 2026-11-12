Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112060A2631
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=huF7thfH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBXR6dqLz2yKn;
	Thu, 12 Nov 2026 18:16:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794467815;
	cv=none; b=jRbpkICxXJdOxPf/JuojIvpCo65iQ8bvgOJyVYBPgcIusT+ek6t1R/4cnhTK0Z5QxsBKTkA9LXYYYcXZ8fzhhtsbK5KKUtbtsSqRaIVZHi/pie1CqVDioIhOAj85X/sGNw+9Ev35ZYBf7nPdmiq37W4pF8+ZkTclKdp0Q6Yd5A5bPIk2Y86L+YJjGEF/p3qR+uEJ0twXYpgfmxbu3QihcIGBdhX+XF7CCoXsd+Otr1F7FzYth8IFKneGkPWHhnB3q4zP308vsjnJYIULz+meHV7nqxoSRzfyDreD0kqABldCo1ATYO6kdyXQ3I5k2BvMfRzPNB7+9h59Uis+Efo75w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794467815; c=relaxed/relaxed;
	bh=5jfDapiU++0yOYDy5HoVWG7Af7SSOjBHeW1wF8Daybs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iNptVKWM6Hcz+TwJfMZ3M8kZV+sZT33I2sFyxKWgRqcdT/nbPC0LLLicNuDk8SEQC9wiPuk7VOFe2qJwD/bDsygbqChLF4Udo7F0g/QhxBisanvRAD/MuMJN3y7uocZhj8O83xZbA9gC+s2nFRAGK5RN1fZNwGGNWgP6NIUjPZ9LMkv5cjG+7VIa4XOu6YMQv4jyCkOf3c0dsGfuEZdDM/kdC6xXESbP7cPIYPIFBMcnmkeEzGChr7qk5QzdRGZ51y+QPwI/vkFZiBQK4w52BGWqYU7cKZjUDJO1PNGEay+czMLOTCK+kvWRCMxinlir565VKUwFVdIdPYuEUKJmSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=huF7thfH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=huF7thfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBXQ1jctz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:16:53 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iW6Y2854664;
	Thu, 12 Nov 2026 07:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5jfDap
	iU++0yOYDy5HoVWG7Af7SSOjBHeW1wF8Daybs=; b=huF7thfH9v42RsONIEE88M
	GqIhCUkJCwr4s66/vPrO5AI6/MRUgi1vBR4p2pEotj4PORVPa0EzvBqUFIdAnYLR
	P/n/dcjXxaDSPBvsBX6AVvNftCqwu4P8a/r2JCpdRpgns/YPjqGGcvaTUTCvQegK
	Vl3UIXkgRK4YRgMgPYq25gMf3OlynTVwC6gPP9LSd20RN3IaNW3QAsIh3RbBNLfi
	zDOJ7eefdZO947Z8kC0jyuoIxJfT1nPsc/d934WHGaYHkhMwo6vqw4PmqBw+6h6+
	htPEeFNG9EHhCVJd3fmjJjNYBaueBLPu8GlnMOTdcI25pHTGbdwD9lyZSbUo0ztA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq765vm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:16:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZoqX146639;
	Thu, 12 Nov 2026 07:16:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthx5j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:16:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC7GaiQ50594052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 07:16:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F7A22006B;
	Thu, 12 Nov 2026 06:51:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 669A02006A;
	Thu, 12 Nov 2026 06:51:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Nov 2026 06:51:08 +0000 (GMT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <2CA2114E-DABF-48DC-B742-B43E0C39DDD5@linux.ibm.com>
Date: Thu, 12 Nov 2026 12:20:55 +0530
Cc: maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6D386A3-2F22-44F3-A17D-600CD9379361@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
 <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
 <00D2E602-E43D-4D23-9304-133263424B3B@linux.ibm.com>
 <ecbfbe14-5202-4efe-b829-1eb2590cceaf@intel.com>
 <04E662EC-0CC0-47C1-91B9-A96BA93496A7@linux.ibm.com>
 <0baf654e-be23-45f0-b213-c7beaf73e70b@intel.com>
 <C4D6F159-C76B-4C58-A61F-288C15C34D33@linux.ibm.com>
 <2CA2114E-DABF-48DC-B742-B43E0C39DDD5@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX9idXA7xCd1U7
 r1a5iQDji+Ku1JJl808enwaWq/rR4ERwUSEpnnSnm1+R4ytxJdUX7D81EAzQUBQOMzd/Sn9e8uD
 KQKYNqb9hGJ2NDR/aHW/Wj+GnLNPK9Y=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af567d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=T4FRJE5OeTfyX1lLRdIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CYIPEgj2WRMgAWmiOvXdMjtJLqbpsZKX
X-Proofpoint-GUID: q9GObHcl522L4J1hAnzrzyJ3fULRv3H4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX1nm5kgxG9gVU
 J+Zn+Xul4NlwUpQKVCFhRpBfJoV37m/8AvuYqg8vnDew4UyOYfT8YQ+RebhVGwgT1EkbHSbPCAo
 pfx6bEGQ1aO/ymKfKOHQ5ZR4IZi0e8V51oyXLVaEVGIGUaEd5OOmcAKWGzPY1kVVZIwEs1B77N5
 QUOt9yxXeShN7GHPtMksVETyEuC+kU/bRg3u5ZEXeKRWu3mPSVVisDGviRcASP32fVRNnC4Fnsm
 +4LnfoDISckDbkiKgZ7es/OpBZmYuuL57TxDOvnPIYc/imSlwk+0Ihu7RoxkH2xAH4Kx+7DeVVT
 +6sxRTSQLUi8hABlILyYHsvhoTQtx6a0wsYrOJWpakzTD+pLLbrEy/FSY9sYilD/gknILVsdDje
 OYiXL9siSFvQN/Btn5SbLzLp/I5Mwwtn9JhfYFH+wN42vzz5c21gQPOAZaB7TI6q9iIJdqeeFox
 MCdM/9XK7ZBVZ2e0hLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120028
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 16 Sep 2026, at 9:04=E2=80=AFAM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
>=20
>=20
>> On 17 Aug 2026, at 11:32=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 14 Aug 2026, at 7:51=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>=20
>>> On 13/08/2026 21:40, Athira Rajeev wrote:
>>>>=20
>>>>=20
>>>>> On 13 Aug 2026, at 1:17=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>>>=20
>>>>> On 13/08/2026 10:36, Athira Rajeev wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On 13 Aug 2026, at 11:52=E2=80=AFAM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>>>>>=20
>>>>>>> On 07/08/2026 17:41, Athira Rajeev wrote:
>>>>>>>> Implement the arch_perf_record__need_read() =
architecture-specific hook
>>>>>>>> for powerpc in arch/powerpc/util/evsel.c.
>>>>>>>>=20
>>>>>>>> The HTM kernel driver sets event->count to the number of =
records still
>>>>>>>> staged in its internal buffers (total_size / record_size), and =
to 0
>>>>>>>> once the stream is exhausted.  This hook reads that count for =
every open
>>>>>>>> htm evsel via perf_evsel__read() and accumulates the values =
into
>>>>>>>> total_pending_records.  A non-zero total means at least one HTM =
target
>>>>>>>> still has records pending; the recording loop added in the =
previous
>>>>>>>> patch will perform another mmap-read pass.
>>>>>>>>=20
>>>>>>>> The drain uses a two-layer safety check: event->count detects =
records
>>>>>>>> staged by the driver, and record__bytes_written() in the drain =
loop
>>>>>>>> confirms data was actually moved into perf.data.  This =
combination
>>>>>>>> handles the case where the driver count is briefly stale while =
hardware
>>>>>>>> is still flushing.
>>>>>>>>=20
>>>>>>>> The implementation scans the evlist using evsel__pmu_name() to =
identify
>>>>>>>> HTM events by their kernel-assigned PMU name rather than the
>>>>>>>> user-visible event name, preventing false matches.  It iterates =
the fd/
>>>>>>>> sample-id xyarray, and skips any evsel whose fd and sample-id =
arrays are
>>>>>>>> mismatched to avoid reading stale state.  When the accumulated =
record
>>>>>>>> count reaches zero the hook returns 0 and the recording loop =
proceeds to
>>>>>>>> disable and close the events.
>>>>>>>=20
>>>>>>> This looks like the proposed driver:
>>>>>>>=20
>>>>>>> =
https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/=

>>>>>>=20
>>>>>> Hi Adrian,
>>>>>> Thank you for the review.
>>>>>>=20
>>>>>> Could you please help clarify which specific aspect of the driver =
breaks the perf ABI? Is it the sysfs format ABI where encoding raw =
hardware topology identifiers (nodeindex, nodalchipindex, =
coreindexonchip) are used as perf_event_attr.config bit fields?
>>>>>> I am trying to confirm so that I get your feedback correctly for =
reworking on changes.
>>>>>=20
>>>>> This "draining" and "read" usage looked unusual, so I asked AI:
>>>>>=20
>>>>> I have just applied the patches for powerpc htm kernel driver - =
they are now the last 5 patches committed. Examine the design in
>>>>> comparison to how other PMU drivers are implemented. Does it =
violate the kernel API for PMUs?=20
>>>>>=20
>>>>> It said yes.
>>>>=20
>>>> Hi Adrian,
>>>> Thanks for taking the time to check this.
>>>>=20
>>>> I agree with the assessment. The core problems I understand are:
>>>> - pmu->read() issues hcalls that stop the hardware trace and dump =
the data, so any read() call ends up
>>>> silently draining and stopping the trace =E2=80=94 which isn't what =
read() is for.
>>>> - event->count is being used to signal "more data pending" which =
breaks the expected semantics.
>>>>=20
>>>> I'm going to rework this rather than continue posting on top of it.
>>>> Here is my rework plan for your review:
>>>>=20
>>>> Kernel side: workqueue-based approach:
>>>> -  pmu->read() becomes a no-op. No hcalls, no side effects.
>>>> -  pmu->stop() issues hypervisor call to freeze the hardware =
buffer, then schedules a
>>>>  work_struct (htm_drain_work_fn()) that runs in process context and =
drains the frozen buffer
>>>>  chunk by chunk into the AUX ring via perf_aux_output_end(), =
backing off on -ENOSPC to let
>>>>  userspace consume between chunks. event->count is no longer used =
as a flow-control signal.
>>>=20
>>> That sounds a bit like pmu->stop() wouldn't actually stop.
>>> I can imagine there could be issues with that.  I suspect
>>> only someone like Peter Zijlstra can advise you.
>> Sure, thanks for directing Adrian,
>> Adding Peter Zijlstra to the thread..
>>=20
>> Hi Peter,
>>=20
>> I am working on a perf PMU driver for HTM (Hardware Trace Macro) on
>> IBM POWER systems.  HTM captures hardware trace data via the H_HTM
>> hypervisor call.  The driver in the patch series exposes it as a perf =
AUX PMU so trace
>> data can be correlated with other perf events in perf.data.
>>=20
>> Patch series: =
https://lore.kernel.org/linux-perf-users/20260807144135.2607-1-atrajeev@li=
nux.ibm.com/
>> =
https://lore.kernel.org/linux-perf-users/20260807143734.1224-1-atrajeev@li=
nux.ibm.com/
>>=20
>> Adrian Hunter reviewed the series and we have some queries. I am =
reaching out for
>> your guidance on the right kernel mechanism for draining trace data =
into the
>> perf AUX buffer. Please read details below and help share your =
thoughts.
>> Apologies for the long text, I tried to explain context and concerns =
that
>> came out of the review.
>>=20
> Hi Peter,
>=20
> Gentle ping on this. Sorry to bother you again. Just wanted to check =
if you could a chance to read through my query and
> if had any thoughts or if you need any additional context from my =
side.
>=20
> Thanks,
> Athira

Hi Ian, Peter, and community,

Hi Ian,
Thanks for checking in. On the tools side, I have the changes planned to =
address Adrian's comments (dropping the custom =
arch_perf_record__need_read() hook from builtin-record.c and removing =
event->count flow-control usage). =20
However, on the kernel driver side, I am looking for feedback and =
guidance regarding the right mechanism for draining the HTM trace buffer =
into the AUX ring after pmu->stop().

Hi Peter and community,
Following up on the discussion regarding the kernel driver side in this =
thread [1]. Requesting for recommendations on the design (specifically =
regarding handling post-stop AUX buffer draining for interrupt-less, =
firmware-managed hardware buffers via a workqueue vs other approaches).

Brief recap of the problem:
- Hardware constraint: PowerPC HTM is a one-shot, firmware-managed =
buffer with no hardware interrupts. Trace data can only be read =
chunk-by-chunk via hypervisor hcalls *after* issuing a stop hcall.

What V5 of the patch series did:
--------------------------------
In V5, pmu->read() did all the work:
- On the first call: issued stop hcall to freeze the hardware buffer, =
then called hcall to dump the trace data into the AUX ring via =
perf_aux_output_begin() / perf_aux_output_end().
- Subsequent calls: skipped the stop (already frozen), copied the next =
chunk, and advanced aux_buf->head.
- Set event->count to the record count written, or 1 if the AUX ring was =
full (-ENOSPC, meaning "retry"), or 0 at EOF.
- Userspace polled event->count via perf_evsel__read() in a new weak =
arch_perf_record__need_read() hook added to builtin-record.c; a non-zero =
count triggered another record__mmap_read_all() + retry.

Review from Adrian flagged concerns with this:
- Concern 1: pmu->read() issues stop on its first call =E2=80=94 a =
hardware side effect inside pmu->read().
- Concern 2: event->count is used as a flow-control signal (1 =3D =
"retry", 0 =3D "done") rather than a real counter.

Proposed design for V6:
-----------------------
1. pmu->read() will become a clean no-op.
2. pmu->stop() freezes the trace buffer, then schedules a =
process-context workqueue (e.g. htm_drain_work_fn) to pump chunks into =
the AUX ring via perf_aux_output_begin() / perf_aux_output_end().
3. Deconfiguration and cancel_work_sync() are placed in event->destroy() =
(at close(fd)), keeping AUX mmaps and buffers alive during the drain.
4. Tools side uses auxtrace_record->read_finish() to wait for aux_head =
to settle before closing event fds.

Queries:
1. Is scheduling drain work from pmu->stop() and synchronizing in =
event->destroy() an acceptable pattern here?
2. Releasing the resources (deconfigure) will be placed in =
event->destroy() (not pmu->del()), which fires only at close(fd) =E2=80=94=
 after cancel_work_sync() ensures the workqueue is done. The AUX mmaps =
also remain valid until evlist__munmap() at that same point.
   So the workqueue can call perf_aux_output_begin() / =
perf_aux_output_end() safely because the hypervisor buffer and AUX mmaps =
are still live when it runs. Is this reasoning correct, or does perf =
core free AUX resources (free_aux / rb teardown) earlier than =
event->destroy()?
3. If not, is there another preferred pattern in perf core that can be =
used for this case?

It would be really helpful to get some pointers or guidance on this for =
posting V6.
Please share thoughts or any suggestions on this.

Thanks,
Athira Rajeev

[1] =
https://lore.kernel.org/linux-perf-users/C4D6F159-C76B-4C58-A61F-288C15C34=
D33@linux.ibm.com/

>>=20
>> Hardware constraints
>> --------------------
>> HTM is a one-shot, firmware-managed trace buffer:
>>=20
>> - Buffer size is fixed at boot time.
>>  Cannot be changed without a reboot.
>> - No hardware interrupt (no PMI, no DMA completion signal).
>> - The entire buffer is read after issuing a stop hcall.
>>  Not while tracing is active.
>> - Buffer must be copied chunk by chunk via a hypervisor hcall into
>>  the perf AUX ring (physically contiguous pages).
>>=20
>> What V5 of patch series did
>> -----------
>> In V5, pmu->read() did all the work:
>>=20
>> - On the first call: issued stop hcall to freeze the hardware
>>  buffer, then called hcall to dump the trace data into the
>>  AUX ring via perf_aux_output_begin() / perf_aux_output_end().
>> - Subsequent calls: skipped the stop (already frozen), copied the
>>  next chunk, advanced aux_buf->head.
>> - Set event->count to the record count written, or 1 if the AUX
>>  ring was full (-ENOSPC, meaning "retry"), or 0 at EOF.
>> - Userspace polled event->count via perf_evsel__read() in a new
>>  weak arch_perf_record__need_read() hook added to builtin-record.c;
>>  a non-zero count triggered another record__mmap_read_all() + retry.
>>=20
>> Review from Adrian flagged concerns with this:
>>=20
>> Concern 1: pmu->read() issues stop on its first call =E2=80=94
>>           a hardware side effect inside pmu->read().
>>=20
>> Concern 2: event->count is used as a flow-control signal
>>           (1 =3D "retry", 0 =3D "done") rather than a real counter.
>>=20
>>=20
>> Addressing the two concerns for V6
>> -----------------------------------
>> Concern 2 is straightforward to fix: remove all event->count
>> manipulation from pmu->read().  Loop termination is detected by
>> AUX head not advancing.  No event->count needed.
>>=20
>> Concern 1 is harder.  The query I have is:
>>=20
>> Is it acceptable for pmu->read() to issue stop hcall exactly
>> once (on the first drain call, not on all subsequent calls),
>> then copy trace data chunk via perf_aux_output_begin() / dump trace =
data
>> / perf_aux_output_end()?
>>=20
>> The reason for considering this approach for HTM specifically:
>>=20
>> - htm_event_init() rejects all non-sampling opens with -EOPNOTSUPP:
>>=20
>>      if (!is_sampling_event(event))
>>          return -EOPNOTSUPP;
>>=20
>>  So perf stat, BPF helpers, and any other non-record caller get
>>  -EOPNOTSUPP at perf_event_open() time.  An HTM fd can only exist
>>  inside a perf record session.  The only caller of read(fd) on an
>>  HTM event is from read hook - HTM's own drain code =E2=80=94 which
>>  calls it deliberately, knowing stop fires on the first
>>  call.  There is no unsuspecting caller path for HTM.
>>=20
>> - After the first call, pmu->read() is a pure data-mover with no
>>  further hardware side effects.
>>=20
>>=20
>> Alternative: workqueue after pmu->stop()
>> -----------------------------------------
>> If pmu->read() having any hardware side effect is not right path,
>> the alternative I was proposing is a workqueue-based approach:
>>=20
>> - pmu->read() becomes a true no-op.
>> - pmu->stop() issues hcall stop operation to freeze the hardware =
buffer,
>>  then schedules a work_struct (say htm_drain_work_fn()) that runs in
>>  process context and drains the frozen buffer chunk by chunk into
>>  the AUX ring via perf_aux_output_begin() / perf_aux_output_end(),
>>  backing off on -ENOSPC between chunks.
>> - event->count is not used as a flow-control signal.
>> - deconfigure the tracing ( releasing the resources ) in =
event->destroy()
>>=20
>> Tools side:
>> - arch_perf_record__need_read() hook is dropped =E2=80=94 no changes =
to builtin-record.c.
>> - A custom "read_finish" callback in the HTM "auxtrace_record" polls
>>  auxtrace_mmap__read_head() until the AUX head stops advancing,
>>  with a bounded maximum wait.  This ensures the workqueue drain
>>  completes before evlist__close() frees the mmaps.
>>=20
>> Adrian's concern with this approach: "That sounds like pmu->stop()
>> wouldn't actually stop.=E2=80=9D
>>=20
>> Traced through the tools code, workqueue lifetime looks safe to me =
based on this teardown sequence:
>>=20
>> main poll loop exits
>>    |
>>    v
>> out_child: (builtin-record.c)
>>    record__mmap_read_all(rec, true)   <- final AUX ring drain
>>    |
>>    |        <- read_finish called here,
>>    |              fd still open at this point
>>    |
>> perf_session__delete()                                   |
>>    v
>> return from __cmd_record()
>>    |
>>    v
>> cmd_record():
>>    evlist__delete(rec->evlist)
>>        +-- evlist__close()
>>                +-- close(*fd)         <- fd closed here
>>                                          -> release the resources
>>=20
>> So event->destroy fires after "read_finish" .
>> cancel_work_sync() in event->destroy ensures the drain
>> workqueue finishes before releasing the hypervisor
>> buffer.  The fd is still open when read_finish runs,
>> so it can safely wait for the drain.
>>=20
>> Peterz, I have tried to summarize these below and I am seeking for
>> your guidance here. Please share your thoughts.
>>=20
>> --------------------
>> 1. Is it acceptable for pmu->read() to issue stop tracing once on
>> the first drain call, given that HTM events can only be opened
>> by perf record (non-sampling opens rejected in
>> htm_event_init()), so there is no unsuspecting caller path?
>>=20
>> 2. If not, is the workqueue-after-pmu->stop() approach safe?
>> Releasing the resources ( deconfigure ) will be placed in
>> event->destroy (not pmu->del()), which fires only at close(fd) =E2=80=94=
 after
>> cancel_work_sync() ensures the workqueue is done.  The AUX mmaps
>> also remain valid until evlist__munmap() at that same point.
>> So the workqueue can call perf_aux_output_begin() /
>> perf_aux_output_end() safely because the hypervisor buffer and
>> AUX mmaps are still live when it runs.  Is this reasoning correct,
>> or does the perf core free AUX resources (free_aux / rb teardown)
>> earlier than event->destroy?
>>=20
>> 3. Is there a third approach we can go with ? please suggest if there =
is
>> another way. =20
>>=20
>> Thank you,
>> Athira Rajeev
>>=20
>>>=20
>>>>=20
>>>> Tools side:
>>>> -  arch_perf_record__need_read() hook and record__final_aux_data() =
are dropped entirely =E2=80=94 no changes to builtin-record.c.
>>>> -  =E2=80=9Cread_finish" callback is implemented in the HTM =
auxtrace_record:
>>>>   During normal recording (evsel->disabled =3D=3D false) it returns =
immediately.=20
>>>>   At session teardown, evlist__disable() sets evsel->disabled =3D =
true before the=20
>>>>   final record__mmap_read_all() call.=20
>>>>   The read_finish callback detects this and polls aux_head (via =
perf_mmap__read_head())
>>>>   in a loop, yielding delay between polls, until the AUX head stops =
advancing =E2=80=94 signalling the
>>>>   workqueue drain is complete.=20
>>>>  This gives the kernel workqueue time to finish copying chunks =
before evlist__close() frees the mmaps.
>>>>  The wait has a bounded maximum, so a stalled drain can't hang perf =
record indefinitely.
>>>> - snapshot_finish returns -EINVAL since HTM does not support =
snapshot mode.
>>>>=20
>>>> HTM has no interrupt and trace data is consumed after pmu stop .  =
Hence making this read_finish callback for
>>>> auxtrace_record to consume data.
>>>>=20
>>>> With this, data collection is moved of from .read() entirely and =
uses work queue based approach.
>>>> Can you please review , Does this approach look acceptable before I =
send the updated series?
>>>>=20
>>>> Thanks,
>>>> Athira
>>>>=20
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> Thanks,
>>>>>> Athira
>>>>>>=20
>>>>>>>=20
>>>>>>> breaks the perf ABI.
>>>>>>>=20
>>>>>>> I am not going to review any more tools patches for now.
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>>>>> ---
>>>>>>>> Changes in V5:
>>>>>>>> - When an HTM evsel is a group sibling (evsel->core.leader !=3D
>>>>>>>> &evsel->core), read through its group leader's struct =
perf_evsel
>>>>>>>> instead of the sibling directly.  perf_evsel__read_size() uses
>>>>>>>> evsel->nr_members to compute the read buffer size; nr_members =
is 0
>>>>>>>> for siblings, so size=3D0 is passed to readn(), which returns =
<=3D0 and
>>>>>>>> leaves count.val=3D0, causing the drain loop to terminate =
prematurely.
>>>>>>>> Reading through the leader avoids the zero-size buffer and =
correctly
>>>>>>>> accumulates the leader's pending count.  HTM events are always
>>>>>>>> standalone or per-target leaders in practice; the leader =
redirect
>>>>>>>> handles any grouped configuration without losing counts.
>>>>>>>>=20
>>>>>>>> Changes in V4:
>>>>>>>> - No changes from V3.
>>>>>>>>=20
>>>>>>>> Changes in V3:
>>>>>>>> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, =
"htm")
>>>>>>>> to identify HTM events, matching by kernel-assigned PMU name =
rather
>>>>>>>> than user-visible event name.
>>>>>>>> - Remove the redundant two-pass loop (first pass to set =
found_htm,
>>>>>>>> second to accumulate counts); a single pass with =
evsel__pmu_name()
>>>>>>>> is sufficient. if no HTM event exists total_pending_records =
stays 0
>>>>>>>> and the function returns 0.
>>>>>>>> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
>>>>>>>> - evsel__pmu_name() will never return "htm" for a dummy:u =
software
>>>>>>>> event.
>>>>>>>> - Rename total_pending_bytes -> total_pending_records to match =
what
>>>>>>>> the driver actually reports (event->count =3D total_size / =
record_size,
>>>>>>>> a record count, not a byte count).
>>>>>>>> - Add #include <string.h> for musl compatibility (strcmp() =
without
>>>>>>>> it warns on some toolchains).
>>>>>>>>=20
>>>>>>>> Changes in V2:
>>>>>>>> - Implements the renamed arch_perf_record__need_read() hook (V1
>>>>>>>> implemented arch_record__collect_final_data()).
>>>>>>>> - Skips evsels whose fd and sample-id xyarrays are mismatched, =
avoiding
>>>>>>>> stale-state reads.  V1 had no such guard.
>>>>>>>> - evlist__enable cycling is removed; that responsibility now =
belongs to
>>>>>>>> the drain loop in builtin-record.c added in patch 3.
>>>>>>>> - File location changed to arch/powerpc/util/evsel.c (V1 used
>>>>>>>> arch/powerpc/util/powerpc-htm.c).
>>>>>>>> - Patch is now 4/6 instead of 4/9.
>>>>>>>>=20
>>>>>>>> tools/perf/arch/powerpc/util/evsel.c | 77 =
++++++++++++++++++++++++++++
>>>>>>>> 1 file changed, 77 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git a/tools/perf/arch/powerpc/util/evsel.c =
b/tools/perf/arch/powerpc/util/evsel.c
>>>>>>>> index 2f733cdc8dbb..2b7851c70677 100644
>>>>>>>> --- a/tools/perf/arch/powerpc/util/evsel.c
>>>>>>>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>>>>>>>> @@ -1,8 +1,85 @@
>>>>>>>> // SPDX-License-Identifier: GPL-2.0
>>>>>>>> #include <stdio.h>
>>>>>>>> +#include <string.h>
>>>>>>>> +#include <unistd.h>
>>>>>>>> +#include <linux/string.h>
>>>>>>>> #include "util/evsel.h"
>>>>>>>> +#include "util/record.h"
>>>>>>>> +#include "util/evlist.h"
>>>>>>>> +#include "util/debug.h"
>>>>>>>> +#include <internal/xyarray.h>
>>>>>>>> +#include <internal/lib.h>
>>>>>>>>=20
>>>>>>>> void arch_evsel__set_sample_weight(struct evsel *evsel)
>>>>>>>> {
>>>>>>>> evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>>>>>>>> }
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * powerpc implementation of arch_perf_record__need_read().
>>>>>>>> + *
>>>>>>>> + * Reads event->count for every open HTM evsel by issuing a =
direct
>>>>>>>> + * read() on the event fd with a plain u64 buffer, bypassing =
the
>>>>>>>> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM =
evsel is
>>>>>>>> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on =
its attr;
>>>>>>>> + * perf_evsel__read() would then call perf_evsel__read_group() =
which
>>>>>>>> + * sizes the buffer by evsel->nr_members (0 for siblings), =
causing the
>>>>>>>> + * kernel to return -ENOSPC.  Reading the fd directly with =
sizeof(u64)
>>>>>>>> + * retrieves the HTM driver's plain pending-record count =
regardless of
>>>>>>>> + * group membership.
>>>>>>>> + *
>>>>>>>> + * Returns: 1 if more data exists, 0 if collection is complete
>>>>>>>> + */
>>>>>>>> +int arch_perf_record__need_read(struct evlist *evlist)
>>>>>>>> +{
>>>>>>>> + struct evsel *evsel;
>>>>>>>> + u64 total_pending_records =3D 0;
>>>>>>>> + int x, y;
>>>>>>>> +
>>>>>>>> + /* there was an error during record__open */
>>>>>>>> + if (!evlist)
>>>>>>>> + return 0;
>>>>>>>> +
>>>>>>>> + /* Read HTM event counts to check if more data is available =
*/
>>>>>>>> + evlist__for_each_entry(evlist, evsel) {
>>>>>>>> + struct perf_evsel *rd_evsel;
>>>>>>>> + struct xyarray *xy;
>>>>>>>> +
>>>>>>>> + if (strcmp(evsel__pmu_name(evsel), "htm"))
>>>>>>>> + continue;
>>>>>>>> +
>>>>>>>> + /*
>>>>>>>> + * For group siblings nr_members =3D=3D 0, which makes
>>>>>>>> + * perf_evsel__read_size() return 0 and readn() fail.
>>>>>>>> + * Read through the leader instead; perf_evsel__read_group()
>>>>>>>> + * extracts the leader's own count from the group buffer.
>>>>>>>> + */
>>>>>>>> + if (evsel->core.leader !=3D &evsel->core)
>>>>>>>> + rd_evsel =3D evsel->core.leader;
>>>>>>>> + else
>>>>>>>> + rd_evsel =3D &evsel->core;
>>>>>>>> +
>>>>>>>> + xy =3D rd_evsel->sample_id;
>>>>>>>> +
>>>>>>>> + if (xy =3D=3D NULL || rd_evsel->fd =3D=3D NULL)
>>>>>>>> + continue;
>>>>>>>> +
>>>>>>>> + if (xyarray__max_x(rd_evsel->fd) !=3D xyarray__max_x(xy) ||
>>>>>>>> +    xyarray__max_y(rd_evsel->fd) !=3D xyarray__max_y(xy)) {
>>>>>>>> + pr_debug("Unmatched FD vs sample ID array for HTM event\n");
>>>>>>>> + continue;
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> + for (x =3D 0; x < xyarray__max_x(xy); x++) {
>>>>>>>> + for (y =3D 0; y < xyarray__max_y(xy); y++) {
>>>>>>>> + struct perf_counts_values count =3D { .val =3D 0 };
>>>>>>>> +
>>>>>>>> + if (perf_evsel__read(rd_evsel, x, y, &count) =3D=3D 0)
>>>>>>>> + total_pending_records +=3D count.val;
>>>>>>>> + }
>>>>>>>> + }
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> + /* Collection is complete only when ALL hardware queues have =
no pending records */
>>>>>>>> + return (total_pending_records > 0) ? 1 : 0;
>>>>>>>> +}



