Return-Path: <SRS0=LneW=2O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4BC2D0CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 06:07:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB9620706
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 06:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="XjahVPXM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjTuryOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB9620706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hm2q2wGJzDqNP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Dec 2019 17:07:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=russell.cc (client-ip=66.111.4.229;
 helo=new3-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="XjahVPXM"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="fjTuryOi"; dkim-atps=neutral
X-Greylist: delayed 327 seconds by postgrey-1.36 at bilbo;
 Tue, 24 Dec 2019 17:01:27 AEDT
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hlw70KGhzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2019 17:01:26 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5020E1E4D;
 Tue, 24 Dec 2019 00:55:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 24 Dec 2019 00:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=quBZcC5Nj15k+G+ee0d2Sguypc
 PXvk8rxSpa/ZtL4BE=; b=XjahVPXMeph/schhBdXTzGRdm3VhVmGKt6OrPT6Dzb
 hfeEnvGzaDB1GOzWUuGUWy8b09znxYHokZq9JXupd1DvgK8y5ptklT5uPHY0Z/mC
 0FDBaQt51Jn3lSejDB6YyF3pkvictdJKWa9UMyhiOZF7o4DkkSnRgPyzGEfMO0eb
 DUsTFTFkFmiYwEoEPcRuNlKZ5yfzHi9F3ls/nKJ/pKfo1YvqARfxdF6ngdZEh+p7
 FW8FWEzpdGVWal+MdaKUpXdpiJ0fyJUcuu00FDfeLP1kWeavRAsmGoVsifbCbO8s
 h3psPt2ChciymIksKw9TSFA6UmHtOMxTjL8X10UJS3SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=quBZcC5Nj15k+G+ee
 0d2SguypcPXvk8rxSpa/ZtL4BE=; b=fjTuryOiDFR+IKhOm4xNdGKh93s3o4fSQ
 elZNNIljI8oSJmFCoXgDfU1LgLMsdLD37AehyFvY+wa+HTOP1xqlNNnTWGzBpGPd
 PNaUA8D3r15QRxPx8yuPGeN1WRRG4ox1UEjdFPQtnfgIuSBOdmnOmW3fLfl+q3cu
 HVGIBbRM9oVmUTIQZLKrJhE4gA0DtvJTcxlBzqWhzJxuiTrwx6XDcRkLKlC4Qcs3
 bakWHf0Bl0uRgC/ezpU3W2o04nr6tu+ltIKgnO4180Hzk4cyZDysX/DGwufFYbd8
 CnsCw7Ar1taYIwAjJz3tOnfcvEu5tv3YAvUwEmZp8URb/HWixETJg==
X-ME-Sender: <xms:aagBXltYeLkDxWnfsR48r3c7NlCIPqfEa4tF9FxsiLZeY6EmgOLGMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvuddgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenogevohgrshhtrg
 hlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffoggfgsedtkeertder
 tddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhoiihlrggsshdr
 ohhrghenucfkphepuddvvddrleelrdekvddruddtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:aagBXitWqBZvi3RRE2AL7wjwcQJ1Z04R_VJ6B5Ni0zyzybAR5cKoLQ>
 <xmx:aagBXjw_Zl6HoaMtTbGDd5QWZuE7dBysBU0PahNN-C8evukBXAs4gA>
 <xmx:aagBXgjep3Dbi8xh1qkhYgClaPMK4awHtEyYR3mbYU-iKt3zL7ZF0g>
 <xmx:aqgBXqkuKaF3LIf7SS9A8p10obwq4DOaaZKpmxRhs8CIRTGdYpFBIQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2C18C30607B4;
 Tue, 24 Dec 2019 00:55:49 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 0/5] Implement STRICT_MODULE_RWX for powerpc
Date: Tue, 24 Dec 2019 16:55:40 +1100
Message-Id: <20191224055545.178462-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: ajd@linux.ibm.com, kernel-hardening@lists.openwall.com, npiggin@gmail.com,
 joel@jms.id.au, Russell Currey <ruscur@russell.cc>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v5 cover letter: https://lore.kernel.org/kernel-hardening/20191030073111.140493-1-ruscur@russell.cc/
v4 cover letter: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198268.html
v3 cover letter: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198023.html

Changes since v5:
	[1/5]: Addressed review comments from Christophe Leroy (thanks!)
	[2/5]: Use patch_instruction() instead of memcpy() thanks to mpe

Thanks for the feedback, hopefully this is the final iteration.  I have a patch
to remove the STRICT_KERNEL_RWX incompatibility with RELOCATABLE for book3s64
coming soon, so with that we should have a great basis for powerpc RWX going
forward.

Russell Currey (5):
  powerpc/mm: Implement set_memory() routines
  powerpc/kprobes: Mark newly allocated probes as RO
  powerpc/mm/ptdump: debugfs handler for W+X checks at runtime
  powerpc: Set ARCH_HAS_STRICT_MODULE_RWX
  powerpc/configs: Enable STRICT_MODULE_RWX in skiroot_defconfig

 arch/powerpc/Kconfig                   |  2 +
 arch/powerpc/Kconfig.debug             |  6 +-
 arch/powerpc/configs/skiroot_defconfig |  1 +
 arch/powerpc/include/asm/set_memory.h  | 32 ++++++++++
 arch/powerpc/kernel/kprobes.c          |  6 +-
 arch/powerpc/mm/Makefile               |  1 +
 arch/powerpc/mm/pageattr.c             | 83 ++++++++++++++++++++++++++
 arch/powerpc/mm/ptdump/ptdump.c        | 21 ++++++-
 8 files changed, 147 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/set_memory.h
 create mode 100644 arch/powerpc/mm/pageattr.c

-- 
2.24.1

