Return-Path: <linuxppc-dev+bounces-24940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B26C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:19:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8czY62Nxz2xyh;
	Wed, 29 Jul 2026 00:19:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785248377;
	cv=none; b=X667UFgKBL6XYXqT5vxoyYxWaFA509N4UGRV1vIBOqbni5/jtLZbhI1qfJfdc/sjbO0AI5WmFKdp3jyJcJHoygvFO0Ca00ApI9F/y5zI9Jw8RtC5+H0WhelYRJdJcW/UpDh6ui7bi1Wee2lj2fVBnDUcOFqTXjOFN3xQGzB1Pq3Nhu/LVX8Ns2sUvBtLBdAFMEW6UQ2fppAUMOTt0waZqq5UCV4LKM6p2YmsRzTXINPPpE9oCllS71Sf7JZ/hv/6bmvYFyYpwZ3DrsfTTE1cda4OBQct2yaTmt4lxh5wi80oJWgxfBAz5di7880VN47sTKWgvpbFGEZMgS3Oq0kQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785248377; c=relaxed/relaxed;
	bh=MjrCd9mxsmpQDAFHzywlWpsYvtJlkanNvbrh2jvv0CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJcyDTkcgHVKY7YZxO+EDlvAbpk6m0vPFzVcdO5xwwPKlVH2yvhqh1PeqgNvyxA7DQIR4xSbeTAoSF58rjAT9aCH/VLYcJjkznCEEH6Jw61Set4hiqFRagbjjZN3224cgjbok1mylAsVG+uURyKquutfX/WORuGvefsTTnyiCLDrbYJr2Ad7yq/FqN/w9PtyoHpYmmNXtis/JftYCWQdMCEba0OxJpraUnTDIduRFs86Ueb6LDbQal4QhyWXiiXug9GdG9+pWD2xIt8q11kQD9EaAhWMbmxJ3KVbIhaGqY3icTbNKDzCwDJP0Y126D5lmUdZOFdh9fjSA3hz3eAy4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NbswFewX; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GVNz30qM; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NbswFewX;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GVNz30qM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8czX2ddjz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:19:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785248364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjrCd9mxsmpQDAFHzywlWpsYvtJlkanNvbrh2jvv0CE=;
	b=NbswFewXObAWI/YfRhEsdRjSbeZXSeBBgRTMEHuNr9K/tDP16dwYFGzLZpJHaKxaQKpC17
	pmkpXGEi6+qV0I6BQbk7IWcNWyJycZiP0YkQrox5L9k7FvvaMJPX02fSGaeR/NphdXVHHR
	zCiqyMbnURVxH/iwFNmeWfHBGyGfV7Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785248365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjrCd9mxsmpQDAFHzywlWpsYvtJlkanNvbrh2jvv0CE=;
	b=GVNz30qMtq178yI6WRzR09HhFpveJRMw6JgULJMEtz3/+TiXYrVVMC4x0zcR2fPjVs1cgq
	y/mx/YjvkynuEfK3Xe9GmqXDTivOEabxpVUcYc30dOdiYuSGZaUBkCLkihzM273LxZkpB/
	pPmDvpp/pJ/ocbmkoDmgh8R4HBpWCMk=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4GwNpWYPNFSatdQZEAEHag-1; Tue, 28 Jul 2026 10:19:22 -0400
X-MC-Unique: 4GwNpWYPNFSatdQZEAEHag-1
X-Mimecast-MFC-AGG-ID: 4GwNpWYPNFSatdQZEAEHag_1785248362
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c106a0bcc7so290317e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248362; x=1785853162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjrCd9mxsmpQDAFHzywlWpsYvtJlkanNvbrh2jvv0CE=;
        b=ZMwzcpr1stWxNd/47mpEbaNhoHBj//UNhDGqlrxhwJijiwh1rZCaYLfDobra5yXy9a
         STZsoXcLqRh3V7kkPumyLcQvQRCqOVl/dI9sqimoydQWy/7ydEyqt0ziW7Udj0si4ljx
         RKESqep0lrTqEMimTNPiqurBOd0H+XWKWPi0Gj4OEMOZwSnGqO3RjRwt9UUXzKYQKNac
         1adPO0tBTuC8wbzsZTUZ5sHZiVL+q0PN+i9Bw+X8Vj22r/mdj8o6Bb3MgIFt8X16qh86
         wh2i6joL0dbouLRLlfWK+hg/W4JIJTSkvEshwe1cxTGkOZrfOiCwtoCbi6jhPPSuhzqF
         oPDw==
X-Forwarded-Encrypted: i=1; AHgh+RpJR0RzJjVo0shiX1hXeegv/xpscYQuQdSbfMGKJfFBdPbM6dlWolsCzIUmjhLM4M4fsOtoOslMTzXeHUw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxM24MpiIa7RN5zVpn8p++ucuwxUaK/WxHtIcQrbGFk1Dn/6KV2
	Ahvu/5d3VUMIyacl+QpJXB998IKNPeFuWVV5hFvERS6FsSJSwUuflBtlUaczrOuzkHkp5DaXe3B
	2kRJIiVJ7zLHqKP1WxX4ZTMtoXZVnSNQdw65bULSz8rmaYDhOob70fa8sdRs/8r7i80ZuInRm0w
	vn/T8TXRBL7sAsCwwYDoWr3ijSZWbNC2hriQ4UNXtj/A==
X-Gm-Gg: AR+sD13v3WY0Brn2XvGmVEm/37w9xYNMUX9xrHqyKtRmHcf/N6p4DfvkfnLaXLRNzT+
	MSJQCgraj0PJ9JTpas/sE/hMXg6DK7wFw+vLGAhbPCbszgKvZTgroUtPxjeu5IxyRVkfaCccMRq
	hI6wkio03M0t8jd8ow4JlIJ5lvAQ83Tx5YlFYYwMRDobrKsfq918PJlfNs
X-Received: by 2002:a05:6122:7cf:b0:5c2:c0ae:a2e8 with SMTP id 71dfb90a1353d-5c33f961aedmr1072622e0c.7.1785248361887;
        Tue, 28 Jul 2026 07:19:21 -0700 (PDT)
X-Received: by 2002:a05:6122:7cf:b0:5c2:c0ae:a2e8 with SMTP id
 71dfb90a1353d-5c33f961aedmr1072582e0c.7.1785248361424; Tue, 28 Jul 2026
 07:19:21 -0700 (PDT)
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
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com> <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
In-Reply-To: <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Tue, 28 Jul 2026 16:19:10 +0200
X-Gm-Features: AUfX_mwvtjL6RctHMnY2Ppa4nuV_z8rzYQR8xZpRKYYWyY-If_YFcfJfseZUKew
Message-ID: <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jdrf_PHxP4KYIdd8U29y3ao6T2Nnkgq_xW4OcPBIdG8_1785248362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:12=E2=80=AFAM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
> No. It doesn't confirm. I would recommend you do that case to find out
> the cost of PREEMPT_RCU alone.
>
> Config A: CONFIG_PREEMPT_VOLUNTARY=3Dy (CONFIG_PREEMPT_DYNAMIC=3Dn)
> Config B: CONFIG_PREEMPT_VOLUNTARY=3Dy (CONFIG_PREEMPT_DYNAMIC=3Dy)

Done. Built two kernels from 6.18 upstream source on the same POWER10
machine. Both are voluntary preemption, differing only in
PREEMPT_DYNAMIC (and thus PREEMPT_RCU):

Config A: PREEMPT_VOLUNTARY=3Dy, PREEMPT_DYNAMIC=3Dn (no PREEMPT_RCU)
Config B: PREEMPT_VOLUNTARY=3Dy, PREEMPT_DYNAMIC=3Dy (PREEMPT_RCU=3Dy)

Config B runtime mode confirmed as voluntary:
  cat /sys/kernel/debug/sched/preempt: "none (voluntary) full lazy"

Results (stress-ng --kill 1 -t 23, SELinux enforcing, mean of 3 runs):

Kernel                  PREEMPT_RCU   kill bogo-ops/sec   stddev
----------------------  -----------   -----------------   ------
6.18.0-vol-nodynamic    no            108,836             19
6.18.0-vol-dynamic      yes            68,197             1,146
Delta                                 -37.3%

PREEMPT_RCU alone costs 37.3% on ppc64le with zero preemption mode
change. Both kernels run voluntary preemption.

> That's true for all archs. Please check your preemption mode in your
> x86 experiment.

Checked. On x86_64 (AMD EPYC 7313):

Kernel               PREEMPT_RCU   Runtime mode        kill bogo-ops/sec
-------------------  -----------   ------------------  -----------------
6.12.0-211 (el10)    yes           none (voluntary)    37,436
7.2.0-rc4 (eln158)   yes           full (lazy)         36,392 (-2.8%)

Both x86 kernels already had PREEMPT_RCU=3Dy, so the x86 comparison
only shows the voluntary->lazy mode change cost (~3%), not the
PREEMPT_RCU enablement cost.

> 1. Is not true. PREEMPT_DYNAMIC doesn't force the preemption mode
> switch. You can still choose voluntary even with PREEMPT_DYNAMIC on
> 6.16 to 6.19 kernel.

You are correct, I apologize for the error. The forced switch to
lazy/full happened only in 7.0 with commit 7dadeaa6e851. On 6.16-6.19,
voluntary is still available with PREEMPT_DYNAMIC, as confirmed by
Config B above:

  $ cat /sys/kernel/debug/sched/preempt
  none (voluntary) full lazy

Jirka


