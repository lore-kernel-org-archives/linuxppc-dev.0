Return-Path: <linuxppc-dev+bounces-26207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A60C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 03:24:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYDrG51G2z2yCr;
	Mon, 31 Aug 2026 13:24:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788146686;
	cv=none; b=hjg17biWlH3ySfuYes+H52X9iHEmFM1FSfHHlC/8bnaPSHTU90qnBWTke8/Dqgq59gCLpWUhbBH6pi/LeSlyxXsHGMPgnmrC7++oriuWclg1NL9Mxrp9cZZZU/gS6EDhxHPdXeV3u5u9SY4Pf+1VQNyq8TJwEP1YOXds2Iq6AP2zwoJKpv1Em4Rmmva7u6/ZsESoUDgnchxwweZKQ8v9SJNLJf98Z14aetPtu0yH32OD+J/iRbKdfU7DhL7poprV0RYA60jTco5kY4up1fCh1RH5Cr8dCFSJAALYePzB1MkbMaUvCzF40Oz/JwMOofT9BXcCCVNyOVY1mXCAm3GGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788146686; c=relaxed/relaxed;
	bh=LqUXShy4Y1uwDBlZFsBdfY3ls/HGLA3gGP5AeZZ/dKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIe+Np/n5hms36jTPE/oormhyug++A4EN41LaktjfHGCblkqkaNIyNuYXKcr/FdgQuFEXcbypHLxn59zNfVKOLQ/Ixos88OY+83yHlHLlDeeIRrYPLrcACTdRZOOqtM8YfEv71GApNmteYiPOIdfgXLUHZcQQvMCUuGSSQhXo1gEV4GJRnx/GQf689nhiLGU2Ap5cw6qcySYeuSWUKfZrAvQgxr/h8CAC4RgDmNj6ekPiAncveZeI4vDxhYPy8F+De4sEUBKgSolznHlip7iUueocACdk32EVYh9bvcNR2pNndNFuVD3l8Tal3ybZLwV2/ef7qDCDVqfn+1scyoW2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J6e6JufH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3-fouag0kdjabud18x9b2iu7408805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J6e6JufH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3-fouag0kdjabud18x9b2iu7408805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYDrF04CMz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 13:24:44 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-398d292eac1so1783741a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788146681; x=1788751481; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqUXShy4Y1uwDBlZFsBdfY3ls/HGLA3gGP5AeZZ/dKE=;
        b=J6e6JufHVVWwILZo5Vig74+Ivmrgdp2gVd4kkIYrvDpT5pey/53PxSyCkXAWuYK88c
         auPnkWwPeuMeu6m2t/J30XwRnOt3+BdjV5A41RYPLYljNv2rONi5NG6mPillXLHxcVeM
         lodu7Qsy17KWfMEvOolsDl4j+EK78WOFRTGAfYfof3/vsf0g+6ZTEDyyvMXnkDg5YIh/
         TA3E0Ym8HR/hPE/uDXE9yZtYA1y6ZSNaRoGnOnqinLljExNtdajJHtafDv1mbIjDK/Ks
         MHlUOSGEO/G/K9r+8Vvs9QmPPnGyZwJy9kWcMxV+0G20zsOH8JOBgJCYYYAGKTGeRFpQ
         zm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788146681; x=1788751481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqUXShy4Y1uwDBlZFsBdfY3ls/HGLA3gGP5AeZZ/dKE=;
        b=LonozJmOlpLB6RtZeQpIz7Yv9g5w5xXjxuv4FoljfF05ZuBNPgvrsjR67u0jT/LblM
         ry9815wrOt2F7noriN/apN/UTEWqJ4DxXb56qDRQQZut8OaPV2YLg+WiOtmyp2kr0h1q
         LA6uip0vU3PXDMa1qMkzLYCdNao/zOltVVDBvt386QvESyAXIiFysYU3kNDkDrUSjmX8
         DC0a355D5meBvDK3LS+9SOnuIsT5bp0SpAbUcn8EO2TyVe6koD59IYJdG0VkzfZwYQ/z
         Fh4+ADmm1saCO3C8w3GCgDj09Ybyd1FXORsLmfrbBIA6bBToPlIcGW/q2LP3IO1A+lNn
         U58Q==
X-Forwarded-Encrypted: i=1; AKwUvBzam5p3zN2MNukdre8OA0/vMtxKQUyE27B+cuBQTtAOBWmN/B0Ld53zC5lIFiSk4ad/rUbHdNLLGZCJEMw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lFDHO1mZ+GdxIc0UtljRcvfZVXJ8MdY5AdaHg/e5UgPFEUZCPb
	ISzYTzfvnYI1eEvW+SJcxcwDV2txUHcSQn+rMAuYXLVBo8HF2h4lnjAZ5MRY9qKMCqGXw1gU1xn
	XC/lmjLUX6tAneL6z6p4ESWoWqfquhdee4g==
X-Received: from pjbgw21.prod.google.com ([2002:a17:90b:a55:b0:383:7b51:b1cd])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4b:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-398f87e4b39mr785477a91.23.1788146681049;
 Sun, 30 Aug 2026 20:24:41 -0700 (PDT)
Date: Mon, 31 Aug 2026 03:24:40 +0000
In-Reply-To: <apSdOnbdLdrJ7ksF@wunner.de>
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
Mime-Version: 1.0
References: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com> <apSdOnbdLdrJ7ksF@wunner.de>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831032440.1053206-1-rathodpriyank@google.com>
Subject: Re: [PATCH] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: lukas@wunner.de
Cc: Priyank Rathod <rathodpriyank@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 30, 2026 at 11:14:34PM +0200, Lukas Wunner wrote:
> The "no active error status is read" is the only scenario where
> this *could* happen.  However if no error bits are set in the
> status register, why did the device send an error message upstream
> in the first place?  That would be a broken device.
> 
> Another theoretical possibility would be that the device becomes
> inaccessible by the time aer_get_device_error_info() reads the
> status/mask registers.  They'd both be read as "all ones",
> hence info->status & ~info->mask == 0.

Hi Lukas,

Thanks for the review and clarifying that.

The underlying reference count leak is genuine, but the additional topology
scenarios listed in v1 were inadvertently incorporated from an automated AI
review bot report, which introduced those inaccurate/hallucinated cases.

I have updated this in v2:
- Corrected the Fixes tag to 60271ab044a5 ("PCI/AER: Take reference on error devices").
- Cleaned up the commit description to remove the extra scenarios and focus
  strictly on the actual failure path (device becoming inaccessible / register
  read returning no active unmasked status).

Thanks,
Priyank

