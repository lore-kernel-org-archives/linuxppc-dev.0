Return-Path: <SRS0=JrXR=RT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312DFC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 11:31:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A570221871
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 11:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A570221871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44M0d813KfzDqTj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 22:31:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44M0Zp0kxDzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 22:29:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44M0Zk1Lqkz9ryj;
 Sat, 16 Mar 2019 22:29:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-2 tag
Date: Sat, 16 Mar 2019 22:28:48 +1100
Message-ID: <87y35f6osv.fsf@concordia.ellerman.id.au>
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
Cc: yanaijie@huawei.com, aik@ozlabs.ru, aneesh.kumar@linux.ibm.com,
 linux-kernel@vger.kernel.org, malat@debian.org, joel@jms.id.au,
 andrew.donnellan@au1.ibm.com, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull a few small powerpc updates for 5.1:

The following changes since commit 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff:

  powerpc/32: Clear on-stack exception marker upon exception return (2019-03-04 00:37:23 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-2

for you to fetch changes up to de3c83c2fd2b87cf68214eda76dfa66989d78cb6:

  powerpc/64s: Include <asm/nmi.h> header file to fix a warning (2019-03-13 15:03:13 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.1 #2

One fix to prevent runtime allocation of 16GB pages when running in a VM (as
opposed to bare metal), because it doesn't work.

A small fix to our recently added KCOV support to exempt some more code from
being instrumented.

Plus a few minor build fixes, a small dead code removal and a defconfig update.

Thanks to:
  Alexey Kardashevskiy, Aneesh Kumar K.V, Christophe Leroy, Jason Yan, Joel
  Stanley, Mahesh Salgaonkar, Mathieu Malaterre.

- ------------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/powernv: Fix compile without CONFIG_TRACEPOINTS

Aneesh Kumar K.V (1):
      powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR configuration

Jason Yan (1):
      powerpc: remove dead code in head_fsl_booke.S

Joel Stanley (1):
      powerpc/configs: Sync skiroot defconfig

Mahesh Salgaonkar (1):
      powerpc/mm: Disable kcov for SLB routines

Mathieu Malaterre (1):
      powerpc/64s: Include <asm/nmi.h> header file to fix a warning


 arch/powerpc/configs/skiroot_defconfig       | 12 +++++++++---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 ++++++++
 arch/powerpc/kernel/head_fsl_booke.S         |  7 -------
 arch/powerpc/kernel/traps.c                  |  1 +
 arch/powerpc/mm/Makefile                     |  3 +++
 arch/powerpc/platforms/powernv/opal-call.c   |  1 +
 6 files changed, 22 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcjN2tAAoJEFHr6jzI4aWA/jIQAK4J2VQD8Sw+2kSm3h7wW18U
+BDyc7fbbigQyBHFkMAdybRKsXMSCbco7jK12yUbh5xqYlo8Hc40DbKI32f0D3WE
7rRotjalxR9tF+u0+m8Pdge42bPmEyt6p/7w5Ys+wVj/KXqlwTJinqSvp5Qmrilk
19qOTaTCXEMJ7dFTXqlFNpBW+0kaahCZ6f767dPPKkiYSm/qMZjKG/KCejLDAGQL
x5ouTpPos8sOjts7dwJuBGCxTfU7usKpy1EbguIklzYjedk1MSh5sg6STTQsH8Y4
kAgd8T12Wo4cQPaBmjwTkD7BrCdWbjNcK5U61kKAByshM3ZyPo+xARyQMdIWVZJQ
pX51tjmKwzGk3nf1UiMP/jdx55Cj6rhr3EsfQepjocMa9t6IWNVpasAvFRPlw8ca
Xmhbqsjwy9wKroAYgITq1L+VfeDe+dXBgK7yrChpqSdU89iOYgjoUbnwI+OeSCbk
Hm8w1p5+7CNxRxNzBieqBCtYUIlEwjP3rOwuNEpb0dJ4USD4jEr/8Mk0YXWJj4yg
mplyFwUXBrWVQHlKRI2tabO8rY7KN8H+SC/EczvERxpLRc3m7dH3DIlMi8A4a9Lk
QyvoQY7n9fZw1lm+/6ORMCNSc8lkIrsDu44rgn7WpaZDbN1woia0q5AtsNDU9jr2
HwUoI/HIHq5FWRu4m6LN
=TNMo
-----END PGP SIGNATURE-----
