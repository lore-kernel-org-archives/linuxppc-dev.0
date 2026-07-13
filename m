Return-Path: <linuxppc-dev+bounces-24095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 05:30:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz9yJ3xbyz2xqM;
	Mon, 13 Jul 2026 15:30:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783920648;
	cv=none; b=kzhOCvE56QRA7+IPpuwwVFDFprdKnJXlQOtPr9MYoruudCQ/+xEB2+LnQZwL2TSeUcF3Hzbuq7h7mK+fVbXicq2Tnd/if02vYojT9kOFjk0Ri6JwWnvqzYaYctHJXtHXLHNcLY4iY7WQECDgRhBsnbvmvkesJI0cHCtA7eqEdrzFnorb6LIbrzOaF54H5FH4CtpOaA1iiN6kfRehcO4dc9J0WaP0cEdj8DGjAR99ANKEkKK7Rw8pCUb6Y+Vk8ySh5Csnq9Yo+x7E8bub0aSflRZUeRxtyj8t/sSrUJrT/XPHkB+Z96PAXwgKHOCLqgWgq2YP90PzJ1J4C9zquw9P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783920648; c=relaxed/relaxed;
	bh=n42GLElRxWFrSJ2rh+rVMDepVJ0T/L4DPFkt7qgjRVU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nC/XMLLZdLTWy5yUD4CmNWfa4qd01HKEc23fC3gui9tgX1LoSlupLscaiZxpnagjnjWeKwD4GrcravGQ9UU4u8ihcvPQzply6E8u2bKQX25C1B6WGgUJwRDIXsCbtjM8YxuSRuGcBuhe0JS8MhhRn1AN+g7sEI22gXta7KI02kVPYUBy2IzdRsZs6zd+hQueHfPxUpr2JHDitSMLtOTXUwZ7SWVQkgZC98vSqOisj5VqvH7Yw766ZICRJ9wplrffD85xjs2pl/xhf06pbeDfNrsEgRwwgujeEtEV7gwAF6Dbz9UDe3jgDuDPvK3F2DJwEbEg1gMKdBgwT3/lDlVoow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONtC/4/7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONtC/4/7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz9yH2Mt3z2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 15:30:46 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1611793a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783920644; x=1784525444; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n42GLElRxWFrSJ2rh+rVMDepVJ0T/L4DPFkt7qgjRVU=;
        b=ONtC/4/7adjh/kcesac9jrUuzfzazuWwEdzoowPJ2Q3vif9pAJUpA84CPvFgWNAEFF
         dKbCt8zrAObZ4Zvs2w4s+k6PWsIZAyxAhPP/wBWwDy4VURocWVK4acpw9xCYdKs0whKS
         y4vpGaAziM8gO1Z2fKX/AkuILZTT+ZPQcpN7u/7c+8Yodutgpgq2DeJPUIwTiHthBHR6
         e12n1LJ05d3hrp9RVdhIuAQ5Mn2THXSxobx0JUVYJuhWgmg0oCODRiv1yJgGgr9/JwDW
         aDYMnD2ubqvNOU+w5N/pnZsZ4zj6eY4HP6qlUxCUaWxMRsPv23lXHzZeDqmOtm/FUubH
         f5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920644; x=1784525444;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n42GLElRxWFrSJ2rh+rVMDepVJ0T/L4DPFkt7qgjRVU=;
        b=dM07s1yjOxa/TGNYpGzajq6P8mModYRk9h5Sp7WVUiX0ffOxm1sIIx/4TLp17YrbrS
         aVedwZUHSlf8PfHd68PBmAQ0ILpbM/9Aoi63fW0g9tu5uS0DxnGHkBB9A0Y8UFMclGGk
         AxAp7rU7HI6KrhMnJW6ifgHp7gkX1sQpNexu5CkRfYjERrVRciOigpDsDvorGjdLD9sg
         zznkoL15LdHiWQr0Jc87BEEXAwMGT+eKXD2xcMiLGtqo+Igp1HhMr5nxrw9upFWoDNvw
         iwdGcVmWAapJq888ZgEwOXmVK3wWBcTb2DWos4GRslUSBif0l/jLOget4XGUjMD8/8Jg
         UYSw==
X-Forwarded-Encrypted: i=1; AHgh+RrjMD8yCiSrqVO3lwkVgBFzSZ2Q+kwBIBvtUq9SrH69Fn5Cit4KjjbpHTyMTo+iYezNGhF28e8dXIdJ7ak=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJ/3+6NBpzFGd0m3l7kvDBe04G96DVuZwDou1ugL9j6oyxVxYk
	gDSquYSBExo+94SqMjWjb8VEth4v3PSITJxsze2v0DdiaNHaihv1nKdC
X-Gm-Gg: AfdE7clwRIN2t5KUE4CkyTOhh7UN+FiqhKPGNaoSfafKhPlmbCJAnHFNzKkdaDgGXcV
	+hAhom6lmy1q9UVwgoh4wXMaoAST/n4oObwAIpLrTWYxgZJhLsQwY1unTcZEtJfnoEGPgpbxs+3
	Dnr+eIXTUiBqir4H1Kfi5EenOcD97waN7lHpSHyoCM6DgqvPtod6lkdrQaICbtKAB6MMkYFZZSO
	nFgEhQmOAY/B1S+pwxOIRTptaKvznkxzVa+hb/Ox+cX9qzpq7y1/IG1iNyJL9+xSI7LeJzA5oJI
	ZURQcvip8oP9WHph1x9yGAEUJ1JpMoWauqkLfgjzFQMPG0u0p5yoGkNJ1JmL3oZZ7jKZdI79kOl
	g35PkBRQf1M85xuTUVBu0LVnDP3/MaOiMwpmThSL+iQI9siqRt+z4B8CC9W8d01QD+h99TC9d15
	iN2ULv3RhQ19M=
X-Received: by 2002:a05:6a20:a104:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c0f049ad18mr13393163637.0.1783920644181;
        Sun, 12 Jul 2026 22:30:44 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm18756761c88.3.2026.07.12.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:30:43 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:51:10 +0530
Message-ID: <mrvvv515.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Changelog:
> ==========
>
> v2:
>  - Move H_WATCHDOG definitions to a common header for shared use
>    across pseries code. 1/3
>  - Added a new patch to handle pseries watchdog device registration
>    failure. 2/3
>  - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>  - Add suggested-by tag 1/3 & 3/3


Reviewed the changes and mostly looks good with some minor nits added to
the individual patches.

Small request -
Could you please also update test results with v3 in your changelog
(since you mentioned we are able to reproduce the issue easily with your
test code).


aah one other thing I just noticed since you are ccing stable and you
added a Fixes tag in patch-3.
Patch-3 alone cannot be easily backported now due to patch-1 and
patch-2. There must be a way to define the dependencies if you are
looking for backporting the fix patch to stable tree, please check that
and follow that accordingly in v3.

-ritesh


