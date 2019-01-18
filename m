Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D08C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 12:47:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD76D2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 12:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD76D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h1204V07zDr0r
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 23:47:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h0yv53QTzDr09
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 23:45:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43h0yt13J2z9sBn;
 Fri, 18 Jan 2019 23:45:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-3 tag
Date: Fri, 18 Jan 2019 23:45:09 +1100
Message-ID: <875zum3zje.fsf@concordia.ellerman.id.au>
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
Cc: Jason@zx2c4.com, maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, leitao@debian.org,
 fbarrat@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, dan.carpenter@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 5.0:

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-3

for you to fetch changes up to 7bea7ac0ca0121798f3618d16201ca4dc4e67a00:

  powerpc/syscalls: Fix syscall tracing (2019-01-15 21:32:25 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.0 #3

A couple of weeks of fixes.

There's one fix for an oops on Power9 machines with Open CAPI adapters.

And a fix for probable memory corruption in some of the new NPU code, caught by
smatch though and not seen in the wild.

Plus a few other minor fixes.

There's one non-fix which is the perf_regs change. That was sent during the
merge window but I accidentally only merged the first of two patches in the
series. It's been in linux-next so hopefully doesn't conflict with anything in
acme's tree.

Thanks to:
 Alexey Kardashevskiy, Andrew Donnellan, Breno Leitao, Christian Lamparter,
 Christophe Leroy, Dan Carpenter, Frederic Barrat, Greg Kurz, Jason A.
 Donenfeld, Madhavan Srinivasan.

- ------------------------------------------------------------------
Breno Leitao (1):
      powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Christophe Leroy (1):
      powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.

Dan Carpenter (1):
      powerpc/powernv/npu: Allocate enough memory in pnv_try_setup_npu_table_group()

Frederic Barrat (1):
      powerpc/powernv/npu: Fix oops in pnv_try_setup_npu_table_group()

Jason A. Donenfeld (1):
      powerpc/pseries: Fix build break due to pnv_npu2_init()

Madhavan Srinivasan (1):
      powerpc/perf: Update perf_regs structure to include MMCRA

Michael Ellerman (2):
      powerpc/4xx/ocm: Fix fix for phys_addr_t printf warnings
      powerpc/syscalls: Fix syscall tracing


 arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
 arch/powerpc/kernel/head_8xx.S                  | 3 ++-
 arch/powerpc/kernel/signal_64.c                 | 7 ++++---
 arch/powerpc/kernel/trace/ftrace.c              | 7 -------
 arch/powerpc/perf/perf_regs.c                   | 6 ++++++
 arch/powerpc/platforms/4xx/ocm.c                | 6 +++---
 arch/powerpc/platforms/powernv/npu-dma.c        | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c       | 3 ++-
 arch/powerpc/platforms/pseries/pci.c            | 2 ++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
 tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
 tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
 12 files changed, 25 insertions(+), 17 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcQcoIAAoJEFHr6jzI4aWA4SkP/ibxCnRlUIJUmMZSD7qeQan9
iV8Duht2BXjUrTrhU2F8PQ20SeKi9Bp5mMUJ96fh0bOeuc+VK375x4bqKyXb1buP
L/zMEDQFWtKOYRE/8wMsA3xdD7x69z/E7gpzEJMEX9SpWALTRBrMiSI3adqLM4vI
ri17SPIJxvJQ85qGOymBWWgN7FSjIXtOm8Dlp2aSJ3rTi6AirQQXIdbZtl9fMtgv
cu7mmF7Vs6BvyThUSPUvCSY6ilWVOcwNV/Zg9KVwMpCHh07U9cbWNv6bp0sa64j0
yavmIYZeRflTEJ7NI6EzBMCws0nNBytWfxWkSeSobQT2Rnpx3ColMMAy035E+EGU
NVxrbrV9J4PtDo87RWUNGLSodUNgcg6rW/Zhvlt5PpSh4WOQopOYKmWS1tYqLP9S
o1EEkZ/vrAkM0syPBrdgMEV2Qzz5xuE7LOZPZNCeQyfUUGeUgLuc77i1BVjcBQ/4
/5PmkHdMw3iG65UJ1IGT4GLHiHmjWyZqrdCw0/bpHaIlNaC5/Jx3ZenJdVbTiEhv
h5c3+cWZPk6ILfvFqzrUuRJVM3Z3Ta4+uHA9yruQZZOgfkx8CADDxsSwSMhYqa6R
R7zVVoQO6JdwRlrwPe35IzppAiWjVrUJMOqbbGBp2/YcpEpUw2tMJDeFhSglrYQL
YFZw+ENrBcoqwduu0xDI
=BgXi
-----END PGP SIGNATURE-----
