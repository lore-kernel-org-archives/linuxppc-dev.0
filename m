Return-Path: <linuxppc-dev+bounces-24869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A6C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:13:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vZQ6LbHz2ygn;
	Mon, 27 Jul 2026 20:13:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785147230;
	cv=none; b=bT1mc87j+JDk9NNHydzSbFdWnplGfpFUZrvv0/c3K4/JDyO6qp2ioQiooQzOYzy/4n3L+Shb9m9/y27I8mDzkfqPYU3CMRtashrBpXoaO71DNNaEaQHcBfG9TGKBybOdv2MEUUKsGu0qvrYOA3/5R7BGFM28LctcbQRZR5On5a7f6+6zH1xhf3zwn/Y6qucWreGMIoauSa8dusne6V5SoWwIGlqfwkAzvZaZCKycBqsRX+V7Nx2qmu/0AKtgzyjykKXNlZJ4XXxmKxEOx2vRFvrCltvcGj9nyhdn4QyktXWtMrhF9YQod/VhSqk9yRIMbmnxW92Xpqc0F+X3fdcYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785147230; c=relaxed/relaxed;
	bh=ud4RuXoTpIz7jiezO+uXrZbBN/aTriHAEKe8yGxims0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mB87rpMZeELIxCQPfF8YpmTV+Qny8/HUup05WA22Y7T82ER2dN8IocYIuaw+x2w1I3F0nkxqljLrlqbpZDdHs9IdY0e7cM5PDLjj8McmrU0tB354AT+AIyEEFdhjeB8Qi7KsGkTTnJ80VHheJfmcPc7Rtxb0n3Eu4zwolnoxxQuGERU2k8SXpoRfN89lrBoFP7cSzuUvsacv6Eb7mOSg2Evitr7dcwPbMdx5vtQrbdmvP+MBfEyZsAxbQ4KVsWGaS8tw6N+S6bsbU6p8py+llLmrIjwkJNJYjW6ibPwETvlRNlEcHIWELxC7bKFOXPI1Iabs814nWHU4MJ3/dqNGrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6Xra9yM; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6Xra9yM; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6Xra9yM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6Xra9yM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vZP4Kgpz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:13:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785147224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ud4RuXoTpIz7jiezO+uXrZbBN/aTriHAEKe8yGxims0=;
	b=c6Xra9yMFtxlkdf+2Yo1WE+RvEtUpaxw5bduC2jNLPY51n4QhEQTfaCFqyO4J42kd9t+7u
	165dJVrzwa/4GEhRsawuaB1CFIXRyX+Yg8LAA/dVH3CIaSwUaHVr9a3Q9iOpY4Th24uFfI
	FRdWzFz9SNTxWX8RvwebGgYxc/CEFJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785147224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ud4RuXoTpIz7jiezO+uXrZbBN/aTriHAEKe8yGxims0=;
	b=c6Xra9yMFtxlkdf+2Yo1WE+RvEtUpaxw5bduC2jNLPY51n4QhEQTfaCFqyO4J42kd9t+7u
	165dJVrzwa/4GEhRsawuaB1CFIXRyX+Yg8LAA/dVH3CIaSwUaHVr9a3Q9iOpY4Th24uFfI
	FRdWzFz9SNTxWX8RvwebGgYxc/CEFJg=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-WPBUI_pjOIOB1hWaUKMCDw-1; Mon, 27 Jul 2026 06:13:42 -0400
X-MC-Unique: WPBUI_pjOIOB1hWaUKMCDw-1
X-Mimecast-MFC-AGG-ID: WPBUI_pjOIOB1hWaUKMCDw_1785147222
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c2b5fcbe87so454894e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 03:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147222; x=1785752022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud4RuXoTpIz7jiezO+uXrZbBN/aTriHAEKe8yGxims0=;
        b=YxSsOOT93Su/h+r1jUQpbD6dddCCmhN+aBil7xOaGY1m1old5APIrm2nfy2GfryQI/
         TcuFYCWbVynyJjVvsIhbDKTlIB7tjZL5aIgp0KdZajW/hqnxC/AhMstwpmnDmb9C+Zyo
         Xg6tsplrJT6Xg1mtc/MvpP9YcwrqFOvGx3IN3wGbB9dkvCSfS/BuvgOEslfjcEe33if8
         Jgf17DAtbUIOSjEbGCQEIFnkCEK6S5vN3n9TbMJfAbOfiE5nCgrWNWLqpXAZ4FKavNz0
         MV9UFWTnKXyuJd9KCwQ1Zm3RpowwDDS2t/jkH+q7598I2oDKI/G7D3EQVN8cQlqmroH5
         Dx+w==
X-Forwarded-Encrypted: i=1; AHgh+RoxmZBseFcjsBAundW1E4WSVE3n4qFER6KywOHVL0arilEoHC8qs4vQMfc4OBroZGCKqwdT515bnsCqPHY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKv6Oh6gBHZ7rjrEz3S3Rh4deQXP5yl1DsM4hiM9Nhr0rvoJkg
	K9X94DbUk4n2dMqyj3uRUakz51lhKZThMvt1iAmiyUeRu1CrOywbUqR+IhqWVXduKLweBDQTJbs
	nzRqXQK39YFU4gqBFJVrc9NFcNLWZK3J0KDTbWrapf4PdL4aQaY1hHVdcALTvIr3ygGMVB//cgs
	Ujb3PPZ5jzaMi744TcBWRi+ShwFzkNUDjLYXKuYcebyI7D/RPaAhJj
X-Gm-Gg: AR+sD12KdAYxQQ6jSK6UAkhB7yF7NpReMStbFiFzFE99aV5KrHINfXbVTCl3Y0tqqdS
	Ri6WJ+DGDjsN6Sg7IT+uXTnMJEuINYbQ8fCOyyBpxz+jMozfKeY9tUe2e9C+jS5kRK2NoAO24Fu
	qOHeiHrgP63Npto31stEC9HPHBzK1iJ62oO/W41Zs/vDe4ZN5dr0tlfuI=
X-Received: by 2002:a05:6122:c93:b0:5a0:afff:78a6 with SMTP id 71dfb90a1353d-5c306da2addmr3047207e0c.14.1785147222176;
        Mon, 27 Jul 2026 03:13:42 -0700 (PDT)
X-Received: by 2002:a05:6122:c93:b0:5a0:afff:78a6 with SMTP id
 71dfb90a1353d-5c306da2addmr3047188e0c.14.1785147221687; Mon, 27 Jul 2026
 03:13:41 -0700 (PDT)
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
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com> <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
In-Reply-To: <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 27 Jul 2026 12:13:30 +0200
X-Gm-Features: AUfX_my4tchY2f0PkVTtivbHXu5njN0yU-lSPim41GlU7QtVX7k2dOvGUcZl8C4
Message-ID: <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ik9cda-9Ma_FvhH82DzDQDQMU6NHcuFZrdy-LJ6HmEw_1785147222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shrikanth,

Thanks for the quick response and for looping in Paul.

> This is true only if user selected PREEMPT_DYNAMIC option i think.

Yes, exactly. The issue is that CONFIG_PREEMPT_DYNAMIC=3Dy has been in
the Fedora/RHEL kernel config since kernel 5.16 (2021). It was
silently ignored on ppc64le until your 6.16 patch added
HAVE_PREEMPT_DYNAMIC_KEY, so this is the first time PREEMPT_RCU
actually takes effect for all Fedora/RHEL ppc64le users.

> Does your preemption mode remain the same in two cases?

Verified. On 6.15-rc6 (before PREEMPT_DYNAMIC takes effect):

  CONFIG_PREEMPT_VOLUNTARY=3Dy
  (no CONFIG_PREEMPT_DYNAMIC, no /sys/kernel/debug/sched/preempt)

On both 7.1 and 7.2-rc4 (with PREEMPT_DYNAMIC active):

  CONFIG_PREEMPT_LAZY=3Dy
  CONFIG_PREEMPT_DYNAMIC=3Dy
  CONFIG_PREEMPT_RCU=3Dy
  cat /sys/kernel/debug/sched/preempt: "full (lazy)"

So the runtime preemption mode is the same on 7.1 and 7.2. The
difference between 6.15 and 7.1+ is that the preemption model changed
from voluntary (static) to full/lazy (dynamic), which is what pulls
in PREEMPT_RCU.

> Weak memory model would need barriers irrespective of
> HAVE_PREEMPT_DYNAMIC_CALL or HAVE_PREEMPT_DYNAMIC_KEY.
> Static key too is expected to minimal cost.

You're right, I should clarify -- the overhead is not in the static
key mechanism itself. The cost comes from __rcu_read_lock() and
__rcu_read_unlock() which are called when CONFIG_PREEMPT_RCU=3Dy.
These need real memory barriers (lwsync/isync) on ppc64le regardless
of whether the dynamic mechanism uses keys or calls.

The real question is: why does enabling PREEMPT_RCU cost ~33% on
ppc64le but only ~3% on x86_64? The answer is that x86_64's TSO
memory model makes the barriers in __rcu_read_lock/__rcu_read_unlock
essentially free, while ppc64le's weak ordering requires explicit
lwsync/isync instructions, which are expensive when called thousands
of times per second in the SELinux AVC hot path.

I also have new data from SELinux isolation testing that helps
quantify this. On kernel 7.1 (which already has PREEMPT_RCU=3Dy):

SELinux mode    kill bogo-ops/sec    vs enforcing
------------    -----------------    ------------
Enforcing       69,107               baseline
Permissive      70,248               +1.6%
Disabled        93,566               +35.4%

Permissive ~ enforcing confirms the overhead is not in SELinux policy
evaluation. Disabling SELinux removes the rcu_read_lock/unlock call
sites in the AVC path and recovers most of the performance -- but
still leaves a ~13% gap vs 6.12 (no PREEMPT_RCU), which is the base
cost of PREEMPT_RCU in the non-SELinux parts of the kill() path.

So the core issue is: on ppc64le, CONFIG_PREEMPT_RCU makes
rcu_read_lock/unlock significantly more expensive, and the kill()
syscall path hits them very heavily through SELinux AVC lookups.

Thanks,
Jirka

On Mon, Jul 27, 2026 at 6:19=E2=80=AFAM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
>
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
> >
>
> This is true only if user selected PREEMPT_DYNAMIC option i think.
>
> config PREEMPT_RCU
>          bool
>          default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>          select TREE_RCU
>
>
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
> >     selinux_task_kill                    6.23%               7.35%
> >     audit_signal_info*                   0.94%               3.59%
> >
> >   On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
> >   (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
> >   implementation, the weak memory model requires real barriers
> >   (lwsync/isync) making each RCU read-side critical section
> >   significantly more expensive.
>
> Weak memory model would need barriers irrespective of HAVE_PREEMPT_DYNAMI=
C_CALL
> or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
> more into it. Also i don't know much about PREEMPT_RCU. So might take a w=
hile.
>
> >
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
>


--=20
-Jirka


