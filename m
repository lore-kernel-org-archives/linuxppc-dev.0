Return-Path: <linuxppc-dev+bounces-27032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFA2C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 14:53:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hggf84z8qz2xlJ;
	Fri, 11 Sep 2026 00:53:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789050692;
	cv=none; b=XhFCpL3gedc2AwV9jRcMgpkxZp78HJ91g32KM+guZeuPT1VwU/cmOJX3izRLjgUhVmNmURx/TBboCPG5/uhkVx0RLdjV0wFrkG68pYNwCtj6At03rtrlZeCZqKQ2ZN0zcL5S0LAKhbx/9AM2omY/42hUyGr3OHCAs7q8LBwtRUefVfBKLdlsMPOgdQRvRkitFV3D514KrZqBa9Ffg5rBUXdTm1wWBspm33zq4nYmLTJyh98BhkuKM7sA1GPBAL2gF8uwRL2Of+sFsImk1TlDiQYWFy8RlcW8oiNtxU8FfMfMU3wRiO2FJbY4dse0XkU1GDBt3yg0onRTzx4BNGQIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789050692; c=relaxed/relaxed;
	bh=8oOYydPLSmmKf+EQ0HkeEap1hYLbva2q5CM0ECTUT/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZSkMfF1wzQeMGNlKRjshyWY3+pbFW/wXIocNYQQDMNKvWGT7fovRUFztOfw1V2Me9k5OFS8tFnwCHAPSUDGEfuamXPd1oZCc7syscxlUcobU6gVOue4Jqjr7ML4bUeKCftSWl8joyvcti2x7GaHyvZqyxV/KjBJcxVu00EqXvyTK8ATotL8JIOJED42l3/SnTGNOvoV321HXHGz1IpjTxmy7g0Zd5YcZ+eLMFMom4EaZI3VG46ZVwZNsFljDvCMdWdx7560ImF65sq3IhER9jCfvQgjfMJVGKcrCjAAISzX9mAPAtutf91OLlbybtXQe4fpiv6qTmd3s6DiUFFCFFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfPcDL2x; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfPcDL2x; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=atomasov@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfPcDL2x;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfPcDL2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=atomasov@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgg8z0485z2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 00:31:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789050685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oOYydPLSmmKf+EQ0HkeEap1hYLbva2q5CM0ECTUT/E=;
	b=ZfPcDL2xHRi9Wzl1bStIrA0w6wmHvZNstDkpa3YczXVTjoaTRo7oRcQOn5BXraZU9cerRr
	jD/P4lzJF28iCncQ8mXoFBbq1mRiRKL5qF5OCz97hrqwgwWPMKwzZp2pUEQoyq+cnklhtj
	iYcMghW0oLXdlIML7xYphZSXMNqm43Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789050685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oOYydPLSmmKf+EQ0HkeEap1hYLbva2q5CM0ECTUT/E=;
	b=ZfPcDL2xHRi9Wzl1bStIrA0w6wmHvZNstDkpa3YczXVTjoaTRo7oRcQOn5BXraZU9cerRr
	jD/P4lzJF28iCncQ8mXoFBbq1mRiRKL5qF5OCz97hrqwgwWPMKwzZp2pUEQoyq+cnklhtj
	iYcMghW0oLXdlIML7xYphZSXMNqm43Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-O8Ypl9fJPM6L4atbQS4teA-1; Thu,
 10 Sep 2026 10:31:19 -0400
X-MC-Unique: O8Ypl9fJPM6L4atbQS4teA-1
X-Mimecast-MFC-AGG-ID: O8Ypl9fJPM6L4atbQS4teA_1789050676
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29AB51955DC5;
	Thu, 10 Sep 2026 14:31:16 +0000 (UTC)
Received: from atomasov-mac.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C4891955F19;
	Thu, 10 Sep 2026 14:31:12 +0000 (UTC)
From: Adrian Tomasov <atomasov@redhat.com>
To: Eric Dumazet <edumazet@google.com>,
	kernel test robot <oliver.sang@intel.com>
Cc: Adrian Tomasov <atomasov@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Luke Yang <luyang@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [linus:master] [net] 5628f3fe3b: sockperf.throughput.UDP.msg_per_sec 20.1% regression
Date: Thu, 10 Sep 2026 16:30:40 +0200
Message-ID: <20260910143041.18106-1-atomasov@redhat.com>
In-Reply-To: <202512112119.5b9829a-lkp@intel.com>
References: <202512112119.5b9829a-lkp@intel.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: VJSYG-Tpjj9JsbjFfxQq6PvhErlwYGTe9TMYm82p0qs_1789050676
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On Thu, Dec 11, 2025, kernel test robot <oliver.sang@intel.com> wrote:
> kernel test robot noticed a 20.1% regression of
> sockperf.throughput.UDP.msg_per_sec on:
> commit: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")

We independently reproduced this on a second architecture, ppc64le (POWER10),
and can add data that both confirms the commit and shows what amplifies it.

Commit: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Parent: 844c9db7f7f5 ("net: use llist for sd->defer_list")

Two factors govern the magnitude, and your x86 report and our ppc64le data
agree once both are considered:

(a) How much of the workload runs the net_rx softirq deferred-free path.
    Tight loopback UDP (sockperf, iperf3 loopback) is softirq-dominated and is
    hit hard. A real-NIC test bounded by other costs is barely affected.

(b) How many *possible* NUMA nodes skb_defer_free_flush() now walks. The new
    for_each_node() loop iterates node_possible_map; on a POWER10 LPAR that is
    0..31 (32 possible) with only 1 node online, so 31 of every 32 iterations
    touch a cold, always-empty per-node list on every softirq RX pass. This
    shows up as _find_next_bit(): ~2.76% on POWER10 vs <1% in your x86 profile.

--- Data point 1: stress-ng UDP, isolated commit A/B (POWER10) ---

POWER10, 8 CPUs, 62 GiB, NUMA 1 online / 32 possible. Two upstream v7.2-rc4
kernels, same compiler (gcc 16.1.1) and config; the only difference is the
presence of 5628f3fe3b16. stress-ng 0.19.03, --udp 1 -t 23, 3 runs,
bogo-ops/sec (higher is better):

    Kernel                        Avg       Delta
    v7.2-rc4 + revert (good)      265145    baseline
    v7.2-rc4 stock   (bad)        204854    -22.7%

perf (stock vs revert): skb_defer_free_flush 2.75% -> 0%, _find_next_bit
2.76% -> 0% -- both eliminated by the revert; consistent with your x86 profile
(skb_defer_free_flush 0 -> ~4.1%, _find_next_bit -> ~1%).

--- Data point 2: iperf3 UDP loopback A/B (POWER10, second host) ---

Independent reproduction on another POWER10 host (32 possible / 1 online),
iperf3 -u -b 0 -l 16k -t 20, both ends pinned to the online node, 5 runs,
Gbit/s (higher is better):

    Kernel (has 5628f3fe3b16?)    median    mean
    no  (6.12-based)              6.34      6.31    baseline
    yes (7.1-based)              4.85      4.88    -22.7%

(These two kernels differ in base version, so this delta is not a single-commit
isolation on its own -- Data point 1 is the clean isolation. Both land at
-22.7%, matching your 20.1% sockperf figure.)

--- Data point 3: workload dependence (real-NIC vs loopback) ---

The same commit-vs-parent A/B measured with a *real NIC* iperf3 UDP stream
(200G, 3 reboots/kernel) on a 2-possible-node ppc64le host shows only -2.6%
(7515.8 -> 7313.8 Mb/s, zero overlap across reboots). Where the deferred-free
softirq path is a small fraction of the work, the regression is small -- the
mechanism is the same, the exposure differs. This also matches our observation
that a same-CPU-heavy stress-ng udp run barely triggers the cross-CPU
skb_attempt_defer_free() path and shows ~no change.

--- On Jason's question ---

On Sun, Dec 14, 2025, Jason Xing <kerneljasonxing@gmail.com> wrote:
> from what I've known, commit e20dfbad8aab2 and commit 21664814b89e altogether
> can lead to a similar regression ... could you also launch some experiments
> just around those two commits?

On POWER10 our isolation is a direct A/B of 5628f3fe3b16 against its parent
844c9db7f7f5 with identical compiler and config (Data point 1), and a full
revert of only 5628f3fe3b16 recovers the throughput and removes
skb_defer_free_flush()/_find_next_bit() from the profile. So on this hardware
the regression is attributable to 5628f3fe3b16 specifically; e20dfbad8aab2 and
21664814b89e are not in the delta. Happy to test those two separately if useful.

--- Suggested fix ---

Use for_each_online_node() instead of for_each_node() in skb_defer_free_flush()
(and cap what skb_attempt_defer_free() populates accordingly), reducing the loop
from N_possible to N_online -- 32 -> 1 on these POWER10 LPARs. We can build and
benchmark a candidate patch on the POWER10 hosts and report back on this thread.
If a fix is posted, the appropriate tags are:

    Reported-by: kernel test robot <oliver.sang@intel.com>
    Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com

Thanks,
Adrian Tomasov
Red Hat -- Kernel Performance QE


