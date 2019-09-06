Return-Path: <SRS0=7NNx=XB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13AC00307
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Sep 2019 04:49:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD26D2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Sep 2019 04:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD26D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46PlTv5DLJzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Sep 2019 14:49:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46PlRN3MhRzDr6x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2019 14:47:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46PlRM2RTZz9s7T;
 Fri,  6 Sep 2019 14:47:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-5 tag
Date: Fri, 06 Sep 2019 14:47:37 +1000
Message-ID: <87ftlaxc7q.fsf@mpe.ellerman.id.au>
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
Cc: michaelellerman@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, gromero@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.3:

The following changes since commit ed4289e8b48845888ee46377bd2b55884a55e60b:

  Revert "powerpc: slightly improve cache helpers" (2019-07-31 22:56:27 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-5

for you to fetch changes up to a8318c13e79badb92bc6640704a64cc022a6eb97:

  powerpc/tm: Fix restoring FP/VMX facility incorrectly on interrupts (2019-09-04 22:31:13 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.3 #5

One fix for a boot hang on some Freescale machines when PREEMPT is enabled.

Two CVE fixes for bugs in our handling of FP registers and transactional memory,
both of which can result in corrupted FP state, or FP state leaking between
processes.

Thanks to:
  Chris Packham, Christophe Leroy, Gustavo Romero, Michael Neuling.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/64e: Drop stale call to smp_processor_id() which hangs SMP startup

Gustavo Romero (2):
      powerpc/tm: Fix FP/VMX unavailable exceptions inside a transaction
      powerpc/tm: Fix restoring FP/VMX facility incorrectly on interrupts


 arch/powerpc/kernel/process.c | 21 ++++-----------------
 arch/powerpc/mm/nohash/tlb.c  |  1 -
 2 files changed, 4 insertions(+), 18 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl1x48cACgkQUevqPMjh
pYBCuRAAo/buJyqBbDaN8qnw1L0gusb8KF3/j9rmoMQYTmwJROtodWnK7Yxf79LI
t8Fj94ENYaEZRazpJ379Yp2qWCIExfmWpv4GdVoLKuZwVi6aM4H5iRTSZ6SSbTY6
Rdseae17IbV4oXwEzYLjYdDtgVdrJbcWEqbdxLkffkn+km35Idz3jD5WeWXx0RQy
H0YtaZfj79caxB6Db78xY/z9ocq4zPNljI2Ghd0bvC7NmsELAVUl0/8RFn6qjRM9
LZM+Oi64Z7JnLz/FRtD/RNZSK4xAwq7vh/BdSzDGiGbaNX1o0OysxQHzv8ePwABC
GE42CqQ326vx4uICkaA7uFJ6F94s6PF1F+6XjiI0hm2STPsn0QuHd+yWKkHXMx23
VU/SvZWK3PC6HJgyCQQvmdY7g/UrcXpA0pr2IUhCnxmT2MrbFceYopSnueoag7An
WAVombwtfaFLRv8g8yV2E0y8K1X3AmfIpZBFK95zMg3uQPTiuA5Z2lFcU6L131g0
pr3K3OkR9vOn5crxOba8osjhwseNcpcvynkT5xzpRewrIpUSkl0tzwwue5jox6NX
KPV2eooGNfEcdYhuum41k+2Ps9y2aNdIXkhAdqXqTArpOdTSjdDNd+CxlHg8ZGl7
S9LffbbZhsxY4++6xSiLhhfAYQi/QjEuL6HQjy+DENEdSc+BmF8=
=nAqV
-----END PGP SIGNATURE-----
