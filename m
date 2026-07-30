Return-Path: <linuxppc-dev+bounces-25121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805EDC55164
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:47:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sVb0B6Qz2yjp;
	Fri, 31 Jul 2026 00:47:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785422838;
	cv=none; b=Pr4m1J+Ut3OqrdXeGLWqGW5VbDViPHyROB+sDGWgAjyDlh6FDf4jFh13GSQQhq9B5g9ZGyocgxNQ4hSfn6tdAXRloxvmwQXmTm4trvYz1gBexuv6f+sTOD6ArR9tUpQxGpop5yUSDI4E0M7CXQWLGlU5smfWToNAkGDgkNZjJmpnaHmn/RAcvx2YzJN16VQHRmW2HjWI9SOoHk6leYlaJQBn3micLCWh7cmSzqUrV8LIe5oa6uZW3wJoFj/NYQ/aGKMKDBbnhNG3znV2+rzrR4QdvbyCWrZfMQREilTPc5Oi2NecZ/fL1CIKQZtOFh4yaBfTDROsn10BsYHYkCGNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785422838; c=relaxed/relaxed;
	bh=ijApISGWTZehCWHrbupvEPmk6F27q3cKv9hwipUESYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuX/6lFbzH+ws+6t9cQ+/wl7ih5zGdB0To6Q04KIzluyHhJPW8vIm59A5bcZ4tXP6/1sdwLxRPacjRyV5mHsOLKb4BXMW3LA+h7BvCajP5P4TTM2N+R+FtnBSxrK74KxnsfUXPVltNmcwKj2nyQfebNSskGNMnkfh21mvuM93F5W/1erMqcrr1PS151B8TJ9/YHWbDbXV36Bpjdi2Bo9qwzInTNtxe43OQaCx7viGZW/+nC71k0DVJ0KOTX0q5mk486FssB36FTFjEuAmCPrfSOje6Y95IltL0ccfbeqkdiJ1foL9CW6AHvnvaB6wNPIa/Rzrf+FAUhrSycXWAjstA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEA6qVaF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEA6qVaF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sVY72Kyz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:47:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 00FE8400EB;
	Thu, 30 Jul 2026 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67371F00A3A;
	Thu, 30 Jul 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422835;
	bh=ijApISGWTZehCWHrbupvEPmk6F27q3cKv9hwipUESYs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=CEA6qVaFo296mQnZdJ/xuxz8FOwI7TrzaCuSHmpO1usVRnsbVPXM13WioXlKeM08g
	 VrMjr2ZJFEgv4cIyoMSM5HT00oIkIBDY7MWNZcbFPlQLVmDpLf3hwiRJ38Dzn8Sgm4
	 k0AI5Jrjg6WaqjShoFVR4/qlunNu1Ph+C3rwDDWzm9dmfvAzruYujb1C+poAMKr3Y/
	 oN2LrT6UcSw3ONyhR9wdkVa177bd02Hbt8eJu59OJSnY/tk+qY4/Ps159Ql/C+WdIX
	 Ckc+kco72hHHVwAEgZEtdU2lHz6Km/wz4+2BlTPEz8kHL2OLfZGS3FS5GgvMNkciIo
	 Z3FpesOVeMn9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B904CE0B67; Thu, 30 Jul 2026 07:47:10 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:47:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>

On Thu, Jul 30, 2026 at 02:08:54PM +0200, Jirka Hladky wrote:
> On Thu, Jul 30, 2026 at 8:44 AM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > From the above, it is quite evident that main cost is cost of
> > preempt_disable/preempt_enable due to inc/dec of preempt count
> > itself.
> 
> Thanks for the deep debugging, Shrikanth. This changes the picture
> significantly.
> 
> So the chain is:
>   PREEMPT_DYNAMIC -> PREEMPTION -> PREEMPT_COUNT
>   -> every preempt_disable/enable becomes load-modify-store with barriers
> 
> And the __rcu_read_lock/__rcu_read_unlock overhead I measured was
> actually the preempt_disable/preempt_enable inside them, not the RCU
> logic itself. That explains why removing PREEMPT_RCU only recovered
> ~5% -- the remaining preempt_count operations throughout the syscall
> path are the dominant cost.
> 
> > The cost of preempt_count is likely un-avoidable with
> > DYNAMIC_PREEMPTION for all RISC architecture.
> 
> Agreed. On CISC (x86), the preempt_count update is a single memory
> inc/dec instruction. On RISC, it requires load-modify-store plus
> barriers for the atomic update, which is fundamentally more expensive
> per operation.
> 
> > Also given that after 7.0, all major archs including powerpc, can
> > have only full/lazy preemption. None/voluntary are no longer possible.
> > So making any sort of optimization for preempt count is not useful
> > since it has to be there for full/lazy.
> 
> Right. With full/lazy, PREEMPT_COUNT is required regardless of
> PREEMPT_DYNAMIC.
> 
> > Also, evaluate it with any real life workloads, IIRC i have run
> > hackbench, schbench, daytrader(db2 workload) this cost wasn't visible.
> 
> Good to know. I reviewed our full CI results across all benchmark
> suites on ppc64le and I don't see regressions outside of stress-ng. The
> stress-ng kill stressor is a worst case -- a tight syscall loop that
> hits preempt_disable/enable many times per call through the SELinux
> AVC path. Real workloads that do actual work between syscalls
> amortize this cost.
> 
> I'll update our internal tracking with the corrected root cause.
> 
> Thanks again for your persistence on isolating this. Good to have
> the real root cause understood, even if it's a fundamental RISC cost
> we have to accept.

Good on all of you!

But is this really a fundamental RISC cost?  For example, does arm64
see the same performance issues?

In particular, I can see why the preempt_count() operations need to be
interrupt-safe, but I don't see why you would need barriers.  And doesn't
powerpc still use software interrupt disabling?  If so, why not use
that to simply software-disable interrupts around the preempt_count()
operations?

What am I missing here?

							Thanx, Paul

