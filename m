Return-Path: <linuxppc-dev+bounces-19636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBA5F36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:04:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kg5HwYz2yqf;
	Sat, 11 Apr 2026 18:02:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894571;
	cv=none; b=l+THTsjjYa5ktUx4VN50zxjDkfXjz46arVWmEFC0gO9pV+FJPXJHneaKQ+1cxk120NN5o3iixbb06W16S6qI4NQ20vj9FzaF2+rQZRxMevFlRjH5aoJEA11tjvUixDI0WprZONYZ5RtVSCa9Lv3g2hnk3nJ/PQBO8XIsfRIZsXMnvPDsZl0EfihYZAVC8GLBtocIGnr9gEM8gHgS2UTb3r1sx8EZY8DgpWXE+38isZuTSp8pi4kyiEQUVZdZ9Sck7q9TfW4z7cuwJbn6W6lnE/pEXGRUrPOrCwdKmL/Fus4nGZHc7DGA7r4BUq4cqZtoAF1fVYlzItUGRPGubYbVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894571; c=relaxed/relaxed;
	bh=JX8NsnGAVfFGzoN+dGA8cN96oe7c7aHrIAXzH1z998Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHGG6Zt2Knzyxbr/2OOqrRG0VFd80bHtQO3BhEJfMO/U9/PARHrPuMxOeRzf9k+2IK+ZfeWuzAu7Hf1NJfC3MH7CleCzF3f2k9U23wlrRpnoG/P7zitxkmVlsAO//Hzt2J0XM4V/hEqLwgdzUc+qNIzlBRbbf3EqDUUqc7uLLHD6fRRIK2tr7VLQXHidrdmJQ/EOLICJTrvu0i8wVQhkAmP92GKRnzOrGMEzzJ9cPXUafJqMMSyiDnZ4/wqCkZNPSfVC1DmUPbvXFfYp9MFtasryj6jaE+4+4nmgnRfs19/m7Z5WKiFbepc0ULfVNpvk8g/MKW5K72NU/mIRLi6WTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kb0avEzV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kb0avEzV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5kg1LlKz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 96AD043AA6;
	Sat, 11 Apr 2026 08:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47332C4CEF7;
	Sat, 11 Apr 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894569;
	bh=Gr3+4m6Cj77hdjiMr0OAiQ4tavCjVjkmMUYZBycpZFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kb0avEzV9ox7btRhxNy1G7gzEzelfJWiEJ9F56x+rcuE1cqzexUGOjxzBJ4YOVg2c
	 MpDB1ywE6aBdC0PvGpkhA6lNsLEfytObgJMyBVp/afL7mzo3c60vayh8ClyRk2s95U
	 1uLu6aTssGggNBfzh/R5v6ljup5C+RagRnX7oYN+ImDGdO1n3qQKdzoB4TKzUfgDIc
	 63u5K8Gy70/B8mdWiVdlwr9VUG3dcDm83owr0uX6Otkv403mb40rVZW2g88Dk78931
	 9CKg9RTGXi9aLO22p1Ghzyooa6dXg6T1Dblff+34t7FWTOSLi3fUcPnolIL2DuNhbq
	 +Vm5oTkT1rehQ==
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
Subject: [PATCH v4 16/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
Date: Sat, 11 Apr 2026 08:01:40 +0000
Message-ID: <20260411080148.471335-17-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2748000a7486..c136603ddf2c 100644
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


