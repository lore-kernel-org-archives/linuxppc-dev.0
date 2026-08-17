Return-Path: <linuxppc-dev+bounces-25906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9654CC5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 18:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP10K5Sbbz2y8G;
	Tue, 18 Aug 2026 04:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786989793;
	cv=none; b=EC/drSUTXWDHd/E55CkEUfDs/cUyOuAa5Pw4O/5xC3Bl7qHEOFuW2Iu7gR8L/rBvPejhzc3srDFUJNMNclBJU6Q71GlDIWHLbHGO7iNtf2KWJy+Th2uvpNk8op8hOXmK9f4rOf6T/RDPf4ybL5jnwVKWkh+yVyRvUanCRscFjwfSQMdv5mI7bjPT2WM3N4K+MSGOVBdMz3OBFqNl6y4rK33yuXOZag50wInMCvAI39AalR7ZskTFYHZpZsMnRM1qGFLKmTaKrRFDhBojoeBVz/sedEDiRE+RVusie7hSxcJ+Z/2gzgxG2fHE9+b+G1IKboEQVQ/Gf+OnbYrEuMHgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786989793; c=relaxed/relaxed;
	bh=jAeR4i4xIVBH5RYgSMD7Le4LQ50IXdG7CA3PWUFXF8g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y+cO2obaFBzizXwCZBulzfiEnh3rBxvT8F8TTCVToAn7SeIvqzSCPF/utwnhDqsTysqNQK8gGO7Yb8BHin4ABdUDcilESocJD6uz1fgKgiIEC0yrZ6FtDnBqNTt/LaRRR5cUQp5SxGm/0KGvDLO7jNQMvQlfXHq2w0J4OFIlGvFZ1E2rZ7nuFOwkLgaXiODJsxZrXXrIxXaYeMgU4Etdj6pPhqgQfvlb87lVbZDnZkTsUu7/HANkFTGAmanWoeos3LMM2voPUKxMbvkq5pVEBikZuqTYx9A4g2zhKla18O0ELRcT6cyfwrxrSpLJxMxVKK9hseqjGimjQQmvPZ4xOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSOtZi+a; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSOtZi+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP10J48rmz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 04:03:12 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFfna81806099;
	Mon, 17 Aug 2026 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jAeR4i
	4xIVBH5RYgSMD7Le4LQ50IXdG7CA3PWUFXF8g=; b=PSOtZi+aTGcu/wEmqAdE/R
	js0ef8kk3e0I6WHR8hX9yJQnVyHNO+iI4JJJkYAZUf/2qs0bnYGywnNglpcV5+Rw
	Ijn1EJx8IQdnorajqZ5owQrTGN1RG9fsimwJk5xGGwpQy6MXXRbqtX4WdnqK8g48
	pGhtm+97cwZjy4oP+DHCQvjoaCW1Px7bp4R6OLfpp/yDT0usvanjhMISc0/+F9nx
	LgXcNLgsIY0UHYpToa8zBEMmkkxUCzer/DW/rkfFYIiwWHeMtyAsBN49blfJi+sw
	WauQrlaL1y52CiL0UHhbesktv3Tx4u6dzZvrl5ynO5Id3atrmz8c8BwWufAw2Pdg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4kpnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 18:03:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HHuKdt016938;
	Mon, 17 Aug 2026 18:03:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epya8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 18:02:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HI2uWW45875620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 18:02:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 146BE2004B;
	Mon, 17 Aug 2026 18:02:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2CD20040;
	Mon, 17 Aug 2026 18:02:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.17.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Aug 2026 18:02:52 +0000 (GMT)
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
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <0baf654e-be23-45f0-b213-c7beaf73e70b@intel.com>
Date: Mon, 17 Aug 2026 23:32:40 +0530
Cc: maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4D6F159-C76B-4C58-A61F-288C15C34D33@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
 <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
 <00D2E602-E43D-4D23-9304-133263424B3B@linux.ibm.com>
 <ecbfbe14-5202-4efe-b829-1eb2590cceaf@intel.com>
 <04E662EC-0CC0-47C1-91B9-A96BA93496A7@linux.ibm.com>
 <0baf654e-be23-45f0-b213-c7beaf73e70b@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: RLW6vRD5cvAje79CyQi0wX2axbGm51f_
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a834cd5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=I05TU-iKgESFcDM3X0wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzOCBTYWx0ZWRfX89MSialhP1H+
 PsfY7eGgV5gQlsrEvAC7zVueLOzvrQWMK0SyA2Ticjd7wjxUz/2MCNrAgvGmhMkq5psehNUSvx1
 cgXRUGXUV1uZAf0S74gQsMBP+nIybBc=
X-Proofpoint-ORIG-GUID: i9HZ4VJTsjKzu6A1aA3PR9dCmMi0pI0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzOCBTYWx0ZWRfX4cRR0qg/bDI3
 grOC9KvwYpF7nUSpVIS1sLEAzXmBhxY6W81UDM2I44WeYN//en93W3TXuXysxJsyNBnNCbWTkUH
 YQEwa36+UffK9xfuVU3dENGR4l+zC1+ycG3E/RSapdhdBWN2cc0DJr9PizJs5Xkzg5lzTSgRBXR
 93lEZilQJcUS9eeo/ueuEPFkFP8gemlCK3n9iCjKBubH1mdt6M+cgZvLUAMiWAS8DvNDeST5Bt8
 hU5U97Wu57mAaHh3Q4YWe4pq+ldw8f+JpmKJVQcTZG0Of9j0wcXbeBqHojDywNAj1b21XUN/+Mc
 +ID6IQ4ysoC6Lax9LBAmph1dysWYiD89LBQI7N2lM7mSq4DgtknPg/h0/F0ioS76sAxNmaTWTEc
 tMC/Zj6FTeFgPqFpi3EINu2XKWj0FSkbzjwKgKq8Gr9V9Obu+X2IVoZx+2kgO0VebvO4mHB2NOH
 y77mysLIl91yTMr2FZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170138



> On 14 Aug 2026, at 7:51=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
> On 13/08/2026 21:40, Athira Rajeev wrote:
>>=20
>>=20
>>> On 13 Aug 2026, at 1:17=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>=20
>>> On 13/08/2026 10:36, Athira Rajeev wrote:
>>>>=20
>>>>=20
>>>>> On 13 Aug 2026, at 11:52=E2=80=AFAM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>>>=20
>>>>> On 07/08/2026 17:41, Athira Rajeev wrote:
>>>>>> Implement the arch_perf_record__need_read() architecture-specific =
hook
>>>>>> for powerpc in arch/powerpc/util/evsel.c.
>>>>>>=20
>>>>>> The HTM kernel driver sets event->count to the number of records =
still
>>>>>> staged in its internal buffers (total_size / record_size), and to =
0
>>>>>> once the stream is exhausted.  This hook reads that count for =
every open
>>>>>> htm evsel via perf_evsel__read() and accumulates the values into
>>>>>> total_pending_records.  A non-zero total means at least one HTM =
target
>>>>>> still has records pending; the recording loop added in the =
previous
>>>>>> patch will perform another mmap-read pass.
>>>>>>=20
>>>>>> The drain uses a two-layer safety check: event->count detects =
records
>>>>>> staged by the driver, and record__bytes_written() in the drain =
loop
>>>>>> confirms data was actually moved into perf.data.  This =
combination
>>>>>> handles the case where the driver count is briefly stale while =
hardware
>>>>>> is still flushing.
>>>>>>=20
>>>>>> The implementation scans the evlist using evsel__pmu_name() to =
identify
>>>>>> HTM events by their kernel-assigned PMU name rather than the
>>>>>> user-visible event name, preventing false matches.  It iterates =
the fd/
>>>>>> sample-id xyarray, and skips any evsel whose fd and sample-id =
arrays are
>>>>>> mismatched to avoid reading stale state.  When the accumulated =
record
>>>>>> count reaches zero the hook returns 0 and the recording loop =
proceeds to
>>>>>> disable and close the events.
>>>>>=20
>>>>> This looks like the proposed driver:
>>>>>=20
>>>>> =
https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/=

>>>>=20
>>>> Hi Adrian,
>>>> Thank you for the review.
>>>>=20
>>>> Could you please help clarify which specific aspect of the driver =
breaks the perf ABI? Is it the sysfs format ABI where encoding raw =
hardware topology identifiers (nodeindex, nodalchipindex, =
coreindexonchip) are used as perf_event_attr.config bit fields?
>>>> I am trying to confirm so that I get your feedback correctly for =
reworking on changes.
>>>=20
>>> This "draining" and "read" usage looked unusual, so I asked AI:
>>>=20
>>> I have just applied the patches for powerpc htm kernel driver - they =
are now the last 5 patches committed. Examine the design in
>>> comparison to how other PMU drivers are implemented. Does it violate =
the kernel API for PMUs?=20
>>>=20
>>> It said yes.
>>=20
>> Hi Adrian,
>> Thanks for taking the time to check this.
>>=20
>> I agree with the assessment. The core problems I understand are:
>> - pmu->read() issues hcalls that stop the hardware trace and dump the =
data, so any read() call ends up
>> silently draining and stopping the trace =E2=80=94 which isn't what =
read() is for.
>> - event->count is being used to signal "more data pending" which =
breaks the expected semantics.
>>=20
>> I'm going to rework this rather than continue posting on top of it.
>> Here is my rework plan for your review:
>>=20
>> Kernel side: workqueue-based approach:
>> -  pmu->read() becomes a no-op. No hcalls, no side effects.
>> -  pmu->stop() issues hypervisor call to freeze the hardware buffer, =
then schedules a
>>     work_struct (htm_drain_work_fn()) that runs in process context =
and drains the frozen buffer
>>     chunk by chunk into the AUX ring via perf_aux_output_end(), =
backing off on -ENOSPC to let
>>     userspace consume between chunks. event->count is no longer used =
as a flow-control signal.
>=20
> That sounds a bit like pmu->stop() wouldn't actually stop.
> I can imagine there could be issues with that.  I suspect
> only someone like Peter Zijlstra can advise you.
Sure, thanks for directing Adrian,
Adding Peter Zijlstra to the thread..

Hi Peter,

I am working on a perf PMU driver for HTM (Hardware Trace Macro) on
IBM POWER systems.  HTM captures hardware trace data via the H_HTM
hypervisor call.  The driver in the patch series exposes it as a perf =
AUX PMU so trace
data can be correlated with other perf events in perf.data.

Patch series: =
https://lore.kernel.org/linux-perf-users/20260807144135.2607-1-atrajeev@li=
nux.ibm.com/
=
https://lore.kernel.org/linux-perf-users/20260807143734.1224-1-atrajeev@li=
nux.ibm.com/

Adrian Hunter reviewed the series and we have some queries. I am =
reaching out for
your guidance on the right kernel mechanism for draining trace data into =
the
perf AUX buffer. Please read details below and help share your thoughts.
Apologies for the long text, I tried to explain context and concerns =
that
came out of the review.


Hardware constraints
--------------------
HTM is a one-shot, firmware-managed trace buffer:

  - Buffer size is fixed at boot time.
    Cannot be changed without a reboot.
  - No hardware interrupt (no PMI, no DMA completion signal).
  - The entire buffer is read after issuing a stop hcall.
    Not while tracing is active.
  - Buffer must be copied chunk by chunk via a hypervisor hcall into
    the perf AUX ring (physically contiguous pages).

What V5 of patch series did
-----------
In V5, pmu->read() did all the work:

- On the first call: issued stop hcall to freeze the hardware
    buffer, then called hcall to dump the trace data into the
    AUX ring via perf_aux_output_begin() / perf_aux_output_end().
  - Subsequent calls: skipped the stop (already frozen), copied the
    next chunk, advanced aux_buf->head.
 - Set event->count to the record count written, or 1 if the AUX
    ring was full (-ENOSPC, meaning "retry"), or 0 at EOF.
  - Userspace polled event->count via perf_evsel__read() in a new
    weak arch_perf_record__need_read() hook added to builtin-record.c;
    a non-zero count triggered another record__mmap_read_all() + retry.

Review from Adrian flagged concerns with this:

  Concern 1: pmu->read() issues stop on its first call =E2=80=94
             a hardware side effect inside pmu->read().

  Concern 2: event->count is used as a flow-control signal
             (1 =3D "retry", 0 =3D "done") rather than a real counter.


Addressing the two concerns for V6
-----------------------------------
Concern 2 is straightforward to fix: remove all event->count
manipulation from pmu->read().  Loop termination is detected by
AUX head not advancing.  No event->count needed.

Concern 1 is harder.  The query I have is:

  Is it acceptable for pmu->read() to issue stop hcall exactly
  once (on the first drain call, not on all subsequent calls),
  then copy trace data chunk via perf_aux_output_begin() / dump trace =
data
  / perf_aux_output_end()?

The reason for considering this approach for HTM specifically:

  - htm_event_init() rejects all non-sampling opens with -EOPNOTSUPP:

        if (!is_sampling_event(event))
            return -EOPNOTSUPP;

    So perf stat, BPF helpers, and any other non-record caller get
    -EOPNOTSUPP at perf_event_open() time.  An HTM fd can only exist
    inside a perf record session.  The only caller of read(fd) on an
    HTM event is from read hook - HTM's own drain code =E2=80=94 which
    calls it deliberately, knowing stop fires on the first
    call.  There is no unsuspecting caller path for HTM.

  - After the first call, pmu->read() is a pure data-mover with no
    further hardware side effects.


Alternative: workqueue after pmu->stop()
-----------------------------------------
If pmu->read() having any hardware side effect is not right path,
the alternative I was proposing is a workqueue-based approach:

  - pmu->read() becomes a true no-op.
  - pmu->stop() issues hcall stop operation to freeze the hardware =
buffer,
    then schedules a work_struct (say htm_drain_work_fn()) that runs in
    process context and drains the frozen buffer chunk by chunk into
    the AUX ring via perf_aux_output_begin() / perf_aux_output_end(),
    backing off on -ENOSPC between chunks.
  - event->count is not used as a flow-control signal.
  - deconfigure the tracing ( releasing the resources ) in =
event->destroy()

Tools side:
  - arch_perf_record__need_read() hook is dropped =E2=80=94 no changes =
to builtin-record.c.
  - A custom "read_finish" callback in the HTM "auxtrace_record" polls
    auxtrace_mmap__read_head() until the AUX head stops advancing,
    with a bounded maximum wait.  This ensures the workqueue drain
    completes before evlist__close() frees the mmaps.

Adrian's concern with this approach: "That sounds like pmu->stop()
wouldn't actually stop.=E2=80=9D

Traced through the tools code, workqueue lifetime looks safe to me based =
on this teardown sequence:

  main poll loop exits
      |
      v
  out_child: (builtin-record.c)
      record__mmap_read_all(rec, true)   <- final AUX ring drain
      |
      |        <- read_finish called here,
      |              fd still open at this point
      |
  perf_session__delete()                                   |
      v
  return from __cmd_record()
      |
      v
  cmd_record():
      evlist__delete(rec->evlist)
          +-- evlist__close()
                  +-- close(*fd)         <- fd closed here
                                            -> release the resources

So event->destroy fires after "read_finish" .
cancel_work_sync() in event->destroy ensures the drain
workqueue finishes before releasing the hypervisor
buffer.  The fd is still open when read_finish runs,
so it can safely wait for the drain.

Peterz, I have tried to summarize these below and I am seeking for
your guidance here. Please share your thoughts.

--------------------
1. Is it acceptable for pmu->read() to issue stop tracing once on
   the first drain call, given that HTM events can only be opened
   by perf record (non-sampling opens rejected in
   htm_event_init()), so there is no unsuspecting caller path?

2. If not, is the workqueue-after-pmu->stop() approach safe?
   Releasing the resources ( deconfigure ) will be placed in
   event->destroy (not pmu->del()), which fires only at close(fd) =E2=80=94=
 after
   cancel_work_sync() ensures the workqueue is done.  The AUX mmaps
   also remain valid until evlist__munmap() at that same point.
   So the workqueue can call perf_aux_output_begin() /
   perf_aux_output_end() safely because the hypervisor buffer and
   AUX mmaps are still live when it runs.  Is this reasoning correct,
   or does the perf core free AUX resources (free_aux / rb teardown)
   earlier than event->destroy?

3. Is there a third approach we can go with ? please suggest if there is
   another way. =20

Thank you,
Athira Rajeev

>=20
>>=20
>> Tools side:
>> -  arch_perf_record__need_read() hook and record__final_aux_data() =
are dropped entirely =E2=80=94 no changes to builtin-record.c.
>> -  =E2=80=9Cread_finish" callback is implemented in the HTM =
auxtrace_record:
>>      During normal recording (evsel->disabled =3D=3D false) it =
returns immediately.=20
>>      At session teardown, evlist__disable() sets evsel->disabled =3D =
true before the=20
>>      final record__mmap_read_all() call.=20
>>      The read_finish callback detects this and polls aux_head (via =
perf_mmap__read_head())
>>      in a loop, yielding delay between polls, until the AUX head =
stops advancing =E2=80=94 signalling the
>>      workqueue drain is complete.=20
>>     This gives the kernel workqueue time to finish copying chunks =
before evlist__close() frees the mmaps.
>>     The wait has a bounded maximum, so a stalled drain can't hang =
perf record indefinitely.
>> - snapshot_finish returns -EINVAL since HTM does not support snapshot =
mode.
>>=20
>> HTM has no interrupt and trace data is consumed after pmu stop .  =
Hence making this read_finish callback for
>> auxtrace_record to consume data.
>>=20
>> With this, data collection is moved of from .read() entirely and uses =
work queue based approach.
>> Can you please review , Does this approach look acceptable before I =
send the updated series?
>>=20
>> Thanks,
>> Athira
>>=20
>>=20
>>>=20
>>>>=20
>>>> Thanks,
>>>> Athira
>>>>=20
>>>>>=20
>>>>> breaks the perf ABI.
>>>>>=20
>>>>> I am not going to review any more tools patches for now.
>>>>>=20
>>>>>>=20
>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>>> ---
>>>>>> Changes in V5:
>>>>>> - When an HTM evsel is a group sibling (evsel->core.leader !=3D
>>>>>> &evsel->core), read through its group leader's struct perf_evsel
>>>>>> instead of the sibling directly.  perf_evsel__read_size() uses
>>>>>> evsel->nr_members to compute the read buffer size; nr_members is =
0
>>>>>> for siblings, so size=3D0 is passed to readn(), which returns <=3D0=
 and
>>>>>> leaves count.val=3D0, causing the drain loop to terminate =
prematurely.
>>>>>> Reading through the leader avoids the zero-size buffer and =
correctly
>>>>>> accumulates the leader's pending count.  HTM events are always
>>>>>> standalone or per-target leaders in practice; the leader redirect
>>>>>> handles any grouped configuration without losing counts.
>>>>>>=20
>>>>>> Changes in V4:
>>>>>> - No changes from V3.
>>>>>>=20
>>>>>> Changes in V3:
>>>>>> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, =
"htm")
>>>>>> to identify HTM events, matching by kernel-assigned PMU name =
rather
>>>>>> than user-visible event name.
>>>>>> - Remove the redundant two-pass loop (first pass to set =
found_htm,
>>>>>> second to accumulate counts); a single pass with =
evsel__pmu_name()
>>>>>> is sufficient. if no HTM event exists total_pending_records stays =
0
>>>>>> and the function returns 0.
>>>>>> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
>>>>>> - evsel__pmu_name() will never return "htm" for a dummy:u =
software
>>>>>> event.
>>>>>> - Rename total_pending_bytes -> total_pending_records to match =
what
>>>>>> the driver actually reports (event->count =3D total_size / =
record_size,
>>>>>> a record count, not a byte count).
>>>>>> - Add #include <string.h> for musl compatibility (strcmp() =
without
>>>>>> it warns on some toolchains).
>>>>>>=20
>>>>>> Changes in V2:
>>>>>> - Implements the renamed arch_perf_record__need_read() hook (V1
>>>>>> implemented arch_record__collect_final_data()).
>>>>>> - Skips evsels whose fd and sample-id xyarrays are mismatched, =
avoiding
>>>>>> stale-state reads.  V1 had no such guard.
>>>>>> - evlist__enable cycling is removed; that responsibility now =
belongs to
>>>>>> the drain loop in builtin-record.c added in patch 3.
>>>>>> - File location changed to arch/powerpc/util/evsel.c (V1 used
>>>>>> arch/powerpc/util/powerpc-htm.c).
>>>>>> - Patch is now 4/6 instead of 4/9.
>>>>>>=20
>>>>>> tools/perf/arch/powerpc/util/evsel.c | 77 =
++++++++++++++++++++++++++++
>>>>>> 1 file changed, 77 insertions(+)
>>>>>>=20
>>>>>> diff --git a/tools/perf/arch/powerpc/util/evsel.c =
b/tools/perf/arch/powerpc/util/evsel.c
>>>>>> index 2f733cdc8dbb..2b7851c70677 100644
>>>>>> --- a/tools/perf/arch/powerpc/util/evsel.c
>>>>>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>>>>>> @@ -1,8 +1,85 @@
>>>>>> // SPDX-License-Identifier: GPL-2.0
>>>>>> #include <stdio.h>
>>>>>> +#include <string.h>
>>>>>> +#include <unistd.h>
>>>>>> +#include <linux/string.h>
>>>>>> #include "util/evsel.h"
>>>>>> +#include "util/record.h"
>>>>>> +#include "util/evlist.h"
>>>>>> +#include "util/debug.h"
>>>>>> +#include <internal/xyarray.h>
>>>>>> +#include <internal/lib.h>
>>>>>>=20
>>>>>> void arch_evsel__set_sample_weight(struct evsel *evsel)
>>>>>> {
>>>>>> evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>>>>>> }
>>>>>> +
>>>>>> +/*
>>>>>> + * powerpc implementation of arch_perf_record__need_read().
>>>>>> + *
>>>>>> + * Reads event->count for every open HTM evsel by issuing a =
direct
>>>>>> + * read() on the event fd with a plain u64 buffer, bypassing the
>>>>>> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM =
evsel is
>>>>>> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on =
its attr;
>>>>>> + * perf_evsel__read() would then call perf_evsel__read_group() =
which
>>>>>> + * sizes the buffer by evsel->nr_members (0 for siblings), =
causing the
>>>>>> + * kernel to return -ENOSPC.  Reading the fd directly with =
sizeof(u64)
>>>>>> + * retrieves the HTM driver's plain pending-record count =
regardless of
>>>>>> + * group membership.
>>>>>> + *
>>>>>> + * Returns: 1 if more data exists, 0 if collection is complete
>>>>>> + */
>>>>>> +int arch_perf_record__need_read(struct evlist *evlist)
>>>>>> +{
>>>>>> + struct evsel *evsel;
>>>>>> + u64 total_pending_records =3D 0;
>>>>>> + int x, y;
>>>>>> +
>>>>>> + /* there was an error during record__open */
>>>>>> + if (!evlist)
>>>>>> + return 0;
>>>>>> +
>>>>>> + /* Read HTM event counts to check if more data is available */
>>>>>> + evlist__for_each_entry(evlist, evsel) {
>>>>>> + struct perf_evsel *rd_evsel;
>>>>>> + struct xyarray *xy;
>>>>>> +
>>>>>> + if (strcmp(evsel__pmu_name(evsel), "htm"))
>>>>>> + continue;
>>>>>> +
>>>>>> + /*
>>>>>> + * For group siblings nr_members =3D=3D 0, which makes
>>>>>> + * perf_evsel__read_size() return 0 and readn() fail.
>>>>>> + * Read through the leader instead; perf_evsel__read_group()
>>>>>> + * extracts the leader's own count from the group buffer.
>>>>>> + */
>>>>>> + if (evsel->core.leader !=3D &evsel->core)
>>>>>> + rd_evsel =3D evsel->core.leader;
>>>>>> + else
>>>>>> + rd_evsel =3D &evsel->core;
>>>>>> +
>>>>>> + xy =3D rd_evsel->sample_id;
>>>>>> +
>>>>>> + if (xy =3D=3D NULL || rd_evsel->fd =3D=3D NULL)
>>>>>> + continue;
>>>>>> +
>>>>>> + if (xyarray__max_x(rd_evsel->fd) !=3D xyarray__max_x(xy) ||
>>>>>> +    xyarray__max_y(rd_evsel->fd) !=3D xyarray__max_y(xy)) {
>>>>>> + pr_debug("Unmatched FD vs sample ID array for HTM event\n");
>>>>>> + continue;
>>>>>> + }
>>>>>> +
>>>>>> + for (x =3D 0; x < xyarray__max_x(xy); x++) {
>>>>>> + for (y =3D 0; y < xyarray__max_y(xy); y++) {
>>>>>> + struct perf_counts_values count =3D { .val =3D 0 };
>>>>>> +
>>>>>> + if (perf_evsel__read(rd_evsel, x, y, &count) =3D=3D 0)
>>>>>> + total_pending_records +=3D count.val;
>>>>>> + }
>>>>>> + }
>>>>>> + }
>>>>>> +
>>>>>> + /* Collection is complete only when ALL hardware queues have no =
pending records */
>>>>>> + return (total_pending_records > 0) ? 1 : 0;
>>>>>> +}



