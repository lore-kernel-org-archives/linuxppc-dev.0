Return-Path: <linuxppc-dev+bounces-28309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28790C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Qm0vmcz2yr0;
	Mon, 28 Sep 2026 00:34:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519680;
	cv=none; b=fuIKyp2aVyMPRqLRoyVupWM6nrmnozNGw3KVjKV6hW0wG2nmUhWmcgs2cnOO9ewqDFShLSDwvW/sNDMYpk6wA5xmkqRJVlnHpmyHfor7pZPvPmC6VyYxDFfTsX3exiXhSpAs8ixhKT2y82rEjb56MwBMCdMs+fKv0YmheT0zyQX4SsosV+kDBJFWt5PydHrIgokAqdjloggaub3LPIqody8apY6qSWpB5lq+tUQKgaT+ZJbsUmNqnTZhABezMWRILbXHqkaSQTMN2NHxyHUtywGiBuQRNiAFbrt/D3xY+2TmSsIEkwDcrQ2STcidN0ZOSkwuRlj2wqASBXyzNOoyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519680; c=relaxed/relaxed;
	bh=wNsYrigQJFRd0fgglNuyNwcYfoFVPQhmuqxLt0lFgyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ud7s84MzhNtLv/r9VdQ4HrkH4avEJ6E9llL7N2xrm5ZCMeCTDenitlAtqL+u9BGZVyVOuQsH8VEAicm5g/ZSOCcEmYL7340UBVzoUkai6BBSswQUUi2JsIMxhOGtiEOajD8xtYlZoB2QerLWmSx2kI34GRwjgkXdDtr8MwPZXu40Rvz0gqeFR+09OApQQtfrRYVMPa1ZjaXw6uaMoNueAf/l1nnJoQfipePb/zuVrFGjqqS29amXPipwhPmJfGPyBA934LlZxErD6012rhrAgecWlrnvlts8QyPhQOffp4x8L3lhQf+HIEfgBhvBwsr4bpkWNC0piNLZBe+hHirQNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lNv/fDX9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lNv/fDX9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Qk3Kpfz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:37 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-341d0522b4dso3421012eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519674; x=1791124474; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNsYrigQJFRd0fgglNuyNwcYfoFVPQhmuqxLt0lFgyc=;
        b=lNv/fDX9Y9PZS65VCSJzIHnzekQ1emaoHDAcdL2GT0DEEONqvLrmZLo535f8WrIJfO
         LisVX1CC/w2yK3gocyrrhYMBKoQJ2SE4RKWUvhrDAxn9BYg629f2JisTkSfDqVP+yYH6
         GIyO3Jk8jZu7QzSguBX0blBfuzUxpPqXgib/N1pHRu4AAZ6jsMEuaLnOAtHIQ0uqpy8j
         UGVEvMCkbE97bG7Hpuk4OAx9djP0+xX/Xo+eHTu+SyAy9C1z97m8WIlm+YkdZMPpbl7J
         9BOJC2XR3RmeyzXf2tc2DOZyCZj2bdknM7fJTok/SojnAyMouAqACUVxqGJ8OvQ9NiMa
         EdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519674; x=1791124474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNsYrigQJFRd0fgglNuyNwcYfoFVPQhmuqxLt0lFgyc=;
        b=xFXG1W0sIgaM7Lxrc+p6hQBXAzdfyLUqfunSLOWq/xti1Ax3buDr29o3H7zX+AxE4C
         rZ98ojqUkRoAhNbedRU4eIC/Mx21sXiARblq1CX0DtpWVANc3kIqIwbfIm5i61B/7nEF
         Y8EyCBQqyvgI7J3SSiWGVl1gicS3mPHLhKpNgDJbBHV/tyamVZ1DyHj2JWVFd8Kd5bTe
         D8OA4fwnNN8Jtq/XU0G4EMvcJfitrX5WVRIte4pkQPZT5W5nrR6WpoK5jk7+9vUUleEX
         cZYSDtYE2/hBD92N37DaEyjrjAuK9vgHW+bErtYjOcrw1Sawdy66ZlNEO5eP3jNsMZcb
         duGQ==
X-Gm-Message-State: AFq9FYI/xRtTTt9dx/Il72RqVuF2Ey4FFHpfP3FQ/5TB0V1U5LFPROZf
	uTsax04hheeKD1qs9Nbo70wu2lPLJGldleszpjivuwfRMPRkLuJOFg/26MJ8jg==
X-Gm-Gg: AYBFou3aZ03JryyS2XuI0MvVMCVQEtODcfmJSE5fTdxtVe/DPNN/NPOcglVHZviI81u
	hxhJF+cvHX44WkQk2RD9Ma1cLvUKXjMq/X51QnOkPHIujVebXwt2bM/jU0pHwy6Z1VdDf11Ycxw
	Kq6JZ3hTtqEmmV2AjWONiKI6Ij6x2+0Ux8fQae+oaKzbCw6L3wSTshQ6DbNt974n9KCDZ3hzY7I
	4zTXDuDRwanbDI8TQDtxldH5I7ICpBN07E227jHj6tI3KS0w4vBiLVL5XNOybqGptX2poBMqBHk
	FlCoVuBprq0zC/2q0MFmGlzs5nvzjQUXTOB8TotDaZgNtBaGKPPnKYz0M0B0ca3umG32wUGDeYc
	QY3wBAlCFHNioBuZFX29yo8DidrvEu24LQzXwd9D2QNabnBGUzl5ZvcRQTeSPjUkvzpSFA9wftz
	aj/1Z54vkERtAuzXj7LFZdfPq8NKKshfGYzQy3gl6O+FlyQ0ebdsRxpRtwt6KrvkXaz9XLsHrDl
	aZ2MJiVSdgXfjRgIhnK2AuTDKeXc2d0arQxbx4dIlPWhIYH9iw+3v4xfg7mjQ==
X-Received: by 2002:a05:7300:fa15:b0:33c:fd92:a7c0 with SMTP id 5a478bee46e88-34273848bd2mr6697950eec.39.1790519673985;
        Sun, 27 Sep 2026 07:34:33 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 00/12] powerpc/pseries,powernv: Enable clang context analysis
Date: Sun, 27 Sep 2026 20:03:41 +0530
Message-Id: <cover.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
Content-Transfer-Encoding: 8bit

Enable Clang context analysis checking for PowerPC pseries & powernv platforms.

Lock acquire and release checking used to be done with Sparse. That support was
removed [1] and replaced with Clang context analysis [2].

Note that enabling this caught few real locking races in arch/powerpc/mm.
However, the fixes for those and enablement for the rest of the subsystems will
be done in a follow up patch series. Also the more invasive checkers to check
what each lock protects is again deferred for later enablement.

The series was build tested with Clang 23.x

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")


Ritesh Harjani (IBM) (12):
  powerpc/pseries: Drop inline from hugepage invalidate
  powerpc/pseries: Rework hugepage invalidate to remove conditional locking
  powerpc/pseries: Rework hash flush to remove conditional locking
  powerpc/pseries: Add context annotations for the DTL worker lock
  powerpc/pseries: Annotate the VPD sequence lock context
  powerpc/pseries: Annotate the RTAS indices sequence lock context
  powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
  powerpc/pseries: Annotate the DTL debugfs read lock context
  powerpc/pseries: Disable context analysis for the CMM hotplug notifier
  powerpc/pseries: Enable context analysis
  powerpc/powernv: Rework OPAL console write to remove conditional locking
  powerpc/powernv: Enable context analysis

 arch/powerpc/platforms/powernv/Makefile       |  2 +
 arch/powerpc/platforms/powernv/opal.c         | 30 ++++++----
 arch/powerpc/platforms/pseries/Makefile       |  3 +
 arch/powerpc/platforms/pseries/cmm.c          |  1 +
 arch/powerpc/platforms/pseries/dtl.c          |  8 +++
 arch/powerpc/platforms/pseries/lpar.c         | 59 ++++++++++++-------
 arch/powerpc/platforms/pseries/papr-indices.c |  3 +
 .../platforms/pseries/papr-phy-attest.c       |  4 ++
 arch/powerpc/platforms/pseries/papr-vpd.c     |  3 +
 9 files changed, 81 insertions(+), 32 deletions(-)

--
2.39.5


