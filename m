Return-Path: <linuxppc-dev+bounces-19640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B914CF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:04:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kz392nz2yr6;
	Sat, 11 Apr 2026 18:03:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894587;
	cv=none; b=OXr3sky9pcDr4XsM3fArfpG3baFQeqx+/D6x4tsQcEX1X7bqTVLjwvLlQ/2C4ApS/qIcc33MFcJA2Y1RRZylf5NGcgmemn0q7q+TVjNCkqTivn8eZq8Q3NSQP0baE7sT+eGtB7Ha6aHPSS+WjczyWhHTdwWx5MDu1OZ56N2I6ew/90TPcJirOzemj7mKEhBOUaKuqJVmyV6ECR9Sd8uHP84u7dYhYYmlvJwpv/jtPc+q4PzxA6d5f8ZaL+k34qYesRxOU5CmQ2DH4agNxT2m4izhQ6Z0vDy7xCOiVFINtUj2rs/uat1rWD9Ku9kRkF/Yvj5Gnvd79qcA4ix45K9xag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894587; c=relaxed/relaxed;
	bh=OZAfH8r7uG1n8mhzp89jGXbC2DeRaKrV8JHHz4jfe0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/IHaRpDq9c6qusqYX3VijvgCMsQ0mX0vU0XjVtc4ouJN5oRv+UbQKHT7W2JKU8mgXYVMRzH/3aLYbkn+FJfCe+VzlSwxx+AhUus7TzUQsxLuVKNhtPjzFqviuvY58dKxp8sCJ6qBC9/FkYQ2UvXs3baOVgBRaMTsKSM7ylkaQOW/ddl4+6el0EQ3KAM78PEfc7ah5pdDV5al82hFJsa//FyeTrUUgiHpLivsOFHkDXHnxq7rzOg/eBOK06nuvlHoOOgYuSW6NY+sd/wIhD5XS/a/ioHq36nGc94x6mIq/RMdd9wgWcSuvCKagEuiJmatSR+1DsNc5RCcjdlQG3CAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iX1XxyzZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iX1XxyzZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5ky5Rwrz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:03:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6CAD600AE;
	Sat, 11 Apr 2026 08:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5784DC2BCAF;
	Sat, 11 Apr 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894584;
	bh=NQbD4J4pW0nv3pRn8qOen291nD4aqRAslHLpEUCpmsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iX1XxyzZtqKzCL0ahK6AWgElhHPuPuyOHWa9d/+HOFVVKtbjE+xKwnc0JGVFFLZ8h
	 N5pvTAHpTMoIEv3ymLzCrp6eiwk0R2BHfp4FW+ZaDechXPTyPrXsxKz0wojLeRWwHz
	 BfzUV5hPFQV91mdGJ26GqPI4l+i49qltuKoVztpsspn3O0pnEfXGMKchfD9byZxVuu
	 IvuVZhg9ZGGLQ/UBAHs1emg57SVYqT0zD9nO3xLt0oMIlDHyH6M84s89QT0+GcMFQ0
	 9tL2aRe5NmkgbluWEFs/Swg9MNFhd702pNoHgCGvVbg5obXy8s4AmKhbPpxLywC5Ub
	 YN3oxfhwowR7A==
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
Subject: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory address space sizes
Date: Sat, 11 Apr 2026 08:01:44 +0000
Message-ID: <20260411080148.471335-21-kwilczynski@kernel.org>
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

Add defines for the standard PCI legacy address space sizes,
replacing the raw literals used by the legacy sysfs attributes.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6f55005f82d..6b630bac8c08 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -27,6 +27,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -1167,6 +1168,10 @@ enum {
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+/* PCI legacy I/O port and memory address space sizes. */
+#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
+#define PCI_LEGACY_MEM_SIZE	SZ_1M
+
 extern unsigned int pci_flags;
 
 static inline void pci_set_flags(int flags) { pci_flags = flags; }
-- 
2.53.0


