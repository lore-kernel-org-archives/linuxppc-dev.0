Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD956C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:30:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2655F20869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsamsSTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2655F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wyKX75WrzF3h5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:30:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsamsSTG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsamsSTG"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wy0j3P2BzF3gX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 10:16:18 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id i20so13211277otl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 15:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Endo/rnyrZtQzjl63XIlDlk+0dMOEvUstgeXnyJyS2g=;
 b=KsamsSTGaj7EBVUbAIZgS9T7QGovy1ECRb9FIS9XU9sUYyBGhXoNh1Dxv+3p9Vb+MC
 rBge74EsJgxU7dSbXROotH6geTkJ8i/KZyLd3HwVJonemqEDH1Ziqo+AU/h6Zm0vrxph
 RGu/QdFcCc1SZwwYyNe80U3qp+gnfzF74r6n4yfrtwob7Wwep+SvBwBID8N+meev7cUK
 NskWGA+n2lJQgl3rgu0ky2Vk1x3UmPO5s5yzC6uPNYnAeSE+27jgCl0erJwC8bIZgO5k
 VjLuY1jTSF94wyopm5l0Tlxu76snt9z4RT5ZRK3DpuWe2USlEDYlqdLJdWo4D2LCrIy0
 MW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Endo/rnyrZtQzjl63XIlDlk+0dMOEvUstgeXnyJyS2g=;
 b=aYg8fdZf0TNeqBI1oGfg7AP3BVOob2re+8/m/QFdYulKqL1MPIQVf/8Ku20cnD3G4v
 hUnokTsQxU+hcW45vU5M/bkkZXIOE9cLwRELSo09Nw7imk8xm4+EHTjvgxSyj8/e2F9+
 SJCpXJLn9jjNCHpGcCaEA1OQtLZcxrThFxgw8I3FIzHhypck/EZsfVtPpRdm7yJ7ovdE
 bTyxCRNGhQUfkO3a17k2D/c6wB0TBIMLb6kSe+OsBhQP+OiV+SFNByqIiQpaUJdMAhFi
 /m6rOoyJoWisNYrqGUJvZZpc9quTBpPfH9M8tL/l6GX1hpQR6nGcLDs3RAiDmKA9yw86
 zpQA==
X-Gm-Message-State: AGRZ1gLd7HdygCe4qfkfaDaespS25fd7koNRlfYbVugo+xZqcbi3nOSR
 AmVKkheg1PeC5/ZsJ9+Ek2w=
X-Google-Smtp-Source: AJdET5frJbOEeY/44Q01Ar6ekmvTcypP0TiJnoI3eU4fo6IOIeyweFzux9/jZ+VI6V2Avp76imE1ow==
X-Received: by 2002:a9d:2aea:: with SMTP id e97mr5094109otb.206.1542323775740; 
 Thu, 15 Nov 2018 15:16:15 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 15 Nov 2018 15:16:15 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: helgaas@google.com
Subject: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
Date: Thu, 15 Nov 2018 17:16:01 -0600
Message-Id: <20181115231605.24352-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 16 Nov 2018 10:26:13 +1100
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
 linux-pci@vger.kernel.org, Shyam_Iyer@Dell.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks to Keith for pointing out that it doesn't make sense to disable
AER services when only one device has a FIRMWARE_FIRST HEST.

AER ownership is an interesting issue brought in by FFS (firmware-first)
model. In a nutshell if FFS handles AER, then OS should not touch any
of the AER bits. FW might set things up so that it receives AER
notifications via SMI. It's theoretically possible to receive SCIs,
but the exact mechanism is platform-dependent. OS touching AER bits
when firmware owns them may interfere with these notifications.

The ACPI mechanism for negotiating control of AER is _OSC, and is
described in detail in ACPI 6.2 Ch. 6.2.11.3. _OSC is negotiated at
the root bus level. Any root port, switch, or endpoint under the bus
would have its AER ownership negotiated in one _OSC call.

Then there is HEST, which is part of ACPI Platform Error Interfaces
(APEI). HEST tables describe the errors that FW may report to the OS.
A types 6,7 and 7 HEST tables describe AER errors from PCIe devices.
As part of this description, we're told if the error source is FFS.

Information in HEST seems to be redundant, as each error reported by
FW will have a CPER table that describes it in detail.

Because HEST describes an error source as firmware-first or not, we've
taken this to mean ownership of AER. Because AER ownership and error
reporting are coupled, _OSC and HEST usually agree on the matter of
ownership. However, that doesn't seem to be required by ACPI.

I've asked around a few people at Dell and they unanimously agree that
_OSC is the correct way to determine ownership of AER. In linux, we
use the result of _OSC to enable AER services, but we use HEST to
determine AER ownership. That's inconsistent. This series drops the
use of HEST in favor of _OSC.

[1] https://lkml.org/lkml/2018/11/15/62

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.17.1

