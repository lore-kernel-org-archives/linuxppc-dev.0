Return-Path: <linuxppc-dev+bounces-24907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE3C53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 16:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h84Nx3X9xz2yhD;
	Tue, 28 Jul 2026 02:51:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785171073;
	cv=none; b=oLr1vSM5MUPUwGwSd0GebDzBItQEyrE9FaTefxqx72EJ9FX2JQ0SWeFRJqdRMHXK6vjwUfpXJ9nz7LrsyzojzdKzgZYVgIAPpndaolU2ksUxnskK3qqe0gsdcwqjgC3Cq7LiRUyFmpFCtOthwYuyTakHzmpwtrlnOxjvhq+yrWqe7dtgxpEmkI4J2fSLGc7fTN1+zkYerg9gCS/KCWtvmaTmsS659Fo9+uoJmws3fepSyoT7FuyTWRCH6kxPSz2MlzNeA6lvTi52T9jwsaQCn0zcGGXEAu+MZAmwCTuhE1nPXhVxsQls4qt1v1SRC7SHBKe704NU4W1NAJJkhTVBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785171073; c=relaxed/relaxed;
	bh=BFjxn6x+L0rJFkoMgfgfBpq4xsckI9hhjCm2UbTJMyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5OAoDvFXuuIN9XfQriIt/nmox3uu2QJnSwoV/tdv0Xz4I4YfvZqrzX0pwY4lfy3D+h63ATAotpaDgJvrWSz8XF31ImdMidMlQ3wy3zFW/PwVALaBtiV3Pe2OP0Ja2HZyV4ITitpHic8HMAks7zLwIiu3uFbqTjDFkmNPat3IuRpnS0+7+rQ84AfBS/NAHWXQ2UbwHyHqlCu6XLbI/fSr5pQWVAWC7uRv1hfp7LKRzsMsSJ+Y9pdMypQLIuWP9Af07zwAO+XsdeGOYIWU7fe5yf4Mqbo4PaY/2sldvnyzeQm1qBaZ7ANZijqaE57EUpM07/PQzoFils4Y4F3+Q/2xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L3Hw6+s4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L66CV+fW; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L3Hw6+s4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L66CV+fW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h84Nw0vtpz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 02:51:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785171066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFjxn6x+L0rJFkoMgfgfBpq4xsckI9hhjCm2UbTJMyY=;
	b=L3Hw6+s48JGGB4G8NIZHGVb6xd+ABTuKfMuhjxWYO9AlvvgX7adVOWtRqRkHl9SPw3t3zT
	zE+qSCqk+G97MFQVRVjKEovuzuNux7QMp/+POy8FicSlEgSS8f1rHaJnl1MCa8PeCYV1N8
	uTsBXxCL/d4kz479KIrkZZf+694mCYc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785171067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFjxn6x+L0rJFkoMgfgfBpq4xsckI9hhjCm2UbTJMyY=;
	b=L66CV+fWl1jbQH3CpdKr4q7Egk5WsU46Q1/B8CWBkB//if32CbhPQaN7Nzi9G0h7oQ6xsi
	rC/R00kcpywelSHHGyfwlhswvzR+2Vg99SsrK1C0m8fePlRlPtODdgRCX5YOlHWds9M2Xs
	zv6FWSp5haUvLopPJgTDuBM7DL4bj6o=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-pjX1_zb1PV-AjBaItFGruw-1; Mon, 27 Jul 2026 12:51:04 -0400
X-MC-Unique: pjX1_zb1PV-AjBaItFGruw-1
X-Mimecast-MFC-AGG-ID: pjX1_zb1PV-AjBaItFGruw_1785171064
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9771a7eaf48so38050241.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 09:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171063; x=1785775863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFjxn6x+L0rJFkoMgfgfBpq4xsckI9hhjCm2UbTJMyY=;
        b=Mms0b/xFa4N9ofhSchFsGLZF9lY7irRxSHvfC2NjtMf15r55Yn7g1Yd6hDGbX5nNkU
         NpkqBY7pcOz5Ept19r77k5r7F5yzX9Ab9BwZGlIWQbJbdoKsqlljQxJF6aUqYpYVhtoV
         776Hj1Z2xWeWg7KJpZ62TDHuwQENvr59jKb+HCV/rtP52ZM7XKs9Gj6tyzVyIX8YOimJ
         UO8dFzqH6w2r/4RNWmuyirEazU97ZzdBPTehlSTg3WdoiHAfDAmR/Q+Q08lP/8cLDjw/
         0mLTAP2lYYUb+cqc8zFBn2Duy+X8qCuZwa5C6gNVcjqc0tdhv4QS939vWOsCv9hN6n3Q
         JV5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrIled+47Uz+42/i7OshwcLkWUePAaftaEX0qp5qMKh3cqGdwiMn72pFeU1JiXX40sRoUeeyJqRkDIyZ8g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzl6mqPUF5LulkhWoWU7R52BAcb3rcChQS8QQvdf6dPaLg2xJDn
	SmE78J3Nw4U6LGfscIQ5oWWeW3+iJ8ogLaqSnYi+b8cre93g8s7ydogX7YYQMjMWEIrsjktZG4Y
	H5M4fsPtWLVBg7rzaB9JO1XaOvH8Xr2k3DKJtHHYpjEMIu5mp+Iiovh9Db70VKAGSOBUaIkl+iQ
	Z1x7TkjSIdO3y2gjSMd6V7RDxgJ6SZ3ertC8Fb4PhKbg==
X-Gm-Gg: AR+sD12DLMTvqv1tLoAnZC8tgSpyLRhvMiMb6cz59wP8xNB4JqyIfSIwk7oFNhPfmyC
	5I/CZmzwl6/LJJxnGuem28x5nvN/s5xgW2W8h+zxO5W1Gn9HVrfEDyj6zW2KXNUFNZQa1IkP2WA
	Eb7GPsnItHj33UMenrakh69pLOB+bfrG/5C57BPFuMdzyw+onc3GeunSU=
X-Received: by 2002:a05:6122:378d:b0:5bd:8dd8:146e with SMTP id 71dfb90a1353d-5c33945f733mr139967e0c.4.1785171063577;
        Mon, 27 Jul 2026 09:51:03 -0700 (PDT)
X-Received: by 2002:a05:6122:378d:b0:5bd:8dd8:146e with SMTP id
 71dfb90a1353d-5c33945f733mr139954e0c.4.1785171063182; Mon, 27 Jul 2026
 09:51:03 -0700 (PDT)
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
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com> <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
In-Reply-To: <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 27 Jul 2026 18:50:51 +0200
X-Gm-Features: AUfX_mzrHlMmbdRyaVgwJI5GGq3lk8w5ugGyIwBmH7pAfT7A9G7FHaCbkjewpSM
Message-ID: <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: paulmck@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, 
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -wtCJdKzeCCComKXHOCFV3TTvSmwPPNhWmbDsTs9uRg_1785171064
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 6:16=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> Yes, non-preemptible RCU's __rcu_read_{,un}lock() are (almost) no-ops,
> but preemptible RCU must actually execute real code.  But I would not
> expect *this* much overhead.

I've now isolated the PREEMPT_RCU cost with a controlled experiment.
Built two kernels from the same 6.15-rc6 upstream source on the same
POWER10 machine, no CONFIG_PREEMPT_DYNAMIC in either case:

Config A: CONFIG_PREEMPT_VOLUNTARY=3Dy (no PREEMPT_RCU)
Config B: CONFIG_PREEMPT=3Dy           (PREEMPT_RCU=3Dy)

Results (stress-ng --kill 1 -t 23, SELinux enforcing):

Kernel                       PREEMPT_RCU   kill bogo-ops/sec
---------------------------  -----------   -----------------
6.15-rc6-voluntary-test      no            105,014
6.15-rc6-preempt-test        yes            73,317
Delta                                      -30.2%

PREEMPT_RCU alone accounts for ~30% on this workload. The kill()
path hits rcu_read_lock/unlock very heavily through the SELinux AVC
(avc_has_perm -> avc_lookup wraps every hash table lookup in an RCU
read-side critical section).

This also answers Shrikanth's question about whether the regression
is from the preemption mode change (voluntary -> lazy) or from
PREEMPT_RCU. Since no PREEMPT_DYNAMIC is involved in either build,
the preemption mode is not a factor. Additionally, switching between
full and lazy at runtime on 7.1 showed only ~1% difference (57,476
vs 56,892), further confirming the mode doesn't matter.

> OK, if you are executing an isync or an lwsync instruction in each call
> to __rcu_read_{,un}lock(), that would explain the overhead.

Yes, that's what perf shows. __rcu_read_lock and __rcu_read_unlock
together consume ~9% of total cycles on ppc64le with PREEMPT_RCU,
vs essentially 0% without.

> CONFIG_PREEMPT_DYNAMIC=3Dn for the win?

That's the simplest distro workaround for ppc64le. But since commit
7dadeaa6e851 ("sched: Further restrict the preemption modes")
removed PREEMPT_VOLUNTARY as an option for architectures with
ARCH_HAS_PREEMPT_LAZY (which includes powerpc), distros that want
voluntary preemption on ppc64le would need to disable PREEMPT_DYNAMIC
anyway.

Is there any path to reducing the barrier cost in
__rcu_read_lock/__rcu_read_unlock on weakly-ordered architectures?
Or is the current implementation fundamentally constrained by the
memory model?

Jirka


