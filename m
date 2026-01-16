Return-Path: <linuxppc-dev+bounces-15912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF452C982C7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jan 2026 14:57:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt2y546NXz2xrC;
	Sat, 17 Jan 2026 01:57:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768575437;
	cv=none; b=FmPRSRBemuS0W1O49qi9hZ+mdAwD9ECSsyM43PuWItHF8EiyCgabx9kbpKA+U1vL4YLTKwZ1M56PTbU2DfeM5gB4p93J12DpIQkkuaDs3NFOgMSbxpfSpWGZvV2oQZA/1gaFYdr83CAgE5FQVWHH3Bj+IWt1lhc6QPoLGRlIRn9AH1izU4umqpr17KBu0b8HXB1YkQ0fpnO/OainK3+z886VGv/NDL+IC2+BYo00F4vLQ51QIdmkr2jmcGgG8NTdJG3lP7mtbdD1SLHOU2JWmfnSMn5Y1bPuRKAwNOO0br+h6RR8DWce4c/YGgswcpMexeoecnGxDt2YnBvdx9LvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768575437; c=relaxed/relaxed;
	bh=MaxWatC6BXDD9MxNLBGBdUdv+FaJKviCzEvHGFX/ndU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPcUwyEXu8uWh51hJ1MB1aY1i0kUkEx7+kxrd4rv3WD5k2W+nPYRsIOm3eBniygzXgLKhDMqtfdwGDC20w4IdsDbm5Zf8xzJ7GsJv9vFHbhdcCSaMZbTBWhMqVLM+y2R1Why1ATvkz+0vEmpZncXKF1NBeDbL1fd1UH9+RbnDgAkVxFHQgiUHew9mKwIGsLmuJVq+y8TD/OcmHxAYtfam/5srL1wYBdhKoKfPaRe4pP1066E8b28tEgYUy4j3ZxEWYC8QBGn/JRlwZBFfNTAhTZTUNhFkhbGDY/zsmCCIrQH4mgLBzYZmO/SX9UeFwunfxadsW6p/bFSdtLndOwHqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i1RwDlWF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i1RwDlWF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt2y44xRlz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2026 01:57:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BD11143E19;
	Fri, 16 Jan 2026 14:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23473C116C6;
	Fri, 16 Jan 2026 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575434;
	bh=MaxWatC6BXDD9MxNLBGBdUdv+FaJKviCzEvHGFX/ndU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1RwDlWF4zmzyFZbSx5OidA/+WFRcuq22Me/qt7d0WzVBLoMhOI0t+l6v0daYAatm
	 953IxDldYcPn7EkgpHIDFA7QU0DlFZqoyuTDFzwqqTZO7oGf5g3UOjc684CSh6cLkM
	 pk3Iy2EQx7aOjiXCS9sKoO+Tn0LnZzKJJnfKRyUl6qDhwoxJfNxNIDKkWELwamyqOB
	 CDY5kLMmbmGp2XbeQWlj7Mvwhp8JSjZOlwE0uRPq7pFkQz2NVGVSgiD0cVvBUu8+VF
	 xXLXhxDgxWK/+c9YOxkbYJ9KoAp3rcXvzXLCZDRM4rzHixmMN+84JKTwAgr/ZMCIHA
	 Wqet92hhJ6A3w==
Date: Fri, 16 Jan 2026 15:57:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linuxppc-dev@lists.ozlabs.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-pm@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-s390@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/15] tick/sched: Refactor idle cputime accounting
Message-ID: <aWpRxyt8HuXkSuxs@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
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
In-Reply-To: <20260116145208.87445-1-frederic@kernel.org>

I forgot to mention I haven't yet tested CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
(s390 and powerpc).

Thanks.

