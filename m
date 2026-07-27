Return-Path: <linuxppc-dev+bounces-24905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB53C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 16:12:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h83Wm3jDTz2yhY;
	Tue, 28 Jul 2026 02:12:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785168724;
	cv=none; b=PT0+g7Yrr5DkqSXj3ugfbkY5N1BcUtdofmEr1+lT9pmTTyU5J2u97i3sS5sg6Xw3bH9RTixZMYRZM5571wGd1cSdFfL/AJ3VYMTAdlL6rRoKy1Q4O+7Yn/qIgP/bPLu/bPjWh2EvLMPwyfbFcDa9VjNvCUcgWexpbT+5+wcX2TY96SWdQ0VQmZaECDq2IRf+DFSfXschyJM6vbDvujWG5zWfoPjUl1ToITK3QS65C/FOwJBW/y674FKML//IebLsIEEwBVvHJgD0s/+MoSB+eFwmJdnLDg9nohpjS3XkNyAVOCu/Lua4b4GkvHElGKctcUXCurOhZXpWWl5Edzg7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785168724; c=relaxed/relaxed;
	bh=Ple3+OAsysKgoDWGnVIzHVpP13VbznxCRFkxfqoP404=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hocyzf08zKmAP9zCRJuFa2ohqoaNhjHnIHDyum44KUzB+IwgbzEBvLEc3wnwY5KjYLb6+lN/9WVKBC0WCbN8cWWZtGIlJ8+iSCb4+g8TWCYbtb9aIgfQEIfOxuqbpv88cUlDoFXxesW12yT3Ex6ukE0oSWTSrxC3v++WCzDxnu+y4EVz1OIn4obXQUy9Dlpw1gnYbNbzpK+MFeIUeGOFYd5cIJUGOiixFcRkn/9p2bMzm2yhXBE1SH8EVfp4YD7u33B+0KbVY5af/b2ZaIi5oyLdIQ2jDTc6wiA8KSL6HD0C9hHyy7bUFa4bI/pQ7U3YGx1pjTMlKL+Pn2kDZeP5yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCxs/RfQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=szs6=fv=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCxs/RfQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=szs6=fv=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h83Wl3Zqrz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 02:12:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C55E43D6A;
	Mon, 27 Jul 2026 16:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A11F000E9;
	Mon, 27 Jul 2026 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168721;
	bh=Ple3+OAsysKgoDWGnVIzHVpP13VbznxCRFkxfqoP404=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WCxs/RfQHNTUcXqDn+YrxYnM++/n4NHW8J1RQv23JeyGcMBSh9/accMZGWeI2pgHa
	 np1WIieMXH1DzGcWdQw7dLYPfZ/CSk0ml/c+oWutBGY2FuaVd+HIaQjZnVGa0tYZ6N
	 cn1DsGDsCYr7uMqcycKYr6/dCxt/AFCjfsoriTEGprjre/3ylSAugVnO5VrE+g+so5
	 A7fI5iUGH3KbqoiH/OxZ2jU/NpCxqVWHEPMzmPNUEguHBIovHWulJVs/eMzE028tfj
	 3eoe/EwqmnHzd839eTJPYEWP1gYidxb+DLzbLCv8lrGai7Mnk/SeOw0XZfzJDJ+D2b
	 u53/IFFY5HE/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5A60CE08BC; Mon, 27 Jul 2026 09:12:00 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:12:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <d4c276bb-e0bc-4445-9b5d-6ac4b3055b39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
 <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
 <330ca432-ddb6-4eeb-8415-697e16e73c43@kernel.org>
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
In-Reply-To: <330ca432-ddb6-4eeb-8415-697e16e73c43@kernel.org>

On Mon, Jul 27, 2026 at 12:35:32PM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi Shrikanth,
> 
> Le 27/07/2026 à 12:28, Shrikanth Hegde a écrit :
> > Hi Jirka,
> > Please avoid top-posting.
> > 
> > On 7/27/26 3:43 PM, Jirka Hladky wrote:
> > > Hi Shrikanth,
> > > 
> > > Thanks for the quick response and for looping in Paul.
> > > 
> > > > This is true only if user selected PREEMPT_DYNAMIC option i think.
> > > 
> > > Yes, exactly. The issue is that CONFIG_PREEMPT_DYNAMIC=y has been in
> > > the Fedora/RHEL kernel config since kernel 5.16 (2021). It was
> > > silently ignored on ppc64le until your 6.16 patch added
> > > HAVE_PREEMPT_DYNAMIC_KEY, so this is the first time PREEMPT_RCU
> > > actually takes effect for all Fedora/RHEL ppc64le users.
> > > 
> > > > Does your preemption mode remain the same in two cases?
> > > 
> > > Verified. On 6.15-rc6 (before PREEMPT_DYNAMIC takes effect):
> > > 
> > >    CONFIG_PREEMPT_VOLUNTARY=y
> > >    (no CONFIG_PREEMPT_DYNAMIC, no /sys/kernel/debug/sched/preempt)
> > > 
> > > On both 7.1 and 7.2-rc4 (with PREEMPT_DYNAMIC active):
> > > 
> > >    CONFIG_PREEMPT_LAZY=y
> > >    CONFIG_PREEMPT_DYNAMIC=y
> > >    CONFIG_PREEMPT_RCU=y
> > >    cat /sys/kernel/debug/sched/preempt: "full (lazy)"
> > > 
> > > So the runtime preemption mode is the same on 7.1 and 7.2. The
> > > difference between 6.15 and 7.1+ is that the preemption model changed
> > > from voluntary (static) to full/lazy (dynamic), which is what pulls
> > > in PREEMPT_RCU.
> > 
> > That means comparison is between preempt=voluntary vs preempt=lazy.
> 
> As far as I can see CONFIG_PREEMPT_LAZY doesn't pull CONFIG_PREEMPT_RCU.
> CONFIG_PREEMPT_DYNAMIC does:

That is correct.

Now, PREEMPT_LAZY does add preempt_disable() to rcu_read_lock()
and preempt_enable() to rcu_read_unlock(), compared to PREEMPT_NONE.
So there might be some performance impact.  But hopefully not quite as
much as an isync or lwsync instruction.

OK, OK, PREEMPT_NONE also has preempt_disable() in rcu_read_lock() and
preempt_enable() in rcu_read_unlock().  The real difference is that in
PREEMPT_NONE, both preempt_disable() and preempt_enable() are no-ops.
In contrast, in PREEMPT_LAZY these two execute real code.

							Thanx, Paul

> config PREEMPT_RCU
> 	bool
> 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> 	select TREE_RCU
> 	help
> 	  This option selects the RCU implementation that is
> 	  designed for very large SMP systems with hundreds or
> 	  thousands of CPUs, but for which real-time response
> 	  is also required.  It also scales down nicely to
> 	  smaller systems.
> 
> 	  Select this option if you are unsure.
> 
> 
> Christophe
> 
> > 
> > If you make it full preemption in 6.15 you will likely see similar data
> > as 7.1+.
> > Only on 7.0/7.1 there is force switch to lazy/full. Can you give that a
> > try?
> > 
> > If it shows same data, that implies the regression is mainly due to change
> > of preemption modes, rather than the static key stuff.
> > 
> > > 
> > > > Weak memory model would need barriers irrespective of
> > > > HAVE_PREEMPT_DYNAMIC_CALL or HAVE_PREEMPT_DYNAMIC_KEY.
> > > > Static key too is expected to minimal cost.
> > > 
> > > You're right, I should clarify -- the overhead is not in the static
> > > key mechanism itself. The cost comes from __rcu_read_lock() and
> > > __rcu_read_unlock() which are called when CONFIG_PREEMPT_RCU=y.
> > > These need real memory barriers (lwsync/isync) on ppc64le regardless
> > > of whether the dynamic mechanism uses keys or calls.
> > > 
> > > The real question is: why does enabling PREEMPT_RCU cost ~33% on
> > > ppc64le but only ~3% on x86_64? The answer is that x86_64's TSO
> > > memory model makes the barriers in __rcu_read_lock/__rcu_read_unlock
> > > essentially free, while ppc64le's weak ordering requires explicit
> > > lwsync/isync instructions, which are expensive when called thousands
> > > of times per second in the SELinux AVC hot path.
> > 
> > Plus, it may call schedule in lazy/pull preemption.
> > 
> > > 
> > > I also have new data from SELinux isolation testing that helps
> > > quantify this. On kernel 7.1 (which already has PREEMPT_RCU=y):
> > > 
> > > SELinux mode    kill bogo-ops/sec    vs enforcing
> > > ------------    -----------------    ------------
> > > Enforcing       69,107               baseline
> > > Permissive      70,248               +1.6%
> > > Disabled        93,566               +35.4%
> > > 
> > > Permissive ~ enforcing confirms the overhead is not in SELinux policy
> > > evaluation. Disabling SELinux removes the rcu_read_lock/unlock call
> > > sites in the AVC path and recovers most of the performance -- but
> > > still leaves a ~13% gap vs 6.12 (no PREEMPT_RCU), which is the base
> > > cost of PREEMPT_RCU in the non-SELinux parts of the kill() path.
> > > 
> > 
> > This seems strange. How come rcu lock/unlock depends on SELinux policy?
> > One should call rcu lock/unlock if they are working with rcu updated
> > fields.
> > 
> > Does the policy change itself protected with rcu lock/unlock?
> > I will check it up.
> > 
> > > So the core issue is: on ppc64le, CONFIG_PREEMPT_RCU makes
> > > rcu_read_lock/unlock significantly more expensive, and the kill()
> > > syscall path hits them very heavily through SELinux AVC lookups.
> > > 
> > > Thanks,
> > > Jirka
> > > 
> > > On Mon, Jul 27, 2026 at 6:19 AM Shrikanth Hegde
> > > <sshegde@linux.ibm.com> wrote:
> > > > 
> > > > +cc paul for any further/RCU insights.
> > > > 
> > > > On 7/27/26 12:03 AM, Jirka Hladky wrote:
> > > > >     Hi Shrikanth, Christophe,
> > > > > 
> > > > 
> > > > Hi Jirka, thanks for the report.
> > > > 
> > > > >    I'm seeing a significant performance regression on
> > > > > ppc64le after this
> > > > >    patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
> > > > >    once HAVE_PREEMPT_DYNAMIC_KEY is selected.
> > > > > 
> > > > 
> > > > This is true only if user selected PREEMPT_DYNAMIC option i think.
> > > > 
> > > > config PREEMPT_RCU
> > > >           bool
> > > >           default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > > >           select TREE_RCU
> > > > 
> > > > 
> > > > >    Benchmark: stress-ng kill stressor (tight kill() syscall loop),
> > > > >    single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).
> > > > > 
> > > > >    Bisected across Fedora ELN kernel builds on ppc64le:
> > > > > 
> > > > >      kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
> > > > >    ---  6.15-rc6 (eln148)    no                   103,207
> > > > >      6.16     (eln150)          yes                   70,281    (-32%)
> > > > >      6.18     (eln154)          yes                   72,552    (-30%)
> > > > > 
> > > > 
> > > > Does your preemption mode remain the same in two cases?
> > > > 
> > > > >    For comparison, x86_64 (AMD EPYC 9355P) with the same config change
> > > > >    shows only a 2.8% regression:
> > > > > 
> > > > >      6.12 x86_64          37,436
> > > > >      7.2  x86_64           36,392    (-2.8%)
> > > > > 
> > > > >    perf report shows the overhead comes from
> > > > > rcu_read_lock/unlock in the
> > > > >    SELinux AVC path (check_kill_permission -> security_task_kill ->
> > > > >    selinux_task_kill -> avc_has_perm -> avc_lookup):
> > > > > 
> > > > >      Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
> > > > >    ---  avc_lookup                          15.23%              24.79%
> > > > >      __rcu_read_lock                      ~0%                 4.52%
> > > > >      __rcu_read_unlock                    ~0%                 4.17%
> > > > >      selinux_task_kill                    6.23%               7.35%
> > > > >      audit_signal_info*                   0.94%               3.59%
> > > > > 
> > > > >    On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
> > > > >    (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
> > > > >    implementation, the weak memory model requires real barriers
> > > > >    (lwsync/isync) making each RCU read-side critical section
> > > > >    significantly more expensive.
> > > > 
> > > > Weak memory model would need barriers irrespective of
> > > > HAVE_PREEMPT_DYNAMIC_CALL
> > > > or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
> > > > more into it. Also i don't know much about PREEMPT_RCU. So might
> > > > take a while.
> > > > 
> > > > > 
> > > > >    This aligns with Christophe's earlier review comment that
> > > > >    HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
> > > > >    implementing static calls for ppc64 be feasible to close this gap?
> > > > > 
> > > > 
> > > > Static key too is expected to minimal cost. There maybe more into this.
> > > > 
> > > > >    Test details:
> > > > >    - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
> > > > >    - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
> > > > >    - Tuned profile: virtual-guest
> > > > >    - SELinux: enforcing (permissive recovers only ~7%)
> > > > > 
> > > > >    Happy to run additional tests if needed.
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 

