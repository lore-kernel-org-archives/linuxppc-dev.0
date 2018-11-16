Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B3C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1502087C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1502087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xH2m1gTMzDr8p
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 23:04:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xGz8716vzF3mR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 23:01:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42xGz70vT8z9sBn;
 Fri, 16 Nov 2018 23:01:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-3 tag
Date: Fri, 16 Nov 2018 23:01:02 +1100
Message-ID: <87in0x2pvl.fsf@concordia.ellerman.id.au>
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
Cc: alistair@popple.id.au, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 gromero@linux.vnet.ibm.com, oss@buserror.net, sathnaga@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 4.20:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.20-3

for you to fetch changes up to b2fed34a628df6118b5d4e13f49a33e15f704fa9:

  selftests/powerpc: Adjust wild_bctr to build with old binutils (2018-11-15 23:05:17 +1100)

- ------------------------------------------------------------------
powerpc fixes for 4.20 #3

Two weeks worth of fixes since rc1.

 - I broke 16-byte alignment of the stack when we moved PPR into pt_regs.
   Despite being required by the ABI this broke almost nothing, we eventually
   hit it in code where GCC does arithmetic on the stack pointer assuming the
   bottom 4 bits are clear. Fix it by padding the in-kernel pt_regs by 8 bytes.

 - A couple of commits fixing minor bugs in the recent SLB rewrite.

 - A build fix related to tracepoints in KVM in some configurations.

 - Our old "IO workarounds" code written for Cell couldn't coexist in a kernel
   that runs on Power9 with the Radix MMU, fix that.

 - Remove the NPU DMA ops, these just printed a warning and should never have
   been called.

 - Suppress an overly chatty message triggered by CPU hotplug in some configs.

 - Two small selftest fixes.

Thanks to:
  Alistair Popple, Gustavo Romero, Nicholas Piggin, Satheesh Rajendran, Scott Wood.

- ------------------------------------------------------------------
Alistair Popple (1):
      powerpc/powernv/npu: Remove NPU DMA ops

Gustavo Romero (1):
      selftests/powerpc: Adjust wild_bctr to build with old binutils

Michael Ellerman (6):
      powerpc/mm/64s: Consolidate SLB assertions
      powerpc/mm/64s: Use PPC_SLBFEE macro
      powerpc/mm/64s: Only use slbfee on CPUs that support it
      powerpc/mm/64s: Fix preempt warning in slb_allocate_kernel()
      powerpc/io: Fix the IO workarounds code to work with Radix
      selftests/powerpc: Fix wild_bctr test to work on ppc64

Nicholas Piggin (1):
      powerpc/64: Fix kernel stack 16-byte alignment

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE


 arch/powerpc/include/asm/io.h                  | 20 +++-----
 arch/powerpc/include/asm/ppc-opcode.h          |  2 +
 arch/powerpc/include/asm/ptrace.h              |  1 +
 arch/powerpc/kernel/setup_64.c                 |  2 +
 arch/powerpc/kvm/trace.h                       |  8 +++-
 arch/powerpc/kvm/trace_booke.h                 |  9 +++-
 arch/powerpc/kvm/trace_hv.h                    |  9 +++-
 arch/powerpc/kvm/trace_pr.h                    |  9 +++-
 arch/powerpc/mm/numa.c                         |  2 +-
 arch/powerpc/mm/slb.c                          | 35 ++++++--------
 arch/powerpc/platforms/powernv/npu-dma.c       | 64 ++------------------------
 tools/testing/selftests/powerpc/mm/wild_bctr.c | 21 +++++++--
 12 files changed, 76 insertions(+), 106 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb7rB9AAoJEFHr6jzI4aWA7uYP/2bbEUaIpGw2OP5AxedSWtIh
7RBX5rtzC8sA+ifpI7utcz8woOH+8HmzXf3f0BsjLlDZO61dCBzPM8yEkgiHmEMH
t1ApMKCUkwTI1R+1somVhyV2fYct+Eb9Qa929IIKqgC5r8nElYqaE7jr56U7jFQE
TZwMoeThTGxfXMa+IuSWLGtvbUeC6LtKoWjoynnZQC4RMQqKRc8xaRpN5W//ZQyq
dtQ8kc9UWrSl5xj5ah/evn/0oWl1cSX95juO00rGsTL5iuUQNcUVZcJAmwoiPAN/
GCNYDLqEX8SwzKidnAmTR6AUBSLP48kGKrUwjMZVfvT0SMNyIL9lq9u6N5ucyq+u
b0HLMrlqZiYasL3fsKHo+dbJ1emzZdjMIYNe/x+6GAgfBTvRePkqVwLgB1uSOjdr
k41aDRaoagOUbIs6y6tXHyp/mFbP3VswBA9n1ZGjr/KsgrlBQftCTOeSuPKSdAf+
WKrzakoj4SIvOZdUGbttb0HJHFHE5xCGIzGH7NaO/AyfFzkIZjq86TU4skqN0nQw
lgHNA9QgXlpBMwRvEBM28FW058bsVw7Dgez/vJijlEQNC7fi6TDJTzYiroBEdmF4
82FEUU9ZECw+zb6OI7E3VntTqWdM8E3qCGI9tLoCrFpoagERHfayTTsW7iQJ/Scj
dTL6b40yqw88T+myURIZ
=lNgM
-----END PGP SIGNATURE-----
