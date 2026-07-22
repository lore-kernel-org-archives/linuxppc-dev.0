Return-Path: <linuxppc-dev+bounces-24653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E85C44539
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 15:18:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4yZ459k4z2yVd;
	Thu, 23 Jul 2026 01:18:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784733500;
	cv=none; b=QiQ1RdIn9MV+pR29+P7uup4FMr3H19MKneH8KxgbH672+ZvBVVwUxH0vpC6/h46rd9FfN4CYL+lGNN0d1tP6e0NhV1TL5qHhvwxBv+lk5VzbCeQmAKgPxaAHdIwGkzG6hDGrX+NIOt/hsD2HIkDu/zbxGJhW0Xj3A3MwYe/og+CBQX40fZBgPYzYRCIHgwqNH6XtVlszrtovMpKxHdfIZTcAbVDAridtf1pVz4I0rPSaaZ4c8OQ2QqMQ4ZXbPNxPKGpo9KmmatToiYOi7jmUnTv8nzcMhYXBO9ExVURC+sRmyUHV3lRwYm3Ga0J2kwGVIbfPjPHouzRZfDjNlFiA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784733500; c=relaxed/relaxed;
	bh=aMd3bS0uqcs7McwQj5vjF3TqbVfUowZQJ5sNvMWfsz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVhfWAWod1OMqwwEvSf0d1OUwwy5z5u3+Mghj06NQ+q2gErJTnCUss15RMIilHf0W7Jr6VLh9J5la/eBohuf50p1FjEKGDjNnnVvCG5C9EKAzQ+x/EwMYhISJvOCglV/EdE8tweVsL1qfbrlYcvWoaZQ2r8xSg3A0Voag4RXnjRkzYvabHdTlU7K5XEd+SPSq9zX166C/oXxXbMxIEmqMFRkognz60Nn/Zi46FxcIUKtEPexhf5iqmLuklb5xCMFZM7TD7GcFYqJCTlicCYy5e9W2SHMFjMf+Mx0SPGQVzzy7mS2xSRMvlDysiA5zTkfS7w1y/vubA1elpsAVy2mgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lL+WvOLc; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lL+WvOLc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4yZ131W8z2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 01:18:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784733498; x=1816269498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIJCq0U0nvzWtAAiZhSd0Lkda2QdVkytVVFdCRV0V4Q=;
  b=lL+WvOLcbgz2pFTeH0x39QM9Xw1mRUxr4+JM9h6j6ZrV7Xa3Tqsj6vTs
   ACdDy3573YRo+IzTuP+LYiCOMhR+23zfrbGCjBvgxbsdJxM2rnoLuazAD
   y/tJzXiGMJZf9jmREbEdsFODlOZNIP68Q/zYGj1xpW1Kp5AXEDSataWUU
   uClISMQXo6VLJmag8CLkaFq60tvTDQZe1yNkW4dpBDjT5e1VEL2r75KgW
   1R0wB0tOGVvawkS3UwX6SP4ipCTfCpFuyhg4Bot1FFfR125Z+VEblISZi
   M2cgKnIRFrROUb5+NKa3p+xBkGAnhhrpfsZI78tYZGZYDRY+131qa5Y9W
   Q==;
X-CSE-ConnectionGUID: SJ7eA5jKR9iGDBCO9dq/cw==
X-CSE-MsgGUID: HFz2oiJnSXCgDzNc7tdu/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102920101"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="102920101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:18:12 -0700
X-CSE-ConnectionGUID: hLa2fyDLSsyVnjwP3QieRw==
X-CSE-MsgGUID: XxCvddLSRgOcXJMGgzV5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="282641187"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:18:12 -0700
Date: Wed, 22 Jul 2026 08:18:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <gymgr5t5ocl3v5gykum2xlb5u3jhejmurgnodca534i6lih5q4@n7e6n3qf7szu>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
 <2026072151-outsell-suburb-64ea@gregkh>
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
In-Reply-To: <2026072151-outsell-suburb-64ea@gregkh>

On Tue, Jul 21, 2026 at 03:08:11PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 14, 2026 at 11:58:24AM -0700, Pawan Gupta wrote:
> > Hi,
> > 
> > These backports harden BPF JIT against spectre-v2 class of attacks. Without
> > a predictor flush, execution of new BPF program may use stale prediction
> > left behind by the freed one.
> > 
> > To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> > The flush is conditional to spectre-v2 mitigation applied.
> > 
> > Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.
> > 
> > 	  bpf: Support for hardening against JIT spraying
> > 	  x86/bugs: Enable IBPB flush on BPF JIT allocation
> > 
> > Patch 3-6: Narrow the flush to only unprivileged JIT allocations
> > 	   to avoid redundant flushes. Also adds pack-selection changes
> > 	   that minimizes flushes.
> > 
> > 	  bpf: Restrict JIT predictor flush to cBPF
> > 	  bpf: Skip redundant IBPB in pack allocator
> > 	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
> > 	  bpf: Prefer dirty packs for eBPF allocations
> > 
> > This one is mostly similar to 6.18:
> > 
> >   https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/
> 
> There is no active 6.16.y kernel branch, so why is this being sent to
> us?

Sorry that was a mistake. I had an old 6.16.y worktree in my machine and I
assumed it was still active. Please ignore.

