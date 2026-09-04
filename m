Return-Path: <linuxppc-dev+bounces-26569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4AC624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 17:16:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc35z0QS4z2ywS;
	Sat, 05 Sep 2026 03:16:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788542182;
	cv=none; b=JFtQ0UnF10/Pw7iHHMR2AvrOd3bpRVtM2VD+ZwU0YWymJEwUbJWJS4oWlTClq4JzL3hG9gNPVnJRsrOLEb9wlzSrIMfL1R/iXYgkq00I7zpd+IlKyQr5jLoXwWrX5srSWIWeL3IJqz+cavUHFFA0os/yqNJYaxEsH8ndEhQ0few9DJ61Tl+6Cbz5FQBoUs9+atuFcVFv5xK13y/ZFQ3PGt0afqbMhSkb+jLuh9kHpU/Sslka3L5XqYTqUhfSdP+E5XbgNVQWtWNnvmFRH5boD4bPtlxqc0fpe1VTRadLNfmyuEkzxQGkkxWFM73jvKw9Hsy917PMvl9eUgt9GT+6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788542182; c=relaxed/relaxed;
	bh=QsLUI6iuIsDgESFlcz3ntuSKxj+BnKcu80wPoUNQMsA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GEFbnEQFkRmB4k19zeHIRcGEzztNWjQfNVUV8+scVoFetjvTcpxMI0gcd9zPyLjEAeEQEXV6Izm9+6QTBgkjohim+VF3ag+u4peyHflBEkzrnG0rs5WApHwc2AMyI7CIVRtbXSH1WyWkwP0F6ryhlBLInLzRJMdV7ZsPSzmBOFMo2tWRJ9xMvjyl3TCHZtXP93vf1H7IjH7gQWOesPeGRB4L0IsiptFNfIZk63aeVRvsW8S1p10rRnDQppsC+xPkhPAQjlylvSbyjQ3pKnq6Gn3i1E7KpAjtengQhFCzm0t2me9cp5aiFqjp+SDNUKT/p+LjgendS51KzYWU6Ovo+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LBpxURdg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com; envelope-from=33pyaagkkdj0q7orkp7erdlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LBpxURdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com; envelope-from=33pyaagkkdj0q7orkp7erdlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x648.google.com (mail-ej1-x648.google.com [IPv6:2a00:1450:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc35x53Zfz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:16:21 +1000 (AEST)
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c255e9a2282so101008666b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788542173; x=1789146973; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QsLUI6iuIsDgESFlcz3ntuSKxj+BnKcu80wPoUNQMsA=;
        b=LBpxURdgzYl9C2IEo6cn5fJ2cZr7wMz29J+rrgaLywBEW0tiPzFHzHZuBhgjNzl/zr
         tNVNpuGnmspEzUIyKBpFci0l7ZWACwL4SIyYKNOZ65HJCNB8iN84UOfOxmJKlXyNJg8M
         eSiYShGtEOGZmzEaZD1rcDD3gTH74q9IiJxsc4rwu14pGZyHFJLIMn+fdSli6Jki4l3A
         pPot03eBWMl2BGWTijMjXWSVkjEQJZUMFe12NnCmOl+mmlLwerCDXCWV0Em1e7GtsFc1
         sFTHgXrczij4vKhuBcabsOFQNOpvK9sYvOiFZpX0ID67BTZGjO78JS7Y/V2S1vrnU/XA
         d8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542173; x=1789146973;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsLUI6iuIsDgESFlcz3ntuSKxj+BnKcu80wPoUNQMsA=;
        b=oI+Oyq4kM0BfWtsD5XnZIke/gdvQAA5G8wNkrLu8tUd7D09WyNpyEnhh+PARqtqcGX
         zL+KLqXyVchrhkhAT68o11IldOUz56YXJKz4nBIRX5qQTBMRoXCnpo9bBfBGirVtJqdy
         VBsx0RneKiYPkLTNlBByvoq09HpuwG4/O/2PVAuT3vczWhQJXfaSCT8SLzMzog7/izte
         6K5jTC21wvzC0nEGjy6bU03qOXRXpgvLty+0OB24NQ7XyXt4BEwjcFxJt0qXVidadq/i
         +QG3QYSpm8wjSWoQfmlyl5vwyVaeaMXiUdgw5gF2pGZJ1UNBRuEd+zSK35lS8zC5RKj5
         +tyg==
X-Gm-Message-State: AFuF++l1HV4/9v8RWVypYhZgk5Xis8gf0aj+wv3g7Jvq+WlPKM0+vJnW
	s4ZW/K6sYtxYkPA8IBkVBP95BTMDYD4ErrwWcuv39enolHiMsbm5XvVa+OQxBDl3jGKUNmaSbzl
	bYYgGwHXmR7u9v/nVgg==
X-Received: from ejcag13.prod.google.com ([2002:a17:906:9a8d:b0:c15:cc45:3883])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72c2:b0:c25:2e93:289e with SMTP id a640c23a62f3a-c260ca19c04mr527353766b.16.1788542172819;
 Fri, 04 Sep 2026 10:16:12 -0700 (PDT)
Date: Fri,  4 Sep 2026 17:16:06 +0000
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
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904171610.3342398-1-tarunsahu@google.com>
Subject: [PATCH v4 0/3] Convert manual kfree(dev) to put_device()
From: Tarun Sahu <tarunsahu@google.com>
To: Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Masakazu Mokuno <mokuno@sm.sony.co.jp>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, helgaas@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	sourabhjain@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

As per the kernel-doc guidelines, Devices that are tried to register
with device_register or to add using device_add, must use put_device
on their failure path (not kfree). This series contains 3 patches
for updating such instances. Same for kobject_init_and_add or
kobject_add, call kobject_put instead of kfree in case of error.

V4 <- V3
1. Added Fixes tags
2. update commit msg as per the suggestion on v3

V3 <- V2
1. Updated the commit msg of each patch to mention about the kernel-doc
   guidelines.

V2 <- V1
1. Removed patch [1] as it is part of another series [2] already.

[1]: https://lore.kernel.org/all/20260810162814.1398016-4-tarunsahu@google.com/
[2]: https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/

Tarun Sahu (3):
  ARM: locomo: Fix device reference leak on registration failure
  firmware: edd: Fix kobject reference leak on registration failure
  powerpc/ps3: use put_device() on device_register() failure in
    ps3_system_bus_device_register

 arch/arm/common/locomo.c                 | 13 ++--
 arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
 arch/powerpc/platforms/ps3/system-bus.c  |  2 +
 drivers/firmware/edd.c                   |  2 +-
 4 files changed, 59 insertions(+), 41 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0.979.g7e5102b832-goog


