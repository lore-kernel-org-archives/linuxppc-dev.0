Return-Path: <linuxppc-dev+bounces-25867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3509C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:31:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM5md1nyzz2ykT;
	Sat, 15 Aug 2026 01:31:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786720445;
	cv=none; b=N+GvB0Du02FqYub+n1REhbP/2XrBLi/1MXf4RPeftWXGqj2SAc66NkVPW36c95Y6AgE9FMaVu5CpTrsWzPS+uSPpNsSqHVThwJqUBhHTMjV9RW+AeK6vTSy9g6EqjD3VELIlyjYYUIKAnY+V5G6evpr6s6a3UzPtOEhuxieJgxBeXg322jaAZAU+NqmJ1D2LsVJzQejt+CvPdn1x3Tsmh6/eqmi5e3SCLGHh9kKkWz5uK/9SUBUbBDo93vHtPqLjcNwqLpitUZV4fh15U+y7nH6afoOp+AUlg4k5Vz+dgYQnrN8SPe9jr6lZA18rHp6P+34M46jSD27FceFteLrMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786720445; c=relaxed/relaxed;
	bh=fPqMpU+LLRNYiSjrqLFHm/GfoNDBW1/b99+GMQWZD/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N+abKl0Hgg5S/ai3HiGWHHlnBOxS1eF/RyypPigCJUik2IlbobzjkzGeM4z2cSPDXikSiqp/yxP/Ol+jIi/K8aupVrM3+zOUR4fGXQ08M1qohXG3JpkKsora/llwA3kRldGV711wRTvZ9L/6jgRNaDPPtdNDQpq8/wIWv/EnoKLqd9XTtHBQQ1IuU+LfxtySDAvMOPxn/NY91Z2s7EO0njiMHQN+P/ONdcCBB3gdsHBiZ23wkPl2RrliFXXSU7zuAU7rtSNZpPY8WDT20rTruPoQpANOrrAKp3h3kMBfjiKKBsw22MXidqej7ILT+QMQT72RKrTMygsxrUgZWYYDSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g1VtuSga; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g1VtuSga;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM5NW4LRTz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:14:02 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cab973140bso18574965ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720438; x=1787325238; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fPqMpU+LLRNYiSjrqLFHm/GfoNDBW1/b99+GMQWZD/8=;
        b=g1VtuSgaP4YoEtS3C0l89sisu6M2wUJ0qQSVUpsxuXMRpeom/pUgSwjwph8uxFjmnt
         8v4t7Bn2T5gc9FjZGU7jU18mVhXwhUWk454hdDr01c7l4WPff01yH/pXvcrHL77mSL3e
         GzI/VTiWPb0x+teJUGJPZYNRonhv0gt/pep+1kAlOE2J9fhRq2b61rJQUgPrLqxyL0Ye
         c5GQX7K+t9Z34ntvVSTM1H84YnpwmhWynpyLer1OwkiRO1lNgk0UTNDqvnYcMPF7Ro90
         hhGtPO72x40eLZQWMzlKsV68KPrSwpnOqSXSfmDls98JP50C4nlIpygMyCg3WENqVhE1
         MjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720438; x=1787325238;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fPqMpU+LLRNYiSjrqLFHm/GfoNDBW1/b99+GMQWZD/8=;
        b=VT50ApeHIwpA2lX01JFrT3da3u0a/GexVa6vvDiY+eTIjsQb6WoQ4l5bcoga6EtC/G
         /OVt55j3xQ2HAw3ORpGS2eDIyj+p+UGzQkBTR3XysMWFhkQ4MMqxPCBm0duloXxFN9Nv
         u4QFiPjNOeObnpZTf2+pKLHVBZgk+fajAypOKsgqILaPs7VDyROq4PI0XF8IXYc+HKAF
         FhbyTIxSXqjqP/GFEfbLK/S21fUK4yv7vSdrX7AX+44pllX7qOAEhjj0H2+P6bW1R3YP
         IDEskGLqK4u1xxiASQ96tkOD9ODtTMbwqrGMgjvnUiO967jMShZXt1i1hKnPVC1ARm3I
         Y3kQ==
X-Gm-Message-State: AOJu0Yy4EzbZbXwJc961ltxZ9dAhkCx4405o8BIaNh1FK/jvRvdPNAXx
	Djh8qgZkb8MDCj1RdfO1eKu8SX/GwDr9j9lwiD0aqe6rgVSvqaLwmXaJ
X-Gm-Gg: AR+sD12UpasnG+ZnIuRB7kxcRsBS1F57vMAKDg42vG4cIYhgWPB+aMl1rEBcjz/Vg1U
	xNv4qpQnstKMgmxT8IorlPtSfgBwORtuIEupdk3LAiuFszhl0T2vIBk1aKlFQWs8GRTvYjqbd89
	Io769mDIhuh6x8+XpeppDVM02z3kDFKNZKZRQWcI/BNOZHWoctPNCuk/Inuvgtmcb4tcXq12yuL
	y7iDYj+EDeN8BUV0erGJioYCkTmvn+a/J6yLp8+0sme35kEvonRV3gTBtiRn1Va1syaSy25Tgt+
	aJQOt0rmX57RliMmC90swVpVM7pxEtIPvIa46ERBHorYk/ltP694vRJ46kaCBJl/t3mkBN+sI/G
	p7rWbi/d1JCHlE/NsQPYUhieq11a1aQqm/BLJsCyxPyN5Uv4mJDC/2rtGfsiXer938tbR2Hsc+v
	DWskUhApDmK8q0aEkHCMHCFEheGCH3OYbvBoPc81eT0jH8QUGDCS0+4DA3dmKCsa738RlaK0Wrm
	4hMWRSi1g==
X-Received: by 2002:a17:902:ec82:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2d3b082b573mr83408195ad.5.1786720438215;
        Fri, 14 Aug 2026 08:13:58 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:13:57 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/3] powerpc/spufs: fix a refcount, a type confusion and a
 coredump underflow
Date: Fri, 14 Aug 2026 23:13:38 +0800
Message-Id: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAKMwf2oC/yXMQQqAIBBA0avErBNMQqOrRAur0aZFiZMRRHfPa
 vkW/1/AGAkZ2uKCiAcxbWtGVRYwznb1KGjKBiWVlk1VCw7JsfBxS8EKrWrt0JgJjYWchIiOzm/
 X9b85DQuO+/uA+34Au9ZGo3AAAAA=
X-Change-ID: 20260814-spufs-groupa-6246fe77de7a
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=1879;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=oQmhcafvryzQTr8aJS6N1tB2XEUUgWL4lgJR/IbHbFo=;
 b=zfG8nyBi7T3ub7M+Svd8MbP/SpBX15kVeB/MKzmI2tsFv1Jn0a9Tkd6kQRapj0IRc+71kQWlG
 6ygYYi4+LN7C+D4Ol8M6zTy8bCMWhvKFP+a6kxzyBqvBfNBHYdc+/pE
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Three independent bugs in the Cell/PS3 spufs driver's file and coredump
paths, found by code inspection. The patches are self-contained and have no
ordering dependency.

1/3  spufs_create_context() drops the gang->alive reference on the success
     path -- the epilogue tests a value that is a file descriptor on success
     -- so the gang directory can be torn down while contexts still
     reference it.

2/3  On 4K-page configs the cntl mmap fault handler dereferences
     file->private_data as a struct spu_context, but simple_attr_open() has
     replaced it with its own object -- a type confusion. Fetch the context
     from the inode instead.

3/3  The signal1/signal2/ibox_info coredump notes declare a 4-byte
     descriptor while their dump callbacks emit an 8-byte u64, driving
     dump_skip_to() backwards (size_t underflow) and truncating the core
     dump. Declare the sizes to match what is emitted.

SPU FILE SYSTEM and CELL BROADBAND ENGINE are marked Orphan in MAINTAINERS,
so this is addressed to the powerpc maintainers and linuxppc-dev. A
concurrent spufs fix series from Junrui Luo is in flight; these patches
touch different sites and do not overlap it. Found by inspection; not build-
or runtime-tested here.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (3):
      powerpc/spufs: fix gang->alive double-decrement on context creation
      powerpc/spufs: fix type confusion in cntl mmap fault handler
      powerpc/spufs: fix backwards coredump skip from undersized notes

 arch/powerpc/platforms/cell/spufs/file.c  | 8 ++++----
 arch/powerpc/platforms/cell/spufs/inode.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260814-spufs-groupa-6246fe77de7a

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


