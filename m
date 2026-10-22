Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD90606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=bdIJRJhL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9XRh0Pfqz2y7W;
	Fri, 23 Oct 2026 03:58:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792688335;
	cv=none; b=fakv0Er0swPzSV603EZw6QYi8BpcRyx9EPmU9kT96tsLVFmmv9CpXq0Mf85xow8QL+7VhglVTEZtjMJlQ2STMlhwg4Hc9wtLG5NaMzBU4ojxWdT4nGNUb0jrcX8QzkXAHzUQG99b8OipKnm4a1j3wRq0Vh56fFWvlaJ9dw0Hb0kuLPHiwSeVbRVMY4crgEuqwgCYMZpnfFSBpIb6NvLfpq6v+RqVEY+ci1CbAG3rA728dKNBSXK5kl91D64Npg/PvLszgXWPhV8LeuEtP5JUdM4JD86ltZQleCDAEwUnZEqKYEE54JW0JhoiSD+wph7lYLzqtYUfyKYZOhhUd3b1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792688335; c=relaxed/relaxed;
	bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krxfUu5Wrc/mgoRwkWlIVNYU9z3SBfbOpB7FcqRvAOy5yFSPIrjgrQVuFI0+8A/w435K0ajTSfPdxUD4pW0QOr7DjONfdmH9GKZzr3NdjvByJlK61uvXxtC//Mjc63lTqIpb06M5+MQlnjGSjA1KGMPLr2l/YV6BzFI9NVI5Jn4bZ9OdsSKbq7lo/qTXvPHRpv8z9os2N7w/NdIsGoqaGGQKAjZvUyZdCXej2fZjEPH7yvJPw75j11mly2xLVxFhmtQyyp1o/tzkjdeXAFaI/9HdC1M62mmkA1njGxwc/Gyr4xjy0lPAUpicJ6vK5WS9/etUhSk+87s+Yk7WhhEiUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=bdIJRJhL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=bdIJRJhL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9XRf6d0zz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:58:53 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1931ff67a29so2702794c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688330; x=1793293130; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=bdIJRJhLTGBBuGNCT4agzosX+gJXkNbpPdzlLkqK9JJ0YfMTMrr5EkJT+i9+KRzp5/
         Jcn+Sr9fGregwI18QhvOu2QFs2za4vGx5AKRIyHW5d9taPmOeaMoyiWSXSMQDShOEChP
         Gmj02S07lEXCC6Ovz14VRfDoCcDAcGulg3gkblWAwYOexvp5r3IBFETZEZrCflkzmnIz
         h7lvztn6nUjRyX/v0N9Qa9dMRxIm2zPW8aBulOla273v0vc1OCBZOXgbQoraQcpvhoAa
         oM7Kk6/a4N4STCW1/OUqonbATdWiQrNCKJxiUGJ+tPMNJvHP5Unu1KydIJTdUvcdSqxi
         emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688330; x=1793293130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=uxAqcXaQuDOHjQNRniSIm/RLuDYH5oKXsDFbZ4T38zQDe3+ACCEMbRktKTQiNqw7bH
         Ut00p9E7aBupnzd0DDTuy/oTLQ7VFwyGPUvXUEuh+86zKFqRvXLuqAAiUlqw9K7irIPP
         iurd2L5iTrdnDp2vM39oJA0SYgWSXdpQuhEz0sQ0CAFHWv11bn+28cd7eOwCmaxyaSzX
         3k2LkpAW8NRauk6FDW9CrKPp77G7MFHgcuB/1SUy/N8Df4xZkju8HWQpamClcCk0TeP3
         SldlZwP1sJf5aJx8esWTqtIMF2QeydXCKzTgs/oP1cPXDhVcJiNTdrnY4LlK68+/xvUG
         RqTA==
X-Forwarded-Encrypted: i=1; AKwUvBwhEAM0mDkQxGWzCBv0jeeRanB83dSAVYjME0/NXLgqHQUbZxzLk2DU+gDIoyuccKshMuQvjEYvX6kO1vo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJZn2Bt4wTzNH8dbM7VoclZOAHFvs641OKuvab9/Z5XcNK9yPXJ
	l/GvRSLwVQhJPNbkZnWqVztJxq5nfNDww/Pe0yb/sFu9ejgR5afs6K9BfHr24Xm+0g==
X-Gm-Gg: AYBFou3jb3vA+/OngW5RbZFtxZAW19e/e1LTAmeMwBot69DVHMJfNgPW4Ad90lfyb8a
	gtK5LsBMNDGeGLNERSO49UNkpLTTnj9noLJvL2nnCJlZdnp4xBlzEAhEKND6kRfjpg3fW0T3I64
	4MA58W6NZ90HgNIVSXe+tRXT8vopUzeDvwziAC7WReFVd/jcKyTVXIMO43BRER1LL5oM2Pw8oIw
	C5HyKfrjJUFLAhDAhADE4o9NSPQafpJnzikMydZrAMd35IDQkohKb8bVSPDJXhbeOkN06LKSQpy
	EYDlYYw9dwwg2/9K3JRr2vRhtpbgXRpZHvjvxNnU3Cu4QMalH5cs3Upi+GaP0rsIwzy7fZ/1QFk
	pFSHHQiQeMmJNM6BUoVl4wTs+/ajK48Md2hgeUI5uJ+bUfoOu6gOfHWvus+ngxu0UhfJcSy/4CT
	kHIm+68X+gTvFX4YQz6XI41Q2eKuSjI6dz6MVmUTRdnWpYBEScABjLeARTWxLdyVpj+QOr+GVhR
	CBEg/hd8O1gV5gEGgBAbDA4YJzf7H64dmH078TBvkp4avZtfzIZwpgQunqRL5K3OotZb+ydKptK
	XPduGA+nJQeGprWZOY2S+ur4GvxthNKOMoI=
X-Received: by 2002:a05:7023:a81:b0:168:3243:c911 with SMTP id a92af1059eb24-195a0effa19mr34185c88.37.1792688329950;
        Thu, 22 Oct 2026 09:58:49 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:48 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/2] PCI: Add boot options to disable DPC and AER recovery
Date: Thu, 22 Oct 2026 16:58:40 +0000
Message-ID: <20261022165842.1463451-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery and to
opt out of Linux DPC and EDR support.

This series adds two PCI kernel boot options:

  pci=noaer_recovery  - Retain AER logging and correctable handling, but
                       skip uncorrectable AER recovery, including CXL RCH
                       callbacks and recovery of GHES-reported errors.
  pci=nodpc          - Disable Linux DPC and EDR participation, including
                       ACPI negotiation and EDR's DPC-enabling _DSM call.

Firmware-owned DPC settings and firmware error recovery remain under
firmware control. The two options can be selected independently.

Changes in v3:
  - Patch 1: Check the recovery option before dispatching CXL RCH and
    ordinary PCIe errors, addressing the CXL callback bypass.
  - Patch 1: Preserve current GHES cleanup and device-reference release.
  - Patch 2: Add pci_dpc_available() and use it for DPC services, ACPI
    DPC/EDR negotiation, and EDR notifier installation/removal.
  - Patch 2: Skip the entire EDR registration path before its enabling
    _DSM, and prevent native-port overrides from defeating nodpc.
  - Clarify the Linux-only scope and rebase onto the PCI next branch.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-1-yurypm@arista.com/
AER review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/
DPC review: https://lore.kernel.org/linux-pci/20260709190730.E19A11F000E9@smtp.kernel.org/

Yury Murashka (2):
  PCI: Add pci=noaer_recovery kernel boot option
  PCI: Add pci=nodpc kernel boot option

 .../admin-guide/kernel-parameters.txt         |  9 +++++++
 drivers/acpi/pci_root.c                       |  9 +++++--
 drivers/pci/pci.c                             |  4 ++++
 drivers/pci/pci.h                             |  4 ++++
 drivers/pci/pcie/aer.c                        | 13 ++++++++--
 drivers/pci/pcie/dpc.c                        | 24 ++++++++++++++++---
 drivers/pci/pcie/edr.c                        |  5 +++-
 drivers/pci/pcie/portdrv.c                    |  3 ++-
 include/linux/pci.h                           |  6 +++++
 9 files changed, 68 insertions(+), 9 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
-- 
2.51.0


