Return-Path: <linuxppc-dev+bounces-26812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02162C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfTG42Y73z2y8p;
	Wed, 09 Sep 2026 02:01:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788883308;
	cv=none; b=Y2JPW3eIOgIE9b/7kwQz4MsHBgWfBRvB+eWum0mNp4oSr5fzVlBq5FR1l/Iy3M2HzTP+kGbpxUrwZbGjQKvEdZBLd4zL/Uqx/k/oYcoXb5ywDomxCDo9vII2y6sFmj0H6s1350Nvb2G5X+u611ujftZXSVDTCKLdv3M+UhaL4yZ3aKtz4OG39nHJub1QfJ5US2kRELM1/z03fLKz4ssnJ4PgBGL1yaGywjX4P3agCRiPM9ppUdYUZ4Hh+h1b3VFT48bgslX1vi7sTERwd3QPXCBJibRWNt/VGfldZv0sWVBp27ocjRVQpECZ4p34Bl5M1ox88DHCLJECb1SeZmbWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788883308; c=relaxed/relaxed;
	bh=0TF3l7b3D5e24e0H9z8RJn24H1xca1tA2sAjz8GB+pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFbxE0kOzJWmBFQ9//0cZOLpwgwtZ/mNk0xVQolp94nkFKkn2JD2P8CGcjjJgcV5do/ZLEoeDib9tKg5zG6W1reCLSgE5XO3c9twG2qzXd1IAopguAABPFqOnw6YCTI8RvQklqMvZBondWR99kz3ys5IM6Avs7pm6TSc9PbViT6LJFfVKm6en1jSoAPhJtOdhpq/cPyQ3rTTycKzg1tI9WLoi03lWaCFFEpDQoOjIPdF5NhkP8ed+2eOopwVVpE3Dw6V6Atr1UErZwv65T9ufNowsJ+mtQ9DyMQrJgHFCo62xaVEHiTbMFClnHoRkT5mmT6uY7f4//PX2RzX+ZP1ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FX4L+4J5; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FX4L+4J5; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FX4L+4J5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FX4L+4J5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfTG270d3z2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 02:01:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788883301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TF3l7b3D5e24e0H9z8RJn24H1xca1tA2sAjz8GB+pE=;
	b=FX4L+4J5X3vKG6BvH3Yv39WhXUVRCAMsaINUEsELHc4lX6ioL5QLpf3eKuk0t+DoTaZJkr
	2KN++9wZ/UlxbA3EPUusvVYJBbcJvq37NlKhbGf4d277SQxuKkANnMDijdkQVRTaPMhQkX
	x7LuFMbuhJhJPUhxRWKfJstHtb4XrbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788883301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TF3l7b3D5e24e0H9z8RJn24H1xca1tA2sAjz8GB+pE=;
	b=FX4L+4J5X3vKG6BvH3Yv39WhXUVRCAMsaINUEsELHc4lX6ioL5QLpf3eKuk0t+DoTaZJkr
	2KN++9wZ/UlxbA3EPUusvVYJBbcJvq37NlKhbGf4d277SQxuKkANnMDijdkQVRTaPMhQkX
	x7LuFMbuhJhJPUhxRWKfJstHtb4XrbY=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-w5KoXkSvOJ6o1OZ1RNgwag-1; Tue, 08 Sep 2026 12:01:36 -0400
X-MC-Unique: w5KoXkSvOJ6o1OZ1RNgwag-1
X-Mimecast-MFC-AGG-ID: w5KoXkSvOJ6o1OZ1RNgwag_1788883296
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bfd3313dadso4762636e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 09:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883296; x=1789488096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TF3l7b3D5e24e0H9z8RJn24H1xca1tA2sAjz8GB+pE=;
        b=AUh2D+/YzxjFerlrIJGJtem5Wg0ltHy56vGGpwjxPBflwi0q2T9hDLBfscwUjt1e7K
         5/PVAnhP32Ftf89ozd+SpU3jkepQ2pvTXIEuLAceik1n/+lY4Zqt3swF7v/kxuKcpgp4
         J9kZYodpshaxIn6N1/TI15G1xt6S/fQ82zgmLvzB8eW03bjoe7jpQ27fiaMTnqWBbxKi
         mgFuoZrJ8vpecfTxT/+VvMjmHjKfsuOg61//8LZxNAe11NsPOWILL/Hlmsw6h/rNkTy+
         +la2SyuN1MiSH0OcqeXBWESPaK73l8FZmVgd3pwHGmMWpV+Lo9hSGcxqtS2B8Ztt0PV3
         vJ8A==
X-Forwarded-Encrypted: i=1; AKwUvBz+OZaU85RXRByDhke2p9yOxv76uPHOaRhrOAqX8aRP5g3P1spvTNqAerkZW+tzS0z0O5KjBCdKJd8BUh0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kNFjaul3wcZROaM1z3olWmkbUfabqMdtl+USZzcDUSvw7VbKyi
	/Ma7uhAiKXVGbs5ZrDYJkvH+Ggn9pkIp5H7rwvjbD5wLy4AZJDdMNr6+BV6w+BTgunToML8rCrQ
	Xv871KJJjfpwai5GFXBbqVj/QwGH0541BqWr/k3vSfJWZEnZuiShbPYI4qeaQduP/xeD/r1hVst
	FPiT4lr17uBw596UOHGW+/4GKKXpMdGAJlLI1x0uBNrQ==
X-Gm-Gg: AYBFou0yXqa0cdwivVK8AvJ0r2o0PyH94TYpwCgoVBe4Nb+wB1Y5q32y7ldYC7PNguM
	n9OSdtsWxubW6eNnOkOwcBdPxSu12+MfLkMhcf0uyNWll6SanQaO4MFzNiTjuetDe4osfwMUfsp
	fcN5gFMFPBUNGaYnQDX5bqGtYuIiai1yDlXvRnjCAPohcYAA4Gn5gP/S8l
X-Received: by 2002:a05:6122:3a0a:b0:5c7:9947:5ceb with SMTP id 71dfb90a1353d-5c7ed3796d6mr16503327e0c.0.1788883296054;
        Tue, 08 Sep 2026 09:01:36 -0700 (PDT)
X-Received: by 2002:a05:6122:3a0a:b0:5c7:9947:5ceb with SMTP id
 71dfb90a1353d-5c7ed3796d6mr16503120e0c.0.1788883295458; Tue, 08 Sep 2026
 09:01:35 -0700 (PDT)
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
References: <20260427122742.210074-1-mkchauras@gmail.com> <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com> <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Tue, 8 Sep 2026 18:01:23 +0200
X-Gm-Features: AcwNN1Uyikg-_AF06PUl91SbhxvAExLeC150JD6l8k8fnW1PrHI7wcoROdrum8E
Message-ID: <CAE4VaGBCmA0+28G=V_Qs37cR2GKYDUTGQWW_uRe0qvEp5io3qQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, 
	ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, 
	ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com, 
	segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com, 
	pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eb7qm_QXRSANkU_oFbQZUPx75xl7q-mhi_H9c6yxnhY_1788883296
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

Re: policy details -  I'm running an ELN kernel on RHEL-10.2, with SELinux
in enforcing mode using the default (targeted) policy, nothing custom
or hardened on top of it. Let me know if you need anything more specific
(policy version, booleans, etc.) and I'll pull it.

Re: the rcu_ct_kernel_exit_qs() diff =E2=80=94 thanks, that guard against t=
he
unconditional rcu_preempt_deferred_qs() call lines up well with what I
was seeing on the RCU-barrier side. I'll apply it on top of 7.2 on
POWER10 box and re-run the stress-ng --kill numbers
(enforcing/permissive/disabled) to see how much of the SELinux tax it
recovers. No need to prepare anything separately.

I'm OOO tomorrow, but I'll get to this by the end of the week and report
back with results.

Thanks
Jirka


On Tue, Sep 8, 2026 at 3:26=E2=80=AFPM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 01:24:46PM +0200, Jirka Hladky wrote:
> > On Thu, Jul 30, 2026 at 11:36=E2=80=AFAM Mukesh Kumar Chaurasiya
> > <mkchauras@gmail.com> wrote:
> > >
> > > On Mon, Jul 27, 2026 at 11:41:07AM +0200, Jirka Hladky wrote:
> > > > Hi Mukesh, Shrikanth, Madhavan,
> > > >
> > > > I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
> > > > syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
> > > > narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
> > > > bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").
> > > >
> > > > The regression manifests specifically when SELinux is enabled. Regr=
ession
> > > > disappears with selinux=3D0. With SELinux disabled, 7.2 is actually
> > > > slightly *faster* than 7.1.
> > > >
> > > > Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
> > > > Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB
> > > >
> > > > Results (bogo-ops/sec, higher is better):
> > > >
> > > > Kernel   Enforcing   Permissive   Disabled    SELinux tax
> > > > ------   ---------   ----------   --------    -----------
> > > > 7.1      69,107      70,248       93,566      -26.1%
> > > > 7.2-rc4  56,247      59,075       99,240      -43.3%
> > > > Delta    -18.6%      -15.9%       +6.1%
> > > >
> > > > Key observations:
> > > > - SELinux permissive ~ enforcing on both kernels (overhead is in th=
e
> > > >   code path, not policy evaluation)
> > > > - SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
> > > >   path itself is not slower for the base syscall
> > > > - The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
> > > > - No changes to security/selinux/avc.c between v7.1 and v7.2-rc4
> > > >
> > > > The kill() hot path (sys_kill -> check_kill_permission -> security_=
task_kill
> > > > -> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC=
 lookup
> > > > in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, =
each
> > > > pair requires lwsync/isync barriers. I suspect the generic entry pa=
th
> > > > changes something in how context tracking, tracing, or RCU interact=
s
> > > > with the syscall fast path that amplifies the per-call RCU cost.
> > > >
> > > > Note: this is on top of a separate ~36% regression from 6.12->7.1 c=
aused
> > > > by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
> > > > (commit 6ad7751537e8), which I reported separately on the v4 thread=
.
> > > >
> > > > Thank you
> > > > Jirka
> > > [...]
> > > Hey Jirka,
> > >
> > > Thanks for reporting this.
> > > I'll take a look.
> > >
> > > Thanks,
> > > Mukesh
> > >
> >
> > Thank you, Mukesh! I'm happy to run additional tests on the POWER10 mac=
hine
> > if you have patches to try or specific experiments you'd like me to do.
> >
> > Jirka
> >
>
> can you try this with the below diff?
>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index e56ded733b1b..dcad641eb2c2 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -120,6 +120,7 @@ static inline bool rcu_preempt_need_deferred_qs(struc=
t task_struct *t)
>         return false;
>  }
>  static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
> +static inline void rcu_ct_kernel_exit_qs(void) { }
>  void rcu_scheduler_starting(void);
>  static inline void rcu_end_inkernel_boot(void) { }
>  static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 16a04202888b..d623f2a7d3fc 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -87,6 +87,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
>
>  struct task_struct;
>  void rcu_preempt_deferred_qs(struct task_struct *t);
> +void rcu_ct_kernel_exit_qs(void);
>
>  void exit_rcu(void);
>
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index a743e7ffa6c0..011018214c6d 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -118,7 +118,7 @@ static void noinstr ct_kernel_exit(bool user, int off=
set)
>         lockdep_assert_irqs_disabled();
>         trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching()=
);
>         WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idl=
e_task(current));
> -       rcu_preempt_deferred_qs(current);
> +       rcu_ct_kernel_exit_qs();
>
>         // instrumentation for the noinstr ct_kernel_exit_state()
>         instrument_atomic_write(&ct->state, sizeof(ct->state));
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b..c23478f70c17 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -368,6 +368,25 @@ notrace void rcu_momentary_eqs(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
>
> +/**
> + * rcu_ct_kernel_exit_qs - report deferred QS on syscall/exception exit =
if needed
> + *
> + * Called from ct_kernel_exit() on every return to userspace.  Guards th=
e
> + * rcu_preempt_deferred_qs() call with rcu_preempt_need_deferred_qs() so=
 that
> + * on the common fast path -- where nothing is deferred -- we avoid the
> + * cache-line traffic on current->rcu_read_unlock_special that the uncon=
ditional
> + * call causes.  This is particularly significant on weakly-ordered arch=
itectures
> + * (e.g. ppc64le) where rcu_read_lock/unlock issue lwsync/isync barriers=
 and
> + * already touch that cache line in the syscall body.
> + *
> + * Follows the same pattern used by rcu_flavor_sched_clock_irq().
> + */
> +notrace void rcu_ct_kernel_exit_qs(void)
> +{
> +       if (rcu_preempt_need_deferred_qs(current))
> +               rcu_preempt_deferred_qs(current);
> +}
> +
>  /**
>   * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
>   *
>
>


--=20
-Jirka


