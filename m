Return-Path: <linuxppc-dev+bounces-18532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C08A1099B3C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd7Fg6s3kz2yYq;
	Sat, 21 Mar 2026 16:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774070775;
	cv=none; b=SMKJV22IUcswYVct8tvdmyqARDMI40brK7O+VBV3TMdtt5rO7FA5aKoUzqGRJ5j9TNR8Pdor3A4Jfn2dtapFjrM2kTCQEbyvRwXvXaDjDm6DRyEwf9bMx2AKulATkrxuVg+JlkL0FjWf3/AFa+ZDVLGeaJPhB7pVmOK/1X2KbJoy1sKSrDasE+jfmzu0SKpVXvJu7NLUzsy7KYJB3RafYmUsCKWyEx8+pgqXDzKVWx6Efg45P+zBdttoqs09wdu73261GRkWrRrZ7oGAxUdYJnpyP5qI95SLFHJrzi6yCJ0dYjDwA5TMn+wojd9dVU0GDvSXxqJv7W62PMlNHWHnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774070775; c=relaxed/relaxed;
	bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bZ8w0UO3eOK0IsG5jEFrH+4jXppM1foTiitwWojXnOdRzobKlEXLRU/eCDf5lzKKqAs1mV9ibJj1sS4m8FBNZEdIDTza9hSkE/hVAZQvwBXAdZU2hD/QezzF/+h7Av4/XKn9equroi8lhV8Ue9V2Ssnt2k6WOH949p0kD+Uk9GFSwAB44Y4+UoO5T7vuB55TAcu74DY4VMsVkPcXbJF7W+loX49AdzapZNnRWMXAGx2Cip6PV6rgw4PB/q+fRmluTO2i3gSAJoHjE2y2BmH0C654O2clD9ZOQUh7yDEeFiFZs2gEzM9S6UVQUQhVROni9++fvavSixOQcycj6P4NGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Smh2vVLB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Smh2vVLB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd7Fg0rLCz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:26:14 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35b905e9dc0so1730653a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070773; x=1774675573; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=Smh2vVLBs+q1v1IlAacPIRKyVN18TkIh9ewn5CEVd3Kig0q8lGP/doojUEjjscX2Yo
         8jOZDJk6KZb2rGBaoWaeICvlsdn3nUI8+XQ9kWbPZz22KwWXr9VtsLSydEfTk80BqiqP
         PhaJHYuqR4me3aAn2+Jq8UI3x5pNopO3qgGruJq2LqyGLuA1rAFqmY+QgCu12t9JWbr/
         7N41YJvAvY3d1MZ/I5ajUTnPvMDPv2mteP+P8ccOg+yXnjBj/v7DG7B3Gw4Ec7mshbad
         9X6ZZFXMrDukzCiME2CfD1Dvz8JnKZC89rHOpChidDBO38fOlUOt+OqweZCWeVH7l5f/
         vvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070773; x=1774675573;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=VTOXQj5fEumIhSIHl79mZQjynhskq4asGG8/MO6YCKIGPnViMc1Nz9kOBKeV4FZCK4
         HVgtvjI+gGDvlFN4FxxjY54OEzbLNsNk5eTNjQx8J7+KNuYf+kj6jgk8k/+ZGzOf4+1/
         uhAginFpl+63w/w56ZLb3bJ57BI0UvqAozZs5C0aW+1AesBAljupWi4x8pb/2IbjymVI
         G4rmacu4WmVDcoZGolt11Q0dvdNhHqJdcmUnBIOeOfqJsaT9Qi9oHL8a/ggTiZuBU6W5
         SAC+2phgMN0qcskMBQQr7HCOaw4RDUX74dipFXO2flbPrmjq8TkTiA9TnMU3GqAgJsSG
         qUGw==
X-Forwarded-Encrypted: i=1; AJvYcCVHzGgKgS2k6udGSGpb2M+iPfcPKDeOivggT7RdPTuVlp4eYTWMrZaLv6YwiCSxE2VLV2MEjTRpjfIVwGc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqBxZMn1pyg/P1TAt2wIvsm4jdHDZhvw55oK512iv/Ik2g+1mN
	pSM0arxw4W47Y4I6DJvAcU0p5U2mCzbNMmU9oQix+etrNsyUfFrf9U5M
X-Gm-Gg: ATEYQzytdpIojpGL2UrcZCxzTHGiYx6P0u5QR8yxJ84kCta6ZIUSV1WPWeOZD7iUPS5
	ooGCSqx/JuxG35qkpDilQZu5Esoyrl3TrYD9n9CbaB3BbYZc9WiQ0dJCHVWXM14wQv8UJhsxQT+
	eC/MY9C3XXLQtnbLmfMNbdyo32SkZq6TH52lBWdOX8un5CXLMtN7/w6Rq39mEUt6t4m+OZxX8Yl
	9PF92pr0Lgdku4yrXb3cnc704g593p3Y8RBYR7RYAOPImqggS52C/W/C5sMzK2j1+Rg1BbpD3Z8
	saslKpN7UI1jJkP4896gNzhYZbKTQywB1SlYA2smnRTVkK0ymxXkVPpawqAb75JtEclrXFudAHn
	HooNNDhSWqysDtbEB7ZEXBcVC6qBkmH+EnuEFetIaaVCRwSZR8lOp3KnCvi7UiwQFZpZ1q1dQlU
	/b2NLKN7zapf8zLSj7w2dj3g==
X-Received: by 2002:a17:90b:510a:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bd2bd5ceamr4620697a91.1.1774070772650;
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd41347f0sm3299371a91.17.2026.03.20.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: change to return bool for pmdp_test_and_clear_young()
In-Reply-To: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 10:54:05 +0530
Message-ID: <ecldycui.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use pmdp_test_and_clear_young() to clear the young flag and check
> whether it was set for this PMD entry. Change the return type to bool to
> make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  2 +-
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  include/linux/pgtable.h                      | 19 +++++++++----------
>  8 files changed, 27 insertions(+), 28 deletions(-)
>

LGTM. Please feel free to add:
(assuming you will anyway kill the unwanted externs)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

