Return-Path: <linuxppc-dev+bounces-25180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B7C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 13:51:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBSC66tl1z2y1F;
	Fri, 31 Jul 2026 23:50:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785505858;
	cv=none; b=Gt3nVi3OobmOHXyX2Vbp48BA67T0L0S5sHaIf/oAlyszGJlCkXu+hKU5ZQKYWwXT5uoljEz8osk3wZCRfrJU5m0yG0n3xGdlJrjcj2tg5ZVhjc+/0R//5O0hZE6KjqaKogeHkWvvkafmKhwPBgOOjXXRgcp2agQTdYuBiQzx2gKpsEi4Ubzdl5DN2bID3QH7Z/nQxZ6wHruyPxlNgHv4oHetQuj9M7cQgzXR4qWCQhggcx5Z9ymqTsE/+nGOxmhUY582Hvbecm3IGKrHl/ZztqgRKXW3NSft44gBdONoFLH59gCecM3+gk9W6lELJu3PClOlobiP7GlFqcD54/HXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785505858; c=relaxed/relaxed;
	bh=T2VduldLwq7JGubTZ5tKT1na8dQuRHMlFSTLNTd6oZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QelRTopCaIsVV9CoH/045wnejN6N7ONx7ILrNKBplFAhMEC7ZUSRPrgvqQIXd1L6+6VgfOa70mg2RSqi/Ep7oezzDXz9tVjXj2IJeAZvgjqyZjS2Jw2ZQZcSDjBbAreZWQ6PZACvW64zFvSL80UlmxggeAI+x2Bt4FCHjVovHZ1U4MK9zSGqMYz33oHJfoIDZrMX91WYR+XfbttCNYxUjHDbHPZvQCkQHugh+lweDdqK988wYnymJHlqdyAkUc+gUQQ4WngQ76YW3eS0+tmmDoF578NeAqq1X6+C12wUt8TgjXTK3teFD55wJBExd16dyJ0lT8DEHe9fp+wIvWFM3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSBPhbtH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSBPhbtH; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSBPhbtH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eSBPhbtH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBSC54tx4z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 23:50:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785505852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2VduldLwq7JGubTZ5tKT1na8dQuRHMlFSTLNTd6oZk=;
	b=eSBPhbtHux73+FVYFECLNcN8weRRrGdN1iixVaSkkNl1YvecuAl3uYI5jH0CM2MHNqNrY4
	264NDblF8ATX47E0LZc+h5pAnmF/Y3BTyqcvOTek1xPizH00tw3EwD4FW2JwWUeGOJoVOc
	Agu0MZZUN+isnef6haGLIiYu6NGYdA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785505852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2VduldLwq7JGubTZ5tKT1na8dQuRHMlFSTLNTd6oZk=;
	b=eSBPhbtHux73+FVYFECLNcN8weRRrGdN1iixVaSkkNl1YvecuAl3uYI5jH0CM2MHNqNrY4
	264NDblF8ATX47E0LZc+h5pAnmF/Y3BTyqcvOTek1xPizH00tw3EwD4FW2JwWUeGOJoVOc
	Agu0MZZUN+isnef6haGLIiYu6NGYdA4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1h_Rxis1NZWs_Gu9_6L--Q-1; Fri, 31 Jul 2026 09:50:50 -0400
X-MC-Unique: 1h_Rxis1NZWs_Gu9_6L--Q-1
X-Mimecast-MFC-AGG-ID: 1h_Rxis1NZWs_Gu9_6L--Q_1785505849
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bfbdb5e610so686490e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 06:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505849; x=1786110649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2VduldLwq7JGubTZ5tKT1na8dQuRHMlFSTLNTd6oZk=;
        b=IdC9AcAMxTWrI8dSebkrumQyjZLXQJyFI0hKVXj6U88D9viAWPIbBJK+MWbxGlk0Cn
         NIP3oHwR72W501clGeT24R6ampzEgJR/RcJsI20oO7WS5SzI2lHgtmvCFrHzYQuWU17s
         NORDcYckY5KQGHXwVkKFEPQa2NN7eGJ6xK++8HxQV8jTkVLVVmRhdN4jJC57LWX2Y6lL
         TXEz2qran3SfuORmCEj0ivDi9RZTcdOozt/lFoGwkx1iyKTC5hxCXoLv1UiLtWt/xIys
         9l/lBnuZThp0xiblzDm0EDnJ3Cvi0g/89Cu4z9kQI/hLKGsVYeYwEIT/eMouABCT23po
         bc3g==
X-Forwarded-Encrypted: i=1; AHgh+RrDBemLLGCOY3PWuFjC3YfhKyJZl/SWEmopTjL3FPnkaoOPlNPvHMsenlyzV3XJPU9uBa/0fJFTEWhtiYw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeVT1e2YOlhit0r822wbEDmqTtvhaCtwBIiuFeSkXJWI7EUKOy
	R4gzCcFu5Jzu8bYWYwRsGweDrX1+cC+A7+1kqQxcK1JHv0+1WkhYljXAmETK/KLXyZm3gBf6AvX
	FgGjydc90QLCBljeb1UnOvfD7xwMONN9Uoir5BZvfT6CCVWRjttOLhtf9Wn1pwIBEfCNZVBZ4Ij
	JqRQLUlmep5He03enRi1RwMG0wxQ6A9IgBZYOMIbcFQg==
X-Gm-Gg: AR+sD13y5bVPKsu8dAwK7o5bLTI+WGtIhK7gR49ZVna99xnclEGoE50oBNY+Hik5d+k
	ug3CwR2IPOdxkBs3ih93XZ5SyIvE588Lz6PcDP1Un1j89w+DDqCv3M5Xfy6omS6OYxYYQIH5pQm
	73PNT9qa9SesmeKrx8HgWg0JXiMp4RMlEBqxXuNuOp0/u15kkc1KRe05rz
X-Received: by 2002:a05:6122:17a2:b0:5a5:3eea:4513 with SMTP id 71dfb90a1353d-5c37e5c208bmr556911e0c.12.1785505848890;
        Fri, 31 Jul 2026 06:50:48 -0700 (PDT)
X-Received: by 2002:a05:6122:17a2:b0:5a5:3eea:4513 with SMTP id
 71dfb90a1353d-5c37e5c208bmr556898e0c.12.1785505848356; Fri, 31 Jul 2026
 06:50:48 -0700 (PDT)
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
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com> <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com> <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com> <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com> <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop> <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com> <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com> <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
In-Reply-To: <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 31 Jul 2026 15:50:36 +0200
X-Gm-Features: AUfX_mxxMBYOybdFdlKo2jp3eGlM8C7LVHdqn42q1hO1_BEjpGTrFQCbGI7vsKo
Message-ID: <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, paulmck@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oA2bFcAGVwaOwuIO9meW7fDcIZPjs_3ZNqb_AA1sB7o_1785505849
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:03=E2=80=AFAM Shrikanth Hegde <sshegde@linux.ibm=
.com> wrote:
> Coming into numbers, I did notice later, arm64 numbers are almost 20x les=
s.
> But if we compare the time taken for each operations, it tells a
> different story.

Good catch. I investigated why the arm64 baseline is so much slower.
The 20x gap is due to cross-process signal delivery cost on the
128-core Ampere Altra Max, not preempt_count.

Self-kill (same process) vs cross-process kill on arm64:

  self-kill (kill to self):      1.16 us/op   (863k ops/sec)
  cross-process kill:           54.06 us/op   (18.5k ops/sec)

The stress-ng kill stressor sends signals between parent and child
processes, so it's dominated by the cross-process path (IPI, wakeup,
context switch). On the 128-core Ampere, this is expensive.

In contrast, the ppc64le test ran on 8 vCPUs sharing 1 physical core
(SMT-8 LPAR), where cross-thread signaling is much cheaper.

For reference, basic syscall latency (getppid) is only 1.6x different:

  ppc64le POWER10:  0.106 us/op
  aarch64 Ampere:   0.171 us/op

So the architectures are comparable for simple syscalls. The kill
stressor gap is about signal delivery topology, not CPU speed.

I also reran the arm64 tests with "taskset -c 0-7" to match the
ppc64le vCPU count. Results barely changed (kill uses only 2-3
threads), confirming this is not a core count issue but a cross-core
signaling cost:

With taskset -c 0-7 on arm64 (Ampere Altra Max, 6.18):

Kernel                  PREEMPT_RCU   kill ops/sec   us/op
----------------------  -----------   ------------   ------
6.18.0-vol-nodynamic    no            6,171          162.0
6.18.0-vol-dynamic      yes           5,477          182.6
Delta                                 -11.2%         +20.6 us/op

Updated per-operation comparison:

            PREEMPT_DYNAMIC
ppc64le         off              9.19 us/op
ppc64le         on              14.66 us/op
delta                           +5.47 us/op

aarch64         off            162.0  us/op
aarch64         on             182.6  us/op
delta                          +20.6  us/op

The absolute delta is larger on arm64 (+20.6 us vs +5.47 us), but
as a percentage of total cost, ppc64le is hit harder (-37% vs -11%)
because its baseline is dominated by the syscall/security path where
preempt_count operations concentrate, whereas arm64's baseline is
dominated by signal delivery overhead that masks the preempt_count
cost.

The bottom line: PREEMPT_DYNAMIC/preempt_count overhead is present
on both RISC architectures but its visibility depends heavily on the
workload profile and hardware topology.

> PS: I tried porting some of those changes in arm64 to powerpc to
> split preempt count into two. but i don;t see much improvement
> there.

Thanks for trying. Paul questioned whether barriers are actually
needed for preempt_count, or whether software interrupt disabling
would suffice (his words: "I can see why the preempt_count()
operations need to be interrupt-safe, but I don't see why you would
need barriers"). Any thoughts on whether that's feasible for
powerpc?

Jirka


