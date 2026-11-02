Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924460D5476
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWoIsYgU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFzj4RX1z3fSV;
	Tue, 03 Nov 2026 02:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633489;
	cv=none; b=CCple0JrzvVG+I66BdQIFIuHRrOiOOMZHoVwuAH4loPe5v+dnLfOAd0w3LN0ncbEJ51pIrB/8w++fTe4ceZekgH20IOZ+shqngTfrOPzIvv3yK5oKSdM3H0+pjw4zR9SbANIBlHUmpFugVngzVin/soUYGS7mvzDzlal63i8i8yWIZsfs2t+Mjjx05gvIinHoi2hJMgtk3r1DRVmXHwtK/+swfc7XSebZRwbIKR4oHPy07vFtloP3mJU+fD8E5sjeZv60HgmmojPoezhVn/t74KC7o+hhofxlHcdPEyTxFzGzELJ8u/apfx/JQiKebctkQd8bOxnVsvc3UTNCOWcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633489; c=relaxed/relaxed;
	bh=7YyTCLjlVjUD8PuEQyZV2V8rls4hQ82Ljpe06zmYJVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtMyA6EkD4/TrhWpoHpDvc7cvZC0L3ruHGV6Uo/RBeipuYt7a/Vl4D6kchgxHESNPO1UpUIuRrjUnVw0FlrnIKjMOO+NAcp+i1d6Veb90qrXBZA0wn0FTaEtJChT9Y9O/2sPoEgDrhUyqx3ew1YpImNrY/KXu7a9fYO9rNU9TI1O5FIy6/DjD3Jb+yFKx1eoPEPrW64lomh8Cw0vKq+QxcwdWdW+5j/Jff6/mWY8WFg/Ya80vBGn08FXHGQM51obAeZNqUZqg6b16ziqcLU0DEFbW3X9+5xgdkysPF27qeLydau2EBQFSvGp/3JPlKK+80YuTB8/vZwjcm3+3ueLmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWoIsYgU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWoIsYgU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFzj0sbSz3fSK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 93CFC43B57;
	Mon,  2 Nov 2026 15:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31C1F00A1A;
	Mon,  2 Nov 2026 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633487;
	bh=7YyTCLjlVjUD8PuEQyZV2V8rls4hQ82Ljpe06zmYJVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AWoIsYgUjKJ2OUZiiG1sqQz2O5ebzNJhRop6sDmR+kmSvUZvsuUhebCjS/IiM1K9G
	 xRgjQx8UJVZkJwPP4BJLv2yBRsRTjjiiq8ZTV6NyMOAJe479JpX9ngvhf5jFbWxjf4
	 9k3KPFPaX3LL9UCuI3b/qM5rqJsdYBzYdEE0t1vLxlVKkxAvy/PUGeaTFF6914toCY
	 lNLS+miJ7V1mXNnio3nCby5JZ1ROicD9ArnPYgYVa4b/6UErOcA+7ME3WQz9P2TzZF
	 IMnghFrYnfC6Ek21yuOl7EF3weSSkSBbWFOFls7d5OVgCP1aGo4qcqh0iBuSl3iwRZ
	 jPRJAJszZT3cA==
From: Thorsten Blum <blum@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	Stephen Chivers <schivers@mandarin.aust.csc.com>
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 2/6] powerpc/embedded6xx: Validate bus-range length in mvme5100_add_bridge()
Date: Mon,  2 Nov 2026 16:30:00 +0100
Message-ID: <20261102152957.300019-10-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102152957.300019-8-blum@kernel.org>
References: <20261102152957.300019-8-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=blum@kernel.org; h=from:subject; bh=CflllZzQuhvqimnUAIXYbj9Rm6hEO+jyVlOLXkFdRU4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1tRFh51iyrJrS5l+MbPpTLxu13Uzz8dXuTIc+qbw3 XFzPGPSUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNhmcvIsG/LacM4gZm7Hab9 T2my+ifuK7XvZ4b6hteTF8l29Mzm3cHwV2ZJz6xL/68FXWbj+tzs5Stgt5vHSJhRupRhx5GMGzU eDAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mvme5100_add_bridge() reads two cells from the bus-range property
without checking its length, and a truncated property can cause an
out-of-bounds read.

Check the length before reading the bus numbers.

Fixes: be2019816e4d ("powerpc/embedded6xx: Add support for Motorola/Emerson MVME5100")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 5ca41972ef22..6a88abac047a 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -114,6 +114,10 @@ static int __init mvme5100_add_bridge(struct device_node *dev)
 	pr_info("Adding PCI host bridge %pOF\n", dev);
 
 	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range && len < 2 * sizeof(*bus_range)) {
+		pr_err("bus-range property is too short\n");
+		return -EINVAL;
+	}
 
 	hose = pcibios_alloc_controller(dev);
 	if (hose == NULL)

