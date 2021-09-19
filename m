Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCFC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Sep 2021 13:11:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCB660F0F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Sep 2021 13:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BCB660F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HC7Pc5gnjz3056
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Sep 2021 23:11:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PrS8xBVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=PrS8xBVJ; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HC7Nr1TVKz2xrM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Sep 2021 23:11:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1632057065;
 bh=72IPhh7RuIGTEvyrIjs6WnEABlmeKQrraAdsE7FrU1c=;
 h=From:To:Cc:Subject:Date:From;
 b=PrS8xBVJWwiCRQ9nbO9B+oU6hZlNXeM/g6FJZ3RiQ0FaSVhr9yISG0ewvXMUOFOF4
 bZay9ZZdlbr4Gl+Ij9WQJVay9A8kNLGHMZ7KeoAvqX7Btpw68re2jSasZg4FFci3C8
 9k0cQEYAXSAqZGs21+JXHYO7TtLTgyvn8oOovsvIABQik5kGAQHu12e1sP1uD0DCCW
 ZNmBDEv54lvC4cgNl52bfFSesQz7iszRaw3ZEbMwpPd0o05jzoFi1nc+edsV8sN3+6
 t9Kc81qm2WL9iBSXiv9/SYCOIahcNZEmzBoLsW/ySJFjZxQEb1Ydb+l8qiZTwLcJaB
 8ahS6H2byXX1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HC7Nn1pC9z9sRK;
 Sun, 19 Sep 2021 23:11:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-2 tag
Date: Sun, 19 Sep 2021 23:11:04 +1000
Message-ID: <87o88oiuc7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, ganeshgr@linux.ibm.com, clg@kaod.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 5.15:

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.15-2

for you to fetch changes up to c006a06508db4841d256d82f42da392d6391f3d9:

  powerpc/xics: Set the IRQ chip data for the ICS native backend (2021-09-1=
5 22:05:53 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.15 #2

Fix crashes when scv (System Call Vectored) is used to make a syscall when =
a transaction
is active, on Power9 or later.

Fix bad interactions between rfscv (Return-from scv) and Power9 fake-suspen=
d mode.

Fix crashes when handling machine checks in LPARs using the Hash MMU.

Partly revert a recent change to our XICS interrupt controller code, which =
broke the
recently added Microwatt support.

Thanks to: C=C3=A9dric Le Goater, Eirik Fuller, Ganesh Goudar, Gustavo Rome=
ro, Joel Stanley,
Nicholas Piggin.

- ------------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      powerpc/xics: Set the IRQ chip data for the ICS native backend

Ganesh Goudar (1):
      powerpc/mce: Fix access error in mce handler

Nicholas Piggin (4):
      powerpc/64s: system call scv tabort fix for corrupt irq soft-mask sta=
te
      selftests/powerpc: Add scv versions of the basic TM syscall tests
      powerpc/64s: system call rfscv workaround for TM bugs
      KVM: PPC: Book3S HV: Tolerate treclaim. in fake-suspend mode changing=
 registers


 arch/powerpc/kernel/interrupt.c                     | 43 +++++++++++++++++=
+++
 arch/powerpc/kernel/interrupt_64.S                  | 41 -----------------=
--
 arch/powerpc/kernel/mce.c                           | 17 +++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S             | 36 +++++++++++++++-
 arch/powerpc/sysdev/xics/xics-common.c              |  4 +-
 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S | 37 ++++++++++++++++-
 tools/testing/selftests/powerpc/tm/tm-syscall.c     | 36 ++++++++++++----
 7 files changed, 159 insertions(+), 55 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmFHMuoACgkQUevqPMjh
pYD59RAAsMPzDU+iT15Vm2dC9Ar4hmlLvC0Ew3I/JigC/XSf1bcyGPM4ybSUsoLj
wop5AeOyoaAtegWki3HxMM5iC99KRI9GuJd8Fa8yrSwKYz/O+6oqVJdq0oJY/rLl
NpHDgFCencKya/H0UV+Xobfb41ol25bGchMfcuhQw5G6JVCtWbYSFQXUefTcC3lt
GjYy9jLzvNT7DGlmJBJaeIU78vqRbXLmbHgBwLhxIIBD0us48BQX4elDWcP5Jjwr
UMyz962EaWLAb/nyac9BHzqO9OS6awYJGI5lx3CPJz3+VA6RI/Vu8WoentfejupP
GaiGnCcRBnUAkcUuapy0XQtcv9197yOLkLi5XUPgS82o9EuI2+TLtpoZCwLBOceu
HLpcjYbxf6rV79wYb+P5+oZkPIUi+JWEzF9hCMSFDIJO3mY8rqoDqbEnGEIdiQUi
6IhihFw6s4a15vd+sn0J1KsUvceeA98zE/7zFXW1tYTqxn2zlJFn923EJuHMr+24
mCQb4JvsWlUi+8YuEvr1659I0nstFJaUxY1BFDuFr5oR4/ZFDwnRUs2JbAw8No8Y
uzM7wuq1PMswnKLm5cnR3tsYOVgwTdR6O9wCe3Uva4PoOoB5Y97VpSU8ElfPI+c+
ePdHNteAjRiMLTggWzLryCUNw+2T8wny/r9nyx5tfI2JswXgSvg=3D
=3DKZ/U
-----END PGP SIGNATURE-----
