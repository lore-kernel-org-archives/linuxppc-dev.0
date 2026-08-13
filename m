Return-Path: <linuxppc-dev+bounces-25819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F36C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:54:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLLLG5dgmz2yfR;
	Thu, 13 Aug 2026 19:54:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614870;
	cv=none; b=EmnW7f50BMaFwxzTotyPcyMzAmGijsTzWxRIdCvfhio1VN7rMw9Xwkjd9QC1LFxoJjADo2TIEQ+t1GPm1zNJLuKLpgVeV2Pe861hpEmgeT0pnO3ElFzrZ2XaH4dNsIpedmzfsVlKgEEzekQf9wxK9bhQK9AKR1MxiRXnIJ/11ZUmpnLae9kDgzb21rScMM9AqQnkoQC2Kh2G7ZvKcvfassd1gFny4aDqENb9/6ZuF4Vd5epzDNS3SYS+EGltTwuZzkh06xeDAtJ0RqOzXRQQxNzZwL3/joam0R61r5zp/g969v9ZUPbaPGq59ZHh8tcXHhQxoI8RBLTBkNzC1FoZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614870; c=relaxed/relaxed;
	bh=UoJE0ONwiW9+839EaZ7hWiQ9yyPS5ERFdBgspRFFZDw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a1aDbgEeDcpYm8PotkkItD5scT/FD9aAj4KhaA9NN1Rca8Y9AC2ZelkVHBmXFVUkp9fBRXvAtet2eoDNCjMXBNRcAS0qzeEs7ccIsKuJEgq8KkVLrW3W2sc5KrnCvGrm6+6Bs66LjijItpiqxtKDq+lJd2VMb6bE/wQwMp4GBAlXMH2l1Oi7HIg3hblhdTVoVqRhwj6Z5SvAdC2ffgG7O6wRhSV1AgxRtH/d7xcqlXdQoN3GkwINtREXaSBbBF5On9/SbGxhKoPsuEWAloFME748mQpqY9dAytyiMaowdPqojlipRdOhA40iqYQ9KpHPe8zylfm8bQG1BIuBhbSjYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GN+6Pofi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::647; helo=mail-ej1-x647.google.com; envelope-from=3ujr9agkkdmk8p6927pw9v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GN+6Pofi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::647; helo=mail-ej1-x647.google.com; envelope-from=3ujr9agkkdmk8p6927pw9v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x647.google.com (mail-ej1-x647.google.com [IPv6:2a00:1450:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLLLF0jRJz2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:54:28 +1000 (AEST)
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c16711b9473so154700266b.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786614864; x=1787219664; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoJE0ONwiW9+839EaZ7hWiQ9yyPS5ERFdBgspRFFZDw=;
        b=GN+6PofiERMXkB06eAvHNb0f8GW1seDHcanYUKgJi7RzB9lZLgqZ619WUSLXFp+0vm
         +CS/36BAju+VYNguLir4ffHk+aAmjJDUXn0+JEfB6Qeha0nKmQEBqVAH5aq79onwR4vD
         mrqVBTSfb/FXH1r31Mz4CsXZMgH96Gx5yDTg4DFnJdTgOkrJW4BfF5GmP3bC9TTJ7GZB
         X2eILECQataexIIv4/eeb6nLWeUMwtcY0eo3PdzjCHvNmsuAdy7Me9jpUXMvJTFfSqiN
         wUh2LZ6k2eOBD8k1rqk0ZcqhDZzgwb035l/3NgP+08987tspXi1xCoESUJ2zzhlDQZEg
         y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614864; x=1787219664;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoJE0ONwiW9+839EaZ7hWiQ9yyPS5ERFdBgspRFFZDw=;
        b=lfVit0d3UsHjSNjTQtjZRhay0gQYuTy0fVaGyX8oroucbCHxhGu0g3xl5xeVsquC1l
         UO9wikMvBW4tUH0+LouBnh1xXHi3Q/Cv0IdshFAUyJZGVRxMdXVQdfyg1ehqAvlxVrNO
         ySzibw7gMpZ4fIeKrv8ovzIREmj1QUuT4xvHPFFQDu44IY/TEQ1i0GVUsit8nmkwxhbK
         6nnJkNjmWGL02iSSfZ96y1edDRbMM1r4l7GmaE6TyG9Gk4HMvo/fxEme2/D4cOJ6ADf1
         ED3Gr6IG/A+y+ovg0uc5sWrMMzHiwMV8wA7p+dglxk0lowUGHYZwXWzVn+dcU4gtYfmA
         fXYg==
X-Forwarded-Encrypted: i=1; AHgh+RopGmwY70okbawQD6SQwhqdNBzpvcf1tn+tevlIzmjkQywbqL3dCDNS9imfMhO5AaPSk+OyyUGjGD8fGrk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2fdWJJCwuLwYIYZBvzW96lrGHsDzsYQzmsKK8sVowvwNbuqKx
	3GvTiEMgM+N/rVAr3VewEM0fHzgc4BfaoqbjmYMvcDuMuzuGc2ulDLymwY8oRiUcGINISffUDfj
	o9J6sIphnunrzHIeaYg==
X-Received: from edtl22.prod.google.com ([2002:aa7:cad6:0:b0:69f:aa9b:a336])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6b06:b0:c16:8adf:f183 with SMTP id a640c23a62f3a-c2108f06416mr245963566b.14.1786614864119;
 Thu, 13 Aug 2026 02:54:24 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:54:18 +0000
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
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813095421.1700945-1-tarunsahu@google.com>
Subject: [PATCH v2 0/3] Convert manual kfree(dev) to put_device()
From: Tarun Sahu <tarunsahu@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, djeffery@redhat.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, souravsgl@google.com, skhawaja@google.com, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

As per the guidelines, Devices that are tried to register with
device_register or to add using device_add, must use put_device
on their failure path (not kfree). This series contains 3 patches
for updating such instances.

V2 <- V1
1. Removed patch [1] as it is part of another series [2] already.

[1]: https://lore.kernel.org/all/20260810162814.1398016-4-tarunsahu@google.com/
[2]: https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/

Tarun Sahu (3):
  ARM: locomo: use put_device() on device_register() failure
  firmware/edd: use kobject_put() on edd_device_register() failure
  powerpc/ps3: use put_device() on device_register() failure in
    ps3_system_bus_device_register

 arch/arm/common/locomo.c                 | 13 ++--
 arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
 arch/powerpc/platforms/ps3/system-bus.c  |  2 +
 drivers/firmware/edd.c                   |  2 +-
 4 files changed, 59 insertions(+), 41 deletions(-)


base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b
-- 
2.55.0.699.gb54405d56f-goog


