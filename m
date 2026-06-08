Return-Path: <linuxppc-dev+bounces-22282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C509CD8CAA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 18:30:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ0w51zFKz3bpM;
	Tue, 09 Jun 2026 04:30:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780943429;
	cv=none; b=KfILMXXDiiVPt7l4lSYsFmiIxso+P8OWG8AnTPyNO472RHQkWfqqWASvFhMx1QdKeQ+iybsapuUBaUf/zODrwFf1q6C4nWmzQixu96jiyD5bOSh9VviQvndDRONeFYJ90UgOdksVh4Id0DrEdPRFuIb0KWz+mD15R/0N7R4hY5QSbYnbvX7hgRO6yZPiT3kWLmrzqg1KHj89odfFytlWnuldGqpU4MSnQcjvoBRJiyoY+PV5QONrVllhPc5vN/dy/CNungDpMp7vMsO2fdXSHwn/dFIj9i07DDvz8bHf0OwWnZ42Nb/lU0rIXTRJEFAoEP/WxwyvxsgkIhH8zhbKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780943429; c=relaxed/relaxed;
	bh=ibOJsmeetxneCCmHjtQ2z4z1O26vRkcyIhyw0AR3RK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eGDquc+rtmAB6LRGEhG3u2QPfeNqJKnQKeIFWnw/etjg2d3olmqTJ2UkfJmMhcaMKFmVkincuOVgR9+3IPTZja7QOEsFzXexywg5n5HhkbrDZ9VaqgC2rbEI9x5ZsoQKJcEYCzT+M3SXYkOiVpPdkGShS/2Z1miVeJVwDF+RPLlShJnvi0jFIw3lcl0Dz2+T7ytdZlI+IM/sVcQ2ORHIywUu/94YD8bAJyWIFDEfmOKoFGZE/n+FcFNwN/D1IMGNpOcItM0I+eeSOipruR5Sl9fLsYhWyRlb5HizSxyKgwHg+QgeJ+7Tr1kLCOog4jNyVf//CZH++wTu7hHWHG59jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DpYsLPAL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DpYsLPAL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ0w33HhGz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:30:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E89266001D;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92129C2BCB0;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780943424;
	bh=J3P8PaXY5CoSjNA0JOjl8vRTZuBEuNAjiD7JhDeH99w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DpYsLPAL147/ebuU8YMTJhIxF4wvYCY3gGyzgp7jDHl7OmmuVWrAqbQrRnDzU/OOh
	 ndGb9Uhw9HgHp6VayXryr3FdNPsWcEFWmsEHbXr3K2wGnWTl9EGPcmkddwpmmN3FAO
	 LhxJ4W2C/KyEgD2zzoRdBGpO/v7QnBwKfXSk8xhL7LbBTXSI6GtnKzJ057REQuMxe5
	 4ur9kSawMjBI3cRfNRHEfnKyZ5hjWVphS66FUC6XdFW9JcgpMOhMCCjjSI+GdumKax
	 X9yMgVrytG61u6WtmYJuO7j2tfV9ZUnx70S9+ElwSCtgSQtma50qWJF6VjhaHFzE1o
	 MFh3KF6Jkv7pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B131CD8CA4;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Subject: [PATCH v2 0/7] ibmvfc: make ibmvfc support FPIN messages
Date: Mon, 08 Jun 2026 13:30:15 -0500
Message-Id: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07ZBSeSgr/8OwoGWQMdI2LTQYw
 r9bMO5cnuTce1bm0RF6VicrcxjIk9ERxClhamj1A4G6yExwUfKcV0ByDL2C3pIGP1tr3ATyKou
 qUJ3o2ozFpXXY03K83psv+1k+UU371W4M5Cfj3kc2ZLv3K1z+FkIGHAoheanyMkd+vr1Iz0sa3
 VSZkTXbtn0A7C2mbMwAAAA=
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780943423; l=2924;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=J3P8PaXY5CoSjNA0JOjl8vRTZuBEuNAjiD7JhDeH99w=;
 b=ch7/CuTmFOEX67sgh/nBE/X2ceGQE0k5/cyLDlk3wYbeCtqE4gzWGLaUPYy6U90DiHRAtYk9w
 rx0xRRlMYJjAK9lWQ418pE9H28P09jprADqOcsrcOPtwm9U1aRYoBu/
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
- full, supporting additional FPIN information and using its own
  asynchronous sub-queue and interrupt (patches 6)
- extended, supporting FC-LS-5 (patch 7)

Full and extended FPIN support requires a new asynchronous sub-queue
with its own interrupt. The asynchronous sub-queue support requires
ibmvfc to also support

- a new VFC_NOOP command, which the driver recognizes and
  ignores (patch 2)
- fabric login, to login separately to the fabric through messages
  exchanged with VIOS rather than doing fabric login through the
  existing NPIV login (patch 3)
- defining the asynchronous sub-queue CRQ (patch 4)
- allocating the asynchronous sub-queue (patch 5)
- register and use the  asynchronous sub-queue (patch 6)

All three modes convert an incoming FPIN message from VIOS to an FC
extended link service message, in some cases using default values for
information not provided by the VIOS FPIN message but expected in the
FC ELS message. This FC ELS message is passed to fc_host_rcv_fpin for
updating statistics and sending the information upstream by netlink
multicast, where it may be read by listeners including the DM
multipath daemon "multipathd."

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
Highlights of changes in v2:
- Refactored mostly common FPIN conversion routines and async event
  processing into single routines with wrappers for differences.
- Moved FPIN processing to a work queue to avoid conflicts with
  fc_host_fpin_rcv and memory allocation
- Set descriptor sizes correctly
- Use target WWPN for basic FPIN descriptor
- Split patch 4 into 3 patches, for definition, allocation, and use of
  the asynchronous sub-queue for events
- Link to v1: https://patch.msgid.link/20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com

---
Dave Marquardt (7):
      ibmvfc: add basic FPIN support
      ibmvfc: Add NOOP command support
      ibmvfc: make ibmvfc login to fabric
      ibmvfc: define asynchronous sub-queue
      ibmvfc: allocate asynchronous sub-queue
      ibmvfc: register and use asynchronous sub-queue
      ibmvfc: handle extended FPIN events

 drivers/scsi/Kconfig                 |  10 +
 drivers/scsi/ibmvscsi/Makefile       |   1 +
 drivers/scsi/ibmvscsi/ibmvfc.c       | 702 ++++++++++++++++++++++++++++++++---
 drivers/scsi/ibmvscsi/ibmvfc.h       |  94 ++++-
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 243 ++++++++++++
 5 files changed, 992 insertions(+), 58 deletions(-)
---
base-commit: 0600eec09ad6cc5ba3ca78aceb6fa8dcbad010bb
change-id: 20260407-ibmvfc-fpin-support-b9b575cd2da1

Best regards,
--  
Dave Marquardt <davemarq@linux.ibm.com>



