Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55399606C95E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cezXZfR7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWNjz4kBbz2xly;
	Sat, 21 Nov 2026 05:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795198391;
	cv=none; b=Cb9XDa3/OlN8tv19HBEGRxKvhUuwxVYvEn0NPtx+ManC8I9mQef12cieOIFCzOw4A0RTRFIWSnMJNGpHJAVp4sl3/mvBU3moDKK9SvBS2PjPmJGuUpl9+ESJQe+9NA0nyYnNhdM2514+o53Gxk5C5VCKwWMUXWDdbrHRBl3Q0an7vBjpecdhRAT8Di1gnJT0UlJU1cg8bWoe9UvnBbQ6Jk1Ec2EeiYqBOKYjz4MVkLuekEfak2t+uRPtLg0pUUwi9mxw4RK4/9i9euQS7uk22+pEsCS5eqYjgX67S4PqZHg0fcqmqWMZGLTMld0Gkkpb+jnzcGYUeo3Gg7GGO5wI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795198391; c=relaxed/relaxed;
	bh=+PDt4EhAr0I6LcXqqsbR2+EI1b4ERLPM8lr0a4ICYS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJuzQc7ue+pXH++sIQLslJm+ST7a5QHUYYypkZS5+TxJj59jSOCfHnbgRTlNR4XJZ1PYuLEO8KeDkB1gUmZKsT4vYBQEnvKAKuAc7q2KOhGy2iBP07HSr+8iCat8ieBQtH3VHDWBdWXuTlFTzi49NFVG4SOXDna6FKsP/1pQq7Jqgjy5QvvWpDC6RUyMYGQroZORYISe5gJNzVUTkJ5nt1+n7RDp4X4clvV1MGVgZ5JUjPYurPU1hTc3yZGcG1JdBCYP3kwDJ1PMOoq1AMKPHctGu4CN99paiKeXwcWGfDlo+B/XaXLBURBfCOIXoNyboVGFCLO9579rDG0CQlxkKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cezXZfR7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cezXZfR7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXDsh00x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWNjy1PKPz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 05:13:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795198384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PDt4EhAr0I6LcXqqsbR2+EI1b4ERLPM8lr0a4ICYS0=;
	b=JXDsh00x4oh2ceyrINz6WJweV7TjCQaR5YTtuDI+U3Y+DxmiXfX8GIDN/vwJn1wKCIcuEz
	AIjoKIGi7vHvo1etP4KBI+YkatKgBZemPV7kGKcuhwuWv5sz+GueMA53+KhbSkci+5iFDk
	foZkk/NFHLRCj/rXcqX73A2qfskl63A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795198385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PDt4EhAr0I6LcXqqsbR2+EI1b4ERLPM8lr0a4ICYS0=;
	b=cezXZfR7o5rksxqMJOaZCxHzR2BMGaOFEsKELmZv2VvB+CBydFvCHRSL8V8BeXd+iXoKwn
	ZezLmh+JdhDvksdRMU58ecbIk4qpF+8n0TPw1eyeaKZpAaLRZxqAFwILgWrbjHgv1unR96
	ItILHX1bxLYA6tJ/G8Nf4TdVULw1kpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795198384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PDt4EhAr0I6LcXqqsbR2+EI1b4ERLPM8lr0a4ICYS0=;
	b=JXDsh00x4oh2ceyrINz6WJweV7TjCQaR5YTtuDI+U3Y+DxmiXfX8GIDN/vwJn1wKCIcuEz
	AIjoKIGi7vHvo1etP4KBI+YkatKgBZemPV7kGKcuhwuWv5sz+GueMA53+KhbSkci+5iFDk
	foZkk/NFHLRCj/rXcqX73A2qfskl63A=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-zd8-r0_HMo-IXlp1Vtsqdw-1; Fri, 20 Nov 2026 18:13:01 +0000
X-MC-Unique: zd8-r0_HMo-IXlp1Vtsqdw-1
X-Mimecast-MFC-AGG-ID: zd8-r0_HMo-IXlp1Vtsqdw_1795198381
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc36b97a77so288671137.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 10:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198381; x=1795803181;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+PDt4EhAr0I6LcXqqsbR2+EI1b4ERLPM8lr0a4ICYS0=;
        b=tBKwQERPimhd0xWG+rJijVykerkIsWHj8YMmmgRgrr2SjEaOkV78dSWdx01s8ecc7a
         OHk45qzoDaQcSSnwbgNv3oWUae6XbYn6Lcbv+gs70o94lD3p6kOjuW5Tddoyu5xMm1kE
         VWdLVvZC2QzpSuuYtAfGPjQQjqoJ+ubYE8F3PjXR5IrGodImQuCKt5W65vV/wHz5FXjr
         yMnDl3aoMt0EZXVmKp7ftKiAH3m0R1XBMQqdlQt4PjKueVvYVOw62aKAEdLTMA0lV4nT
         hTnjwo3rz8Vsi4TxDnULgh8l0DiqSNuT4dEmBN5YCJaOsasow4gh5C3/k3+XjJ6hjxlY
         9Zdw==
X-Forwarded-Encrypted: i=1; AL+hErFnSu+LRTNppyjIWQP1jyfw+U5snfoPy3MR1xdxKvi5ZlgvKdba9oX9z5MmS4P1xqjmRG8CAz9jgkAAxXE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/PgyMQYoojAcDznl/tFcaoiO1NrqW3dGGlVdGqNP95f2YvhUJp
	wKyOX/E0yDxO5gJUtgRFgcxmeimw22qZwNydY94x+XfkPc2dWd7QdhA4sswh5an4jy1AJ4ztvp8
	NwfyTW8UoOX3F2Jzf1O7J4E76lN+ixhvOwCKW5h5XXjbmlnOSYzJyJOHVcLVsvA3gt7T+jo0wfc
	CaU+wdm9XyssbalmfljkN4DjA/UnszzkYwWuJdoQo/ow==
X-Gm-Gg: AZFdTZcu86OokfzrgHXKQJU865BoK5y53Oe/KbKmk0OAoy6D9XP4iAEvk4S9p34cj3b
	wPh34tGSBUILk9Zp/HpBNL+kiVgVd5x1SGzSrEOy5rycsZ6uu6xRO3K1utBRaudSwGSYdNieEtT
	kooEk6GzfHeFyGtUp7q0ZlwU8lvTXX3VnNPSYh+a9QAGThOR2Qpjf2nNgB
X-Received: by 2002:a05:6102:5613:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7d7395e3287mr1594280137.25.1795198381115;
        Fri, 20 Nov 2026 10:13:01 -0800 (PST)
X-Received: by 2002:a05:6102:5613:b0:7cc:2cd0:e73c with SMTP id
 ada2fe7eead31-7d7395e3287mr1594270137.25.1795198380610; Fri, 20 Nov 2026
 10:13:00 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002164619.1455143-1-sshegde@linux.ibm.com> <3e9d9576-0af3-4922-b8bf-37f9127cdb01@linux.ibm.com>
In-Reply-To: <3e9d9576-0af3-4922-b8bf-37f9127cdb01@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 20 Nov 2026 19:12:49 +0100
X-Gm-Features: Aa3M54oS9zaowfMoEkZpf46FhinIzcrTuU3uxDY44dv7rI7s1IzCEF21KLsQg28
Message-ID: <CAE4VaGD3h2C4BHgM-v2tyP5mEbRtE8yn7fJ1u4GPen=t6GiTmw@mail.gmail.com>
Subject: Re: [RFC 0/3] powerpc64: Preempt count optimizations
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Samir M <samir@linux.ibm.com>, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	ritesh.list@gmail.com, peterz@infradead.org, boqun@kernel.org, 
	will@kernel.org, paulmck@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hbKly1QM1AQLwwsNJPBCSEWLUrikWNFXSfrOwg4zvSU_1795198381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shrikanth,

Thanks for the RFC and for the pointer. We ran it on our POWER10 box.

Short summary: functionally clean, but we could not reproduce the
performance gains, and the stress-ng kill regression from the
ppc64le dynamic-preemption discussion [1] does not improve.

## Setup

Same-tree A/B on ibm-p10-01-lp13 (IBM 9080-HEX, POWER10, pHyp LPAR, 1 core
SMT-8, 64 GiB, ppc64le):

- baseline: v7.4-rc3
- patched: v7.4-rc3 + this series (git am, applies cleanly)
- config: seeded from our ELN ppc64le config:
  CONFIG_PREEMPT_DYNAMIC=y,
  CONFIG_PREEMPT_RCU=y; dynamic preempt default resolves to "lazy" on boot
- SELinux enforcing, tuned virtual-guest, stress-ng 0.21.03
- interleaved rounds, full reboots between all measurements
  (n=27/kernel for stress-ng, n=20/config for hackbench)

## Functional: clean

Both kernels boot and run without any dmesg findings.  No
scheduling-while-atomic, preempt-count imbalance, lockdep, RCU or NMI
splats. The NMI-folding (HAS_SEPARATE_PREEMPT_RESCHED_BITS) and PACA
preempt-count paths work under load (stress-ng, hackbench, perf).

## stress-ng --kill 1 -t 23 (the RHEL-216657 worst case)

    baseline   58,722 bogo-ops/s
    patched    57,378 bogo-ops/s   (-2.3%, 95% CI [-5.0%, +0.4%], n.s.)

No recovery of the kill regression. (Noise floor on this LPAR is CV ~7-8%,
single-threaded on a shared frame. Effects below ~4% are not resolvable
here.)

## hackbench (20 groups, 1000 loops)

                        baseline   patched    delta
    process, socket      3.601s     3.653s    +1.4%  (p=0.09)
    thread,  socket       3.860s     3.895s    +0.9%  (p=0.014)
    process, pipe         1.619s     1.608s    -0.7%  (p=0.60)
    thread,  pipe          1.778s     1.771s    -0.4%  (p=0.40)

We could not reproduce the 2-3% gains from your cover letter; our socket
configs point the other way slightly.

## perf profile observation

Paired perf-record runs of the kill stressor show __rcu_read_lock +
__rcu_read_unlock at 5.5% of cycles on baseline vs 4.5% on the patched
kernel, so the RCU read-side component did get cheaper, but avc_lookup
(22-24%) dominates this path and total throughput does not move. That
matches our earlier root-cause analysis of the dynamic-preemption
regression [1]: on this path the cost is dominated by the weak-ordering
barriers rather than by the preempt_count address computation this series
optimizes.

## preempt=full follow-up

Since our config defaults to "Dynamic Preempt: lazy", we also reran the full
matrix with preempt=full on both kernels (same tree, same methodology,
n=15/kernel kill, n=10/config hackbench):

    stress-ng --kill:   baseline 53,995 vs patched 53,901 bogo-ops/s
                        (-0.2%, flat)

    hackbench:          all four configs within +/-0.8%, none significant
                        (process/thread x socket/pipe)

So under full preemption as well, the series shows neither the gains from
the cover letter nor any regression on our box. For completeness: the mode
itself matters more than the patch on this workload. Kill drops from
~58.7k (lazy) to ~54.0k (full) bogo-ops/s on both kernels alike.

Thanks again! I'm happy to share raw data or rerun with different parameters.

[1] https://lore.kernel.org/all/20250210184334.567383-1-sshegde@linux.ibm.com/

-- 
Jirka Hladky
Red Hat


