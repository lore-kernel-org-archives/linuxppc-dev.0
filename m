Return-Path: <linuxppc-dev+bounces-19519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2924810F995A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:08:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frTz12Yxwz2yqc;
	Thu, 09 Apr 2026 03:07:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775668077;
	cv=none; b=EcsdclSb9hJWpn3iYZ3AkfqvVO5YJ1QcWBCQLaqdE6eB/ymYcwISeW4Vn04s0+gjnZ9ZOC0f5o7qtfIEsouaVjA3hsGyTZudXvsOsETakrwpQXsR4AyUtJDxOErrHBrZhCNAoRm6JDyEeMOCWCRr09n5I+ogZmZtH3EeM9uuKIhTfcmhcIscQDYgNtsg1RrlRmEKlfJuLoCEAG3pTV2uk9K8nCGUZy2osnMhCrHklJLfwd3Mrj6wmX20/j1P6CVfroz/8b1i+Mq/A65TxEF/Z4rQekhci3dPgNzBS5mz8f0xKZsJemxgnPNvjDV3lwmwIGTs23Zb7oOlXvHkh7Tt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775668077; c=relaxed/relaxed;
	bh=n5i1Z6W1lrl7Jr/Et6Yrvdu3p0errLMiY3a9xAeRUcA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cKf35ieo/0pjCdd1fgjxCw3+UnAr5iFE8Ysr1ZE/HV3o0hkqutQogb+96ieaz0UKhEmNYgec8HR5TnjCcIulsMXSGgeePttORhLBu5CCrqnsOl4LMTBzGy8+OF7Ca9rOngDwin8yn7BnCy+BrIg2uRni2EPzFpCn4k8einwCczoY4Jaoif7wtOpqiCbrV9T5h+G9eF25niNIA5qo9ScO8GxBgxus9wEwZejzZLhkdFVWzEWMWn8/KdKNBOxMfhkbvbqvSfq/janosr0NEUgsB0LHB6Q4LmPyGmz0rVHQ9d9uoGjY9K07S47rND/8K+DcpgxuuC2IBSsjaeNoB3hAow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ju7yLbI5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ju7yLbI5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frTyw5bDkz2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 03:07:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8257A6011F;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F438C19421;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668069;
	bh=/V2YOh5dun+k/7gXehbcIbYcHTsZqq3ru5OdAAq4JmM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ju7yLbI5yeQ/hhmR7cx/t5N99/R8XvSyfYmVQb4Pj1VDyXwi8l1IdDzyhVmW8Wf/g
	 fV0Pu1mhKtWWtnIdgi7iyKHdycmyHgd1+iIvPsfu8FMrYWs0oTZDV5FEzF4YBmPvRe
	 WGjy9RxiUYllEQzjWlhursZcyopsYJNqbfmzvrknhTw+MZh1zmMplw8fi2+9Lhmvgv
	 BB51I0E56b03esTviAiUwutNSxu63s23k3HTY/tw2CgTHnfKJ+txDlg1mrRJRVnVwj
	 0RELnJHM02PVuq157FSgDArjqZrekWSYHVscNppe14YiR7TWmMgxvZEbWkGPVdHJf1
	 Ks5GNa6Lk+rvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4FE10F995E;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Subject: [PATCH 0/5] ibmvfc: make ibmvfc support FPIN messages
Date: Wed, 08 Apr 2026 12:07:41 -0500
Message-Id: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB2IQSv1KuIiP5N2Co0hoyKId
 ze1y2/x3gFCmUlgqA7ItLHwHAuaugL3NvFFyL4YtNIP1aoe2X634DAkjihrSnNe0D5t13fOa28
 aKGXKFHi/r+P0t6z2Q275reA8L2blqjx3AAAA
X-Change-ID: 20260407-ibmvfc-fpin-support-b9b575cd2da1
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775668068; l=2115;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=/V2YOh5dun+k/7gXehbcIbYcHTsZqq3ru5OdAAq4JmM=;
 b=Mr24O9zSJQyULVQH6pUlEtKtf3Ixdd5fISCF3k9bRs8Nd14sBiYHWx9RAd7MDndQVe75RHmY2
 O98bO8dMcP+DgCdPydXjIZMA/eTM13TMjvoBlFd7t4Hk/Vc0mtxQKa+
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

This patch series adds FPIN (fabric performance impact notification)
support to the ibmvfc (IBM Virtual Fibre Channel) driver. This comes
in three flavors:

- basic, to recognize existing FPIN messages from the virtual I/O
  server (VIOS) (patch 1)
- full, supporting additional information and using its own
  asynchronous sub-queue and interrupt (patches 2-4)
- extended, supporting FC-LS-5 (patch 5)

Full and extended FPIN support requires a new asynchronous sub-queue
with its own interrupt. The asynchronous sub-queue support requires
ibmvfc to also support

- a new VFC_NOOP command, which the driver recognizes and
  ignores (patch 2)
- fabric login, to login separately to the fabric through messages
  exchanged with VIOS rather than doing fabric login through the
  existing NPIV login (patch 3)

All three modes convert an incoming FPIN message from VIOS to an FC
extended link service message, with basic and full FPIN support using
default values for information not provided by the VIOS FPIN message
but expected in the FC ELS message. This FC ELS message is passed to
fc_host_rcv_fpin for updating statistics and sending the information
upstream by netlink multicast, where it may be caught by listeners
including the DM multipath daemon "multipathd."

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
Dave Marquardt (5):
      ibmvfc: add basic FPIN support
      ibmvfc: Add NOOP command support
      ibmvfc: make ibmvfc login to fabric
      ibmvfc: use async sub-queue for FPIN messages
      ibmvfc: handle extended FPIN events

 drivers/scsi/Kconfig                 |  10 +
 drivers/scsi/ibmvscsi/Makefile       |   1 +
 drivers/scsi/ibmvscsi/ibmvfc.c       | 668 +++++++++++++++++++++++++++++++++--
 drivers/scsi/ibmvscsi/ibmvfc.h       | 102 +++++-
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 219 ++++++++++++
 5 files changed, 961 insertions(+), 39 deletions(-)
---
base-commit: 927722dcfe0a5294433bb087387cc52a46cbf675
change-id: 20260407-ibmvfc-fpin-support-b9b575cd2da1

Best regards,
--  
Dave Marquardt <davemarq@linux.ibm.com>



