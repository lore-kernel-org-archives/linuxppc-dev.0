Return-Path: <linuxppc-dev+bounces-20291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF7CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 13:42:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5JQd3HHkz2yVL;
	Wed, 29 Apr 2026 23:42:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777470169;
	cv=none; b=VN0Z6+0tKpKqZgLxDRJZTTr5JlaJ4oNXbw9jorx0QRLh1fOepN/hZILFAdP+OcGpQu1FCVHKGnFHq2f3Tv2CFSCpyFpdhxvOLzmc/1ZA1BmCsRia8pXYMqj2rMq/TJ0+qNZFlygZJKuGOBpyyA0nLOvFgKu4TgBtyPtdJwc1afPHuHfeJIKm2LEq6XTLaaD7h0SliRPs/GNDozVx1LqmzL4LyW0Q9VT50gTm4tsSIhwFkDBN1Zs1HFe/uQbfw3P8+5BdzqQ+fo+1hOx03By3fYSJMJeWJTUFrpnlhIDy+bCtE7WiTcZALil53ozQH9R7bY2Ul+fChLC89BhL4ZU7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777470169; c=relaxed/relaxed;
	bh=Q5X54Lz+Jn5o+nzaKD5owfJoIfYox8wOHlKlroc2Wag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5qiQE4sHORz9DgMlqBZfn1FwjSaKfm9JxQaNLEnHbeUYeDy8nOnwAv/jcqcGM+hlWHT433/eIZdVRTO/Tc370ZGr1X6s3fp/O7lCJ4p86JoszSZ/WQXNdKp32f2mnD86EZyjWXp7s/5SuErps6aAgjEhf69AZ3YwmaA8tR8t5H3c8gePBGnAlOgBQ7ftXidT2Jp0qEX5EQrDHLyadz5a35X4kY7vwp6WFdwXkjqQuhJvGRoPIo+pL38OYzJ7SnS/BEMOPRQWNiW3BuOxypYnHZKNjj7fXG+6ToIlb+t9r34TbyUo8B9uneJb5gfnCh7/IaXcD+DuE3DQYT+YCHMLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OE6rjPL/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OE6rjPL/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5JQc52lSz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 23:42:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E6574083B;
	Wed, 29 Apr 2026 13:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0897C2BCB8;
	Wed, 29 Apr 2026 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470166;
	bh=a+7XuyHe4EWHnX6s11UGKgV6DlS21CowOLqbN6S2Lg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE6rjPL/oe/WMCFrDH6l3RbMArU6cghOl5LqMUtgZvG93/JEtP90ZRaC0R0/nGTJ4
	 i572MX4/7aD2rfZ53EXS46/FDWqfHYU05/BmQIc+RlsiVLJkDNacCGZ/MfIvtgp3vF
	 Bxg77LO0XIFRq8wXYAO0F+CeZ4hlYusXnDMTKe+c9pYwyPznu/Gnx6ihT1KvAbd7xW
	 BcmxHOc8NbxIy4uK1TCKCt9SLUhJcTudfvODsIt5bMkg3e6IZW+gRLAI82UCOlmfir
	 5B2/FrFB9LuiytqiN486dclU0Nc+jC8Q6z06/I6g+k/xMWoJVFDIeC3yeD/Gd+xlq/
	 tjEWzpbb7DouA==
Date: Wed, 29 Apr 2026 15:42:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/14] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <afIK02h-gBvuqJnn@pavilion.home>
References: <20260331131622.30505-1-frederic@kernel.org>
 <20260331131622.30505-5-frederic@kernel.org>
 <2dab11d1-18ca-4da4-a33e-3f2c3c4b6320@kernel.org>
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
In-Reply-To: <2dab11d1-18ca-4da4-a33e-3f2c3c4b6320@kernel.org>

Le Mon, Apr 13, 2026 at 01:00:07PM +0200, Christophe Leroy (CS GROUP) a écrit :
> > @@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
> >   extern void vtime_account_softirq(struct task_struct *tsk);
> >   extern void vtime_account_hardirq(struct task_struct *tsk);
> >   extern void vtime_flush(struct task_struct *tsk);
> > +extern void vtime_reset(void);
> > +extern void vtime_dyntick_start(void);
> > +extern void vtime_dyntick_stop(void);
> >   #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
> >   static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
> >   static inline void vtime_account_softirq(struct task_struct *tsk) { }
> >   static inline void vtime_account_hardirq(struct task_struct *tsk) { }
> >   static inline void vtime_flush(struct task_struct *tsk) { }
> > +static inline void vtime_reset(void) { }
> > +static inline void vtime_dyntick_start(void) { }
> > +extern inline void vtime_dyntick_stop(void) { }
> 
> You mean 'static' inline, not 'extern' ?

I might have been too creative here, yes.

Thanks.

> 
> Christophe
> 
> >   #endif
> >   /*
> 

-- 
Frederic Weisbecker
SUSE Labs

