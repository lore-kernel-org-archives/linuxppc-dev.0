Return-Path: <linuxppc-dev+bounces-17331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18490FD9E34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:17:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMdQT2kkwz2xMt;
	Fri, 27 Feb 2026 17:17:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772173025;
	cv=none; b=IV1NP5oVbfoW1ty2uV/UIOrEJxwoag/9UxjHC94zqXhWu8Yb9uesoewnR4SAO8o/OCjzKXiLqac6KGZUQIUNKFLVClVrHVQSl8pwnpuhyXZAjs1Yy/1u3DJ1wqAO+G7OgrzMMG98tQzD3df2GjqrsyK9sV9voz7cLP8oclMA6IJ41REqSS4UqdQyZrsYDn7HhBfAgnv7PHAntlp8/XUaGvBWdm+FLBTJLXsPP2oOCX0F38yce4Ys7OVicaQN17g/PP+zRKlyTpSBXmsVKfeLPxanMOUoZ0FHVYgtvL3RPJ4kutA7J+NzgXYwaM+MN7WhM75X0z/y04b7ad3lPOIV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772173025; c=relaxed/relaxed;
	bh=TBQTSZoZ8QpZw8gStM3hrWmhO0sM5dIUkdb0CVPsHZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdCG1EzofVYu7Kb4mSgzx6AUrEMrWASZPoNUbZf5WcuO5ynxLl0SOWv8TBbce+FFxd3CzOvYlZo8kWl6XMLVYp6SvwtOPzIt2ooBG8lc8O/v2H7tqz5GBGyxtv3Qkydo90O/k4sqDB1UY2Rztu0reEk0Dkx7SyhSvm4Q4sT16+NMKRzTEDYQAO0TavI0TJP2Oct5+56It+4bP//8BzFHYUJyVVAiGjX0EtyOMsp+/6H+lndbY5xLDMLz1aFkEQSd2w053gjip2KIUGJACIAu4SZGrNT2iP7SkfaLiDt7mttBq3O11956YpQgWaH75d4MVm+BM3vP7y6fZQWx3HmoJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BAxx+qsO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BAxx+qsO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMdQS0p54z2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:17:04 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2a962230847so16062865ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 22:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173016; x=1772777816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBQTSZoZ8QpZw8gStM3hrWmhO0sM5dIUkdb0CVPsHZ4=;
        b=BAxx+qsO5NJi/taj0ashj77/VpzHItHoCQAeVyDhcQFg2L33iK/n/1x8qxCGD+SENn
         T2hou9vB330fD9gmZXm6ooy4GQQMs6uTEJ4tLtJLCUE6g9W7NU9aYLfwsBSOuLo6X13Z
         Q/dl94stypVG2ZZ/SrzX0V+bjAVYf/BWwR6xZm0cPpacQ7ZCDFU6drRQY1w6l9RJ5bnS
         Wfn9Jo3V8M7/uxNBGQepHUFKJV711LBvFtuhstHZiYqwLF9Rfsp2uwdD6IIYx2snZW05
         7AZN5DSA4QtlH0CY19xnUsfssGoor/CFlMiwHzymzPaOzS4VwOZlsnkWOrdjTmaS+czu
         dHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173016; x=1772777816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBQTSZoZ8QpZw8gStM3hrWmhO0sM5dIUkdb0CVPsHZ4=;
        b=VAUqiPboem79G8NYTxKVRLtO5S6UF0ubWXwrgPP69uW8NSY/5vqV/x8GywkeScPJ55
         tjAdx24UcfNcFjKPw02WC8WyfsQu7POpU1H4NSk6zsg1fSF3u2zgIM/wWUgM6ca6BNo0
         ugDMUMs4BGZjlmqom3P74BnrY/byZM+DCnA6UqYVHD1lA/L1cZI66pXziD2t55na4Wzk
         YwLEmUXlmvk2uAawsnEVOgo/JL0OZKPiWEXQ7u4GqkIRWTuBOSruEAAg9d9rivPr8Iej
         QsaGwofZFwuo0RhxZOYbaHCNf67/FPl8aD8xGpG/CfkWaoUqOGLDG+KN1NEpkBK0WQNk
         q1nw==
X-Gm-Message-State: AOJu0YwkhxHnKp6oEzX6ZTDIGu+fhtlUUGJJfK4crI+K++gtIe+knhzC
	ubLtAc/NhSZb75BiyvJ1CodDQi0mblfdY28HN28HeC6iofQ4uWjsW8Z8FO9plkDb
X-Gm-Gg: ATEYQzwSSGfv0TTD4O+cqCE3n5YsKBDfrb9WKrEjGA1OzzRHVSm000OhHiGOwJk5pDk
	JyMsm8ruEEY5O+pscMJRpmcr868MECumb/s08xuCGSgAOr227ggvgEho2r1Y99FdetEjdwq5rTV
	MP9RqtUKXk7wFMyyWU59Ko05npi5M7jxgXN8b4x4flxzWSfGNTUt8hnHeiXclztrLBzIE8PCY5H
	N+yhwUcKaAf3t+MsKM5ndo9Dgdt45FYCbLM0jfHei/JiAda+5HG4CXQiN4lHJGe4ayWZoRr/ras
	ex6Q3RRBo4b0oZGf6hue7NJnkI5tAfW+RcurRrZoJpRtkEdjUqAd47xGXxPa4GPChhNg6N3ls6K
	Q0aKgRaptlAz+PKNzvtEuayCdgs2mSCH3qAuvOw8eMkm+dOEqbek9Iub7reRkNpLNfQ3+ZI44ep
	X6e5Xqrw2SkfNRoepZJQ==
X-Received: by 2002:a17:902:d2c1:b0:2ad:9edf:7fe5 with SMTP id d9443c01a7336-2ae2e4bce9dmr19427245ad.42.1772173016250;
        Thu, 26 Feb 2026 22:16:56 -0800 (PST)
Received: from dw-tp ([203.81.243.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1913sm57837485ad.77.2026.02.26.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:55 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	kvm@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	Peter Xu <peterx@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 1/2] drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block
Date: Fri, 27 Feb 2026 11:46:36 +0530
Message-ID: <0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Architectures like PowerPC uses runtime defined values for
PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
at runtime using kernel cmdline. So the pXd_index_size is not known at
compile time. Without this fix, when we add huge pfn support on powerpc
in the next patch, vfio_pci_core driver compilation can fail with the
following errors.

  CC [M]  drivers/vfio/vfio_main.o
  CC [M]  drivers/vfio/group.o
  CC [M]  drivers/vfio/container.o
  CC [M]  drivers/vfio/virqfd.o
  CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
  CC [M]  drivers/vfio/pci/vfio_pci_core.o
  CC [M]  drivers/vfio/pci/vfio_pci_intrs.o
  CC [M]  drivers/vfio/pci/vfio_pci_rdwr.o
  CC [M]  drivers/vfio/pci/vfio_pci_config.o
  CC [M]  drivers/vfio/pci/vfio_pci.o
  AR      kernel/built-in.a
../drivers/vfio/pci/vfio_pci_core.c: In function ‘vfio_pci_vmf_insert_pfn’:
../drivers/vfio/pci/vfio_pci_core.c:1678:9: error: case label does not reduce to an integer constant
 1678 |         case PMD_ORDER:
      |         ^~~~
../drivers/vfio/pci/vfio_pci_core.c:1682:9: error: case label does not reduce to an integer constant
 1682 |         case PUD_ORDER:
      |         ^~~~
make[6]: *** [../scripts/Makefile.build:289: drivers/vfio/pci/vfio_pci_core.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [../scripts/Makefile.build:546: drivers/vfio/pci] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [../scripts/Makefile.build:546: drivers/vfio] Error 2
make[3]: *** [../scripts/Makefile.build:546: drivers] Error 2

Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d43745fe4c84..5395a6f30904 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1670,21 +1670,20 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
 		return VM_FAULT_SIGBUS;

-	switch (order) {
-	case 0:
+	if (order == 0) {
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+	}
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
-	case PMD_ORDER:
+	 else if (order == PMD_ORDER) {
 		return vmf_insert_pfn_pmd(vmf, pfn, false);
+	 }
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
-	case PUD_ORDER:
+	 else if (order == PUD_ORDER) {
 		return vmf_insert_pfn_pud(vmf, pfn, false);
-		break;
+	 }
 #endif
-	default:
-		return VM_FAULT_FALLBACK;
-	}
+	return VM_FAULT_FALLBACK;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);

--
2.53.0


