Return-Path: <linuxppc-dev+bounces-24904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2F5C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 16:08:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h83R24NXXz2yhD;
	Tue, 28 Jul 2026 02:07:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785168478;
	cv=none; b=SvBryLN+2nsUgEh/GU9oU3qrBPEKRJLUaVhImf3uraSSKJe3IT0c7XXDPREq0ggeKuGzakIwXarsvDhMg6bpf//hucHsOBQI2j2TxaEgKWuPlbM0d2zE05hvODa9S1/BvH5aC4XwhSwMtgfQOhbW5/wcbpaTqkId1bSc3TYLlCr1+9IBEgoS0bDXrEjU9Huy2EkCNlBaTuMpT6WfRHSoh2xGXnzX+JYgrTZxt6dxx2JLIR4UkM4jTeA+xTpDd8+A8yZN/WEuQsOB/F669MOasrYPlWhIUXewlHIf6S3MgbiTrgzT3O+RJBpqk0iEfmYb2YsGjnm26gpS1PUebdegTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785168478; c=relaxed/relaxed;
	bh=QCrWmryD9ZEZ9/iXJ/nEV+ihWJQSCDCdLb0L3Rz25Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU1ptNcAy9EfJmCR2vc3RA2TCSmF1cJn9dGXwOLfATgZiWu/2jFnGogd9z7ec4uodh5WTxEYQtsLD9An0CS0hbPbkuOdycbHzmzoafh6fVIUuUwlxeZM0/lZUcmdoWeOUwZeIinkHmdjDEzD5yFJYAMVgmOCWq7AfQ5y4hTZnkTF55UBoCwNrvhH301AygB3+PB9+MmCE/cwGFfELma1KT2+74Ll6x9yTYmV5GFc2reGpTXi1RIVxapelJybFCjWhZXFZyfl7w9BbLCH4VPAlf8gVaW8k/sbjL9TOJyLuERrFcXeFD5xHfyGBD3aZlPOORZs0PYwn4ju3hn28bPFyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jETbaRNM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=szs6=fv=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jETbaRNM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=szs6=fv=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h83R13NDPz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 02:07:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BF57C60008;
	Mon, 27 Jul 2026 16:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734861F000E9;
	Mon, 27 Jul 2026 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168474;
	bh=QCrWmryD9ZEZ9/iXJ/nEV+ihWJQSCDCdLb0L3Rz25Hw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jETbaRNMqDZpl2TWbo4xhs0bhXgY9s7zRjl2QqR4H/VN3UdnfvoHsqcki3WycY5sj
	 aKtkuM398f1rEoEqpDfFwatABJJ69InVYuZhCr+8CRd0l5XQ1BQdPO8AjoWqhBaocz
	 IJc0LqxNoCDJObopyLRV8vGsKa9Dc6aOBUNhbJ06yEgJJ1Cv0Cn3bRxr8Aau9vEyK0
	 GeCjTNhWBm0rTJHTbPe/KCHOB4+2THs5gstEMT2/LGeFvJEztovjOCtMQgAC4JcV8g
	 z0oaqB0hJxq8zc+3DX+Ls53lvBJnH4GhXplAEUW+bWZ2wq669DSFOMB1xEkQTXzZRU
	 y0pIGxfKnQyqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B057CE08BC; Mon, 27 Jul 2026 09:07:54 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:07:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
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
In-Reply-To: <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>

On Mon, Jul 27, 2026 at 09:48:25AM +0530, Shrikanth Hegde wrote:
> +cc paul for any further/RCU insights.
> 
> On 7/27/26 12:03 AM, Jirka Hladky wrote:
> >    Hi Shrikanth, Christophe,
> > 
> 
> Hi Jirka, thanks for the report.
> 
> >   I'm seeing a significant performance regression on ppc64le after this
> >   patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
> >   once HAVE_PREEMPT_DYNAMIC_KEY is selected.
> 
> This is true only if user selected PREEMPT_DYNAMIC option i think.
> 
> config PREEMPT_RCU
>         bool
>         default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>         select TREE_RCU

Yes, if you select PREEMPT_DYNAMIC, RCU doesn't have much choice but to
choose PREEMPT_RCU.  Something about not having the guts to implement an
RCU that dynamically switches between its preemptible and non-preemptible
variants.  Cowardly of me, I know!

So if you want non-preemptible RCU, you need to turn off PREEMPT_DYNAMIC.

> >   Benchmark: stress-ng kill stressor (tight kill() syscall loop),
> >   single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).
> > 
> >   Bisected across Fedora ELN kernel builds on ppc64le:
> > 
> >     kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
> >   ---  6.15-rc6 (eln148)    no                   103,207
> >     6.16     (eln150)          yes                   70,281    (-32%)
> >     6.18     (eln154)          yes                   72,552    (-30%)
> > 
> 
> Does your preemption mode remain the same in two cases?
> 
> >   For comparison, x86_64 (AMD EPYC 9355P) with the same config change
> >   shows only a 2.8% regression:
> > 
> >     6.12 x86_64          37,436
> >     7.2  x86_64           36,392    (-2.8%)
> > 
> >   perf report shows the overhead comes from rcu_read_lock/unlock in the
> >   SELinux AVC path (check_kill_permission -> security_task_kill ->
> >   selinux_task_kill -> avc_has_perm -> avc_lookup):
> > 
> >     Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
> >   ---  avc_lookup                          15.23%              24.79%
> >     __rcu_read_lock                      ~0%                 4.52%
> >     __rcu_read_unlock                    ~0%                 4.17%

Yes, non-preemptible RCU's __rcu_read_{,un}lock() are (almost) no-ops,
but preemptible RCU must actually execute real code.  But I would not
expect *this* much overhead.

> >     selinux_task_kill                    6.23%               7.35%
> >     audit_signal_info*                   0.94%               3.59%
> > 
> >   On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
> >   (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
> >   implementation, the weak memory model requires real barriers
> >   (lwsync/isync) making each RCU read-side critical section
> >   significantly more expensive.
> 
> Weak memory model would need barriers irrespective of HAVE_PREEMPT_DYNAMIC_CALL
> or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
> more into it. Also i don't know much about PREEMPT_RCU. So might take a while.

OK, if you are executing an isync or an lwsync instruction in each call
to __rcu_read_{,un}lock(), that would explain the overhead.

CONFIG_PREEMPT_DYNAMIC=n for the win?

							Thanx, Paul

> >   This aligns with Christophe's earlier review comment that
> >   HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
> >   implementing static calls for ppc64 be feasible to close this gap?
> > 
> 
> Static key too is expected to minimal cost. There maybe more into this.
> 
> >   Test details:
> >   - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
> >   - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
> >   - Tuned profile: virtual-guest
> >   - SELinux: enforcing (permissive recovers only ~7%)
> > 
> >   Happy to run additional tests if needed.
> > 
> > 

