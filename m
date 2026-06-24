Return-Path: <linuxppc-dev+bounces-22950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7771CDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glPQX0sbpz2ySV;
	Wed, 24 Jun 2026 11:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782264356;
	cv=none; b=GzQB1n7Xjz9V+tEuL4vOyvE86Lu9otL846kzQhguxWQnZln4bnNHTaqTEiGk2XjRr5zTQnvywq2jDgF7sAKcDrDqmy8d3yoxazt8d0GqlfNHV+B5dGO0D21aOJdr5VASCioJV4TJ6fKgKErqblFnbPF3QrIWnSRnU14WQQJ3p+1APBdFLJBIINJcnuSE8EDKD5k168E5i+Mjji/Wi6zxNjxKs88VjVhhjcURuITYjZ8GQY13hJMkkeCCh04W3bE1RiB+UbUfGBO34IF4JtKPH7LahFc9tXCTe+DdDKrKVXOBXYas4tYOh34f66l5d62ZH3XmnGD135evvq4dtARQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782264356; c=relaxed/relaxed;
	bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oPS5FiY+GKEi8XXShesHsT6sSXQO92V97tKg2y7mbSBZhEwsIxnNqO6yahKOy3nxO7ofSS0Mxfg+LFJc/tG05dqd64Qkf87GCAYqeY+027stlSnJPefeJnpJAXb1ugstKGvdXDOdz6JE5gRZowfDJjaCpxb0wH6FYDWdF1B9xlIpkeNlxBqvbVGpCQzo8Wd3EDWRxT6vH21AAAX1296rbQAK85XmflL7H494GTtTzLn14gsGfQ2XkrO0UQtLg9boWDftWFSr0gDJ8ds613dcizqJJDSq3Eot88O/Lhp7Y4QOGg6nQnXTkfYaVjEt0hQHY3dQY51VqjnZn/1w0dNZDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NJLZ4Qr/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NJLZ4Qr/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glPQV3kmxz2xyl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 11:25:53 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c89636920a3so167866a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782264350; x=1782869150; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
        b=NJLZ4Qr/Zy/H95UT0WCMUXciowvxZ09LSeH0ON5/vILKDVehdZqGgN+2BQ2x/1D+KG
         VY/w//o4X/Pgh/wFHIf1ct69deQlhfWdf5WkodyvuhB3cWT7iixQ3gmV7ovGuURZKefp
         4FT1cVlWzUH4n7xISuMjeY9N5oSCdA2Rwsr+wb6tNGS1Y9lzHwao8BSEnyquik2uI3Ld
         q1K1RQMZzCb3QfwU5JoyVLWVpXB82ibW/vT3+ZATvp6CH8KXkrkQPmR74S6jAUJmZkPB
         h/mJ2P84SCdf8+l3MdT2knZil8uHqoLTQVDptp9odncyREF5ZXmFy3F3X9N+yNuQwOR7
         f1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782264350; x=1782869150;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
        b=BNO0JQ7xZoyupJvAJBMJc5Hm8EuCOWGSj7fQXtU5Xv29Lv9WECVSF/5GqEVUxXlXLG
         Iycieta/68IQreaRsHvIm+6CNMG6N1YJEstEUBy+jDQf07lFFZFCOHcghJw6RZs4iu5g
         7eTz3zbIYtEm+ypX/lMHyVZ3aqpQmIs63HdgIVLsQOvp/gqUTtgX/qgca555/NiQnUMJ
         5fDrwz3W4ruJfbl3fTvVkp8/MYr/be4GAff4Yhm2559nfS6UhV9GuzmSwIdUPzJCgBQf
         a+tDrVediyIxE6Jo47642MI4/yzEqUwPLLkGLYeb/bHvqWKxhKWSejgFroBa0iwsiqLD
         t0xQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSRpih/CUPSzgDWfhI3AGe7uyRM5svVZN8JjDUf1Th5y4MRIaGlC8bIO7j0YQV/N1S9Iw3OZ45AjLdqvM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyp/porTuDp2X6HnMzv+/dkEKGnnIxsAxsjx0NAIbjS0/7k1cUZ
	95M3R3wEM/YZtfcbA6X11lk1KO/jgCbrGNz71sRvuFSjTn99Uh74otha
X-Gm-Gg: AfdE7clQL2rL9qVAbtYtjtkcAPb8y69UTRQx6dN1DHAp/daV8VhkaCXvcZsOFTnAqhy
	t2Y8Y4tf2pQkeq1MIyV2Z4L08UuUVnntrCzoCg1SLMNbdA67S22gL/GDCC+jKescHTH7mUd/Woh
	46crexjD09C3BixK4+j2AjRftEzqgA7Vt92fXIc99+kijjGNRqQUh1U1czzY3HaXoWbiJZGXZuY
	d/gn+RZenZk53lBNaZADJX4S56EhLQS8QIxwA6jd06eFxRzOG/bASm5vfEk2I0mN3Eg8rvqTgKf
	iNfiOr8yup5KGfGEnMUxcKXdsxetwdspMipTx+FURu8YZfnUr0ivX4STgWnHuzCDdwgqfZcfptT
	KkZ3gdlGlE4jrV8EXjuKOe5r7pAG82VjUTsFHCiuFjdbu59BFQedI1TbNZVFeolhKk5oWrIeLjf
	7Em50MF6zcQfSd35c=
X-Received: by 2002:a17:902:d4c2:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2c7e15265aemr12562995ad.29.1782264350114;
        Tue, 23 Jun 2026 18:25:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af310sm121860795ad.2.2026.06.23.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 18:25:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <aimOVomL2RzYt2J4@google.com>
Date: Wed, 24 Jun 2026 06:48:02 +0530
Message-ID: <qzlwwxbp.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> Compile tested only at this point, but I now have a series of ~17 patches to yield:
> <..>
> It'll probably take me a few days/weeks, but I'll try get a series posted before
> the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> support landed in 7.3.
>

Hello Sean,

I have addressed the comments which we discussed in v3. Kindly let me
know if you want me to post v4 or otherwise I was thinking once you post
your base patches (to take natural alignment into account, which we
discussed here [1]), then I can rebase my changes on top of that series.

[1]: https://lore.kernel.org/linuxppc-dev/aimOVomL2RzYt2J4@google.com/

Thanks for your help on this!

-ritesh


