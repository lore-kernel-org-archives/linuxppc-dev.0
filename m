Return-Path: <SRS0=x5jM=LN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05497C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 23:41:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016AE61159
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 23:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AE61159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G6skM6K2Dz3c25
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jun 2021 09:41:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=UBmgtB05;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UBmgtB05; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G6sjw0h5bz302K
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jun 2021 09:40:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G6sjg4MXnz9sRN;
 Sun, 20 Jun 2021 09:40:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624146041;
 bh=amvNJNy+ZWUWObBHVKZALCApYZ772MCSmqS8exnahqU=;
 h=From:To:Cc:Subject:Date:From;
 b=UBmgtB05/SVwKFjZD2cDLvE4cv+BfuimTIO0RR3f08Jq07Sa+f2Z5N0CDTtTI5ZwF
 Qpz29XamRsPkPV6UoLfEiN7+d1lyuyfR9E9llPw8hHx+Idq2V43ZfcZia1qaGj5BA3
 9QkaeEpL2nDp4mfQF418EvDmh1IElz053ydH0k4L0lQJCJsL0FOrNrWUNjxkL2TFcF
 mem+jEgIJ6CIGesD68o7SGhJFIo9PXRNlpzwhYgyAKv/YG1/Bfvcyz71lAdfXxGTzC
 JjfXdMEgGgypDN6ijvA/4iBM3fFWkYbOuNxi2vNE/Bum4bTkSE9uXl8cqmkkHC/FyI
 Ky3Iv+S6YMgXA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-6 tag
Date: Sun, 20 Jun 2021 09:40:38 +1000
Message-ID: <87lf752zk9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.13:

The following changes since commit 59cc84c802eb923805e7bba425976a3df5ce35d8:

  Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs" (2021-06-01 11:17:08 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-6

for you to fetch changes up to 60b7ed54a41b550d50caf7f2418db4a7e75b5bdc:

  powerpc/perf: Fix crash in perf_instruction_pointer() when ppmu is not set (2021-06-18 16:30:36 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.13 #6

Fix initrd corruption caused by our recent change to use relative jump labels.

Fix a crash using perf record on systems without a hardware PMU backend.

Rework our 64-bit signal handling slighty to make it more closely match the old behaviour,
after the recent change to use unsafe user accessors.

Thanks to: Anastasia Kovaleva, Athira Rajeev, Christophe Leroy, Daniel Axtens, Greg Kurz,
Roman Bolshakov.

- ------------------------------------------------------------------
Athira Rajeev (1):
      powerpc/perf: Fix crash in perf_instruction_pointer() when ppmu is not set

Christophe Leroy (1):
      powerpc/mem: Add back missing header to fix 'no previous prototype' error

Michael Ellerman (2):
      powerpc/signal64: Copy siginfo before changing regs->nip
      powerpc: Fix initrd corruption with relative jump labels


 arch/powerpc/include/asm/jump_label.h | 2 +-
 arch/powerpc/kernel/signal_64.c       | 9 ++++-----
 arch/powerpc/mm/mem.c                 | 1 +
 arch/powerpc/perf/core-book3s.c       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmDOf4MACgkQUevqPMjh
pYCWZQ/+IFYW1st6xlM1jBDlLSItSn234dqOmvlihIo+9lCR82l72H4E4EWIj7A+
3GGzMllEdDcGooEF1jg+7+zUlx8i1WNlRCF4RNszGzpipiDWGPlxW2t5FqNeQRQ7
YyooMzrgPYlRxGHnG/KHfGiPJxxLj4ZsyRhWfoS6cY1EbS/YOX8SDX1Xz2qQu/Jr
qRzZvSZKkBpVdvcxEYcn7WSauDpqtZ9keWHdP8e6WRd/Bceu4nyxlxOI0z+pBUsr
3IhWzQexznJwCGClQBbaXg/uPmUDtEjx+LzhU0jTmSMLxVI+UFPVDIbco6bMX7AE
EevcU35aDLu8tclNd3IAA9Au/EZPUe8kMNUPmBncFAID4ek+gybRJuGO9b9XEJ1r
AZFFCb2rRugBvOeNtb5y3u9XNR0Ct0S2lsZygSOkCQ6R3Sf2yoVgP0M49PbFvEEO
fSVLnAMEWQDWfaLjYxFXp2S3vddyLw8G36lBzJo74Y/cRuz10g/87oWpIlFq5tqK
aMXTroINmErOv1XVALqix1ScrLeBnPlL2nH0gBSZ96W0A196kFjWkKaGsQFwXMEH
X2Om1rKYiC3/vKrLXRYcxSZcoRg7/a1es7ftVSv5DQAPGRGWDrplCJh70x5JW2Js
kA6IB2K8+Ehf3F0a7O+i5q5t1oTvOvR+wIEl2TpJdx5aMVGkBt0=
=CmCH
-----END PGP SIGNATURE-----
