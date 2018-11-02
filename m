Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB3C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 11:40:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A3F2081F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 11:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A3F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mg9M32GSzF370
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 22:40:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mg6N6kFyzF36n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 22:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42mg6K27dwz9sjC;
 Fri,  2 Nov 2018 22:37:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-2 tag
Date: Fri, 02 Nov 2018 22:37:26 +1100
Message-ID: <874lczemmh.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, oss@buserror.net, tyreld@linux.vnet.ibm.com,
 joel@jms.id.au, felipe.rechia@datacom.com.br, leitao@debian.org,
 aravinda@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, camelia.groza@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull a few more powerpc updates for 4.20:

The following changes since commit 58cfbac25b1fd2b76f94566aed28a3662b0ff8c6:

  Revert "selftests/powerpc: Fix out-of-tree build errors" (2018-10-26 21:58:58 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.20-2

for you to fetch changes up to 1936f094e164cc13ebf17aba1d6b34e033e64188:

  selftests/powerpc: Fix compilation issue due to asm label (2018-11-01 10:06:03 +1100)

- ------------------------------------------------------------------
powerpc fixes for 4.20 #2

Some things that I missed due to travel, or that came in late.

Two fixes also going to stable:

 - A revert of a buggy change to the 8xx TLB miss handlers.

 - Our flushing of SPE (Signal Processing Engine) registers on fork was broken.

Other changes:

 - A change to the KVM decrementer emulation to use proper APIs.

 - Some cleanups to the way we do code patching in the 8xx code.

 - Expose the maximum possible memory for the system in /proc/powerpc/lparcfg.

 - Merge some updates from Scott: "a couple device tree updates, and a fix for a
   missing prototype warning."

A few other minor fixes and a handful of fixes for our selftests.

Thanks to:
  Aravinda Prasad, Breno Leitao, Camelia Groza, Christophe Leroy, Felipe Rechia,
  Joel Stanley, Naveen N. Rao, Paul Mackerras, Scott Wood, Tyrel Datwyler.

- ------------------------------------------------------------------
Aravinda Prasad (1):
      powerpc/pseries: Export maximum memory value

Breno Leitao (1):
      selftests/powerpc: Fix ptrace tm failure

Camelia Groza (1):
      powerpc/dts/fsl: t2080rdb: reorder the Cortina PHY XFI lanes

Christophe Leroy (6):
      powerpc/8xx: Add DT node for using the SEC engine of the MPC885
      powerpc/8xx: add missing header in 8xx_mmu.c
      Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP"
      powerpc/code-patching: Add a helper to get the address of a patch_site
      powerpc/8xx: Use patch_site for memory setup patching
      powerpc/8xx: Use patch_site for perf counters setup

Felipe Rechia (1):
      powerpc/process: Fix flush_all_to_thread for SPE

Joel Stanley (5):
      selftests: powerpc: Fix warning for security subdir
      powerpc/xmon: Relax frame size for clang
      selftests/powerpc/ptrace: Fix out-of-tree build
      selftests/powerpc/signal: Fix out-of-tree build
      selftests/powerpc/pmu: Link ebb tests with -no-pie

Michael Ellerman (3):
      Merge branch 'next' of https://git.kernel.org/.../scottwood/linux into next
      selftests/powerpc/switch_endian: Fix out-of-tree build
      selftests/powerpc/cache_shape: Fix out-of-tree build

Naveen N. Rao (2):
      selftests/powerpc: Relax L1d miss targets for rfi_flush test
      selftests/powerpc: Fix compilation issue due to asm label

Paul Mackerras (1):
      KVM: PPC: Use exported tb_to_ns() function in decrementer emulation

Tyrel Datwyler (1):
      powerpc/pseries: add missing cpumask.h include file


 arch/powerpc/boot/dts/fsl/t2080rdb.dts             |  4 +-
 arch/powerpc/boot/dts/mpc885ads.dts                | 13 ++-
 arch/powerpc/include/asm/code-patching.h           |  5 ++
 arch/powerpc/include/asm/mmu-8xx.h                 | 43 ++++------
 arch/powerpc/include/asm/rtas.h                    |  1 +
 arch/powerpc/kernel/head_8xx.S                     | 97 +++++++++++++---------
 arch/powerpc/kernel/process.c                      |  3 +-
 arch/powerpc/kvm/book3s_hv.c                       |  3 +-
 arch/powerpc/kvm/emulate.c                         |  7 +-
 arch/powerpc/mm/8xx_mmu.c                          | 26 ++----
 arch/powerpc/perf/8xx-pmu.c                        | 27 +++---
 arch/powerpc/platforms/pseries/lparcfg.c           | 13 +++
 arch/powerpc/xmon/Makefile                         |  6 ++
 .../testing/selftests/powerpc/cache_shape/Makefile |  9 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |  3 +
 tools/testing/selftests/powerpc/ptrace/Makefile    | 13 +--
 .../selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c   |  4 +-
 tools/testing/selftests/powerpc/security/Makefile  |  1 +
 .../testing/selftests/powerpc/security/rfi_flush.c | 18 ++--
 tools/testing/selftests/powerpc/signal/Makefile    | 11 +--
 .../selftests/powerpc/switch_endian/Makefile       |  1 +
 tools/testing/selftests/powerpc/utils.c            |  6 +-
 22 files changed, 169 insertions(+), 145 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb3DXnAAoJEFHr6jzI4aWAYKYP/i/a94GU2Otsq92OBhi0vi0F
z465qeQYjxtLfB0+a1Pm8RE6PbiecTHdeNl11VH4Us1m0tn8RwikbfsAuM+C7R/k
LNXfIrzz77RFXQgNs5kBMeTvQG1yznSpdDfZ2xtx72Oqdcw4JHFfjCf2Dzf8i8Dl
Dn3NSaO0uppg/P4Eoi7eMZ+CgI9CpPzPQKj0wcIszHatoswKJg1AMglnAHeiERMh
ne7XkKq/h0nVydTR/+OYXSAj7CBvqSXJ1PQPVzkknvgTuPiHsmzFlffm5NVobIHN
KYI66HdJ0M0a8tpES+LovrebVGH3HPe4xtjxtxKzpUipbtsGBobroIz9EzRE+XKj
UMgnEtQziXnUU3aI1E8ctoR+e5NeLT37Q9OH6fDZgOhVo3CaVGCYf2cJP0yfsJHu
ovksMHfuQuJtZQtdflmYezVsWi1uQo60oMfTKYqvM3FYEqrZZdvjlj8S3LtTUOh6
Q8EJKSTLGUF2h8rl5CYK1LHpSbv736qc3kodjvQmFAsh+U3y0ooShfoa+O8ORylE
Q/gf4TvLPHcA/PvowUD0UQIW//SDem+CX3axORICKITjSywgIZoZj+3CSt29SFVd
Vublxd2s3zflRGseZXURvGd9Ra4U+Al4AO/rvfPYWgp6eiieRbk4fljps0gaVbaF
OAAyPTb2VPyGG6UCGrP2
=gwAL
-----END PGP SIGNATURE-----
