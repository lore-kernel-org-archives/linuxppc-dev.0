Return-Path: <linuxppc-dev+bounces-21634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A50CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 15:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRB1X0HqXz2xM7;
	Fri, 29 May 2026 01:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779983791;
	cv=none; b=lQK9NjsMXA1UnGC4g4+s2FI4Gn7QyZQDKQBMlGkPigeDLdcMUCNqtdt6rJesoqxP3yB/Q+RiwXKwqXIhf2KLXTd7BGsendbqTymRl9IXSLyBdU6gMxN+q6uA5HnFq3CI/UGJbNMiiBX5xuLx9+Sz+J4CfNEIDzoo2FhQGafWxxaPEvbeEhlZ8UCJ0ePehvR88sl8ZP2GIrJojGy1Z5TCmu2PwkygKlmKkm1mO/qvM2ntwEZy7ZZA/idx8QXVo9APDincg/RFZM62EclFhrDXdj7pacz4U8unCe6yN5X3uUUjHS0fDsWdBbTkAYesbSDd2yGt2WJqwE3EQ+HXXJiMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779983791; c=relaxed/relaxed;
	bh=tZGnMBOtWKeFwwicE4ptN5y9cnUWMG4/NkvZPO2aUKs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=E3cBJEIskvomO6oXGAMfaFGM4gryqsVhwcrVITqa7eQo5f4BZYQC94i3Do/nra5Rkd02PbOIFrGpDqsefbxdjjkLL10Bq9tMwvXo5coH9gw0+/d9DVizq0OAnSICc5IiDteThTZaDieE9FIo5vtkZlH1yoRmdSzKwfnLwgxxObmKfnSRUV5yiTubxWoZcBnGA6p4tp7PNMzS4gGJ71rBvrNSNmyECbLFXCaW43tZySQUUQIff8LIaAPpGZMUG6ejzaoirdkStsginRia6Dz804u7qKhEshItKxADbGu1K3CYUywVSL7p0eyOkHDpaIUYCT33fc7HMQRPervPM4rwWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F4M7Ay28; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F4M7Ay28;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRB1V3RsQz2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 01:56:29 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so5912084b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779983787; x=1780588587; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZGnMBOtWKeFwwicE4ptN5y9cnUWMG4/NkvZPO2aUKs=;
        b=F4M7Ay28bUEbBgfy76A2KAXuc6bEz2kl2j99BZfttM8tkXVXJ8iUgcJlk/WQlHJpmP
         C+SadkJRWWQH4UdL8mEjvqpGh1Nh51qOgChsHzzoVfpPHUARcDnfX/urcPCa4EmvXWiz
         3LRRk0mT6Wn4oFVjs3QPVQmXitYY5Oh5tVjeQMMdg0i3O5E07kxh5kBIVTLdiRv+pa9n
         j4rhFmeAkCpoUjQTCgOayNKTkKJNAqllmWUOG/YHyV2DOFYV1x8RHuAxvX5kN7U2F617
         DX2i+2geJOxTicHoJ1rZd60uR8V6Vm9HsZa4ngy+kO/4L3UFAkpcsEcevj/xWlZomsBs
         1Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983787; x=1780588587;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZGnMBOtWKeFwwicE4ptN5y9cnUWMG4/NkvZPO2aUKs=;
        b=GqOPOysjXWrIpYt4UxN5JfmWfYu8VhIvoXKtw4zbC5WV1ZFVruXnX27fdnyGcyTGie
         OuixchIW44pVV9zvopW9yjkd4xqaSTvYBXDkTyzRNOKRk5DGNzJ2neTI8J193k329Rwk
         0ghf/xe5pfNmGoTXFfomUObS4xHED+hG+pjaR5ptD5bnYGHEx8f9dJWT2OwpFNoNjGPJ
         0sWfc/p7whEuHhU3WhP1/NG5olsLdmpe3ZCq52O3tVfF4CCVvwq4MZA14ZvVyFfjK07c
         xl0KT2ar9MNt9d0jN3Odgo7mDEK4eL0AYWzxO++XMCUAYuWRBROZUdJnStdO7M2DB/aT
         xI+w==
X-Forwarded-Encrypted: i=1; AFNElJ/8QTAyraRc8o7BlfNzJzgFCq3L4fQOreVA51a219ENnCfzyjuSEHxfEGaWAdT7QW4KBG1jR7pXQtAiEwU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLnIueLWXA/+oBTxqZ7tlaT1RMGzB91OYgSgNdrfIk06ryR3p9
	foKyN6bVvlTt5CeoOWB1p4vd+cH7UTxzcfH9RTgxmeb5GdAoBGVaw+9f
X-Gm-Gg: Acq92OESYUehCVIOZOlogSkhJrPOrF6DgKRoa5aG4OYD2nHm0EcDTxLUK3caafWj8vI
	yGvScwc/qeydrr+ZmUEP5VOao3UjPORw/vHFsTpLJnlEFID5pOAU+9mSO6c6JQxOZgC3dIRQRC7
	6ricIi9XjN6Nc0SIy8j6AzTWwy/latem3uI9ZHlkrZMwuaj+x5s3RftlNzf46tHszxXWCF1HHEQ
	QoHZvfGX/BhVcAAo6EGeLfmY22B8bmiEb36/gijbavDpz4nNHlVCxi1zRpSArud/HYhzcqgiRpx
	3HHGBC9zOJsgI7D4lxuiI7WGOfdb8HzF5Jk/qwm790NCBJhw0bCvbwZU1WilMjZWXFJAX8yogm8
	PZ75jQ2jtw7jaTfkOGCgZFgLRJbGqQRy9GZUbTpZkdhCSBMo9oXP7SCP8kxUyeaudgO23u1wuVb
	NZS8SM3qeDJmdatXtudFqUSaV25Aiatslo
X-Received: by 2002:a05:6a00:ab05:b0:82f:7762:3eb2 with SMTP id d2e1a72fcca58-841fe40a100mr1973612b3a.17.1779983787298;
        Thu, 28 May 2026 08:56:27 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb19asm5364984b3a.30.2026.05.28.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:56:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Srikar Dronamraju <srikar@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask dereference in build_sched_domains on POWER9
In-Reply-To: <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
Date: Thu, 28 May 2026 20:36:27 +0530
Message-ID: <mrxj7evg.ritesh.list@gmail.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com> <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
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

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>> 
>> I am seeing an early boot kernel panic due to NULL pointer dereference 
>> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
>> 
>
> Hi Venkat, Ritesh,
> Could you please try the below diff and see if it helps.
> This helps to fix boot problem for SPLPAR for me.
>
> Hi Chenyu,
> Let me know if I have to send the patch. Or
> if you want to add more comments or change it feel free to pick it up and send it.
> Either way is fine. Let me know.
>
> Hi Prateek, Srikar,
> I hope the below diff makes sense. Please check.
>
> nit: llc_mask is still under CONFIG_SCHED_MC, for ppc it is set to true
> always for SMP systems, and for others it is LLC domain. So not a concern i guess.
> ---
>
>  From 10e9413cef063446d67dc02c2b44e1ea582e5d53 Mon Sep 17 00:00:00 2001
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Thu, 28 May 2026 06:16:44 -0400
> Subject: [PATCH] topology: Provide arch_llc_mask for cache aware scheduling
>
> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
>
> Stacktrace points to llc_mask being null.
>
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
>
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn;t supported. In such cases llc_mask was being referrenced
> when it was null leading to panic.
>
> on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain.
>
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Suggested-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/topology.h |  3 +++
>   arch/powerpc/kernel/smp.c           | 10 ++++++++++
>   kernel/sched/topology.c             |  9 +++++++++
>   3 files changed, 22 insertions(+)
>

I had to apply this change manually - as it wasn't cleanly applicable
for me on linux-next. But since the changes were straight forward so it
wasn't a problem.

With this change I don't see the panic anymore, which I was observing
earlier.

Thanks for the quick fix. Feel free to add:
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


