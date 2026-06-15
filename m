Return-Path: <linuxppc-dev+bounces-22667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4170CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 22:29:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfPtv4vy4z2yfD;
	Tue, 16 Jun 2026 08:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781562583;
	cv=none; b=mNskg78xg0Livz5Lv+6hZKeELPIxSTFKRwDtzLLn6OSqwKAHwu+UM2GBOJ2r80BeFpLLyoniQYKCbZ5S5Al25fuobRIgQBlxCJ5gEnIe7IPcbYjM+r2eqTPPjZTUMKxCsadQj+pp4ooxSMFI86g9q8e6La5drWuXPknjhGqGTEahuWBziDo7wZ8e958ydqZKCnS2pWcWvehdkyNmRTLI/3I6ybQqLmFC6e8jSD9Cj/s9/9SLignS0wEWm4E3zv4oj2MIdezfW01uMcqkkpdeYgXJBiaoUYE9KAT8lx5V8xYZ5jMgbDBoRRD3bpwqk66ims//PsReBVp2v/2KcrbcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781562583; c=relaxed/relaxed;
	bh=jlQPGxguRWI9qpH8iTo7hAEJVXsf499qSnGcNlAN4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMrU/Pc4aOXKPRKYCYQ0MyJLi/qQ/PKBdi2Kb9F7wwy8BMnHOkmDhve9fs1MFoCMTqjRY+YMf6aupDSaQVxlYAYKvlzc5EHoKVYbJgFEnSkRZUnDhUWeLRVmeuELRDXVT8q4cGMQwHtxFxCXymNdCsZVqLDcuZ6e9Lm2N5LKC2u2YtysJp+uu2gjxJHJOnW64RAk7wKL1Xy5Lf1mJrc84OIwwsDNS7Bo8aYptJOLr3Z75xBhUZiwxg60/0R7R/nbkeyceYKsqKE4apof3T5RDp6JOujD0UZWj7tf1WThk5v8hvik6ubVrI5rkMP69jOWCcQjhfX8KDUKTW/1jE5gYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+SMgU71; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+SMgU71;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfPtt4Vxwz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 08:29:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D31546008A;
	Mon, 15 Jun 2026 22:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22D1F000E9;
	Mon, 15 Jun 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562579;
	bh=jlQPGxguRWI9qpH8iTo7hAEJVXsf499qSnGcNlAN4u4=;
	h=From:To:Cc:Subject:Date;
	b=n+SMgU71YsGGMv6moPGk4CQZF8N2L8grY3o1ZPaYpPXUyvwZ0VTr9qxnXviqgdWRP
	 gNJDjpfVWAKQwvqzKBPVHqdynuXXf01jNTycOmituSFzxVvL/GGXEmFBUi1aboeyq4
	 HX8Cd3SkqEzCqCtWfgLqu5LwuLOS+pVfn9t6S0kzSQlh+9H1IEWuMH78I8AVKR8qXD
	 rIsDHILdPs8R+Y1sjcAh7QUz0m1Cnxg7pYbAEjX4HB59l3nUU/sgbUuEV6+Tu74Kkf
	 0heByX00Kl5cC8OCGETsi+QB5HLC+7Ti8ZRrl8wHJaHlmh7e4iS0BqvmaKtxnhQaC0
	 Qzysy9WcmjHlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	geert@linux-m68k.org,
	chleroy@kernel.org,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	maddy@linux.ibm.com,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Date: Mon, 15 Jun 2026 15:29:33 -0700
Message-ID: <20260615222935.947233-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
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

This tiny series moves appletalk out of tree, to:

  https://github.com/linux-netdev/mod-orphan

Core maintainainers are unable to keep up with the rate of security
bug reports and fixes. Nobody seems to care about appletalk enough
to review the patches.

As Eric pointed out Mac OS dropped AppleTalk over a decade ago.

Jakub Kicinski (2):
  appletalk: stop storing per-interface state in struct net_device
  appletalk: move the protocol out of tree

 MAINTAINERS                                   |    5 +-
 Documentation/admin-guide/sysctl/net.rst      |   46 +-
 .../networking/net_cachelines/net_device.rst  |    1 -
 net/Kconfig                                   |    1 -
 net/appletalk/Kconfig                         |   30 -
 net/802/Makefile                              |    1 -
 net/Makefile                                  |    1 -
 net/appletalk/Makefile                        |   10 -
 include/linux/atalk.h                         |  186 --
 include/linux/netdevice.h                     |    4 -
 net/appletalk/aarp.c                          | 1041 ---------
 net/appletalk/atalk_proc.c                    |  242 --
 net/appletalk/ddp.c                           | 2017 -----------------
 net/appletalk/sysctl_net_atalk.c              |   58 -
 arch/arm/configs/ixp4xx_defconfig             |    1 -
 arch/m68k/configs/amiga_defconfig             |    1 -
 arch/m68k/configs/apollo_defconfig            |    1 -
 arch/m68k/configs/atari_defconfig             |    1 -
 arch/m68k/configs/bvme6000_defconfig          |    1 -
 arch/m68k/configs/hp300_defconfig             |    1 -
 arch/m68k/configs/mac_defconfig               |    1 -
 arch/m68k/configs/multi_defconfig             |    1 -
 arch/m68k/configs/mvme147_defconfig           |    1 -
 arch/m68k/configs/mvme16x_defconfig           |    1 -
 arch/m68k/configs/q40_defconfig               |    1 -
 arch/m68k/configs/sun3_defconfig              |    1 -
 arch/m68k/configs/sun3x_defconfig             |    1 -
 arch/mips/configs/gpr_defconfig               |    1 -
 arch/mips/configs/malta_defconfig             |    1 -
 arch/mips/configs/malta_kvm_defconfig         |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig   |    1 -
 arch/mips/configs/maltaaprp_defconfig         |    1 -
 arch/mips/configs/maltasmvp_defconfig         |    1 -
 arch/mips/configs/maltasmvp_eva_defconfig     |    1 -
 arch/mips/configs/maltaup_defconfig           |    1 -
 arch/mips/configs/maltaup_xpa_defconfig       |    1 -
 arch/mips/configs/mtx1_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig         |    1 -
 arch/sh/configs/landisk_defconfig             |    1 -
 39 files changed, 3 insertions(+), 3665 deletions(-)
 delete mode 100644 net/appletalk/Kconfig
 delete mode 100644 net/appletalk/Makefile
 delete mode 100644 include/linux/atalk.h
 delete mode 100644 net/appletalk/aarp.c
 delete mode 100644 net/appletalk/atalk_proc.c
 delete mode 100644 net/appletalk/ddp.c
 delete mode 100644 net/appletalk/sysctl_net_atalk.c

-- 
2.54.0


