Return-Path: <linuxppc-dev+bounces-25861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE68AC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:17:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM1T029GRz2ypW;
	Fri, 14 Aug 2026 22:17:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786709860;
	cv=none; b=MjcBurnsbrUD2NzAlY/q7dbottQVXY+h7vgRQT8DvU1EWP3uAJrcKdtlOX8M+IH77u2FzrjXkRav/fej0LFG38eHLc7Ar8oKyyZUKoCk8G7jg8P+lvgEmUkBVOqybct8zLSaTJRsWNDxaD2eesB9ER4Q8dW24LOSocK3CP7qJfNsWAFk4sQcmIbGuIrzxh/SaImN73rRdPfRed+wMZtV2/tIiS/d4U8X/MjhrKYocjeK1VRqpRK+GPRoIrrMzNTVlp303hWbNan62BEfEq5rba/P5uptoUUj+o6qmoKkgaS2MOXyTVzj0GxUhNdKUrqIyoO4ktpO+YTOGUgVveL9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786709860; c=relaxed/relaxed;
	bh=7kDLJ355LYt1huG4H0p1pUx5oxXniRknXeT6bQxnHdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGJEzTD6bDslVDfQN14U12MMIBh8AHfP0OBx43gs7o1cO2c6oW3/qmiOktIrH1/WphzmCzqWvPAveSBEZ1nH/+7d9ULbguRqPy9DGqbjW5hUg3/RPVLk7mZGhNXHYxGGYTKCTe+Y2B0Ml7dC5S304UkxYSKRzjVMRo4BWvmPEj2VS/o+xp9eKf1H+OVSb0daRhdmEz5PQtsDkFt8CmoiY7DCeaURXE5WrI1UElDBnzC1bTi5q1id49PO4R7Udsf824aI6rEVpojU3I6GFY94nFcYMoE/eUJEuYKFfWp/w6pGzrrLs2S2C2Bs930kti/ZWcbdfrVSi3tbU0b9cpn5RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cty3rcPU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cty3rcPU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM1Sz3yFCz2ykT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 22:17:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1gXW903724;
	Fri, 14 Aug 2026 12:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7kDLJ3
	55LYt1huG4H0p1pUx5oxXniRknXeT6bQxnHdg=; b=Cty3rcPU+pfGsHr0zpcPHh
	jAH4xfaaTHiM++L7qaaotX3EWOU1flm6I58ewM3D5ilNqUSezwIfLu08fI1kDeZS
	l8DE7mkps93uXRc32gwA25EO5luIvfF6cFhTm/YRvQlJpsh3f3bkxd3YgN5aKbgm
	GJUh+HV0TkW64deOjlCfxX8jE1EOLs4hA7NWBebkGzXBXxncrybVI6dE0YQmHNTA
	gY8FSK2MjafFHvKp0ygoy9J7v/cUMBAWw/emrXLGjZw8iAJ5VcDgZxsvcDInu/82
	tG/oNDr2BifbMum/k6p3h0gF+9/kN7I3PkVckXxRcR3BiNZVKyzbkFz7xR0kcQpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vn69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:17:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECBpP7010658;
	Fri, 14 Aug 2026 12:17:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk76up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:17:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ECHWqO50004460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:17:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4B82005A;
	Fri, 14 Aug 2026 12:17:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F203E20063;
	Fri, 14 Aug 2026 12:17:30 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.210.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 12:17:30 +0000 (GMT)
Date: Fri, 14 Aug 2026 17:47:27 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get
 accurate values
Message-ID: <an8HV08_-EyaA4-R@Gautams-MacBook-Pro.local>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-4-gautam@linux.ibm.com>
 <20260813100103.001361F000E9@smtp.kernel.org>
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
In-Reply-To: <20260813100103.001361F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3KaWxEoTg-nwJ_VAj0ilcu0DccogpRNk
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f075f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=DrxZ4JEAOZhTRNrT7n8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXzGxhbw9Eq05L
 xd5rsCVAMI97iLnL0akxa5Sc70ivbbeTVprJF0hbVwsEqquPxTjwKKfd8fCUwvI7oXg+BDuUr0d
 DvXxnZXvTUrAFyT4IAamAXxzKhk8gZyl/GbtV7KJLlpU5ontdIL9PJI8/R9N6/9UkLORo97Wl/h
 A2VJCuQLisw45tEPz4tjt80JFRnKmJtoC9ubW43vCaR7qSiIntyxdJ5ab5mH3OT4O4wqXqiLQQU
 TFTVePLFFl9tmh1b6TKZc6PXeJ/GnTP2vvniqSR8NBh0KIpNVtQCU3osCeGbqVX8O0lFaNU6Xh/
 jystvmqRg8B+EZ//taMCCaBrSSADWg7V7xZ0B10QzfstMI+h1zpClfjDKPmxRy6E2/eEuby+gm5
 Tej8Kl3TZda3QGUrJzF6S2QN6n8aXsIunucrOly4oZhCYu8XJRGCgSyvfAP9KE0h3UjdunRQzYq
 eN0WDSbgrNWErnrxAgw==
X-Proofpoint-ORIG-GUID: 3KaWxEoTg-nwJ_VAj0ilcu0DccogpRNk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX3OY46rBrtpSt
 WEpoifIfh5E3teR54R5kgOY4+d15uzDZTWNvyC1S8TE9EDsvVhBoi/xKwTFWuXQNZ2NprYF7awG
 T8kpsfPaMzBM8AkTReT3GfXVGL70gYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091

On Thu, Aug 13, 2026 at 10:01:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Missing atomic cmpxchg loop in vpa_pmu_read() when updating prev_count.
> 
> Pre-existing issues:
> - [High] The VPA PMU `add` callback stores a raw pointer to `struct kvm_vcpu` in `event->pmu_private` without reference counting, leading to a Use-After-Free.
> --
> 
> --- Patch [3]: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get accurate values ---
> commit 7c392d724ba481a5282a90aed95397fac4533493
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> powerpc/perf: Update prev_count of event to get accurate values
> 
> This patch updates the VPA PMU read function to keep event->hw.prev_count
> current. This prevents stale values from being returned on consecutive reads
> while a process is running on a CPU.
> 
> > diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> > index e79d98447c743..efc39f71553bf 100644
> > --- a/arch/powerpc/perf/vpa-pmu.c
> > +++ b/arch/powerpc/perf/vpa-pmu.c
> > @@ -156,6 +156,7 @@ static void vpa_pmu_read(struct perf_event *event)
> >  	final_data = new_data - prev_data;
> >  
> >  	local64_add(final_data, &event->count);
> > +	local64_set(&event->hw.prev_count, new_data);
> 
> [Severity: Medium]
> Is it safe to use local64_set() here without a local64_cmpxchg() loop?
> 
> If vpa_pmu_read() is interrupted by an NMI (such as a hardware PMI) and a BPF
> program attached to the NMI reads the same event via bpf_perf_event_read(),
> the nested read will calculate its delta and update prev_count.
> 
> When the outer vpa_pmu_read() resumes, it could calculate its delta using the
> old prev_data (resulting in double-counting the inner delta) and then
> non-atomically overwrite prev_count.
> 
> Should this use a local64_cmpxchg() loop to safely update prev_count?

Yes, valid point.

> 
> >  }
> >  
> >  static void vpa_pmu_del(struct perf_event *event, int flags)
> 
> [Severity: High]
> This is a pre-existing issue, but does this code leave a stale vcpu pointer
> in event->pmu_private that can lead to a use-after-free?
> 
> Looking at vpa_pmu_add(), a raw pointer to struct kvm_vcpu is stored without
> taking a reference:
> 
> arch/powerpc/perf/vpa-pmu.c:vpa_pmu_add() {
>     ...
>     vcpu = local_paca->kvm_hstate.kvm_vcpu;
>     if (!vcpu)
>         goto out;
>     ...
>     event->pmu_private = vcpu;
> }
> 
> When the thread context-switches out, vpa_pmu_del() stops the event but
> does not clear event->pmu_private to NULL. When the thread is scheduled
> back in outside of KVM, vpa_pmu_add() sees the vcpu is NULL and returns
> early, leaving the event active with the stale vcpu pointer.
> 
> If the VM is then destroyed and the vcpu freed, would a subsequent thread
> exit or user read() calling vpa_pmu_read() trigger a use-after-free when
> dereferencing vcpu->arch.l1_to_l2_cs?
> 

Valid find, will fix in v3.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813094535.10083-1-gautam@linux.ibm.com?part=3

