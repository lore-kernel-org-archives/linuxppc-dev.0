Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3655EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 13:01:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24682070C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 13:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24682070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WQ0f44MwzDqMW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 00:01:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WPyM0q45zDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 23:59:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43WPyL5KDNz9rxp;
 Fri,  4 Jan 2019 23:59:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-2 tag
Date: Sat, 05 Jan 2019 00:00:03 +1100
Message-ID: <87ftu8y3vw.fsf@concordia.ellerman.id.au>
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
Cc: diana.craciun@nxp.com, malat@debian.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some powerpc fixes for 4.21:

The following changes since commit 96d4f267e40f9509e8a66e2b39e8b95655617693:

  Remove 'type' argument from access_ok() function (2019-01-03 18:57:57 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.21-2

for you to fetch changes up to 074400a7be61250d9f0ccec07d5c35ffec4d8d22:

  powerpc: Drop use of 'type' from access_ok() (2019-01-04 23:07:59 +1100)

- ------------------------------------------------------------------
powerpc fixes for 4.21 #2

A fix for the recent access_ok() change, which broke the build. We recently
added a use of type in order to squash a warning elsewhere about type being
unused.

A handful of other minor build fixes, and one defconfig update.

Thanks to:
  Christian Lamparter, Christophe Leroy, Diana Craciun, Mathieu Malaterre.

- ------------------------------------------------------------------
Christian Lamparter (1):
      powerpc/4xx/ocm: Fix compilation error due to PAGE_KERNEL usage

Diana Craciun (1):
      powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

Mathieu Malaterre (1):
      powerpc: Drop use of 'type' from access_ok()

Michael Ellerman (4):
      powerpc/4xx/ocm: Fix phys_addr_t printf warnings
      powerpc/configs: Add PPC4xx_OCM to ppc40x_defconfig
      KVM: PPC: Book3S HV: radix: Fix uninitialized var build error
      Merge branch 'master' into fixes


 arch/powerpc/configs/ppc40x_defconfig  |  1 +
 arch/powerpc/include/asm/uaccess.h     |  2 +-
 arch/powerpc/kernel/head_booke.h       | 18 ++++++++++++------
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
 arch/powerpc/platforms/4xx/ocm.c       | 10 +++++-----
 5 files changed, 20 insertions(+), 13 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcL1eOAAoJEFHr6jzI4aWA86wP/3V5zlUNtsyXpcCx60PNIMya
6z6oWVKoM92nMIyfWuoxKBEbylSyixFSxOsKoiVJDyigW5WWNjsPQ1KOUD2OVn0V
OQhj2aDXwUtxdlQ5dK0H9lodsUKUEw1/saqcgi2OS8iDDa8kJIEemDe29Omf5DyE
U2RKl++nhAfK8BLfMRCAIqL+TVZq9Zy+zNwbVtsmj7lAlw+Csb4KV3YvlJ7b6pjD
Ntm6O3X8sy7GtJdMpeBDOMTbWuvIQpefVH135jS1IjJZbrafZK6a4gQ9cs5mx68d
+/nyzkcjy83eRGkv3QY5Y+vEa0wkFdBb6Nf0MH63xCPVYVjom6pRUGL+RPldi2GO
bmieDXavlicX9y+BCQSKASTzNo2uR2heF31aCnr6bsOSeT8ZNGbIwgHuGGqrzN+8
qLQb00hA0uKlbNgPpNoyYO5K3khntR348HfH0Uwlm3Nttvn1TEh87c9L19FcdlMw
SlA6kpJ6328FkEv5FUPu7v7764dPgOQNImPKnsYdhbUxhHnDMx33LzsUEQQcYWpM
3nsKQMW1yqMH2BG8u9LQtZErFanX+RNm81OsP38F8nvGe1RJkoq7R7MSooZ9tzs2
Ymf8W+KNofKmXVAPh7AyKQzpy0a/sEqAXmtTPBf7bsdwU5PQB0+LMf0yzyZpEp2U
3eFcseqDoO32ScDZQUYt
=Y+yv
-----END PGP SIGNATURE-----
