Return-Path: <linuxppc-dev+bounces-11329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B5CA0FE7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Aug 2025 13:29:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cB7mg4QPWz3dTp;
	Tue, 26 Aug 2025 23:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756214963;
	cv=none; b=iW0nnZsJMEL/7f9RaSVIWfxScTjtJ0WWwsuP668DccpBLdVibEGtDyXWakYualXpHq9zIgFFZsxnkJXWR3LnF6iEgOIpesukLHX7m7OzJ4Sdk2ylkykKecZYZznGzQZ0yxBLaSLcOg8SxM4g+YuiFdhy965E/Sg2u2KWD1mWv5QK83dTXNLQlohzDsjSYhKLMEVS9rQixNQ7UIILZt8iDjagpjyAUvhTcm0nWykSY1HR9BDbgxuf8sOo02OZIESZISoJfLFRN1Eir9Ov3wydSGSFUi1bm+gYGWFG0QmTyqAYu4JOxFz++CkpHs3T8j1/kZNP5ixTdzF9+kuRtXjkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756214963; c=relaxed/relaxed;
	bh=0aiZeMf2NhiiIB1v34ZPRLtQef3GSv6ZteY4y12PHFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWGa1rCCRakwtBkOhzWJexqoOWhJ3Ir038/rttjcU5jId4KTzHsCo2IKa7ORIVyvQ9ExuJ2wx7u/JwsYF4zlN9baNEb9pxvmrslKn6l1PwteokGWtaMI41QAGSO7OWEkmJGAyc+xcQ4c4Slx3o1LeFPuZH12f/HK9EMiroayNgEkxeXmqDFdpr7tznzv4uCvpmVsGWMjFFOI+q6L765W325qDeY50kQKPXodSYZxKH2VbGYqw8wSDP2UA1YkDnPajxW/nSuiBGsjy/PRgESdheCHtp7YxY5xMgWn9ZpI/TbBieeWGZiUfv1Vk1wcHwSUh6GihfubMS4W7PJ1Fexw9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cB7mg0W4wz3dTg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2025 23:29:22 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742EB1A25;
	Tue, 26 Aug 2025 06:28:43 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56233F63F;
	Tue, 26 Aug 2025 06:28:45 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:28:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, mingo@redhat.com, will@kernel.org,
	acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, coresight@lists.linaro.org,
	iommu@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 16/19] perf: Introduce positive capability for sampling
Message-ID: <aK22izKE4r6wI_D9@J2N7QTR9R3>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <ae81cb65b38555c628e395cce67ac6c7eaafdd23.1755096883.git.robin.murphy@arm.com>
 <20250826130806.GY4067720@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826130806.GY4067720@noisy.programming.kicks-ass.net>

On Tue, Aug 26, 2025 at 03:08:06PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 06:01:08PM +0100, Robin Murphy wrote:
> > Sampling is inherently a feature for CPU PMUs, given that the thing
> > to be sampled is a CPU context. These days, we have many more
> > uncore/system PMUs than CPU PMUs, so it no longer makes much sense to
> > assume sampling support by default and force the ever-growing majority
> > of drivers to opt out of it (or erroneously fail to). Instead, let's
> > introduce a positive opt-in capability that's more obvious and easier to
> > maintain.
> 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 4d439c24c901..bf2cfbeabba2 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -294,7 +294,7 @@ struct perf_event_pmu_context;
> >  /**
> >   * pmu::capabilities flags
> >   */
> > -#define PERF_PMU_CAP_NO_INTERRUPT	0x0001
> > +#define PERF_PMU_CAP_SAMPLING		0x0001
> >  #define PERF_PMU_CAP_NO_NMI		0x0002
> >  #define PERF_PMU_CAP_AUX_NO_SG		0x0004
> >  #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
> > @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
> >  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
> >  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
> >  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
> > +#define PERF_PMU_CAP_NO_INTERRUPT	0x0800
> 
> So NO_INTERRUPT was supposed to be the negative of your new SAMPLING
> (and I agree with your reasoning).
> 
> What I'm confused/curious about is why we retain NO_INTERRUPT?

I see from your other reply that you spotted the next patch does that.

For the sake of other reviewers or anyone digging through the git
history it's probably worth adding a line to this commit message to say:

| A subsequent patch will remove PERF_PMU_CAP_NO_INTERRUPT as this
| requires some additional cleanup.

Mark.

