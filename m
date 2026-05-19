Return-Path: <linuxppc-dev+bounces-21203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F14CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 05:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL0x36Lzfz2xy3;
	Wed, 20 May 2026 15:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779256183;
	cv=none; b=jlubafIzPw3qDoZWt/M9eBEFBEjbJF26NmLEv46zkiDkjNUkacCkFc2ZQ/j+8CT8K/wU526fhVQTn375KZNkQp4h1SrjADge0o7Kcr55yOKoig48v2rdWD28uEFQKr7tEXq4Pkg645THVaqqpSFb8tyOseqW58nxzKZ8ZjxEbxVhnXg8x557IXrTR1pBUmX/jZzqzNZ21GfZc9xPPiDzIkXWMkCB1Tu35SWbdZdz5UOrM/2N3C/yVIo4t7BA+b2ZtNpABBwl3Ydgz9Bt5a1JoXeU6m3cZUykQRnosYHnMbIasnTLgGZOfXB4n7qF2WcaaHpYv1JoP7zGprmQ5OcLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779256183; c=relaxed/relaxed;
	bh=MTqoHv+DicNYk5kIYTnplBIAwN/Kr2WwcNuJKFIQIwE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=o0N0KbhBTo2ceF0cjbu6veMO9hyFQcwTuzA0Dk0v5Q4Em4CDa9uTTwOJ42/FaLRlJ8ELXibApmxI/JI2hXqIMLz+uXWMsaY+o5BlrO6HMM2djlJmqlpyftbYckpWIsYVlccOuK8WH+pZErG1sjy5hJVExQnbs90Z8Zs8f9MpKQUz75H/iHuI04bY0L0iC4o6S1WKjYILI6uq1qylOfbkL+Czvy7HQtrVWFrdgMI7vTlwdygznxd781wFnbYOxsEg4cV9K04ZGBqWozkzNlE/YYxAmOCEcHnN5E1TFGPF58bVzXT1yyOz300XH2OB/JRvDZNBnuUnEvCaQIVz/1Uuiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eqe71YDq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eqe71YDq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL0x20Z2Rz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 15:49:40 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso121244b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779256178; x=1779860978; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MTqoHv+DicNYk5kIYTnplBIAwN/Kr2WwcNuJKFIQIwE=;
        b=eqe71YDqAFO8xt8JEQCnVO4eUZ8Tjqo/uPfkSOsc08MIeiDXplh6z316BCiKa3+pdY
         8Br1EbEgB9b1YsCeyxVfHxPNwSwGf1rHzdXB1snYNgMgsvGxoPimIys9Tk8JdsI9IVIm
         rDw5m/x1MQVja/R2X4QiJFCBaFhcIs6JzWFM3gRjkBr8YmUPZKjQj5TVUXhzxdOv5a0c
         kj6i/K56APfbaYE55uFzyMmcGr8D5GjhnFQ4y5B06ooeo4bv6eFmPOVB427p7XzKZeRd
         E8zhUUizaDQljPrHn0xCcVjrWJuhrU1D+caJxvAo+v4HAqH2bIKqZrFsBrof9QfRmdja
         6lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256178; x=1779860978;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTqoHv+DicNYk5kIYTnplBIAwN/Kr2WwcNuJKFIQIwE=;
        b=VuuKYsqQ3Vt6RtcRRqXBpYyluxDNZbBIR166eo2LEndtAE0uWcXxpkVLl85bF8BXtF
         Fzetd5XGNJ5a5KKv9+5SNBIaWnCCTHHiRGt08s3Qy/LKASPOxTwFnfI1RzJweEllLn0d
         c2FPiALuVrEwuuk7IBCuMSQPJYagL90gkQ1ob+UpZYHE9O+/cz2ySYflTuQVCTyZ3C+S
         pwCLf715T1Eh1raSJ3YflNT70vc8nrM1e6wx9UOgSXnLRkgn0G/sMR9RUeSjR/KkTvun
         mGiOEU2sACODNVnQCfAQyoW4GcAqqIwNdRG9GiNQzPm8Dg039QDNpQXjE00dHoywAFYt
         Jw3w==
X-Forwarded-Encrypted: i=1; AFNElJ/prWlaybnJ4wNEwcCzbGkCQtIagMUMFdQIo4pPZBZKZz+4UflKFgTj253sYZLN0N/o3HaTbuCCwZhSmyw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbLJjV17rUd+O5Y3IMlHn2PPLyXeYyuV4ZdmDfPosY4srjW3pN
	wdGZ6i/2ioEgYJ+wUT3zjd0A5vnuXuH6MwasrbTPsnnmj+/57iRDuvzz
X-Gm-Gg: Acq92OFuFtvhvsUshoIMu9MRjmC5pRqdGG4tK3V00YtZzD2a6md2mzjU3+DJTpNDMZ7
	7SlE63CR2pEb7X+UoWKxN1oviA/Ob7LM2RL8fNbaG4/S4cFc6RjdCRNDv6dXscRQkpGIBwsLpdj
	uTinbEHPvvqHS9irmmpS7NNyEoi/oT95yoTS1w4fR+v+WsRrwbqfxZAHH+GXwB3RAq5M78IrVfl
	3uULPJaBilKPABLQI/yQLPyrrPzURbw/og8aOkmsgKqWUxwxwoJdyrtvic5ZvN7R/D/ld8Y+8G7
	RInhoPsXrV5Gdrabt5ZyqmkIZhXabl3U91RQbEVwDEAn8uqI7jUF9wZyHonKvJNuFyvdO2XqNfC
	EIhYFbOuzUk+5rk45oLCTm/y4INvvLnUj4douE3+6H93pvtN7RU8R6W3JU+K3OEAYOnL+UlFdMf
	Q5glHqKgaCVH2CP41tRXYaUzUGRGcsrOiQ
X-Received: by 2002:a05:6a00:4193:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-83f33d9dc33mr23321111b3a.26.1779256177788;
        Tue, 19 May 2026 22:49:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660f9sm24881929b3a.10.2026.05.19.22.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:49:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
In-Reply-To: <85c9b59217bcecb3c7af52e9d5b175266771d7de.1778975974.git.sayalip@linux.ibm.com>
Date: Tue, 19 May 2026 08:19:13 +0530
Message-ID: <lddgqfkm.ritesh.list@gmail.com>
References: <cover.1778975974.git.sayalip@linux.ibm.com> <85c9b59217bcecb3c7af52e9d5b175266771d7de.1778975974.git.sayalip@linux.ibm.com>
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

Sayali Patil <sayalip@linux.ibm.com> writes:

> Add a new LKDTM trigger (PPC_RADIX_TLBIEL) that executes a process-scoped
> radix TLBIEL instruction to exercise the radix MMU behaviour and
> associated machine check exception (MCE) handling paths.
>
> This provides a way to validate MCE handling in radix mode. Currently,
> there is no dedicated LKDTM test that exercises this path or allows
> triggering radix-specific machine check behaviour for validation.
>
> The test is only enabled on ppc64 systems with radix MMU
> support and If radix is not active, the trigger is skipped and reported as
> XFAIL.
>

yes, ISA states that RIC=2 and IS=0 is an invalid form of tlbiel causing
machine check.

It's good to have this test case which can test MCE handling while in
radix mmu mode for an invalid TLBIE[L] encoding.

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


