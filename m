Return-Path: <linuxppc-dev+bounces-25123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB2EC55164
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 15:08:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sz75jx8z2yCK;
	Fri, 31 Jul 2026 01:08:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785424115;
	cv=none; b=iJs6AgxmrHK/Ux2qqDnflg7ivmRJIwo7tvKl3/L+mvfLk3eV3b172c4NrrzO3n+UepKMB/4jBjgJBsK7xmGR6j8l042zX8LEL7M8sdviTddbzPRT9FYlX9bGuWiVd3HirPWaLrjmAnbh1yZFOL4bInQkdONZeUpAzwsWXX2d6zAJUgd/6E0gIhw23+JXYzwacri06EkvWvoqwA5tZ4nwK0p5BpMvSACoKM3hBB55TOQZUaAYfUZBepWPmnXTnfE4HV2iwfT4uZ6Cp+tcNHA3IammF7/HEAvLiTL4KkfUranpLEq0OwBjDdRK3hmccjz60uVZOW7UXZXiuWnMhtVHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785424115; c=relaxed/relaxed;
	bh=7ih9ctRJT2ry3Bf+jpWUJLBgYpIZVim4bnZlMJT/wak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwBDYw1gRF2GO7AXrkTPFIGaBYipMt2H2e0f/5Cq5hsKnQsMOU0nClYN/tsF0aQC+JEYcLeggzl0Y6XVz9+57qnNbIC9KRS0Ul7t+UgGjXh+kHsvAagewWQVpaOUOWjzW6cEkrr905RNy1tWZK6D06glP0CtGEmCMMA/CIEF2KsTgrsoTkdeEHbVRwtCw5Ot15ET52D6kzJrivQhZwONXwJgOmQl+AoLOxE12xq/TfNKU8VPonr/6FzDiANHxUf1pKIrLnSwqmF/jTxqOTeUTzfzneOatIJogwLtmU42eQkWHYrUnfxtos16GUi5F6bVirviAz9zFlHdjA1Wb2H82Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGI8zzXS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGI8zzXS; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGI8zzXS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGI8zzXS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sz61JjWz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 01:08:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785424109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ih9ctRJT2ry3Bf+jpWUJLBgYpIZVim4bnZlMJT/wak=;
	b=RGI8zzXSlIV+y/boCaY7b9jEMJxD7THxmjyR4iXTrHVrsq8YH3aLOfAZmyRMIdSwS9GxqQ
	xKEw4Z0rcaWhBGAs1FynkUlGKbO2eDH4zQecNfIKqymxQTJb1lGK+mtqPHizxEOjr2vpSA
	Q6tX/Rs/1ZvXAMX2uS/Ju+InMhHAIMw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785424109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ih9ctRJT2ry3Bf+jpWUJLBgYpIZVim4bnZlMJT/wak=;
	b=RGI8zzXSlIV+y/boCaY7b9jEMJxD7THxmjyR4iXTrHVrsq8YH3aLOfAZmyRMIdSwS9GxqQ
	xKEw4Z0rcaWhBGAs1FynkUlGKbO2eDH4zQecNfIKqymxQTJb1lGK+mtqPHizxEOjr2vpSA
	Q6tX/Rs/1ZvXAMX2uS/Ju+InMhHAIMw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-pOXy55ugPAKHTDpDMGuodg-1; Thu, 30 Jul 2026 11:08:25 -0400
X-MC-Unique: pOXy55ugPAKHTDpDMGuodg-1
X-Mimecast-MFC-AGG-ID: pOXy55ugPAKHTDpDMGuodg_1785424105
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-977d6c69e06so222098241.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 08:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424105; x=1786028905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ih9ctRJT2ry3Bf+jpWUJLBgYpIZVim4bnZlMJT/wak=;
        b=Ou8GCxheKw/3y4+gfJLa4rE4KCzbuEMuTEw23xzO4RpZZIUYzgepNJ0dQNKgKGJFNV
         1UTdbGYPgVjFiCPykNDssNJU6g8fdS8ujKOnNTAxtzDHmiF4uzvExFeYwebYa0SeOPQ9
         czkKfoDL3EKiC4Dehjes76/4faZRX7AUsEt0Mo59afTBfIgZyq+8V8JRpvYYiGhAujd5
         DLG2VnDgztiDh/dIq4UD70axWpLvi7LS9NfCmb34W6aBcc/oXZz5eHF44ieAB2UlXzKx
         sVGOgwHMed+kxNFYuv2mNa17aTNaiLEt8R230hGAeuKDHMJAe/8HC8lPnlTOsnD9CAWC
         O+Fw==
X-Forwarded-Encrypted: i=1; AHgh+RoOvr+VdCM7REXdhbgiRxMAcFfKtg7usoLgQk1LSIStS8l2qLWnnAI4xM8vupzicJnUkC3cm5tzu7cUS54=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxel4U4OBNCtqw/+1vkmWs5avr7a5/xUh11FWsOXtpzRuwCoX45
	MhDhiFidqgdFMRdnnR48sGGaR7a+IK2utrWUi3Ux0Q99HXKOI+QxuH92DJfq88b/lnpa1qfuCEj
	nxJAoo05vYu6NnsPGFZSbw1Y1irRLDZKkEdKzwqvVmGSZriEqNLQOpxwTT4c+c0EY5y/YxDrfaY
	zpY9o52S4IJHt28XOOxzfejCbOhWAK143wzg+idtcDww==
X-Gm-Gg: AR+sD12n8f/9vIRZVkOGy0/5AD+spa7je4YZsHelbooHHzdyk702LPWkEy9YX9rDjGj
	A3CYxMr6cNeXQ6KpSIhBvCdGf6bQIHavcz/hzU9REw4PJlfY5G6ZJLt7EBtlN/kOjxI1u18gcOs
	1ZKuamcc1AM0Ufv/bpFqHn7jvyOWJGjkhCG37x6TuCSLYljpfHmRmCtrkE
X-Received: by 2002:a05:6123:86:b0:5bd:ecad:8f80 with SMTP id 71dfb90a1353d-5c365ff478dmr1007915e0c.2.1785424105310;
        Thu, 30 Jul 2026 08:08:25 -0700 (PDT)
X-Received: by 2002:a05:6123:86:b0:5bd:ecad:8f80 with SMTP id
 71dfb90a1353d-5c365ff478dmr1007900e0c.2.1785424104830; Thu, 30 Jul 2026
 08:08:24 -0700 (PDT)
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
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
In-Reply-To: <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
From: Jirka Hladky <jhladky@redhat.com>
Date: Thu, 30 Jul 2026 17:08:13 +0200
X-Gm-Features: AUfX_mwVdF9WyWNQB_mTOlZHKPkYtuRJ3Nl52lkm0NMPqxAVYxOGrFUM8CBRP_c
Message-ID: <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: paulmck@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, 
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yAzN6ESCjyQhhjrYx2nw-fknMjwpWsQZ70e-OSWpjm0_1785424105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:53=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> But is this really a fundamental RISC cost?  For example, does arm64
> see the same performance issues?

We tested arm64 (Ampere Altra Max) with the same controlled
experiment -- two 6.18 kernels, both voluntary, differing only in
PREEMPT_DYNAMIC:

Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
-------  ---------------   -----------------   -----
ppc64le  off               108,836
ppc64le  on                 68,197             -37.3%
aarch64  off                 5,538
aarch64  on                  5,082              -8.2%

arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
much less severely.

> In particular, I can see why the preempt_count() operations need to be
> interrupt-safe, but I don't see why you would need barriers.  And
> doesn't powerpc still use software interrupt disabling?  If so, why
> not use that to simply software-disable interrupts around the
> preempt_count() operations?
>
> What am I missing here?

That's a good question -- I don't know enough about the powerpc
preempt_count implementation to answer this. Shrikanth, could you
comment on whether removing the barriers or using software interrupt
disabling around preempt_count is feasible?

Thank you
Jirka


