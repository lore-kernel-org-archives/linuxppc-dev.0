Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E273606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdAoVYnH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZk594bCqz2yDD;
	Thu, 26 Nov 2026 15:26:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795667181;
	cv=none; b=OD94rrLA39sSrl5tECrVRztWfp8/c9/rFFC8IQ/ApQpFNHfs+GFZ0E3wsXgTrdEN10XvHyBWeimhhRzSiALqBaB0k+d+dGs2weh2pc661h0AT7j3/kYiPS0ert1LZZ5JErnkbskfgIl//MmhofEXWtFsrxtZSD74u0MghQo37bcOIRs5IDuehFBWOIQ5Ec4Qy4X+pPCRpqZwSTQux1I/U+CtR8kN/wuJIpSsod8rMJupYPsoWwIPb2UJGeijlOyl03sOeKiSTB58FmNcBDSKwS5Np1bxLT7Q5XIlCG/zV6NgSlGnr6f9YuPYELDOJrLhm7up2C2OQklr12h/5pv1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795667181; c=relaxed/relaxed;
	bh=bBJoGKJyIYEsiB5zwIDSoKxvFTy4kcr2uROiFtHd/QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8uQX4kBHeJDNg3PXL0XpnGOLX3hsnnjtIhGdRtDklKoWvFXBjdSwDP4o3x1IUwrWdoWiqjLOWgjj4wghbt5D3jA0e+q3wXCTi8f83icZ/22kL1KXNd2gtDUSZ8zQJAUiOVfP14QNxD63wNsiulq2aToQpcjlbv9hff8y2aCnko9Yh45tJkiNSPb5TcUr1txQDosfeHeWHhT7xcrCM4QiakqebjcukpCJdNUdRqDoo/4I1Cc/jcLIHLRb9KaY66lEAETgU87eoALhk2bJFHQP1DiDiEoJyUUxYzhjJXELVMoXHuctQmGunq6n0KRX4y1NbUwH0dL+1B+BVS/l/NSRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdAoVYnH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdAoVYnH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZk583gfvz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 15:26:19 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-386b8f2f671so3520246eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667177; x=1796271977; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBJoGKJyIYEsiB5zwIDSoKxvFTy4kcr2uROiFtHd/QA=;
        b=sdAoVYnHLGnswgxslpoDjJn9iO7kZQqG3ilKG63WDZOJzSUltWU2l7/USxv3WDEbSr
         vmVuGPfQG8snDP9H3bo65eDLXs0xvWINfUB6NNm0qbmMBYp/NH2c6OCEagFZ7R9c+uUh
         h4PPASgX0c1ekgHTC1oJ7nSYCjYu6HOgOEiiU05HspirzQJwuzHN8XvhDXVHQiaQYTTP
         aXR/8k08VNYRhV1+nE2DGUPWvRDH7QEMlEplcu67Zh0JbX+2Mdc2ok3ogkjobLB34Q+C
         P+LO/MKBVEWeNjIGNPbvQyLpZHJgsBr+mCVOnhEm0CICRsYiD3zSI3bgTG08XnBSVm3a
         XSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667177; x=1796271977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBJoGKJyIYEsiB5zwIDSoKxvFTy4kcr2uROiFtHd/QA=;
        b=U8j1rRmu0g1Un4iByZU4Th2o7gcdc7lIfrfLB5OyPaZBrz1TJoG1S2IrLvDn7s0VYr
         1a9df7BIY9lkYkovnRHnWtMma1JXahxPnqEWt33L+3XoUnNBtp7XgCfjBkd4e13WsIia
         Pxz9WslChokoYGNYzpj9yy8smOARLppCHpGBXvGaMwBGhg7ek68uSgRFrNyb/ty5xWCH
         EiBAYiFK0+tlp3bHouCby1LZK9qVoat8Mq5LEyzha5LnAL/BzHpm3RUeNBM1SMVBx1Z0
         8LrkI5INXgACYf6kCew2u2eHSSoGuLzyeUZSysJNWLA9f9afamhEzqENZpU8gXm+fZkG
         wUPg==
X-Gm-Message-State: APuU4Z82GNgSuCYaXA6EPxDv96y82uEMFjrn9X3rGKOI6K+k/8RsHWc5
	C1/5lJFHSsRyJafX5Dk9pRu+ZtepBpHXRzSpPr2WcCS8IwtIgjbCjU4TiPhSbg==
X-Gm-Gg: AZFdTZeWXGseYnk6MHjQf0V7MgZt8mvnh39K7U1Z+UjYzEL7O1u9SRg+43Zz6MB8wxN
	6BopuHv5s+iMHkWCrva0FDUxwYHmss2MqEn357i2jB6cFKi/AVWRyUrlzIX5pNGMmvAt0RJwr5Q
	quFNNPVEo+iTm4MpmchYtNnlbhkxbXHJNWLR7Ng8c36Kl8Og2smpaaAVsRnIaupSVJbyN/DtbNx
	Ra7GeMwzTlJoS1y+f0pmuLZhCCknoCFTKOy3QoR9VMkcWG2PEPdS97PCqTVwt8mPdZZMYt3Ye/C
	XEUWWAhjefGyQq9QcLs85DTMwCHW55EEKL5eP86xFwmFfs5xK6MJXPXfvN8cdIz+ugEinklwWYK
	PIGq629GoZPJsLRGpFw2neE6+E0BWt5ZP7Cv0hQYTXeP4TgpKTCeDfDwvH3atnOcqXBtG2lxB0s
	YYn4e3pQlc16bI2sbVlRLWgatbMyiG+vm8GZ8KT0y/Qy916wGgOuUdsfRbHZwVXz260qotcOGo/
	X8XL+qnag/7nj5hbh3BMsq60ZYhivIWJH1E8VlxJUXJSZKNgrvfzUtJ53pxN/Z4Wwy/QTeFgP9n
	A14vqJGOURgEG6fxOY2IuPg6J9VH7LLMAw==
X-Received: by 2002:a05:7300:6da7:b0:36c:3b8a:8090 with SMTP id 5a478bee46e88-3856c9a302amr3033886eec.2.1795667176924;
        Wed, 25 Nov 2026 20:26:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54542185eec.7.2026.11.25.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:26:16 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 0/4] powerpc: kprobes insn page fixes
Date: Thu, 26 Nov 2026 09:55:58 +0530
Message-Id: <cover.1795666663.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

Misc few fixes that came out of looking at a W+X warning at boot with
KPROBES=y and MODULES=n.

v3 -> v4:
=========
1. fixed the commit msg and added details for book3s/32 and 8xx in patch-2

v2 -> v3:
=========
1. Collected RB tags, addressed review comments & suggestions from Christophe
2. Removed PAGE_KERNEL_EXEC in the cleanup patch-4

v2: https://lore.kernel.org/linuxppc-dev/cover.1794572365.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (4):
  powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
  powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32 and 8xx
  powerpc/ptdump: Show the exec flag of kernel mappings on e500
  powerpc/mm: Drop PAGE_KERNEL_EXEC

 arch/powerpc/include/asm/pgtable.h |  3 ---
 arch/powerpc/mm/mem.c              | 15 +++++++++++----
 arch/powerpc/mm/ptdump/shared.c    |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

--
2.39.5


