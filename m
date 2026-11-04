Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAD606A33E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK7izhno
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXVJ5qPKz2yDs;
	Thu, 05 Nov 2026 04:28:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813336;
	cv=none; b=TqlE+lJ01rJSkD0cDbP9EnwPpC76lLCIfw1rokv1j42Mil+sx1MvIHeokNRYTafU9HApiw0NWaHE2Lm93WO9Xl0G1PtimCRtE8UCLJng5txHk/VS966hMFjke0jr2SiE7UMQvmH03eyt7Y0HebyRUVpYtKDD62PJzp6VhnskZ1etsWu4egN4zks7w7WmQWwQBFT+DfbEYrS2khuqoSihWTkeQhx+vhPh1XzI3j6wiYeavia/rcfW+SE3qTZ16tKw05AECNih9nKbG83pOIxeLXqHr3HA8b1muaJT3BhOFfad7QErXzHikMk7fK/qOJpauLi3ikwKMVZJ0LkGZ8Mi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813336; c=relaxed/relaxed;
	bh=/2uDJDXzHicGsxbsYEgaBGi/Fbf89CthmN/itDPv2fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/sbFj1u73dnCsV6yjfm6oaiupUrI3g+3aJyeUHKIZMXoapd6MC7V2vmwlAVcZ8vdnylS4d8g7JIAigN5H6Ah34onmCu6yhgVHaObaCm5m1QrShZntBzbv5mfTrcW+zNfPrXfUON1daPAOx+HL1NdGC8Alj/BKoGdG935sVw/g1adNsuG4WEFhYIbgXmgHbvpGKD30jZMohi23Wt9z+zGWMOG3sv++u+zl3zJNWuK2lLEym0KUsNNMUt0KHJNEeu2hOJfMhaodVF8W2X0BNMVoYLjHlwBBa81XlvLBQDgpTOC9M8Ys6RIGjSUvHbsdR6K6k+NwpKx/YXL4WaektQXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK7izhno; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SK7izhno;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXVJ138zz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:28:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46EDA60A7C;
	Wed,  4 Nov 2026 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C891F000C1;
	Wed,  4 Nov 2026 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813334;
	bh=/2uDJDXzHicGsxbsYEgaBGi/Fbf89CthmN/itDPv2fE=;
	h=From:To:Cc:Subject:Date;
	b=SK7izhnoe3mmurLolplKYHMvxuZJblKrGR1JL6yCVSRiW3casRTlCR/nX99F7RRR4
	 xCx/nMtQS8ZRyLJHDsA9ioaVoBmtkouKdLpsI3WJQI4y1+VqsY7Jc2fbSDk/wKuZQz
	 RG80y08RzwLUmU6699b9rum7MzzOu5RPqMUq6wIZe8MJ3QRiXaSConDF0WevG4rAiI
	 IzjlaPOadmFKvNv426Ph7YwytWPR11VYIPm2ShrfzBpuf2C/lLQM3KH0geEi3tbrYS
	 MpkSpo6D5xTRG7XXQLyy/yBX4275tvfrA8amqJjvB7M6cQW9Dh/x27LpXoHcFgKgOI
	 kNRlZRkBNbzPQ==
From: Thorsten Blum <blum@kernel.org>
To: Anatolij Gustschin <agust@denx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mpc52xx: Remove redundant 0x prefix in mpc52xx_pci_setup()
Date: Wed,  4 Nov 2026 18:28:28 +0100
Message-ID: <20261104172829.231857-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=blum@kernel.org; h=from:subject; bh=i2d7EHLyCvvfJEHd6m6HmC1jX0Sr9JHbihHcAYB3m5E=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvs23D+kONOSq1v6ydlRg9YdIbV77NqW9YKzh4HFleZ Py2SOzsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIkY3GJk2Ptzfp7HLJuktCin k08SOjNsYxxsn036f0t+Wq7iRu+9tgz/Uz/I3jxioCScVcMtfq5h/eGmHe/X7W5cHqN0XuRmi8M 9JgA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefix to avoid printing 0x0x.

Fixes: 59510820fff7 ("powerpc/mpc52xx: Fix some pr_debug() issues")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 0ca4401ba781..a2e53cacd15b 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -288,7 +288,7 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 		printk(KERN_ERR "%s: Didn't find IO resources\n", __FILE__);
 		return;
 	}
-	pr_debug(".io_resource = %pr .io_base_phys=0x%pa\n",
+	pr_debug(".io_resource = %pr .io_base_phys=%pa\n",
 		 res, &hose->io_base_phys);
 	out_be32(&pci_regs->iw2btar,
 	         MPC52xx_PCI_IWBTAR_TRANSLATION(hose->io_base_phys,

