Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753D60D3C9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zsqqkc9k
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFzX2ZQwz3ckP;
	Tue, 03 Nov 2026 02:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633480;
	cv=none; b=gu5lv09/f+Ow9a/6rCpC63FgbZ+Iv1t5m10qrL10RJTYWwGTWYR8V/kLqPsAo4vUxKCk5tUnIjIoAMiKa6wPik7IHQO91o2mF1EftY+36h/NXniGcVf2OE3Le8aPrOFrgUM4xhcAGXLe4aW6MBzi08V6KZV1MwgxqwssN3ljSJVORb0PZoDtxc6h/CR9m/CIyy9DMDW0vXaw17TBwBDPZqBZUqMSEAI+fDna1vRtblRqvlGjP9+ScvJ3GECQfEwqpdt0IrdeIq0dRVhQCkkaYqtk+YhQYLVnFeFLgPuhjUbGx8yBq172m4XLe10edkTOghaJ/zkzuaSn8ggJX1P6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633480; c=relaxed/relaxed;
	bh=+9txrTl5/NO8hYAgz5oQlXyA2nE6DwHGSloTA/xHM54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn6EVcNILxsVv26Li4mguzDSRTmGaiM+5/T6y9ZwpVMs3C4sxAX5542KuXJEbEcDVHXA6md6jQunlLfc4+dYvXdVr/rbyWB9K38A0op3IfZrwn9qK1+GFv3iSHZmztzfa1+pbLZ8fIpQx4YbHkYNes3KwBpXHZBvh7/SHgtlmFlv5N2A1IPsNJ7LHD1hC+vdUa5fcjA7Ssigpa+mht5SzgvQCelGOYcxURojO5Hd32of79wPQQuZuXY6qUeQfJ4X3f8VFQaZYDJU5n5mkpspT/UdYvJGOj068DqixcysGK+S30LnpyLXj3IIGVcqSzpNHXKrkQtmNs7oFa+bQV2QGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zsqqkc9k; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zsqqkc9k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFzW4rcCz3cjr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2AA360EFB;
	Mon,  2 Nov 2026 15:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7E1F00A16;
	Mon,  2 Nov 2026 15:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633477;
	bh=+9txrTl5/NO8hYAgz5oQlXyA2nE6DwHGSloTA/xHM54=;
	h=From:To:Cc:Subject:Date;
	b=Zsqqkc9kduFdUaxpOIpvWzLs4s6w1weryuyFxz/3zrBRZkBRlHX1FaiJwSIB50s3n
	 2zELJefLLOL1ytjVcg96/9BbfGy7BsA/l9ijHsdL7+uojqzkaKvSoPkiR/FE2hOgrm
	 y0wSIFcvti7pxrVNqHVMpbjF4WAY/rOSM9WIAg+qGu2Wtq7vKfD/1Pq1ZazX/FkA/z
	 K6JhZJaGXKEXGvujkA593Ty0aZv2c9yRgHlGqHdP2Ed83vd/Hd5AgXWVEvpGf9NCem
	 7M9d19u9Ua8zLR47QB4Zj1VN5Nfg/xErLVdfZV1x4JdVFsCfRiD8myOhjuPQjrvP/7
	 XUJG0iDjgTl/w==
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
Subject: [PATCH 0/6] powerpc: MVME5100 fixes and cleanups
Date: Mon,  2 Nov 2026 16:29:58 +0100
Message-ID: <20261102152957.300019-8-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=blum@kernel.org; h=from:subject; bh=ZxhEJFnmm8qLi9HIdGUmQB3gA8pliXDANXM6do7v4Wg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1pSVTg58qupTfC48RZdfPWDP1ESWZrnz2qJii1Nl3 sl633rYUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNZcpiR4cqb63kTtog2tApN UzyZUC0113fO+lyVmappZ86Ym/GevsXwP+XiBQvbW0s0XU7xOqxS0szbFrl09pOFDj4/onO9nRl vsgEA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 removes a dtc warning, patch 2 prevents an out-of-bounds read,
and patch 3 fixes the function name in a log message.

Patch 4 replaces hard-coded function names with __func__, patch 5 marks
pci_membase as __initdata, and patch 6 removes redundant initializations.

Thorsten Blum (6):
  powerpc: dts: mvme5100: Drop #interrupt-cells from ISA node
  powerpc/embedded6xx: Validate bus-range length in mvme5100_add_bridge()
  powerpc/embedded6xx: Fix logged function name in mvme5100_add_bridge()
  powerpc/embedded6xx: Use __func__ in mvme5100_pic_init()
  powerpc/embedded6xx: Mark pci_membase as __initdata
  powerpc/embedded6xx: Drop redundant initializations

 arch/powerpc/boot/dts/mvme5100.dts            |  1 -
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 19 +++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

