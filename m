Return-Path: <linuxppc-dev+bounces-26453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA1C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:05:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZrHV3rNXz2xlv;
	Thu, 03 Sep 2026 04:05:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788372326;
	cv=none; b=Hil0QAw7iPIlNrR8fN0KEhRta68g5RpbPs+IAXPwShzwkC9FvXHVsZ3o7AbFVjBae/PF8OLM6G7KFZYe2/dJiqGKOxPoCL9OeZ4YjgWXrtCl1lr98P5+L8jYLMqN/M4ExCaqvH/eIzSo0CmNSCylZs3LlBEUEMUNqb/jh6STpO7WMLrfKXHCG6VfO+XVBVufhwdQX3DhZ+zQzotXTEvYudfmiLxepakeJ16lWcVBXG8mh9YGaErkKWvjarSMWun3O8Exjk9QhNL4t2fgKNlgvcSfFsr3NjTx3WVEMa5/BPLtgpOuhfsjAUdvBGfh0HagmU3B/xrEMObXHK3U2S6CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788372326; c=relaxed/relaxed;
	bh=mIy9w1/7l+YPH2gFOr27PV6p4ska6UcSUlBoAUwTOLk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=iyzz/i5TM6DF43PlGkxkU0ULdpqT+cEzOBrhY929D8jhS2VSwhnJUlQEv2AAMLZlUvpWZcx3wBjZmtmC/5V8K3YTcgqKeS5VduHnIqaljtPGd+NK0WBdClD3KRs4u/XAZvHt4FwYzxcUgRF2CpEmj3RwW/1pNKSmw3NljYl+sm/zxoKGsKcrJZF3Ky+hKzQgBV4Zo9hBQ6AxKCpOYn61fDsh5ESytHStobjv1o46pppYdktcdu1XG+7T5USmg3s0tmullpegdbwWsQwQUgiOto1MX0apuXMgoIGP8WNl6Tah1aalY8LuBugq59e/tZyz625BvEyXuBJ/Bowbq+dDDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNr6Ol6D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNr6Ol6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZrHS5CdPz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 04:05:23 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1276946a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788372321; x=1788977121; darn=lists.ozlabs.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIy9w1/7l+YPH2gFOr27PV6p4ska6UcSUlBoAUwTOLk=;
        b=pNr6Ol6D65iId0WbYrtp7DsGgIPuYBfqUYQlnZxu0ZXUatVaHRnroLbhKRrJiJ489G
         BH61bAB3WWvmvHAawVzDNs0Jfc9tDs8eHuOpsIdcrrLrBE95w9l26MA+9K4sdj7HGKcP
         XbIUKhQJo93Otc9V6pc0Glg3W+L5Qlf17fVyYk1fCksKMyW/yAHfxLNS6zJ9Sv5aLEvu
         5SnPi37C1AcOWWjUjVbyUudQbAx55ZT4hUZCM7wIE6q7my1ZY4QvhOVYRV8rIV6OzrOl
         zoniYdt2R1jqogcs0/IJssm15GcqLX55mQkFzadGyt1ciiLA/WJdYKsslw7qYufE6B82
         JlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372321; x=1788977121;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mIy9w1/7l+YPH2gFOr27PV6p4ska6UcSUlBoAUwTOLk=;
        b=QRU08flnH0CoFiJ4K/iGKaakZsdFOf4cLJPDNVqrGZvdH5n274u4ilk0tHnKVEWg3g
         CiZN/fs3x9nzWKeRVieZ8f10kFRig2ziNzvA+JkHeV/XEyKix5Z8wvB6kK83b+fA8Opu
         1p0882fqmdeu+mfcoMgt7ouMm1ojyMNv0TI5kPddFP5fpAv8gTaJ9OPQTiXiBKHn+Vnk
         gu+SjHhp4jS87B4iid4sJ2Rgk0rBDJKzrCFZ4+lWvUE5mg1ohJdR4/ThSEo5Q8hJzJsJ
         p4ReEgrV1RnwB5BFQDMQ6MyGvazxCznaIQaXhvjT6Gcv20gYNXcJ7LT62Czycyrc0zwG
         a2Ng==
X-Forwarded-Encrypted: i=1; AKwUvBx1PLs3e7HYAaCgpJowHaACFDWP9pLwE8Qb+NDWka6gonk6iKhIRZetAEoO5hEo6U9iKqob1uK0F2lyowo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++me7DjPtPHRDZc1Aguyiwlle5MPe6hAmQIAoC/TeRkQCN0xi4X/
	kky3DAx3FwPedH0ZF6flunOJz6kQKsigGWAuVWVDDvKWIls1g8h6UPOrW6WIMA==
X-Gm-Gg: AYBFou0JukP1ZEhnXYg4jpwmJvKaJmm59Pnycfgmv5M5Ord41qDFITgd79pGH010sC1
	/XwSs673k/0otRIlMyVwaK2ObV937d71o/dgp9mTZlGTQQms8+AKPDYGM4ivWCW45xaICK2mKbM
	d9i0LZPITssci3piflfLhRhYqJugajk6ScvucDxIeH65nq0MhXu29zfhRde/odazM4CHXk5e5fH
	aihX9X9nTV2SFQIiHgRRGUf8ywd8CV/0+gfnPzEecDtSE9ogOLB6UvsWp8BZ7OoynGzIS/CQNje
	YU4OHn+G7TynQSANAKtVQBLJW4aprasiD135X1em7tYt5/xVT44yRPM4KLzt1Pm/XZ5kx1pQXdd
	iKyl890+B+zIVFewGIjKFcqcVOH3Q7RavdEbihtQAVqMgOqo48/RXSWmCLwmN22iQD929HdlN7E
	2rIjP4IxoqaS5pKJazpyFZVjt0+ivXP1lvvGmY7NWVbyfWqeJSadp2ysKb/sl3NPFt+foDefI0A
	gas4PY/kjTg75EnOxx9j1vw4xbrHN/fbL7h88Ltplgq
X-Received: by 2002:a17:90b:4b89:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39aee105a46mr9138561a91.18.1788372321290;
        Wed, 02 Sep 2026 11:05:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm9808273eec.18.2026.09.02.11.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:05:20 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/20] KVM: selftests: PPC pre-enabling
In-Reply-To: <aphioo_KTboUCtZd@google.com>
Date: Wed, 02 Sep 2026 23:29:06 +0530
Message-ID: <h5k7ttzp.ritesh.list@gmail.com>
References: <20260826230511.972824-1-seanjc@google.com> <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local> <aphioo_KTboUCtZd@google.com>
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
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 02, 2026, Gautam Menghani wrote:
>> 
>> + linuxppc-dev
>
> Ah, shoot, I *just* posted v2.  I'll add linuxppc-dev to that cover letter.
>
> https://lore.kernel.org/all/20260902164123.2546762-1-seanjc@google.com

Thanks Sean for sharing these changes.

Thought of sharing an interim update:
I have rebased PPC KVM selftests support on top of this series and the
initial tests ran fine. I am currently looking info few findings though
- but will soon rebase those changes on top of your v2, review that &
update the results.


-ritesh


