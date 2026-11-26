Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB3606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2hH+FUi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvqY4mRvz2yKn;
	Thu, 26 Nov 2026 22:45:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795693513;
	cv=none; b=f1Y8p/J++FihA98feZnYzBGg2VYDBP97QIVbzfaDM769hsBjwyx5QKFnkgUO+V57dp9NKl+fRntYj+HvvXluD0cltru02cfJNkMABipf2CGz0nvxV8WV1i7Wrx5utXP5jA9SGhW+4+On8Zd2Xr2Rx516FTiEO6N/G26B4lIVBxefnDmGiJvrxeaFHQ1wL1KP29KVdYlvAlx7ACxnB1K0zyX9IPYH//0muLQuYvRhdzuJpWc0SBgW2SeBlecaVbWEyfXKDuh4xgAKMaLXWpsZqlHfg9apDfVT3h4NEsHH8y5xnziZJsiJ2Es8V4JkMix/J0O3K+15OHmE+L7mjzXXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795693513; c=relaxed/relaxed;
	bh=5BVeDoXywdonN8l0fahN7PgNc5xFYXRHYBZPC3PlIr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEXsWsnqCa36p16VQGstKQZchew9E2OQ/dodElhGGVFuGHFg/bgjVgTrSChAeZlRVEnoIhLeHItOJU4wbgvLZ9y3O0WLKidzqFjU1RtOVwIg4PAM189ELMRZBKSYcICvm4m33yMD+aafHEEqy4ypw2MhpjhA5dcD24WyLUfIqIVVwtKUoXWPskuD897Iw+nlwl7MroSC4EDpfSqq+ZacUoXA8OiwrIMbuSbQnqSooxr3o2b6EdQOG+KlM6n87u7pauT4ko4wkZ2gIpAqvunx89egFJUA4v79REN6GG7SOu68jDYbekZZLqkgHkNrPznKWgA1+gu65wdEY06533MkDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2hH+FUi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2hH+FUi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvqX6Gbhz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:45:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D76643F1B;
	Thu, 26 Nov 2026 11:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8741F000C4;
	Thu, 26 Nov 2026 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693510;
	bh=5BVeDoXywdonN8l0fahN7PgNc5xFYXRHYBZPC3PlIr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2hH+FUi1whGz3Tc5erJ4wvaQIsa7/tWSP/c6X9vu53OBUKo1B0WiNAclJt6yAFgm
	 pGz1Ex70shjn/h1DHItCYjmiSeUn89UCHCA4G1w1wWeCAdswE3zJrMKPMwFzKMZlDd
	 nC0SY1V0v4hU5bqu5wSTOQsO02ln/4LBS8/pU19gTTq8a94zu1u2oRzquyVVWvfoyJ
	 A9Q9F5dRlSSngm44CD8uAUW6WllAHTLL/ZABWNrv2paiBktHMVqFSwsqVP75fnKoBF
	 d/7+x6dvllgHhWRvd2tJbeHoIPzncqy0ud8b0/7wXvqdGK8WsxcZSCgR/1wb4XGsOs
	 rx6swYcSlIfow==
From: Mike Rapoport <rppt@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	x86@kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
Date: Thu, 26 Nov 2026 13:44:53 +0200
Message-ID: <179569348034.4110350.10768570671103859123.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 19 Nov 2026 08:16:56 +0200, Mike Rapoport (Microsoft) wrote:
> The intention is to take it via kexec tree.

Applied to kexec-7.5 branch of liveupdate/linux.git tree, thanks!

[1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
      commit: 09ade745fcd10af7fa62c73a918cae6814c5b0d8
[2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
      commit: e583fcbe5b58597fdd81bcf150115fb801d6507f

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-7.5

--
Sincerely yours,
Mike.


