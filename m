Return-Path: <linuxppc-dev+bounces-24914-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766E4C531C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 00:27:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8GWH5f9Tz2yH4;
	Tue, 28 Jul 2026 10:27:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785198443;
	cv=none; b=DE4psRcu5EHx+XTDYvpzcqxGnxUnYK71F4rUbMnp02o+cYQGLPveBOelylQ7e3+8LQn7EBRNvq++Vp0uABqS+DZgx91vxBIYtNUzPh2m+31Y55MGez00gm4/RL3xymtMw+UVyQk104FE78VSiqWl0+rP7CVyHxoCgpb3ORhhkQ6pSGtpx80rgyPkjQxjfNGPS89dhE7wYstQPzgWNtA6R1GOpNEXNP33RT6+jxbiuFpW1ydqC4BMNaVxZQrPQhAzmbg3Cz4CfSEpJlCKhQFJ4DZzWfPlESu41bi+ORcm5Ut7aw+GrzzprRQDCWNoLEzcoGv9bWp33+Q0L6ykhPL9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785198443; c=relaxed/relaxed;
	bh=uJ8kBL8LwTWopdiIyv4X6HvkdPaMx+qU1rj6SnBlS0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHe5nmCLw1tUy78GeL9FvdpZJ4AigrKjvd/IiOLmehudbZOUwI6pYIbWSi6dAswCRh0ylSBdihJwddxwHEi+4ijN/WE8AAqvZ+VTchxSCYTpIOCvyeKaIzs68Y1+wr80dhYNv1YZC6ssZIq6tZBS8ePoK/IsBA7xmS5eAEcRtWyoARive5Gnu6Epl4q+U44smogt3idkLAZ+AYjVsYJEogdgB5kQUx9RRid3z1o89U9mQ9SPyf8cZAT7ZWejJ6zEntbG4WgGFdI35rCF2tDfHkuy4jcuZmYynd7isuymGjkxv9m0/sE1OKBpeAqEgO6KGN1ghdm3LsZtdfJIIxed6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov4ksCUS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov4ksCUS; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov4ksCUS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov4ksCUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8GWG0mTWz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 10:27:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785198436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJ8kBL8LwTWopdiIyv4X6HvkdPaMx+qU1rj6SnBlS0c=;
	b=Ov4ksCUSXf3spEybzAKhSx+CdD4s4gjcgAeHcpTFAHBtY5y/bMgmr8IuvWIc3VCVTp43cP
	4rbVRKndWfmC6XMT4fp3k0f1eset/fIF+/PgWz9Jkj2wXQwAAu7IiM3UkGO42vmxtIJ3mN
	gqCn+2GefErigkSeY/tdZ4fhKGo7Qok=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785198436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJ8kBL8LwTWopdiIyv4X6HvkdPaMx+qU1rj6SnBlS0c=;
	b=Ov4ksCUSXf3spEybzAKhSx+CdD4s4gjcgAeHcpTFAHBtY5y/bMgmr8IuvWIc3VCVTp43cP
	4rbVRKndWfmC6XMT4fp3k0f1eset/fIF+/PgWz9Jkj2wXQwAAu7IiM3UkGO42vmxtIJ3mN
	gqCn+2GefErigkSeY/tdZ4fhKGo7Qok=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-ENNeYDcHOD6kwGOmi4U0Lg-1; Mon, 27 Jul 2026 20:27:14 -0400
X-MC-Unique: ENNeYDcHOD6kwGOmi4U0Lg-1
X-Mimecast-MFC-AGG-ID: ENNeYDcHOD6kwGOmi4U0Lg_1785198433
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c134f0501aso658020e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 17:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198433; x=1785803233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJ8kBL8LwTWopdiIyv4X6HvkdPaMx+qU1rj6SnBlS0c=;
        b=WDXuDa3b32oXepx+5sVDdGssWsfBWJfsWRAMSAIDaYVfgiYfDI+O+mPaLHsxQIQGim
         QXMAp3Z6htok2bbkHm+hhfBBg7y052cxfcMxcZbFBA6ZjiUjVokY/HJOcsszicMSWBil
         X7djGqbrZArqPsR6+KA5m0K6pWrXoPP3dtKXpjmhIqEj8OtZntfO5Y+kPL1lbab8lkJN
         pBKgmmOBkqnKp0yIXVEba8WD0wgiFJ+LIK+wWUUClEcEmVVgZOYjkApCZ5M5JLe+Sxgx
         4cnVzfSuAozedCe89rT/lsisCOYlk3mjuPlq3Gdv4HF+Q/33+rUHCL4O9Crf6fRhKKtO
         nXIw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1FIJDHTWU8s4lvopyLEJLbC0qfISlRQh8i2INiz8/ueOxwoM1QpXpesOC29HWSB746DrgojnS/otN8Po=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDwNaj3XvPrCYXrsbpZlKHBsQn5Hvs29tWFxdSA4RzWilxJMdn
	qzR83kYaSokimRkpcUzVXFtXimNmRsb2VAQoMLk6n494Du0gF2DtiaH6ws62PA5B+m7gfJ3ELks
	bqNZN6i9R3Su+gaYxpCdHQo7fQV+iCwYT6khOTL0DjABwLf6TqNUeWuAPeWYBYPsL3uMQvAjSR7
	mXMFGAJpEYYpG2pFS06G24+nTgngzSsi9rJtVxGgDxng==
X-Gm-Gg: AR+sD12Js84PoGaTCtMcw30Q1OncPFoCY6nuu5oIUXy0z3bYYbDjUx0AGkYNn8fxbD5
	97xhzN7wyrdRI3fahJwLzWfkQvgzmRB0WeCSA8f4KuDyTyB6trYoi6eA7xTySy9jH8HF3LSlk9o
	B3tseEW+rNZKB/pVi1PldOp/OE+qiR8Onq+7bPUoahR1tSD4wjVs9rA8w=
X-Received: by 2002:a05:6122:1d8e:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c33f8e4ea1mr73719e0c.3.1785198433396;
        Mon, 27 Jul 2026 17:27:13 -0700 (PDT)
X-Received: by 2002:a05:6122:1d8e:b0:5bc:42be:f758 with SMTP id
 71dfb90a1353d-5c33f8e4ea1mr73708e0c.3.1785198432928; Mon, 27 Jul 2026
 17:27:12 -0700 (PDT)
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
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com> <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
In-Reply-To: <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Tue, 28 Jul 2026 02:26:59 +0200
X-Gm-Features: AUfX_my7EMghwOH2TDCNRrjZPXc4tokx8RNXX3f5gcbdZTrJGAK_80lv1ekHmhI
Message-ID: <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GNqnUh4PpfJxghVNZJkmL-dar1GL7s5YOpl3HRKA6FQ_1785198433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:10=E2=80=AFPM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
> That's full preemption mode.
>
> When preemption mode changes preempt_enable/disable which were just a
> barrier earlier now become real preemption points. If the code path
> repeatedly does the exact same thing, it might pop up.
> But, can we say is that number expected? it is difficult to put a
> number to it.

You were right -- my previous test conflated two variables. I've now
built a third kernel to separate them. All three are from the same
6.15-rc6 source, same machine (POWER10 lp11), no PREEMPT_DYNAMIC:

Config                                    Mode        PREEMPT_RCU
kill bogo-ops/sec
------------------------------------   ----------  -----------
-----------------
PREEMPT_VOLUNTARY=3Dy   voluntary   no            105,014
PREEMPT_LAZY=3Dy                lazy           no              86,878
PREEMPT=3Dy                           full             yes             73,3=
17

voluntary -> lazy                                  -17.3%
lazy -> full+PREEMPT_RCU               -15.6%
voluntary -> full+PREEMPT_RCU       -30.2%

The regression splits roughly 55/45 between the preemption mode
change and PREEMPT_RCU:

1) voluntary -> lazy (-17.3%): preempt_disable/enable becoming real
   preemption points, as you predicted. On ppc64le this is expensive
   because the kill() syscall path is very tight and hits these
   points heavily.

2) lazy -> full+PREEMPT_RCU (-15.6%): __rcu_read_lock/__rcu_read_unlock
   requiring lwsync/isync barriers on ppc64le.

> What I was asking is below. (You can do this only with below 7.0)
>
> Config A: CONFIG_PREEMPT_VOLUNTARY=3Dy (CONFIG_PREEMPT_DYNAMIC=3Dn)
> Config B: CONFIG_PREEMPT_VOLUNTARY=3Dy (CONFIG_PREEMPT_DYNAMIC=3Dy)

I couldn't do this exact test because 6.15-rc6 doesn't have
HAVE_PREEMPT_DYNAMIC_KEY for powerpc (that's your 6.16 patch), so
CONFIG_PREEMPT_DYNAMIC=3Dy would be silently ignored. I would need a
6.16-6.19 kernel for this, which is before 7dadeaa6e851 removed
voluntary as an option.

But the PREEMPT_LAZY test above achieves the same goal: it isolates
the preemption mode cost without PREEMPT_RCU.

> Are you saying you see regression with voluntary with
> CONFIG_PREEMPT_DYNAMIC=3Dy?

Yes. On the ELN kernels with CONFIG_PREEMPT_DYNAMIC=3Dy, the regression
appears at 6.16 when HAVE_PREEMPT_DYNAMIC_KEY is added, because:
1) PREEMPT_DYNAMIC forces the runtime mode to lazy/full (voluntary
   is no longer available on architectures with ARCH_HAS_PREEMPT_LAZY)
2) PREEMPT_DYNAMIC pulls in PREEMPT_RCU

Both contribute to the ~30% total regression.

Jirka


