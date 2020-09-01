Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A6C433E7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 22:21:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933E4206F0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 22:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p925V7sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933E4206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bh1kL5Gr2zDqXR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 08:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=p925V7sn; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bh1dx5F9kzDqP4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 08:17:25 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id j11so1254493plk.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2020 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=M8j6Ldkq7Y6L6HNtPJpdtArkg82hNoz7EQt2ZZQpQiE=;
 b=p925V7snElOQZXlWMLip8xP1dwydX4MO40+mVFj0KyAvGYuTSaLzAdLMfBDDV081Yc
 fEnLq463d09UGAfhsrrBF62cGT/GqQtYjv0nq5ng6OZ5m4jKNTDM86uafLdc6j721eOg
 6f1p/HTw+taNTu4O7whEf+6bZmHYqxDOIiy5obUbw/5UsCVHJ9vf6MEnKgvy+pQvF+5J
 IeXr6w2XCQR8Hs6QTtvSXHW9D7hGl2Fnpi3RZZppFwo5+UafHLipz4crtYIUn/PHLBWc
 C/yluXJaWRsBj31/j7ffRgYozI9+twYp8EsiVCVuCJtaxWo11IwJJw/rhIA2CmV/TP98
 71mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M8j6Ldkq7Y6L6HNtPJpdtArkg82hNoz7EQt2ZZQpQiE=;
 b=NvkYKhZH59tdEXefiW0+ckN6BvtOtQZTZRMaZEmudoZgMWsy3lSPed5yLmwYMeVQM9
 eBt8r0Wo/Rm05Csnwuyl4s8yJX9vyqpE+2Ef16mZb08ZkbS4qY2inhxvbzmmljDlUN5I
 Kbws2C9pv/nL1Cz/tsEldGkoKba2sOZm+X+Je7zlfccnOVIgAEHMhIfsLQTesbRmRZgL
 R5TAHMI2A8/pANpiVlY/U+Wm9bjtv9ZrR7iUEg/lCJ81OfcCkWZlZlccn2gUcYo8offl
 izRav2fya/BR4/Ri7NcHgmTfm+1/FwxjO9SV3AQJrwSAoyaQBP84gisFZivoAohO5UJa
 S+9w==
X-Gm-Message-State: AOAM533nB7H51Jr4YMS++khtKJvfXhBjmka2H7ua63It5y5gLt2Rh2r4
 6Dx5beEBwrhgAPSXfbqIO0s=
X-Google-Smtp-Source: ABdhPJzHMtqQ9oWwXWEViAEvRErMfjdDqEOcrOWlNbyGgorcxLjtTk6m7wzAANlJgigaSW1gJ7x2hQ==
X-Received: by 2002:a17:902:9a8e:: with SMTP id
 w14mr3206869plp.6.1598998641433; 
 Tue, 01 Sep 2020 15:17:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w203sm3201356pfc.97.2020.09.01.15.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 15:17:21 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de
Subject: [PATCH 0/2] dma-mapping: update default segment_boundary_mask
Date: Tue,  1 Sep 2020 15:16:44 -0700
Message-Id: <20200901221646.26491-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-ia64@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 sfr@canb.auug.org.au, deller@gmx.de, x86@kernel.org, borntraeger@de.ibm.com,
 mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, gor@linux.ibm.com,
 schnelle@linux.ibm.com, hca@linux.ibm.com, ink@jurassic.park.msu.ru,
 tglx@linutronix.de, gerald.schaefer@linux.ibm.com, rth@twiddle.net,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, bp@alien8.de,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These two patches are to update default segment_boundary_mask.

PATCH-1 fixes overflow issues in callers of dma_get_seg_boundary.
Previous version was a series: https://lkml.org/lkml/2020/8/31/1026

Then PATCH-2 sets default segment_boundary_mask to ULONG_MAX.

Nicolin Chen (2):
  dma-mapping: introduce dma_get_seg_boundary_nr_pages()
  dma-mapping: set default segment_boundary_mask to ULONG_MAX

 arch/alpha/kernel/pci_iommu.c    |  7 +------
 arch/ia64/hp/common/sba_iommu.c  |  3 +--
 arch/powerpc/kernel/iommu.c      |  9 ++-------
 arch/s390/pci/pci_dma.c          |  6 ++----
 arch/sparc/kernel/iommu-common.c | 10 +++-------
 arch/sparc/kernel/iommu.c        |  3 +--
 arch/sparc/kernel/pci_sun4v.c    |  3 +--
 arch/x86/kernel/amd_gart_64.c    |  3 +--
 drivers/parisc/ccio-dma.c        |  3 +--
 drivers/parisc/sba_iommu.c       |  3 +--
 include/linux/dma-mapping.h      | 21 ++++++++++++++++++++-
 11 files changed, 34 insertions(+), 37 deletions(-)

-- 
2.17.1

