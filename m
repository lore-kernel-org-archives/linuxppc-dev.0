Return-Path: <linuxppc-dev+bounces-27267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F8C88E73
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 21:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkJvg1kpcz2y7Y;
	Tue, 15 Sep 2026 07:59:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789423151;
	cv=none; b=lCv/lEI/pN1MHEqHjK4IkdHDWHZUeiRAFUGb/O3Fh19PmueERrmImsfowsSniKsslxaZum1reIId9YIAwOriIcwqBvGih2uUzwowX1+dorT6TtLEB1u6bQ7bBzbTC5xEgITXUIe5gQpGim0X2s4gTAicPde8gBUh6gp/eEz/Fjwk0Z1BUb0KIkK3QrcA9Vo51mJsKXNyMNgyvXSBZvqYt1tn811Jlb5sgUg/2XTJaYi1XLqnKvhmn9h7rNokpXVFly89CIsP5IZIiJgl3CeX4jcDgOjpbTtbCCkYOfjwt2clkyiGge3O1KvjVbqqvefOkOY5VEIkBTEQg6pnaoLgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789423151; c=relaxed/relaxed;
	bh=10BkpJc4PjNAt5xN3gpTNWKZE08C1lHzMleua/sqrds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqbfDLqTIYvTZ9C7RviuRCoIDGM051RjCjYlOPzVobEwknP/rmNZK4zMZUGAf511ZC7J376JiJlryUNrvtpb0JaPQqVZFf3Y2RJGajVBdtfBdTuBSJ+5W1LpSsKhodUAcrhxqA3FhHPHoAe+psU4vyEHH0a4U79lzS65d8Y1+rcIcPdjzhaMyc92vDo1jnWzByB/IoT2aM43M9BPxjYuKL9Nn6Y8B2LvybpjIVwRrpJy669fiZJwooycWp3RP+lIPT7AzjntgkC0D0jfDatcHvlNnm9EN6OWbPfuyKOgvoEdGy965etGYQNPeZrdaRvFamhwkXBSBhvy7TfIFBlwSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG+DkYh+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG+DkYh+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkJvf2kGKz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 07:59:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 545DF60252;
	Mon, 14 Sep 2026 21:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712561F000FF;
	Mon, 14 Sep 2026 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789423147;
	bh=10BkpJc4PjNAt5xN3gpTNWKZE08C1lHzMleua/sqrds=;
	h=From:To:Cc:Subject:Date;
	b=TG+DkYh+/3zm6wyq4ULPMxisV95apu7xTSEKg4Xgvp1tFIflUO9O3VDDqCKNWRWai
	 TGPTKLwwtwu9VYyejBb5tx2k+4N1qRXSCUpJiqKNWSWtpVsNDMFBMM450KM1j1vv/4
	 qj8xVSD9isPOiAMLDLdj8+2Gkc4oCnAbNjAEAK9n8LCwAYVv6hJqJ0cWSdB12Kctw3
	 7j/Pd5PJ0gs63+OgZp+N1xi07eRNXP3LKIfu+i7/OkNbldF1MqJ4Fw48rwS00AAvwg
	 jLdm2uDHtic7Eyyrg15dSPE3MauQl690M+LEIKbe5rz23VGtWF5YH2bRs25WCddvuG
	 +iCUuZ7onenBA==
From: Thorsten Blum <blum@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()
Date: Mon, 14 Sep 2026 23:59:00 +0200
Message-ID: <20260914215900.84712-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=blum@kernel.org; h=from:subject; bh=RX0WDJXWEEI7e/dXQep77AMT/tE7x4fspdCWYxL7dWI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkr8lQiBZaZ1P+PWvNif+4V09mxQk0LnPyjwuJ6dYsqZ wckFap3lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwETOhDL8Zju6+MPG81JJDdLL PP7bpt6K85nN97Mx8UTjqcbfPlEJvxkZ2q9P11i9tOziu77/Uovn7z+0NXRXo4PY15Iozk1SOnE 7WQE=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

In ps3_virq_setup() and ps3_irq_plug_setup(), remove the goto statements
and handle errors directly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/ps3/interrupt.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index a4ad4b49eef7..358611638258 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -184,8 +184,7 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	if (!*virq) {
 		FAIL("%s:%d: irq_create_mapping failed: outlet %lu\n",
 			__func__, __LINE__, outlet);
-		result = -ENOMEM;
-		goto fail_create;
+		return -ENOMEM;
 	}
 
 	DBG("%s:%d: outlet %lu => cpu %u, virq %u\n", __func__, __LINE__,
@@ -196,17 +195,13 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	if (result) {
 		FAIL("%s:%d: irq_set_chip_data failed\n",
 			__func__, __LINE__);
-		goto fail_set;
+		irq_dispose_mapping(*virq);
+		return result;
 	}
 
 	ps3_chip_mask(irq_get_irq_data(*virq));
 
 	return result;
-
-fail_set:
-	irq_dispose_mapping(*virq);
-fail_create:
-	return result;
 }
 
 /**
@@ -250,7 +245,7 @@ int ps3_irq_plug_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 
 	if (result) {
 		FAIL("%s:%d: ps3_virq_setup failed\n", __func__, __LINE__);
-		goto fail_setup;
+		return result;
 	}
 
 	pd = irq_get_chip_data(*virq);
@@ -263,16 +258,11 @@ int ps3_irq_plug_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	if (result) {
 		FAIL("%s:%d: lv1_connect_irq_plug_ext failed: %s\n",
 		__func__, __LINE__, ps3_result(result));
-		result = -EPERM;
-		goto fail_connect;
+		ps3_virq_destroy(*virq);
+		return -EPERM;
 	}
 
 	return result;
-
-fail_connect:
-	ps3_virq_destroy(*virq);
-fail_setup:
-	return result;
 }
 EXPORT_SYMBOL_GPL(ps3_irq_plug_setup);
 

