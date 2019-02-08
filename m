Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDFC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:37:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2262146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2262146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wyTG43sczDqc7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:37:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwbH26p9zDqWx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wwbG3qW9z9sN9;
 Sat,  9 Feb 2019 00:12:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-4 tag
Date: Sat, 09 Feb 2019 00:12:56 +1100
Message-ID: <87r2ciiftz.fsf@concordia.ellerman.id.au>
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
Cc: aneesh.kumar@linux.ibm.com, oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 5.0:

The following changes since commit 7bea7ac0ca0121798f3618d16201ca4dc4e67a00:

  powerpc/syscalls: Fix syscall tracing (2019-01-15 21:32:25 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-4

for you to fetch changes up to 5a3840a470c41ec0b85cd36ca80370330656b163:

  powerpc/papr_scm: Use the correct bind address (2019-02-01 10:13:51 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.0 #4

Just two fixes, both going to stable.

Our support for split pmd page table lock had a bug which could lead to a crash
on mremap() when using the Radix MMU (Power9 only).

A fix for the PAPR SCM driver (nvdimm) we added last release, which had a bug
where we might mis-handle a hypervisor response leading to us failing to attach
the memory region.

Thanks to:
  Aneesh Kumar K.V, Oliver O'Halloran.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/radix: Fix kernel crash with mremap()

Oliver O'Halloran (1):
      powerpc/papr_scm: Use the correct bind address


 arch/powerpc/include/asm/book3s/64/pgtable.h | 22 +++++++---------------
 arch/powerpc/mm/pgtable-book3s64.c           | 22 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/papr_scm.c    |  5 ++++-
 3 files changed, 33 insertions(+), 16 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcXYAdAAoJEFHr6jzI4aWAGAwP/1VlkYVIU0gA+x3iifUW0vD+
MhDhWuzFYpP1xfy5rMvEtwQ+IbwgO/j4220NilCAbCNbB69Ccj6x4mdPayTLWswi
lVb8VVKG0kre0sj0hXm15j/ZEhkIwGuAzu1FH/q6mf0kyEOCsdUiZ1k+vDjWtgJS
TzrpmstgCMlkAtJSq2RfGdWTqQc2N5uZktyjobpmkubvBm9PoEgjA/f+LwMmxZEa
M83cOdQ8HXKV+tZVMftUR9dfDuDo2L+5EhXdrBgreAF0haEtVo9JALp4rwvCdS4H
c5SzuJSNnaBvGTzCVmwOadWJHH8/Ok3N0ryC991SeAonYLedOQhSVZRzgqN9nCF2
KIGahudY5djIMTe41FXDsHC95yYuH6C8rfDPJBZUj6o9I6N98Xjz0gASoMFRJ71p
25kskxbH7ehL3ZdAENp93MmNS0gXyBkfhYs2JGKy+ufdlELUh8Yn6q0kJxrqgGnj
Cc9i221OXkRbi8Z0eZeAdWzzz48cdmqio2bvT679xwghRtFXfy1BhGv0m9F9evS4
TGTIKL/al/UVtCEStjdbTT9XGovGqrUSbIqe7MDaH478cGrQjBTVdwn6eU2G48Vh
nZMyY7g5J3BQWeE9vOkX8T9T/9ChwIIXDDjiXYr76+7jcgamWH9VL6bCwKQO00Lx
+9G3ikkFDRcFqleuTrf3
=BKaS
-----END PGP SIGNATURE-----
