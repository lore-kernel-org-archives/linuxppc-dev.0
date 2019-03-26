Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B56C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:27:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB8020823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHvJtvyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB8020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TJ3W5d4XzDqQX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 04:27:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHvJtvyJ"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44THzg014tzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 04:23:55 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id c16so12229022otn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=POhWQIt+7MKKaB0xpr8RCC2Gi7vnEhrJDayyqfFtsbU=;
 b=JHvJtvyJPNSo+HDI3O7LUbgFSAoKWqiK3xAPrdEDOHPmAjIxTX8HdIgpu5kRLeTYmG
 D2ic5C23vN3pW7Bv3LMc1JMFV48cFhW850dIIrA+t8tO3t0Rh2MJ7D6EnJHRWz52o2M6
 HrOC9eDL5XDADZCU+UX42MHeImCYJMqWbzTCR5P1ZT71eLBmRfrFX+iCW2kpflatDeNz
 5nEx6raxwOSBU5+OQOI/WxTChZxGdUTcoiIJFo/0fwLfIXwSb+h1hYxTal7y6MFkMLzd
 x4qig8zmA/8PrYol34fPVvhv7SoAEB18tnbojWbrAw8U20QcG/aOxkU8l+4U4VuHJAZM
 a5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=POhWQIt+7MKKaB0xpr8RCC2Gi7vnEhrJDayyqfFtsbU=;
 b=p+QrP0Q/H9hlECYEoaOr3Czn/6oE8K/9uBUb0wPoYYKlEKQKOhdVMy0glCrwgSabqf
 lVSWQT78EHANmMpv/QxWNofwgxBTo6a+RZKttGE2tJkZFtyFLGh2YPhfzD3aWZgp8Rds
 eT58bhuB1lXJ/pIsrUR1cEywlbqFHcOqZx4B9EC/xyl8HtBeCijm7uEP0G6YUOpkY+YY
 7DVMlHUt2hj9sW0SxAJxUwlYGG0UdpRBPjK4WuS/O7BMO5DGQY3W3M9Tnx6zUVTvFAeQ
 q64tdrIx3xd4UXb/OvIg/02q056EhtVrSiDTIo1EhEr6YGNUdU+ZuHuochrSzhpeCZh9
 8K1Q==
X-Gm-Message-State: APjAAAX551CFqDUTXJ4K7jqqPSboofOrlVRmnaQlDQR1uwAZauHk76MU
 5PPc3Nj8i47dqWXvmZZYTxs=
X-Google-Smtp-Source: APXvYqxV49KQ0KIVmX2RkMEowFct5KcJJEg8z5my4fLysNPQXWdjr4S/z3f64Wxu3k1PqZri9cA2MQ==
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr23703768otl.276.1553621032105; 
 Tue, 26 Mar 2019 10:23:52 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id z12sm3047459otp.2.2019.03.26.10.23.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 10:23:51 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Subject: [PATCH v2 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Tue, 26 Mar 2019 12:23:40 -0500
Message-Id: <20190326172343.28946-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
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
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shyam_Iyer@Dell.com, okaya@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, keith.busch@intel.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de, leo.duran@amd.com,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, scott.faasse@hpe.com,
 Oliver O'Halloran <oohall@gmail.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This started as a nudge from Keith, who pointed out that it doesn't make sense
to disable AER services when only one device has a FIRMWARE_FIRST HEST.

I won't re-phrase the points in the original patch [1]. The patch started a
long discussion in the ACPI Software Working Group (ASWG). The nearly unanimous
conclusion is that my original interpretation is correct.

I'd like to quote one of the tables that was produced as part of that
conversation:

(_OSC AER Control, HEST AER Structure FFS) = (0, 0)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.


(_OSC AER Control, HEST AER Structure FFS) = (0, 1)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM is being given guidance that Firmware is handling AER errors and
	  those interrupts are routed to the platform. Firmware may pass along
	  error information via GHES


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.

(_OSC AER Control, HEST AER Structure FFS) = (1, 0)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that AER errors will interrupt the OS
	  directly and that the OS is expected to handle all AER capability
	  structure read/clears for the devices with this attribute (or all if
	  the Global Bit is set.)

(_OSC AER Control, HEST AER Structure FFS) = (1, 1)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that although OS is in control of AER
	  read/writes – the actual interrupt is being routed to the platform
	  first.
	* Subsequent fields with masks/enables should be performed by the OS
	  during initialization on behalf of firmware. These are to be honoured
	  in this mode because with FF, the firmware needs to be able to handle
	  the errors it expects and not be given errors it was not expecting to
	  handle.
	* Firmware may pass along error information via GHES, or generate an OS
	  interrupt and allow the OS to interrogate AER status directly via the
	  AER capability structures.


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM has no guidance from the platform and is in complete control of
	  AER error handling.


There may be one caveat. Someone mentioned in the original discussions that
there may exist machines which make the assumption that HEST is authoritative,
but did not identify any such machine. We should keep in mind that they may
require a quirk.

Alex


[1] https://lkml.org/lkml/2018/11/16/202

Changes since v1:
 * Started 6-month conversation in ASWG
 * Re-phrased commit message to reflect some of the points in ASWG discussion

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.19.2

