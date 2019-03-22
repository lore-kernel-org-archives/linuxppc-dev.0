Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 13:02:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA1421900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 13:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA1421900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QkML2lsVzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 00:02:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QkGt14fjzDqQx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 23:58:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44QkGs1vRJz9sNq;
 Fri, 22 Mar 2019 23:58:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-3 tag
Date: Fri, 22 Mar 2019 23:58:08 +1100
Message-ID: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
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
Cc: malat@debian.org, ben@decadent.org.uk, mark.cave-ayland@ilande.co.uk,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some powerpc fixes for 5.1:

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-3

for you to fetch changes up to 92edf8df0ff2ae86cc632eeca0e651fd8431d40d:

  powerpc/security: Fix spectre_v2 reporting (2019-03-21 21:09:03 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.1 #3

One fix for a boot failure on 32-bit, introduced during the merge window.

A fix for our handling of CLOCK_MONOTONIC in the 64-bit VDSO. Changing the wall
clock across the Y2038 boundary could cause CLOCK_MONOTONIC to jump forward and
backward.

Our spectre_v2 reporting was a bit confusing due to a bug I introduced. On some
systems it was reporting that the count cache was disabled and also that we were
flushing the count cache on context switch. Only the former is true, and given
that the count cache is disabled it doesn't make any sense to flush it. No one
reported it, so presumably the presence of any mitigation is all people check
for.

Finally a small build fix for zsmalloc on 32-bit.

Thanks to:
  Ben Hutchings, Christophe Leroy, Diana Craciun, Guenter Roeck, Michael Neuling.

- ------------------------------------------------------------------
Ben Hutchings (1):
      powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations

Christophe Leroy (1):
      powerpc/6xx: fix setup and use of SPRN_SPRG_PGDIR for hash32

Michael Ellerman (2):
      powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
      powerpc/security: Fix spectre_v2 reporting


 arch/powerpc/include/asm/mmu.h            |  2 +-
 arch/powerpc/include/asm/vdso_datapage.h  |  8 ++++----
 arch/powerpc/kernel/cpu_setup_6xx.S       |  3 ---
 arch/powerpc/kernel/head_32.S             |  6 ++++++
 arch/powerpc/kernel/security.c            | 23 ++++++++---------------
 arch/powerpc/kernel/vdso64/gettimeofday.S |  4 ++--
 arch/powerpc/mm/hash_low_32.S             |  8 ++++----
 7 files changed, 25 insertions(+), 29 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJclNsLAAoJEFHr6jzI4aWAQlAQAKgQgvPoMIBKObYsjQ6KK6iN
lgXCrU+WuI+7f6kMMeFWP8sOeT4nA+f7ejoXJDog96Z3oBG63sZuILTlifFetFbp
0ptJA+AC0DS0k//yv2pMweZVWq2jR7Jfr213inZxwJW6NzvI9m54QK5eUXv++dkk
Q0H/PhMxNTnP0HKBYRWKSkBSvhCZd6zex5hRZFkXVfDwe6fhpYSkObInGlt2rN4s
u3NJIZLS1zqYOyx/VPwkUCsePmdqdR0/qFBYT191iFce3lmdrKociFt9/mJKkqj6
DYVbJljxJtoZ0iIztHdStvHBpbC0kaaUHTNnKEjX2Q2xL7oitiOyOa5gT98Cs8Q1
ZHfNPidZhyhdRRwIgpDKECIE7xldhG/4icTg0a7LnufjpVrbc8idUU8Hm2oaGuvu
SlytOO0AAepPFqsTy/IeKo5cT1TNhjqcPe0twxx5nOHtaY0vhtZ9azn6B/2AFfIb
y/hX6rFoIOzBDlmdRS63EdtQr9negUilUvonCWkY5luo2ypvGcNVnxdrTQww5yPA
geahb+HRm+dJb22lVp6sONHXJZRfZijBi6jJPPhSRjAVmaibCUvxYiN9MvSFQT/U
iwsMtS4dpvX8WISijEfCuiZNBEjGSoUQEIwPWqRtgaqZbHYfBFZkwrb6yGF/YjmP
wVjdhrCcut+qz2NbbDlv
=PXK6
-----END PGP SIGNATURE-----
