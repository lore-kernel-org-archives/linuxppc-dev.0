Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE5606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zi8sgBcb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTBD75yqdz2xly;
	Tue, 17 Nov 2026 15:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794888791;
	cv=none; b=ke/eT9VGpsDkT7xaJ1fVKHRt/2deckMq6q97nOqVnlCKyJZXscoU74HM2fkkLE33eoCDm5Vo9K7YL1xFNIbNw208tdwY6kadMtfYvb0BYITi0wJ2jKsz5qk6Tfr1byiI3TzrGNt/54AZ4QXCX7KlRGzornyOo9+H6+U5L73/wZv7E6rtrsf6FwaXqezcOX+aeYWaxnPDSjCyclxrvNcBXVuwUF4C/GI2n8om9ENTKboioR81Im6G8FlPwACDDPvRcdLwgFCi6wVU1/EHiOGcWf4SPNcS+dO/t+wKdIffewj8TT/+rRYud69dQvrPsMhGKxCXIWKTQZH2ucyFezGWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794888791; c=relaxed/relaxed;
	bh=bOzBCYdSa/53GAfvZrEou4UNDnD5bis/vQ5YKWB+YTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILOz/IDGcJ7UN0Syo+z2CSlXjyZJxlqZPBFga7hh2KbN3BJ2s3IWRys4sDU+nehWB+1fFxe3Spgc4ceq72DHAcrScLJSrRuER6gJaFrY4FfrrB22KZRSLHSdoKwkUYod+zLMOOhL3MErEKE6qyM7XyNponce2nNoWOm0qNbaDrYkqCLowg+UABYEf4OTpxWSO2Mo0Xli1tnEI1+cXmfdw1HH9lY1jDNVz4I9pglHiGCNy4Df/UNI+VeL2cLolTdx5z2i2wJuEi+lZTVodSO6qAXRMkz+sKpmo1R2/BWYNYevfL/+qMcl7WonbzRQLb4n/Aw1GfRL8vjYPsMBJYYLPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zi8sgBcb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zi8sgBcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTBD25byBz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 15:13:06 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-170135e43c7so6746840c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 20:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888784; x=1795493584; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOzBCYdSa/53GAfvZrEou4UNDnD5bis/vQ5YKWB+YTY=;
        b=zi8sgBcbhdpLRzTy496Ns2l0Wq/xD+0qCm7kQaNjZ0UH8pJ0QHmfFBs8U9Wzv38vYm
         SdepEzp79aXDJFDnqzpt6skUOCwXu9hBDcI6dbBh8bKNQF8uuhHT41S+anvzsshjaRch
         aXJZnUPlTD73YpGAyBlTiQD/ghUSLHfuDJn7MQCQeBXzaI4B7T2jpYaxPqBl1mOPAOz/
         cI50nCwIH37e10GX4bmNKkEngvFcp/vcDQYw/VB5V6eikH6YNe58yzImHGz1RChA/3+j
         jG4/4/BZdltrO/wY1eWiyCOi4E9ff0T0lOnkmPbqpJDapEEpX+EqP8tP6+F7+gbDsVRh
         kRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888784; x=1795493584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOzBCYdSa/53GAfvZrEou4UNDnD5bis/vQ5YKWB+YTY=;
        b=uKnXN3qFLTBcN3dMlDiHoRLETwzG1NwuNK3z8WrdHpBmXFPaO+LV+KRGYjmdkqJLBk
         Tt1B2JfADhiTpbJGzoWFIMJaDTV0yIlPsNVi1KgOFu3m/PItdPeykKKMoUkmM3H9S6Zu
         w5ODeUqzi1SXL0/7pVzsrb/BSBUbPF7V9SjB+fWHD7kC8jbGbvzumldP5ZMhz/bfCN0y
         wTKiM1KMGJEjESDjBl9Im5D1p+BpaW48rRkG5rHhwYeAtQzQo3n1s/CPa8vrWmzuCs5J
         fzUpDqlk1arw8oFI+HgXB71ED+JgLbpb8mt4mVE0RvE5UxwuY8lPWVV5p/CjORenXrut
         rXzg==
X-Gm-Message-State: APuU4Z9slJ66zIGEPDcphASqwEk6LqI3tdw8drDU1mx6S2KQGMzh5Oq3
	x9vCBV9ZiUTXNUeaNcOQe1T3izSVJOZoIX4FaJgSHDJtYC/Nz8q8aOefJ4n2oub9
X-Gm-Gg: AYBFou0sjPx74f/vlUZBeDf0hXVHDVo9LhFC8tWCJ06VaFKRKHiEB/uLYFclu03wzjO
	twiC+p6FFIp7guMe9zu517J3b5awntkULT/ZZEwFDepXsIJlQDOVsMhiJCjAkFxu+6HqWoRN8EP
	k0f0RJCOqV/Qg4DGy5bBm6wXHQRr8hxyyMNg/5wrUtHtdm4xWmkMix5eIsPuIPDmVcw6TmitXZA
	jsuNJXmBZwqRN9ldZRNg0WVnovQLaO0wEEF1ow1ZEgdhQxWNTGqhPAESlmgu5BPnF8af2WqgpjN
	xuPfb5T8KM3HnK1qquPNi+2cuo3nLFAhdPmEPYKZhQuzsVvuiqX6FqOCNW6ECM6CB84T7ibYTUY
	QHTeS2letQ80j16Y0XxhaI3xhhH9jhKIdKaf8mDHAWAXCQ4ximAAXi8pxDk4Sj+gkQg5wD83qkT
	iOWM5ZnEwwy98bszWkk0IoxkUVaN22SE/TUBrEpuaomYR94z1sE21ZwgjcZSHfeNUloC60I5ny7
	2iRQWYsScM9tPFqbsOwQAL9yRZyfW5oRm2uQm2C5hS+gRjn6UXTtWGJT/KOoJscfkUFKVAazQDi
	qRUlRbFkXLnZVdp4is24iim829qPdeS9yQ==
X-Received: by 2002:a05:701b:2810:b0:1b5:58d:fd4f with SMTP id a92af1059eb24-1b5058e03e0mr9273652c88.43.1794888783614;
        Mon, 16 Nov 2026 20:13:03 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:02 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 0/3] powerpc: Misc fixes for debug kernel splats
Date: Tue, 17 Nov 2026 09:42:50 +0530
Message-Id: <cover.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling debug options like PROVE_LOCKING, DEBUG_PREEMPT and
DEBUG_ATOMIC_SLEEP on powerpc64 showed these warnings.

Main motivation for me to look into this was - many folks internally reported
that after generic entry/exit feature, they aren't able to use lockdep because
of the warning splat it generates during boot, after which lockdep gets
disabled.

Therefore this series is an attempt to fix the warnings which are generated
- when we enable these various debug config options.

Ritesh Harjani (IBM) (3):
  powerpc/64: Leave lockdep hardirq context around replayed interrupts
  powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
  powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()

 arch/powerpc/kernel/irq_64.c   | 11 +++---
 arch/powerpc/kernel/watchdog.c |  8 +++--
 arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
 3 files changed, 41 insertions(+), 43 deletions(-)

--
2.39.5


