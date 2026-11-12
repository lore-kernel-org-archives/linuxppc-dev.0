Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19824606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JOkt+7Vu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ5H44cwRz3bQm;
	Thu, 12 Nov 2026 14:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794453600;
	cv=none; b=JvIz2s9VBr1wYNC/uxZ/uEN8yE5kgOU+Z92uW7D/Sp+M3gOjKtHk+sHlAADiaogkF0I8bMsWYskjn+fu0S9+IJBjsy2zc4DumBlsNYDX3SQgiY2pbZIERRZ6+ebS7heaqmryesj0f7x7GkPpD9nh7307xiILTxLqNoXCCPiD9Y9iJgEXOYYMLmdalftSe05EMwMk+BfYdVLYSyYuuXtsfTIfKbOauFhvduXxSL7/lHYLDcrYR9rPjJXLBGst3odr4ltBp3ypS8gktlot9u6OqeEPnzH7mxnRXVWiQADUQWYc9W8GXCT2+6RLj2jCmss7QNgZd+h2MG+mjmMYstt9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794453600; c=relaxed/relaxed;
	bh=HAfb+6DUs0uTtEcf+iKm/8+qgjcv7Bls9H8c4BeRrAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lx+W0LvWRdKSuX2CBKtNGIyPVNxTuctBAhmbwhVZg9OklI1VMZKLkF2X5wP+gJdPv0DwQTv/JafjiEyTMqBSLj/2u1Pw0auaXdzeotmfiJLKny5uAYB/RLFx1uJqC780sS3z2yuKXzR2wUnQ9Vow5m2zcsajE6X8XgipBc6PcRQz4SGmY1gCJdPhhatgqf+ccTfevDpKXVOl65WJlHifqckYa92jKkI80eqE3561WJPFF2HaAuo5R8p8YqBsMR2u4dtquwUT5Ej1aqbf6ESLutclGS18r0NZwT7jAT92rf4s/TFZF/wkgmAXoxRKjI7O1QBHZPPti/eHBoaEIuGreA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JOkt+7Vu; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JOkt+7Vu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ5H30SV3z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 14:19:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HA
	fb+6DUs0uTtEcf+iKm/8+qgjcv7Bls9H8c4BeRrAs=; b=JOkt+7VuOdQ4lOZjPg
	pv+fQ2kLYgOKw2WyDgraRXax13C3KCcZxAUGXatDuL2WTK2rMyxNvRnFxf4i3L+I
	JxWE37LkBTTDcP9fpfcsu+SwiHxAKTkanHb/f1Syx41qFdsxXxURDY0K0dV20q4n
	1p9AFL1owHcf+KzdwoOnyrvNw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S2;
	Thu, 12 Nov 2026 11:19:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 0/2] PCI: Introduce pci_clear/set_config_dword()
Date: Thu, 12 Nov 2026 11:19:19 +0800
Message-ID: <20261112031921.1255661-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3Zr17tFykJFyUCw1fCrg_yoW8WFyUpr
	WfZryfWrW7GFySgFW7Wa12k34UWan7JrZ3GrnxK34rZr47ArW7XF9agryrCFy7GrW8Kw17
	urs7WF109w1qka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUDG5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xwz1mr1MDwi6gAA3J
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series introduces auxiliary functions for the PCI configuration space
and simplifies the read and write operations of the AER driver, reducing a
lot of repetitive code.

Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
to reduce repetitive read-modify-write sequences when modifying PCI config
space. These helpers improve code readability and maintainability.

Patch 2 refactors the PCIe AER driver to use these new helpers,
eliminating manual read-modify-write patterns and intermediate variable
in several functions. This results in cleaner and more concise code.

Changes for v5:
- Rebase onto v7.4-rc2.

Changes for v4:
- Introduce pci_clear/set_config_dword() (Lukas)

Changes for v3:
- Rebase to v6.17-rc1.
- Modify the patch commit messages.
- Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Changes for v2:
- Modify the patch commit messages.
- Add new optimizations for the functions disable_ecrc_checking,
  aer_enable_irq, and aer_disable_irq.

v4 patch:
https://patchwork.kernel.org/project/linux-pci/patch/20251101162219.12016-2-18255117159@163.com/

v3 series:
https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/

Hans Zhang (2):
  PCI: Introduce pci_clear/set_config_dword()
  PCI/AER: Use pci_clear/set_config_dword to simplify code

 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 include/linux/pci.h    | 12 ++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)


base-commit: 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
-- 
2.43.0


