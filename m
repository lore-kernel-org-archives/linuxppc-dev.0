Return-Path: <linuxppc-dev+bounces-26803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC86C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfPpb377yz2y8G;
	Tue, 08 Sep 2026 23:26:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788873975;
	cv=none; b=TO5DjVZ/zj+TM60nSj/nmIMpmkXJwkPfZEXHfYfiMvqFcRe8JYG1F6FZQf5N61M0PPJQk1/H/D424UK2LKzV3F/ef+2fSHNWYJEqslgdD1oEWC4fy7tVEKODYIfDfv9W6ztA/WZahnrCeQm2tG22vaj4Ta68mYrPC5WcfOpQhzFQCodwDUU7DUOfnrXyuY4ocT194shVKrMy3r9po+kUNT161qE6POXMcE7Zffn3ks/tcl1oOhKaXsj3+PTkYnzAls9pe8pxSEcBzGuVAamfIKYZMdumBbq0p/C+uk43D9UJNNXqiPK8ieYszTz5mks2pDl9Rm5WMhJZgb7JkJQzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788873975; c=relaxed/relaxed;
	bh=9ZOHA9tdlo1qTDpR1eEKANEz1uLz5blHgwM68Z+xZ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXi/a8GUPdTMx8+hk8m/bx4zxTufdApu5LapJd871xAxl8bPOmkY4YUqkIOpiRULJ4v8YuG4uF8E0AEVVIW21MtDSnoUfCAntXK0mUResHdbOtUof12Vz1WcVG/qWtR8K+vpEh/uq5YjqsmQSJKS8KxlgqU7BxBf17kUtlX1yC2CUkI1YeWqQeXo66Utnqstz7A7Z6iGlBGVyghJ0wqBg1CTAzAXZ7ny/UTPlvQALuI8fkVvCo2bt9A2w4SbWz7F3Epi2BPpmERYPtuICVNW3xUbD+wmkO3tE2tBWcuHW9FDNfJK3y4DNcoRYtPnFM1uZlmm/snJTSvfeg8UsD3z/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kl8t02Mv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kl8t02Mv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfPpY3fhVz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 23:26:12 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-852c481415fso5548860b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788873970; x=1789478770; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ZOHA9tdlo1qTDpR1eEKANEz1uLz5blHgwM68Z+xZ28=;
        b=kl8t02Mv4dhybByPRoXuc2tU0x2DqMEhmwltNN1c4twdg0uNIMgmwPUzpPO2wuVd3a
         aap/G3mx/P4/QrsM+twq0NcNZGy2CMBAswbD80bMaEO8Ml2tnjJKJd3pEplLTkburHd7
         ZAghCtnIrRKPzuoMLhoQR4b/KZXSbvsl7bZv9U/RN6y0SfO74RZeEcqkgWBGAYMC2kQl
         zjOlIVX+wPQVortVG4guurKPLjRjvxumXBt8S1Ad19Ufq4+kqBIUc0aQfDPRXoHnNG6I
         q2nAJMEOtbKpjkSKmWsZfYa9ZdwQtj3vn7tL1Gs33/kRzIqSeeA5WlOi49Zz9edePFvq
         tS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873970; x=1789478770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9ZOHA9tdlo1qTDpR1eEKANEz1uLz5blHgwM68Z+xZ28=;
        b=cBgbrKzzFAauKBj1wK7Hfo6BHiyPW99GdOowKYk5thKM8SALncd4JA+sST4x3ee7JI
         q6spCNkQdQunY38w0jomPiG6FCQvOPguFd30wrO6uH8XueGKTsqODMXThHK4Yi3mnIvE
         ATPDdp1hn2ZvkPoV70hrPsvHyccrXFZ6pMfjpRi6GTbqSDaxgdO/L3xTLnNU88BgwY3k
         S9BXjFlrKZWXAJRhv8AZKG9Vz4mqZkzQWpviEFmECe5MTKENaWZO3GxTRFyuu9WCvDqZ
         dph/mnKhuGCZBDCC1m3/u+ckhIV0OGQt0LVdxsUKExD84v6WCPHtoeYN2xJE9TLfxuuQ
         REug==
X-Forwarded-Encrypted: i=1; AKwUvByM1aDf3s1JdKWzKj0SsB5+zhqO5j71nPqvi6ryy7fmH6qzb8HVkquB62Y/gxryPTU8Yf+o0U8dl603tqY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++miOyxsuGvLYLlBzkRJ+uTheniAvCS41Wcih1On8PEGo5rMlRbg
	ue8wpUKkkoY0Q6uDn6ysN4gQjoXsXPbO2jwEeYQ381IssOXpDHv0OM38
X-Gm-Gg: AYBFou1/jWB5MvZDvE8KzQMZcBaWunYOl04Ij81IbFI3vaz6H6T0wxowsSVv83CLfRI
	FlY2fbkG5/YFjKpOM/MlOLCrOTxqt4nl31hTuViRcXmzlgtTXK1oroz/nGhL7j0vGDF7eoevzdy
	bDdUClUHq0qVPCnWzJai2t46EFLENqo5NY8rE81tmZGJkTW1kf10c7MpHQkl0QMjC4+5nw1/z4H
	fslwcfYftJ5A54iF2VNxmYqjfUEeU0paVoW67OXe8UYYBXE3PHa7qm2FNaeZMYvL/zUeXHr1eYb
	oNJoRukDMxggzpUjQnfjUqM/mMzwaOvkYxSgnZZEaCWt1StbQ0QG64TXZz+OeNCpdQp+zZrRdb3
	O+kb0g/mgNx0k8oYBiPzMjnGrFws7Pxirebz35C/RfEqGaRvntLi5yRU6uwDl47DlX/cqkrMpp2
	2GUaa+R61wgbnIrL88J2vC71yDUsyQ2awCsJJTf7GIa4Je6Oabi6D5aR8XYU6h9NhN73bZVNznj
	ETfsdloBQJVPDbwIr4NJmZU+U8Dpyg5GtqV
X-Received: by 2002:a05:6a00:44c7:b0:857:7337:5dbb with SMTP id d2e1a72fcca58-8616b56e83cmr44216894b3a.25.1788873969342;
        Tue, 08 Sep 2026 06:26:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.53.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615292a8f5sm5695364b3a.27.2026.09.08.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:26:08 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:55:55 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, 
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, 
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, 
	kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com, 
	agordeev@linux.ibm.com, segher@kernel.crashing.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
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
In-Reply-To: <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>

On Thu, Jul 30, 2026 at 01:24:46PM +0200, Jirka Hladky wrote:
> On Thu, Jul 30, 2026 at 11:36 AM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 11:41:07AM +0200, Jirka Hladky wrote:
> > > Hi Mukesh, Shrikanth, Madhavan,
> > >
> > > I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
> > > syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
> > > narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
> > > bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").
> > >
> > > The regression manifests specifically when SELinux is enabled. Regression
> > > disappears with selinux=0. With SELinux disabled, 7.2 is actually
> > > slightly *faster* than 7.1.
> > >
> > > Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
> > > Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB
> > >
> > > Results (bogo-ops/sec, higher is better):
> > >
> > > Kernel   Enforcing   Permissive   Disabled    SELinux tax
> > > ------   ---------   ----------   --------    -----------
> > > 7.1      69,107      70,248       93,566      -26.1%
> > > 7.2-rc4  56,247      59,075       99,240      -43.3%
> > > Delta    -18.6%      -15.9%       +6.1%
> > >
> > > Key observations:
> > > - SELinux permissive ~ enforcing on both kernels (overhead is in the
> > >   code path, not policy evaluation)
> > > - SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
> > >   path itself is not slower for the base syscall
> > > - The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
> > > - No changes to security/selinux/avc.c between v7.1 and v7.2-rc4
> > >
> > > The kill() hot path (sys_kill -> check_kill_permission -> security_task_kill
> > > -> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC lookup
> > > in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, each
> > > pair requires lwsync/isync barriers. I suspect the generic entry path
> > > changes something in how context tracking, tracing, or RCU interacts
> > > with the syscall fast path that amplifies the per-call RCU cost.
> > >
> > > Note: this is on top of a separate ~36% regression from 6.12->7.1 caused
> > > by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
> > > (commit 6ad7751537e8), which I reported separately on the v4 thread.
> > >
> > > Thank you
> > > Jirka
> > [...]
> > Hey Jirka,
> >
> > Thanks for reporting this.
> > I'll take a look.
> >
> > Thanks,
> > Mukesh
> >
> 
> Thank you, Mukesh! I'm happy to run additional tests on the POWER10 machine
> if you have patches to try or specific experiments you'd like me to do.
> 
> Jirka
> 

can you try this with the below diff?

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index e56ded733b1b..dcad641eb2c2 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -120,6 +120,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
+static inline void rcu_ct_kernel_exit_qs(void) { }
 void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 16a04202888b..d623f2a7d3fc 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -87,6 +87,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
 
 struct task_struct;
 void rcu_preempt_deferred_qs(struct task_struct *t);
+void rcu_ct_kernel_exit_qs(void);
 
 void exit_rcu(void);
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c0..011018214c6d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -118,7 +118,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	lockdep_assert_irqs_disabled();
 	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rcu_preempt_deferred_qs(current);
+	rcu_ct_kernel_exit_qs();
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..c23478f70c17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -368,6 +368,25 @@ notrace void rcu_momentary_eqs(void)
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
 
+/**
+ * rcu_ct_kernel_exit_qs - report deferred QS on syscall/exception exit if needed
+ *
+ * Called from ct_kernel_exit() on every return to userspace.  Guards the
+ * rcu_preempt_deferred_qs() call with rcu_preempt_need_deferred_qs() so that
+ * on the common fast path -- where nothing is deferred -- we avoid the
+ * cache-line traffic on current->rcu_read_unlock_special that the unconditional
+ * call causes.  This is particularly significant on weakly-ordered architectures
+ * (e.g. ppc64le) where rcu_read_lock/unlock issue lwsync/isync barriers and
+ * already touch that cache line in the syscall body.
+ *
+ * Follows the same pattern used by rcu_flavor_sched_clock_irq().
+ */
+notrace void rcu_ct_kernel_exit_qs(void)
+{
+	if (rcu_preempt_need_deferred_qs(current))
+		rcu_preempt_deferred_qs(current);
+}
+
 /**
  * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
  *



