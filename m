Return-Path: <linuxppc-dev+bounces-19806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7683AF8D761
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnq1YmSz3bkP;
	Fri, 17 Apr 2026 04:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362527;
	cv=none; b=oVT+mdDCL0bPFyLAJTNaumBKXnCHlai5srsiIIMsmtePJWEIHQIOlfg+fypn4WzToOwxy40092hj1V1nItM1Q002od0dYoNAx0ISGySAJdq8bwV8dKLMZ3L+pg9ARfxfrFs5XBLu5JzoyqvuFGXE6jY57iSZNpOePIjplLvMEhPX+zDDLaXpJdnB7AorcHjGvE2vhZZ/w2BoUnCA/UT9SrB/nX5L+3S5eG0GTGvIH9qld17AI6j+/OngrOm38YEajKWQnTHrvqMP1y9ZudQfb4VtKMQE6lqG4TiB/J7wi+GjXAIJ5qdtr7KuIsH6sdTSWr2Vc8xH0mXkdGswyd1xdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362527; c=relaxed/relaxed;
	bh=50t5xej+gYj2UOKOdDIAO9NEv1MGtj2uiTi8WTI6wyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm804u3L039QQvqAVaIX5rfym84cxlZOWGWPFCJ3MqEf633rSHCl9cyvDk4Zrv14Ar89L8tnVTkGrdCdeY0QrvD/BZtgNGLHq92vRCt/dczPnjIJkBXNC+HUVHfGT68auAAA37Js/gikjAFoxbHsKjLKSFuqIz8QARAlYSCXGPHWSacaUNjoV04v+TNnloLmUS/eKOJAwFwWHMKiIZtz/EGIL9EzGal6UAQMhAjwsMqF9MZWAKASc8Eld/YfhxGjs2p2YntrxRIvMVyMXvu7blNRmSu0FVfZN5EI5aaFwNjwTcTfmUuGZosbbMt9tGMIrFkxJyozPNjS9HbZocSo5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAOaoPkz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAOaoPkz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnp466Yz3bjG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:02:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EFBB844463;
	Thu, 16 Apr 2026 18:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A193DC2BCB7;
	Thu, 16 Apr 2026 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362524;
	bh=hgdLCn3GR7rdEsn4XPXwIRAUu3lfUvkyKZP9W2tZ9DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAOaoPkzMh/4vHIGkCH4nNcdBBPEEUjk8XIc6w4Y1mZFUaGJrRCQnXJXFW+BikZM3
	 ps/CyoBlKt/2yjF2ApdaiQJX/xS3Kac5yH2d5G/6X7WUcVaZ7uut46gYlRiFluS8IO
	 UL4UTYJXBCinNmcwWi8NF2bqsT5JvgQ/8bIgRW7Z6Y6kZ/J+8iYqT3+vJ/zE1V5/1U
	 iMfMXasZx/VtIz1iLVPA1LJ7UIB9MrXiuDe/6lKUqkny5uea2rHW8pmZH697Cl/LDY
	 T0GKcD4FFwaLOR5wpGse0X2JFYeOFZpiPsuqKQsxtORvFpNUSZ6CGXKtjMjlBpdP8y
	 vYq9Ow+fvQ+/w==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 15/23] alpha/PCI: Remove WARN from __pci_mmap_fits()
Date: Thu, 16 Apr 2026 18:00:59 +0000
Message-ID: <20260416180107.777065-16-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
Content-Transfer-Encoding: 8bit

Remove the WARN() that fires when userspace attempts to mmap beyond
the BAR bounds.  The check still returns 0 to reject the mapping,
but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..f2ee737c588c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -48,13 +48,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int num,
 	start = vma->vm_pgoff;
 	size = ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
 
-	if (start < size && size - start >= nr)
-		return 1;
-	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on %s BAR %d "
-		"(size 0x%08lx)\n",
-		current->comm, sparse ? " sparse" : "", start, start + nr,
-		pci_name(pdev), num, size);
-	return 0;
+	return start < size && size - start >= nr;
 }
 
 /**
-- 
2.53.0


