Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A20C77B61
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Apr 2023 13:26:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtwxW0bm3z3fcg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Apr 2023 23:26:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AskpWopd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pali@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AskpWopd;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ptwth4BF3z3cKb
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2023 23:24:12 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B794460010;
	Sat,  8 Apr 2023 13:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03996C433D2;
	Sat,  8 Apr 2023 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680960248;
	bh=0pyF5BprYbz87qK2AZkPwODALXJFq6DUsJqadpHT440=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AskpWopdFqX6lsJDhlhGzTTV3en9jDxFxZlVrZTw47L5imksgqFHPvghcNWg5eNIy
	 ihfkYOF6+pFlskm6eI5fITYV7m3FMC/IyTR9x6sLuzRZFvc3tLKA8DIBzDGUIAt+/I
	 VTQgo4y3PyIGChS6MhWVqB5K2Stm/CNoLksc7hS0P+Sh+BGL+QeMKNGeqryE8hYut/
	 DXMTgKv9MoujdhNIbHIhyLLWDJMW4a6ZNpDpR2JjZ/KWx4ZnOD2EyYgxh9ehc0Qqos
	 ZIBvBf1uaH2oH1+u2kcTRJ6fGjZN/1t5McjnFKz/4iB9BmdhudQaoSMZ30ryhMNyAk
	 9Hgyv0oaFdpCA==
Received: by pali.im (Postfix)
	id 6E29D1C97; Sat,  8 Apr 2023 15:24:05 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/8] powerpc/85xx: mpc85xx_ds: Simplify mpc85xx_exclude_device() function
Date: Sat,  8 Apr 2023 15:21:45 +0200
Message-Id: <20230408132151.8902-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408132151.8902-1-pali@kernel.org>
References: <20230408132151.8902-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Function mpc85xx_exclude_device() is installed and used only when
pci_with_uli is fsl_pci_primary. So replace check for pci_with_uli by
fsl_pci_primary in mpc85xx_exclude_device() and move pci_with_uli variable
declaration into function mpc85xx_ds_uli_init() where it is used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index ed7b71d55b10..0c905a838942 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -108,12 +108,10 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-static struct device_node *pci_with_uli;
-
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	if (hose->dn == pci_with_uli)
+	if (hose->dn == fsl_pci_primary)
 		return uli_exclude_device(hose, bus, devfn);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -124,6 +122,7 @@ static void __init mpc85xx_ds_uli_init(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *node;
+	struct device_node *pci_with_uli;
 
 	/* See if we have a ULI under the primary */
 
-- 
2.20.1

