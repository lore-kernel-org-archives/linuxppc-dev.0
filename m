Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75479609EE63
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/qdmox2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFzc3Mfmz3fRw;
	Tue, 03 Nov 2026 02:31:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633484;
	cv=none; b=czKb3G+OX4ee7cC1y9U7EgZ2vVZ/Jl2cJKOZLSx7HMO0pMlvePHWghMCXnTHRD8pKBYorplbQ+GSV7jfZ7NTzLpZR/CuDZau8qJdCYMnTRVW0iwhWQgiwbGoFwWtcHR1NrmEuG8iz/nSKq9/ftVyOU03R0shjytQdvHowhZ8lj4pojHkx7j/Q4eeIblq/l3oNUF/6cABgUK5mIQiPtrv4BkJDe4lHT/VtoVnU6BXqA4UrUgeV/P/nXMr80kMN4mQToVfwVmubRECZkGaUi3O/JSZPF+Z+Dqafu+5lb4kh7tZNGdvPyqJaEYRGQgZRwSHeoKtfyQ0XMlbOfQM53g99g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633484; c=relaxed/relaxed;
	bh=u8KlsjglqgYtj5jEusWZDtIHX8Luz8pZC9rBnXtmi0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odW+p2O0WgcP8FpDtHEwT6UqpdANf1cvWmJ0UHWcMw7QEe8sE2crjU3ogiY1uw0FQAZA+/qyueC0/K3kUKvvLh5vsVAc7JOTM37mFkh/97MNcNKixZ6b7rc3HhOqUq8mmVV4gGd37h/JwcJAJWO2JKvs4LNpdrXwf63anGdZJ5pw61e5+bxIo3sCX6+IAGPo5GjKrRV+a6AZBz8mvOwAOvVFVUPyvQ/ORSZPp9MRooTPnC4iZ4qYcI88YZFEKnKdgVakkW4bTxtxcDfI30OYQgR/OtdaeVJCnY6trRESzaZUxrUuLIjBCE9BpBUCZU2U8I2Ih7EYPL2NmFOf9/8ylQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/qdmox2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/qdmox2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFzb6FnCz3fRv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 087156025F;
	Mon,  2 Nov 2026 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E461F00A16;
	Mon,  2 Nov 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633481;
	bh=u8KlsjglqgYtj5jEusWZDtIHX8Luz8pZC9rBnXtmi0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/qdmox2eqXEWCv5XUEJQx37Od8nU1wMi0Bc2C9mCDhL88i+zSzGRbVihYHiqXLOa
	 g3Dfo9QA3MmH8rJNsoNOBBbat/liFHRZjNV0muYx/wuyAamwIzOyboc3aQNaG1Fpv8
	 CmJopb7QZVW9mKI6nlkx20lP84DZ5fMfWgfMcc/AI5kSYQRWOuRQQg5tcF0Lr3Tl80
	 VdxnogL31pZlj1Yewi0W5WJbAPBZ9GMUQ04l04+KJsZqsHB1JLWdWFTUfHrUXUb2oY
	 YJsgjEm1zbOnFDa1ShHicpDP/KBYRVUkIqSzwe1OoQoIbz+p5Ql702WWJKb9ZbqBCU
	 MBom5HcpX+00A==
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
Subject: [PATCH 1/6] powerpc: dts: mvme5100: Drop #interrupt-cells from ISA node
Date: Mon,  2 Nov 2026 16:29:59 +0100
Message-ID: <20261102152957.300019-9-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=blum@kernel.org; h=from:subject; bh=k9cmxF3STQ+7TVeFgrQyaw4gu4MlGxo9bPzSio1vBok=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1tSoZE30EfxuI5r0fUniiW3Psyw2LWBlLdhyK7jfu 3/Xu5gjHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR4zCG//W39E1+H4s3/c3q enbbm85ValOO3ue01Gx6Fja9Okp69RGG/04mf1V2R5Y3N0TYHdx/4Pa389NMQv3XzYs7VbmJ4ZP YFXYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ISA node does not provide interrupts. Its interrupt-parent property
points to the i8259 controller, which already defines #interrupt-cells.

Remove the #interrupt-cells property from the ISA node to fix the
following dtc warning:

  Warning (interrupt_provider): /pci@feff0000/isa:
    '#interrupt-cells' found, but node is not an interrupt provider

Fixes: be2019816e4d ("powerpc/embedded6xx: Add support for Motorola/Emerson MVME5100")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/boot/dts/mvme5100.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/mvme5100.dts b/arch/powerpc/boot/dts/mvme5100.dts
index a7eb6d25903d..b7e97d56c324 100644
--- a/arch/powerpc/boot/dts/mvme5100.dts
+++ b/arch/powerpc/boot/dts/mvme5100.dts
@@ -155,7 +155,6 @@ pci0: pci@feff0000 {
 		isa {
 			#address-cells = <2>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			device_type = "isa";
 			compatible = "isa";
 			ranges = <0x00000001 0 0x01000000 0 0x00000000 0x00001000>;

