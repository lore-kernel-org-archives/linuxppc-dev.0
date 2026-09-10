Return-Path: <linuxppc-dev+bounces-27055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B388FC79FBB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgvfm0NMjz2ygK;
	Fri, 11 Sep 2026 09:54:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789084479;
	cv=none; b=WUWs8mqBkfldiKXZ/A3tl+x8Fh62iE2WgFv8t6oU78yZAzgxiNk5ejxW5/r8TUD1QqGL4Ts7giUclEaKur+FhupX5BaeGtVcbveY0e4o30jYDQxkJpqjWS/hhfZMCV6xlvfzDA30Cfp7wM1gEl1GtWnAKR89BhHBquXJo+lSnqsxEeTmfmvR8QjicXJXi6UN4bgCGMsrEK+INk4XtdZ+lB98juPoAM/SAoSlD64GJ/Q9IFRg5mk939YBnQ5vSGAOnBSBTQ71NEtH9/ga7ViX9uTZOlmo7wABuuumvdpkWYbAwvszT7o2X4+pM7WRXEcdkTKtAF0pBSwAsI4zCehXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789084479; c=relaxed/relaxed;
	bh=Xr4ylB1KGaYrjMDmEnz8DBoGfYS3HjosxfsRR5CFGeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFUEzYGyAva304WtuQwQnBttVCvscyHjHDp86pswX6lsKKYyHkqf8riBtKt67eKXwqpLsgOMUTpwEtns/5lfE2R9YsLP9kV4kup0mjY+EEf9BiTfQQMATrqaD4+ZJc84DXv71i6s/tGUqFiQL2WOMmU1jl4l4Hdt1Ke3KdBJuClEp1dELN+SlppmmxrmVZvMIovDjELE3MSDq8qcWPmEZ4K+qv4ztEDVcVSvn9JlqdwoVbvSdKrB3SrxNtTIC4tKnttmOw85noC4cY5Wb5z/Py4EHU6GDxcjVeYxgZKb9m+qM8XhEY0erYD0rHFp+hvkbK3k7jzobuZ8vbwBwApdTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZZysQGd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZZysQGd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgvfk1JHyz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:54:36 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-52fb766bfd8so4898941cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084473; x=1789689273; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xr4ylB1KGaYrjMDmEnz8DBoGfYS3HjosxfsRR5CFGeY=;
        b=JZZysQGd3/lOkZ6ToycdD77wlm509qSuhNp5vxzCErSjvfQf5yqKOAz8JgW+/e0P/Q
         hi8Z5sRGlt/rvCgt3FSt3uv1qFC1W1BkdLgEJ2Mra5+hK0UUZ2FQxcuqfvwCK1g/HKE5
         i1oUYcrFW6gIJBESRW5x+9tmaiW8hgnedDn1mG8Zzgdr1TsbSHtrIapQh0GgKFbTPBla
         HFj+qgbMHf+krZW/OTFvsidv+9ntLcijNT6UUpe7QZ+0F/c0KIEsF8Ow0ZI1g9sOSGdg
         hP4zJdKg3jV2aYFuINVK9RzsEKomJ3GVOjkN7BsgVSHyrJaU0kGnUgArMWXbRfcNuHh8
         cd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084473; x=1789689273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xr4ylB1KGaYrjMDmEnz8DBoGfYS3HjosxfsRR5CFGeY=;
        b=kb5Zo3U4E/Wwle5fqoielpHG7Z0zWD5wHB/0gSNVctfT0DAMlWUa5MITLcu0rFl/nL
         TsNAfx5g43uZxOI/idTj/Q8wSXgg42D2DRSOzu3T1NDsJ4kJHLu1UQUoATNrIWWOa6OP
         N5GJWY4Pwx13bZaca2frnt0dStpsbPX3WlBvTdD39iNNsD/HNrJHUMBHDlT8voOi5eAl
         EnFIL+RDYlyC63NUWLo5VB1NUGFthYSNn7n6Uq6Xl7aMpXtwbGI1hdDC3wXQVRQEhbfN
         lFpGXExEUWf4avIqptBH9qgHDaHbQzlDhTAJLk3TORJ/t+bCf/gjnKMGxRiESXb0Ri0C
         LlJg==
X-Forwarded-Encrypted: i=1; AKwUvBxWRA7xKY7KfAojF/LfrjAu1O+p+i1+NS4ht2+6YpenkQSrYzlGO4JZSrwRdx8li73MgLAL2TvClbMZR3s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++klho+H8b46iVlItC+R8Tt85i3F9s1JRRXHf0pFlEWMaBXBWZey
	CBDSBMq37MylsY6R1I/654YdcJjIqDFBwBHB0dDa7C+CF/kk/dVXrAs=
X-Gm-Gg: AYBFou1LbccMfNi4xBZ8AacCCAk8A/fpRfh3DIJoNPmAXyw0O/WuPhwkabJZDUUJOfu
	k4Lkwilw6NMlhwVgKEuVBtwVQRis7ORRuIe2YlZ5EodXZkln58xSMPQZBY2iy7X2EmDj0iaD6Kk
	G1j5aJZOZeJqGrZ42KSfrJU8JkwrrIBNQ4omEXxIPwPMRFeY78Rj73GDkF4c6c5dUcVj4/j1yZf
	0PMHeJHfZIAxfAxI1znnImRED4hl8D6R0tkPi2/mvTuUVCdD7jShPuI6dnXSA8BrFMQIRnm6wV6
	bEVizlzakrVQ5FsyRg0+6slLLZpibj7Q3Vm0BbuUixjN2pkP/W0nntoa2s8/TIcqBWLUipE6XNC
	XaIfUIcJ2/PK0+hyAnCmabdWwcD2EQ1igkHHxZQ++iJiVj91GGGvAd/kJZqX7+W88z+AZ/lTofZ
	VmZSV+Q57vw3o1lNOQEbhsLL9czHG+t+YHhK6XS2EYo+WgV03GiqW9oH2ipTWfly5M2+xLES7nV
	Uuyt0FZOFtIBb551CJ33f9ebaeP4hOTZBZ1YRgoQWe/D2DL/6BzWqVWeZhBMbFKXoJIRLyK4TZ0
	OWQytLYmsqEidfy14X1TW5c31DYulWoWrg==
X-Received: by 2002:a05:622a:229d:b0:530:2146:81c with SMTP id d75a77b69052e-530c8525903mr43339041cf.12.1789084473405;
        Thu, 10 Sep 2026 16:54:33 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:32 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] net: wan: fix FSL UCC HDLC lifecycle bugs
Date: Thu, 10 Sep 2026 19:54:26 -0400
Message-ID: <cover.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

The v2 review found two pre-existing FSL UCC HDLC bugs and asked that
the generic HDLC behavior change be separated and audited.

Patch 1 validates that an HDLC protocol is attached before starting the
UCC, avoiding a NULL protocol dereference on a premature interface open.
Patch 2 allocates the suspend backup before disabling NAPI, so allocation
failure leaves the running interface usable. Patch 3 closes active HDLC
devices before detaching their protocol and documents the audit of every
current caller, including the farsync probe unwind. Patch 4 unregisters
and frees the FSL UCC HDLC netdev before its private resources.

Patch 4 depends on patch 3 to stop an active device while its protocol is
still attached and before UCC and DMA resources are released.

These fixes and changelogs were prepared with an LLM and then checked
against the cited source paths and call ordering.

Changes since v2:
- split the generic unregister_hdlc_device() change into its own patch;
- audit all eight in-tree HDLC hardware drivers and document farsync;
- fix the NULL protocol dereference reported in uhdlc_open();
- keep NAPI enabled when the suspend backup allocation fails;
- rebase the series onto Linux 7.3-rc1.

v2: https://lore.kernel.org/r/20260803133048.42650-1-mhun512@gmail.com
review: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org

Validation:
The series applies cleanly to net commit 784450234395.
All four patches pass strict checkpatch.
No hardware runtime testing was performed.

Myeonghun Pak (4):
  net: wan: fsl_ucc_hdlc: validate protocol before starting device
  net: wan: fsl_ucc_hdlc: allocate suspend backup before quiescing
  net: wan: hdlc: close active devices before protocol detach
  net: wan: fsl_ucc_hdlc: release HDLC device on remove

 drivers/net/wan/fsl_ucc_hdlc.c | 29 ++++++++++++++++-------------
 drivers/net/wan/hdlc.c         |  1 +
 2 files changed, 17 insertions(+), 13 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.1

