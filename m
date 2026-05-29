Return-Path: <linuxppc-dev+bounces-21702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D4CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 09:18:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRd7R3gcfz2yQH;
	Fri, 29 May 2026 19:18:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780046291;
	cv=none; b=EGvMyMC02mbLf2/yKB4RQLoJN27BCNjsQMePYtUegmw1wl2CoFks7AXVwgBjtorLqEa1S8c7lgoXNldjRX0Hrfeo4onTVze8vgrf/6nJOcv5PO07eo0ZMiCq5IsyK44i3isB88kDMPMJuLsJxcdMFUPhGH2ndttjaEkklA6u9VRAsKO8Zuu7m5O7hi4vrSkfNqNNcqOcf9nTWYCtNTIUSmcQq8ABAHfiQcx6DWnAQzcCOda2+x4z30tGcY4lHsZBm4zMp4ZRUDi3sY706FaaqHICi4yo6rGAuJcxoFegBrVw2dZ2ZVRFTmqEihgNgFn8v4JW9ByGt34cU9ALUD0Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780046291; c=relaxed/relaxed;
	bh=3X+h87zVQbiADPCPME4wwho65wKw5nknhCHOBBKB/ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB8nA+ySUAb7EAjQgZ30LyZHuH5ZYYY8+ZIM4Dx8CfBd5JK9FM8tQ1hnmJ8Cxu5AT8ycOV/nC9pKlLKW2TrBPNasChrYDoC1ZkNFX2/Z61+HPe0W4TqZlpcqkZP6BrcNTEYu/mX7UyyguLddurekcQ0y/4/N5h9wfc2Dr/V7dRC2SpdWKiYQz1MtqtVT7wvq+2LhWZ4raK9TRC6XzjnsMNFFLaS0bwXunw5ijyFbBjGt+2nJ1F773bjSbV/Q0qq/kose5nYYquB9D6HPi//DTybp7ajUNQbg/25crCzdQFTXknKWWZkNfUKbpE914NBU/ku1jqfU9DRSQ8rK5zcDDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=S4d5H3qa; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=S4d5H3qa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRd7J0ljgz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 19:18:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3X+h87zVQbiADPCPME4wwho65wKw5nknhCHOBBKB/ZY=; b=S4d5H3qarX01z/0rutOkGmmtgH
	SmafBLNzWSuRikquCnziG8k6GrnvLHPFhPRuOT3QvQS2TPy297K/UTdkimkO+hxne3sSLUIZTmNAq
	9c/6l3GZ8/JCT+v6HV6Dlub5gF9Em85WhV44v4LajUdu9tII/JQ/jgZI65gHLSM86P5h7L9LcKWv5
	5r2xmaLIMNNV81Rc5+dlEfgCzl2AMuzm/uByCPPZv3+cyzS3wvEIgWb+vsoIbvY1CSCSyKgZSiCAI
	Q/RlCxJFIptG3MUxVHbnkVtyL8t2sdTzIMxejtZ4mGhP0o8T1F4YAvIaLiBOi0i/aCqzCwwhA6pe6
	8G2je/rA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wStLn-00000000t4y-2wo2;
	Fri, 29 May 2026 09:17:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4C5E301CEB; Fri, 29 May 2026 11:17:54 +0200 (CEST)
Date: Fri, 29 May 2026 11:17:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	venkat88@linux.ibm.com, yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com, kprateek.nayak@amd.com,
	srikar@linux.ibm.com, riteshh@linux.ibm.com, stable@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] sched/topology: Provide arch_llc_mask for cache aware
 scheduling
Message-ID: <20260529091754.GO343181@noisy.programming.kicks-ass.net>
References: <20260529075712.1181039-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20260529075712.1181039-1-sshegde@linux.ibm.com>

On Fri, May 29, 2026 at 01:27:12PM +0530, Shrikanth Hegde wrote:
> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> 
> Stacktrace points to llc_mask being null.
> 
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
> 
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn't supported. In such cases llc_mask was being referenced
> when it was null leading to panic.
> 
> On powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain. 
> 
> Based on tip/master at 5c89783224e9 ("Merge branch into tip/master: 'x86/tdx'")
> Cc: stable@vger.kernel.org

This seems unwarranted, the patch breaking stuff is in tip:sched/core.

> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com> 
> Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks all! I'll stick this in tip:sched/core to go along with the
patches that broke stuff.

