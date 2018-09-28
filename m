Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B175EC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1062168B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1062168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M8rZ1xLszF3F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 21:41:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M8pS0zwCzF3DY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 21:39:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42M8pR5hSsz9s3x;
 Fri, 28 Sep 2018 21:39:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.19-3 tag
Date: Fri, 28 Sep 2018 21:39:10 +1000
Message-ID: <87r2hdua01.fsf@concordia.ellerman.id.au>
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
Cc: mikey@neuling.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, mwb@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Greg,

Please pull some more powerpc fixes for 4.19:

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.19-3

for you to fetch changes up to 7e0cf1c983b5b24426d130fd949a055d520acc9a:

  selftests/powerpc: Fix Makefiles for headers_install change (2018-09-28 15:07:45 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.19 #3

A reasonably big batch of fixes due to me being away for a few weeks.

A fix for the TM emulation support on Power9, which could result in corrupting
the guest r11 when running under KVM.

Two fixes to the TM code which could lead to userspace GPR corruption if we take
an SLB miss at exactly the wrong time.

Our dynamic patching code had a bug that meant we could patch freed __init text,
which could lead to corrupting userspace memory.

csum_ipv6_magic() didn't work on little endian platforms since we optimised it
recently.

A fix for an endian bug when reading a device tree property telling us how many
storage keys the machine has available.

Fix a crash seen on some configurations of PowerVM when migrating the partition
from one machine to another.

A fix for a regression in the setup of our CPU to NUMA node mapping in KVM
guests.

A fix to our selftest Makefiles to make them work since a recent change to the
shared Makefile logic.

Thanks to:
  Alexey Kardashevskiy, Breno Leitao, Christophe Leroy, Michael Bringmann,
  Michael Neuling, Nicholas Piggin, Paul Mackerras,, Srikar Dronamraju, Thiago
  Jung Bauermann, Xin Long.

- ------------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size (again)

Christophe Leroy (1):
      powerpc: fix csum_ipv6_magic() on little endian platforms

Michael Bringmann (1):
      powerpc/pseries: Fix unitialized timer reset on migration

Michael Ellerman (1):
      selftests/powerpc: Fix Makefiles for headers_install change

Michael Neuling (4):
      KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM workarounds
      powerpc: Avoid code patching freed init sections
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Srikar Dronamraju (1):
      powerpc/numa: Use associativity if VPHN hcall is successful

Thiago Jung Bauermann (1):
      powerpc/pkeys: Fix reading of ibm, processor-storage-keys property


 arch/powerpc/include/asm/setup.h                     |  1 +
 arch/powerpc/kernel/exceptions-64s.S                 |  4 ++--
 arch/powerpc/kernel/tm.S                             | 20 +++++++++++++++++---
 arch/powerpc/lib/checksum_64.S                       |  3 +++
 arch/powerpc/lib/code-patching.c                     |  6 ++++++
 arch/powerpc/mm/mem.c                                |  2 ++
 arch/powerpc/mm/numa.c                               |  7 +++++--
 arch/powerpc/mm/pkeys.c                              |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c        |  2 +-
 tools/testing/selftests/powerpc/alignment/Makefile   |  1 +
 tools/testing/selftests/powerpc/benchmarks/Makefile  |  1 +
 tools/testing/selftests/powerpc/cache_shape/Makefile |  1 +
 tools/testing/selftests/powerpc/copyloops/Makefile   |  1 +
 tools/testing/selftests/powerpc/dscr/Makefile        |  1 +
 tools/testing/selftests/powerpc/math/Makefile        |  1 +
 tools/testing/selftests/powerpc/mm/Makefile          |  1 +
 tools/testing/selftests/powerpc/pmu/Makefile         |  1 +
 tools/testing/selftests/powerpc/pmu/ebb/Makefile     |  1 +
 tools/testing/selftests/powerpc/primitives/Makefile  |  1 +
 tools/testing/selftests/powerpc/ptrace/Makefile      |  1 +
 tools/testing/selftests/powerpc/signal/Makefile      |  1 +
 tools/testing/selftests/powerpc/stringloops/Makefile |  1 +
 .../testing/selftests/powerpc/switch_endian/Makefile |  1 +
 tools/testing/selftests/powerpc/syscalls/Makefile    |  1 +
 tools/testing/selftests/powerpc/tm/Makefile          |  1 +
 tools/testing/selftests/powerpc/vphn/Makefile        |  1 +
 26 files changed, 55 insertions(+), 9 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAluuEqoACgkQUevqPMjh
pYDd2Q/9FuvhAY3jn89VcWFATv8bst/h0ujZp9w9IJapA3Pa3kAktrFo7arwvbqM
M1ffcbuU+klIYL0PpJN1pN19xZCd+vsYmmlx4OwpXBmA9+hIyX6WKo5rxLDc/cbq
N8b6ARmA4b8qIXSeLlUZ8WjQ+Qw19DzNLNq7MpCFHS1fkaE8ozn9bQLm+8v/M9Qz
6lKneV3pSvGIDI0PQOP3FC6TNKdR36MVng1LW9lKlt8y3gJFboNaP/5QGz7x3sBP
qe4cqxx9F9GlJyonQxz6T0PcoxFpk2DTKnxlnJ2okT7QG30hXXdJkgWStE58Xgyp
8yTJYZ+KXcpt/hfwMR82RVP9TzDr1UwXnuWF8slkoEu+y+YcZrlnajzoZVgojXqH
aU4k3pcQJXOU0evOz9+TvL23ilV6dCRIt5Fv9Hy3+QUnc2+2iFe3+AEPIKAXUWPG
mPhI37020GLBfi+ymUIoJ8vRwahQEcr2aH+uWndjV8+4FgNw3ygLbTGCAnsh4nHq
y1jUm1Ep5tjhM9IkKPTvY5IrAdUnOdfaZ8ZkS1hawf4P8po4wxzxhDxSce5N69W0
sLsmPnNvtnMS75pAMa68pGCxAJV34CmW57RhNNom3zU3Of7le/ZG3tX7IODqLpKT
8E2Ijaseq4M0hOyHvTVxABNErxWyDIOO7YFJTg/7Qwkf3P/tL/w=
=V+r1
-----END PGP SIGNATURE-----
