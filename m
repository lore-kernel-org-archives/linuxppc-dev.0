Return-Path: <linuxppc-dev+bounces-25860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE093C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:15:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM1Qy3hSQz2ypW;
	Fri, 14 Aug 2026 22:15:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786709754;
	cv=none; b=OuVOvLDbSgZg1nicrS9/G6L+1UqPdiE2zXg1kHaGPjTivEd4JmFFx7LgzqQcazgdfyidmPeAMIkESzrGdegJXZcQQgOR9gV4YoNP1pQ77/bEGQzRUjFpaqkM3bPCAH4G/my7DcbjQSQcxrtXTnJRGWwrANPDOYiPVHdYJg2X0mojVZgbaUW2eM39ZpUmxUVugy+UmtUyPIA6jl/PApRUiQGgEfKnUyfwBWK9My5qnKIvTlcANgd+bXKtQsAaBMYJbd8GuwEC64ayAmzA0DVGIBAog08R3v0SbCfZBAiIpVnZ4W8+ODJuIt1Ren/iGbc8grP3JXrETt89geogG+wH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786709754; c=relaxed/relaxed;
	bh=NFErWawmejesM/wdDNiV7H7JJ/nBut4zCjYKn6XicYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPOPskJmxptYO5dYFVHP3Mg0ZdR5c3ogg+13GMRmlDIUwzNc+XSXtTEgRmqo6PN2IClpdiN/u7SZ24J8RtxEQalpkdFNY0YTO5+f1ibP6CLyDpF/uyz9PFghHESdSnRIn2zneV+VOf36JnH67D3EYj4w2ynbVJjE233p48CJcCCu32yc2LRquMtlG9EfICq1DObggup19el/nPzMTkWDFunVb1pMMNi5hkLesZtgGJg49c3j0m1dykoqGjnmXL8aGz10DWWYdvt33mvASKL2eOT3DJAt7MN8pvEwDzApU2a5RkjBW7SXdMk/Jk5PJfRSawvT7lnAJC/T5DDEjWyJJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fchkRIGQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fchkRIGQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM1Qx2kT1z2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 22:15:53 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1q7N903870;
	Fri, 14 Aug 2026 12:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NFErWa
	wmejesM/wdDNiV7H7JJ/nBut4zCjYKn6XicYA=; b=fchkRIGQdiup5nNdjbtB+1
	XTH9czMuum1ENLfPrSZhP0QgFn+Y2ZeDiELkhymthFdup4vnB9NtDKjXGNAaVoYi
	0O8XaMxTvwkAIXRZTUtwn/AnlxTA+rTHlkcOG84LN9j/9Hzs4UlllFpjp/rbrmGz
	twYCpnnrljQIUMTe4BOIwwx/qmhsoxcd1x3Q1b8Sl9ZfYgUNuoargWg3gdugKQGo
	WIEvp5KNl1DVPBiPbg6v10dPROUdKRtLl0jQoQ3aGxeRn9SzKfcRFo6Grg9ev+FA
	J64juvxgcBOHU39rvY1iGZnRhgqfqb4Ol/5XOyEQukaU44XlAWSq6M/uGcHeGS6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vmu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:15:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECBPIA021710;
	Fri, 14 Aug 2026 12:15:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gq378-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:15:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ECFk4J12452230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:15:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 769DA2004D;
	Fri, 14 Aug 2026 12:15:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C35820043;
	Fri, 14 Aug 2026 12:15:45 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.210.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 12:15:45 +0000 (GMT)
Date: Fri, 14 Aug 2026 17:45:42 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/perf: Use the aggregate context switch
 values from vcpu struct
Message-ID: <an8G7vj-wSNZFjGS@Gautams-MacBook-Pro.local>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-3-gautam@linux.ibm.com>
 <20260813095851.4D9CD1F000E9@smtp.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813095851.4D9CD1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3XlVBCoGYR6lnUXCdnJEOqVi-Al5-92G
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f06f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=IGmtsB82vXp12Oa3oEcA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX3N//VLamV7ux
 ODoUmriOfeFDfTtPLf39d2hquLLomB4OPHKTRogoS4e2gu2BnKLxj0vFMpq6koxgKHpgFLi2gms
 v9NJVEsTkghayR5mHTHXwLHM7R/YmckXBdDPREIwJS7YImaRAqGBYLyDDD+kme2etFojTLwclUc
 S/yqEq52PaYV8NRmGPKrHqLcrnpyDLkrmK17ZnY7/ufbVrnrfu7P9DCH/YPuVniuXRLkFxBcsfy
 DM20PX2fGf3fMtkrqH/960CBcS++8Vw8lpjcmyzWoY/uwN4JWgvFG52uIsvc/M7q9Zo0ESNYqo+
 bT9wzNUyIuRk7/zl2pD/efumhbXOYZz43jUbVJgsU8b/wW4L0YvjSK0d6mrM1HGIhvm5uLiS75V
 Wy60D6lNQhs/dXgYBiYhxiTIVIQ/s5ixrgGQTYvvRzI40MBjXAN/bXgWGEWqOUTc7NWhL5lZJB5
 Yzl2Kf1Y3IxQ2xA95DA==
X-Proofpoint-ORIG-GUID: 3XlVBCoGYR6lnUXCdnJEOqVi-Al5-92G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX3Y1nZ7Y5BgHM
 VJSmhKvP+gqofKFllj9Umhm6i+yrPwI7frWql4pD6sgmXNDtGoLYu2v+vRotS1CLif5QluKvnrs
 l2AI+AsZY6h8EKu912dBkHZ+Q3SvB4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091

On Thu, Aug 13, 2026 at 09:58:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Task-bound PMU events cache a stale vCPU pointer, resulting in tracking the wrong vCPU.
> - [High] CPU-wide and system-wide PMU events are broken and silently report 0 if added when no guest is running.
> - [High] Uninitialized event state on task migration leaks stale vCPU pointers.
> - [Medium] Unbalanced disablement of the global hardware PMU counters.
> 
> Pre-existing issues:
> - [Critical] Dereferencing `kvm_hstate.kvm_vcpu` leads to a Use-After-Free if the previously running VM has been destroyed.
> --
> 
> --- Patch [2]: [PATCH v2 2/3] powerpc/perf: Use the aggregate context switch values from vcpu struct ---
> commit e328e1f6c8baf0140410c1983f559e87d1d0efdc
> Author: Gautam Menghani <gautam@linux.ibm.com>
> powerpc/perf: Use the aggregate context switch values from vcpu struct
> 
> This commit aims to fix inaccurate vpa-pmu counter reporting during vCPU
> migrations and when vCPUs are not running by fetching aggregate values
> from the vcpu struct instead of relying on the host cpu's PACA.
> 
> > diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> > --- a/arch/powerpc/perf/vpa-pmu.c
> > +++ b/arch/powerpc/perf/vpa-pmu.c
> [ ... ]
> > @@ -99,19 +99,19 @@ static unsigned long get_counter_data(struct perf_event *event)
> >  	switch (config) {
> >  	case L1_TO_L2_CS_LAT:
> >  		if (event->attach_state & PERF_ATTACH_TASK)
> > -			data = kvmhv_get_l1_to_l2_cs_time_vcpu();
> > +			data = vcpu->arch.l1_to_l2_cs;
> 
> [Severity: Critical]
> This is a pre-existing issue, but does dereferencing the vcpu pointer here
> lead to a use-after-free if the previously running VM has been destroyed?
> 
> When KVM exits a guest, it does not clear local_paca->kvm_hstate.kvm_vcpu,
> leaving a dangling pointer in the host's PACA. 
> 
> The PMU driver reads this dangling pointer in vpa_pmu_add() and permanently
> caches it in event->pmu_private. Subsequent calls to vpa_pmu_read() pass
> this cached pointer to get_counter_data(), which dereferences the freed
> memory here.
> 
> >  		else
> >  			data = kvmhv_get_l1_to_l2_cs_time();
> >  		break;
> [ ... ]
> > @@ -126,21 +126,33 @@ static int vpa_pmu_add(struct perf_event *event, int flags)
> >  {
> >  	u64 data;
> > +	struct kvm_vcpu *vcpu;
> >  
> > +	vcpu = local_paca->kvm_hstate.kvm_vcpu;
> > +	if (!vcpu)
> > +		goto out;
> 

A dangling pointer is stored, but will that cause a UAF? When tracing a
particular tid/pid, the perf stat command exits if the pid (guest) is destroyed.

> [Severity: High]
> Does this early exit break CPU-wide and system-wide profiling?
> 
> If a user initiates a CPU-wide profiling session (e.g. perf stat -a) and no
> guest is actively running on that specific CPU at that moment, vcpu is NULL.
> The function exits early returning 0 without initializing event->pmu_private
> or event->hw.prev_count. 
> 
> Subsequent calls to vpa_pmu_read() check if (!vcpu) and immediately return,
> silently leaving the event counter permanently at 0.

The vpa-pmu driver is only meant to report context switch times of individual
vCPUs. So reporting 0 when a vCPU is not running is expected behaviour.

> 
> [Severity: High]
> Could this early exit also leak state from a previous CPU when a task
> migrates?
> 
> When a task with a vpa_pmu event migrates to a new CPU, perf core calls
> pmu->del on the old CPU and pmu->add on the new CPU. If vcpu is NULL on the
> new CPU, it returns 0 (success) but jumps to out without updating or
> clearing event->pmu_private. 
> 
> The event silently retains the old vcpu pointer and prev_count from the
> previous CPU, resulting in corrupted profiling data calculated against an
> unrelated CPU's context.

Yes, valid point.

> 
> [Severity: Medium]
> Are the global hardware PMU counters skipped here on early bailout, leading
> to an unbalanced disablement later?
> 
> If a user creates a PMU event on a CPU where no vCPU is active, this early
> exit skips calling kvmhv_set_l2_counters_status(cpu, true). 
> 
> However, when the event is deleted or scheduled out, vpa_pmu_del()
> unconditionally calls kvmhv_set_l2_counters_status(cpu, false). This
> unbalanced behavior forcefully disables the hardware counters even when they
> were never enabled, which could break legitimate concurrent KVM tracing
> sessions.

Valid find - in vpa_pmu_del() the counters should be disabled only if they
were enabled in vpa_pmu_add()

> 
> > +
> > +	event->pmu_private = vcpu;
> 
> [Severity: High]
> Is it possible caching the vcpu pointer here results in tracking the wrong
> vCPU for task-bound events?
> 
> When a user creates a task-bound vpa_pmu perf event, the core perf
> subsystem calls vpa_pmu_add() during perf_event_context_sched_in(). At this
> point, the task has been scheduled but has not yet invoked the KVM_RUN
> ioctl.
> 
> Because of this, local_paca->kvm_hstate.kvm_vcpu does not point to the
> incoming task's vCPU; it contains a stale pointer to the last vCPU that
> executed on this physical host CPU. Caching this pointer permanently means
> the event tracks unrelated data.

Valid find, will fix

> 
> >  	kvmhv_set_l2_counters_status(smp_processor_id(), true);
> >  
> > -	data = get_counter_data(event);
> > +	data = get_counter_data(vcpu, event);
> >  	local64_set(&event->hw.prev_count, data);
> >  
> > +out:
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813094535.10083-1-gautam@linux.ibm.com?part=2

