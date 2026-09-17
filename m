Return-Path: <linuxppc-dev+bounces-27533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F9CC982CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 00:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlc1Q2TYBz2yfD;
	Thu, 17 Sep 2026 10:23:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789604618;
	cv=none; b=GmmOuhum7hXJoao8FG/9cVkUX9eLrBpT8FMDraZXKXAci8tk3hZkrVCCXuOnL8R9AtV3Z5f9DXUW89oAkg2rJokCC8bIAlyAAOkvV/9kzAhVD9S2i3uvYHiP9ln7Dc0Qxh9y8zrDLLTChlRBS+1PXo4wrrT2YjoGAIDNaZ4vx42os4q0RahOmXWLp61PRr2AD7uW4cdctYzjjijhO27msaQdXF57e18LGJ/USKZ6yUL3EO+MR1kpOBTqJvfobz5vqVS3xhJMwKWOe7TsUSx7+w0C4zuPUIJFZOIpzpjQgt7haqDE0taXZkd1tvWSuzjElPzZchnfN4r8nnSeR3mEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789604618; c=relaxed/relaxed;
	bh=McaKO0yHOxz0y4KcMiZNfILTWJHJOqO2DVoFelFO74s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjtR2WUUsgnGUYHwDJfNro4Bkr7NJzbqO2RScqiUUA/x0XVqP2eTxd1PzSvyTt5t20aC25UnWTBz+QZTo3S7IS8VFhM0yVlFiONdD1g9QlTylWy6qqEiK9h+SvXz4xVJ+NS8hcOM7HyenjuCPeSJ+/rTRNmkZkhvpHHvcobwZ2ZfGwkz7eLxk7G9+GiTOvVTj9XAxi62AOQj/Q/5Ed14mWEStVnwqx5QNk23Cbuy8iBIVinNKzhhgCGZRxs7nMOoTVt/rbTNGIARR2rjcUu7n9QUud4EoierMYQj3Z313TQ2dRMZCRDpEUYJsahkTPInlvToU9ZsMGNGdsFlCOi2mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6JycS3o; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6JycS3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlc1P2fxzz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 10:23:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA27843F72;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCB1F008A2;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=McaKO0yHOxz0y4KcMiZNfILTWJHJOqO2DVoFelFO74s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6JycS3of59rxdBiglixB5HNPd6Dn5sh6zdLBA0Xh36pf/UBbkl5Jj9dmgGswxBxJ
	 WnCNiCLj6IXDccT/fv9yOgekTIpVqSP+aZDJiGVTJCuXhDOp1NWY4HfVOHb7CeukNN
	 GpVQks5mFfFESbXc+hEaLf5Gq2ysKEHS+ZgNc6JfsLflpz+tm6XDQqQ/W3SPsHpi1C
	 BsV8ASpurk7btY1td0fXbBWGXIM4kKSt3hbA5N1V43x1CkFCWOhLljdqvbpTRF38C4
	 eLii2d0P06xYKOkM1NL5zO533NPhayV98Qub2ZtOdmjZWRWOWdOsAaFIlLPTLiLOPO
	 /20AVW4FNymdw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 6/7] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Wed, 16 Sep 2026 17:23:18 -0700
Message-Id: <20260917002333.2306346-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=kees@kernel.org; h=from:subject; bh=QpDdcSnidsU2zeT85ZzQmT7vYMazwTC5RAWGMIhrVIY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb7xzWJ+eWth43WfdTVuE3LK7j29oPS8L/2ATsD8X 11HnVKPdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEgZGRYQmToYjh5TNi1p8v Lo5aUbhrcnqf9ePdj0ISGJdm8/p+/s7wz3bxHJ33y6XabPcZNZqWmF+9M/nBPZ7SDRc3n4yav+7 3QjYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.1.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..6c87c8b4de8e 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
 	if (seq_buf_used(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.34.1


