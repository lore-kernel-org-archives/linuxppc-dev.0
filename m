Return-Path: <linuxppc-dev+bounces-19419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450CCFB5190
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 04:07:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqXjM6qQ0z2ygf;
	Tue, 07 Apr 2026 14:07:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775534871;
	cv=none; b=XPlCWMYWgfdT/Nl73CJJ3ZHP2G8pWHExnBP78F2AtEGDSFEizFG+f1U8Zwawt6824hjuZBDCS8oR/qjGzprq8rVKAN5DibvfPOFOPaVA56r0E7sB9gbXVENWKxLinf/SkfcvJJYjsoeNNYyz+lhjx/X1Z85jHfW6hWPtk9iyJa77mGTrJ+GcJVy22EqMJrEn0DyOFUhh3MNCn4P7Z0ZXSNek7o5tvZEVKAYjp7Ud2U7f5PBoB1jd2CdvzYD9HcA2y6FJLZ9PPm4QUF0kMe8/w16L95wK+ScWDsCiaZEcbpoapFFzRVtiyIfaxe47hGgVvyU1h1LJ43y15Lhc3BbECg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775534871; c=relaxed/relaxed;
	bh=z/d26nUNEIld6JzIfDKNBmEnkO9f2aJaTVV3ZWZuPlo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ERGiXPoVD9pC/lyYWwsAwT11WiNZBnPBrp1/Vfx1UofGcxcxMbLGboSQHg7ktVNyxeIoQOdZNEYJ9O+i1g28KbEa2yhAZMC/w1Oi4xjPHk8KEQl/kxP7trkbiboxmiPt47afbMtz0Vl3tJAF8QEk6i1NEeWgtIOom4vieZ7SpXASWWkAP+2EODAErVcDQas0MbylvxcJbcrEDXniJdc/dv8ROF4/BMxp9FDtfR34NS2R0zv42vatDFrWBgvZOAYnyKx6YLcVKKyQMgCHRdAOav2tyU+bOR3qHtxMTLny5qlkrRQNivJxmDoL6HfeomV+2bnC5VJwG9an1bSQJhGwMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGeJYY6z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGeJYY6z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqXjM0GS4z2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 14:07:49 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so1997348b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775534868; x=1776139668; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/d26nUNEIld6JzIfDKNBmEnkO9f2aJaTVV3ZWZuPlo=;
        b=BGeJYY6zylJ7eWmedVS+0DrhAa7qUG1wyTAsAjcAg00XV9R1UzHju5lKP+Sp3kvR35
         KX1l73A+HVTVhZ+4quEKYzdm5NDIPKgV6kv5mlHHAZ2Ht49rfe+9h1aXiu1JXbm+yMt2
         zGYw0sbbAPBSoqZA9FvpsX/ziWiFPZkD7+xb+wnC2gckOATjaeyRNkq11ocOG0WLUKv7
         g3bfilZ8SY8av6UUpM3SpV3+wE2DW1Y+2N2Ona8OgQxFzkouNEMIjYiNDqWcg4S3ixxP
         5y8SSIqG0/545TUgP/u3jkt5AHZmbu30WW4r42AFiPcjX1qURJ4FvSEXYaqEwMu3h/Xi
         /28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775534868; x=1776139668;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/d26nUNEIld6JzIfDKNBmEnkO9f2aJaTVV3ZWZuPlo=;
        b=srNm8lzSftC4WOLLMZaGcMpky0cusAHM54gwNlSXCjkBPOEo+PXwxtp8aLNKu62iLu
         gq8l8/KLMJs7PpRrMV27xfRThU4G7usFOzWJjCGx3ouo8EpAud5xIfwFIvhBHIuRYepe
         0DGcGgBHdHEf8FRjzqXnx6STE7Xxqy+ZJ9A+RCtCO13fk9s5lNaOn8idTGM0dJe9qsXU
         oCjb/TGpUX7/hU3Ve9V4HAasl9AkQQB8rCklVZDACakuvbJGhh3+C/DpBXKYIVh8X+K7
         d1VL4yaz+gtwFlpdEssJgroPNR7Q9q8ANy1NxUYFRCUgqmymzirERcLENvtyl7OzzAkc
         aD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvq2rYvm0liqjDdbA/VgabtuYDGVV54f6bqbvPhUKDom4l3rEyZ7CZ4Ra0VCsI3/avCaUtYIvxDdmysbA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJc5C63Qaq4CF++jm7uQy40WniH1krPrUjK+St4GuD8xbEdZTY
	g9HpNofDBCeKrd3nfN6weT/g17Zte0sOowEJqJ9W/s0piYjikaW4OyNh
X-Gm-Gg: AeBDieu4cSw3+dpGrwOGdDD+iddfTFGGJzZQHBx5vBQVp7zfM0ir15uSaMaADTfDGib
	5mOZ93hRVfv7DRhRZfSzkSKlEkEJdpfVKMErxGTWMprjvj1hroBi1rFGiPJWsokHJxOihe6AHYL
	9ELUcx5ZlYB6gFn7h+TJYf9Vy7XqxsklFv5RwfPCpzRTa0cxUrncP+DBs73zfVRPAhYGeMQJpBk
	0VOeyFLRl6+hwpsYKgsmcVg03eBZakYWNcC4eWyVWJCIXOIog69j7W+aMEETLQ9FpuseRsYZEAt
	j5GAVmx8Eyo8CAzj7S5ug+ClDpoGb0lVIUAJTs+65NDp/aI9xgnj5hqZS2AzCcFpo5j2u+jqh2R
	eHnopekUWGHGPskXuZ2KJnbji49IZuE2p2o1wOscSb3rYTHV9TAuU3lF1DsqTjdiHp/lvjz/K3+
	NdS13ZSVQ4nt3c6IAofzrrOQ==
X-Received: by 2002:a05:6a00:4092:b0:82c:2155:5b6d with SMTP id d2e1a72fcca58-82d0da332bcmr13420506b3a.12.1775534867592;
        Mon, 06 Apr 2026 21:07:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41bc6sm16102423b3a.29.2026.04.06.21.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:07:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Adriano Vero <litaliano00.contact@gmail.com>, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>
Subject: Re: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
In-Reply-To: <20260406061542.22354-1-litaliano00.contact@gmail.com>
Date: Tue, 07 Apr 2026 09:36:50 +0530
Message-ID: <wlyjl8h1.ritesh.list@gmail.com>
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
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

Adriano Vero <litaliano00.contact@gmail.com> writes:

> The ibm,configure-kernel-dump RTAS call sites in
> rtas_fadump_register(), rtas_fadump_unregister(), and
> rtas_fadump_invalidate() polled indefinitely while firmware returned
> a busy status. A misbehaving or hung firmware could stall these paths
> forever, blocking fadump registration at boot or preventing clean
> teardown.

Was there an issue which you encountered? Can you share the details of
the same please?


>
> Track the accumulated delay in a total_wait counter and bail out with
> -ETIMEDOUT if it reaches RTAS_FADUMP_MAX_WAIT_MS (60 seconds) before
> firmware signals completion. This follows the bounded busy-wait pattern
> used in rtas-rtc.c.
>
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>

