Return-Path: <SRS0=G0Pv=6Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C987C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 18:36:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306F220731
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 18:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2NCiBwIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306F220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49DyWr0ZZtzDrP0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2020 04:36:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=2NCiBwIE; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49DyKk1wX3zDr10
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2020 04:28:10 +1000 (AEST)
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2225C2072E;
 Sat,  2 May 2020 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588444087;
 bh=JRoG0qslFOI3mcr5Da2hc+OQhThpWXW+mf2gi5+RQ1Q=;
 h=From:To:Cc:Subject:Date:From;
 b=2NCiBwIETXytI2yuuNBdaRvpn+9UdKrMsTpl/KzWXbyjquRsOWuzxhHz77RKrA7FG
 49EwdoaQwBnUYC3bXbdQPUF05XVgyFD9+zoY+Y/wYzM+BjP4lhOI18zUcCIXY8/qFS
 nwTdTKxWSOwRlmZV3Buky12S6cZA30Gpc+w3hiI4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/7] sha1 library cleanup
Date: Sat,  2 May 2020 11:24:20 -0700
Message-Id: <20200502182427.104383-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-s390@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Theodore Ts'o <tytso@mit.edu>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

<linux/cryptohash.h> sounds very generic and important, like it's the
header to include if you're doing cryptographic hashing in the kernel.
But actually it only includes the library implementation of the SHA-1
compression function (not even the full SHA-1).  This should basically
never be used anymore; SHA-1 is no longer considered secure, and there
are much better ways to do cryptographic hashing in the kernel.

Also the function is named just "sha_transform()", which makes it
unclear which version of SHA is meant.

Therefore, this series cleans things up by moving these SHA-1
declarations into <crypto/sha.h> where they better belong, and changing
the names to say SHA-1 rather than just SHA.

As future work, we should split sha.h into sha1.h and sha2.h and try to
remove the remaining uses of SHA-1.  For example, the remaining use in
drivers/char/random.c is probably one that can be gotten rid of.

This patch series applies to cryptodev/master.

Eric Biggers (7):
  mptcp: use SHA256_BLOCK_SIZE, not SHA_MESSAGE_BYTES
  crypto: powerpc/sha1 - remove unused temporary workspace
  crypto: powerpc/sha1 - prefix the "sha1_" functions
  crypto: s390/sha1 - prefix the "sha1_" functions
  crypto: lib/sha1 - rename "sha" to "sha1"
  crypto: lib/sha1 - remove unnecessary includes of linux/cryptohash.h
  crypto: lib/sha1 - fold linux/cryptohash.h into crypto/sha.h

 Documentation/security/siphash.rst          |  2 +-
 arch/arm/crypto/sha1_glue.c                 |  1 -
 arch/arm/crypto/sha1_neon_glue.c            |  1 -
 arch/arm/crypto/sha256_glue.c               |  1 -
 arch/arm/crypto/sha256_neon_glue.c          |  1 -
 arch/arm/kernel/armksyms.c                  |  1 -
 arch/arm64/crypto/sha256-glue.c             |  1 -
 arch/arm64/crypto/sha512-glue.c             |  1 -
 arch/microblaze/kernel/microblaze_ksyms.c   |  1 -
 arch/mips/cavium-octeon/crypto/octeon-md5.c |  1 -
 arch/powerpc/crypto/md5-glue.c              |  1 -
 arch/powerpc/crypto/sha1-spe-glue.c         |  1 -
 arch/powerpc/crypto/sha1.c                  | 33 ++++++++++-----------
 arch/powerpc/crypto/sha256-spe-glue.c       |  1 -
 arch/s390/crypto/sha1_s390.c                | 12 ++++----
 arch/sparc/crypto/md5_glue.c                |  1 -
 arch/sparc/crypto/sha1_glue.c               |  1 -
 arch/sparc/crypto/sha256_glue.c             |  1 -
 arch/sparc/crypto/sha512_glue.c             |  1 -
 arch/unicore32/kernel/ksyms.c               |  1 -
 arch/x86/crypto/sha1_ssse3_glue.c           |  1 -
 arch/x86/crypto/sha256_ssse3_glue.c         |  1 -
 arch/x86/crypto/sha512_ssse3_glue.c         |  1 -
 crypto/sha1_generic.c                       |  5 ++--
 drivers/char/random.c                       |  8 ++---
 drivers/crypto/atmel-sha.c                  |  1 -
 drivers/crypto/chelsio/chcr_algo.c          |  1 -
 drivers/crypto/chelsio/chcr_ipsec.c         |  1 -
 drivers/crypto/omap-sham.c                  |  1 -
 fs/f2fs/hash.c                              |  1 -
 include/crypto/sha.h                        | 10 +++++++
 include/linux/cryptohash.h                  | 14 ---------
 include/linux/filter.h                      |  4 +--
 include/net/tcp.h                           |  1 -
 kernel/bpf/core.c                           | 18 +++++------
 lib/crypto/chacha.c                         |  1 -
 lib/sha1.c                                  | 24 ++++++++-------
 net/core/secure_seq.c                       |  1 -
 net/ipv6/addrconf.c                         | 10 +++----
 net/ipv6/seg6_hmac.c                        |  1 -
 net/mptcp/crypto.c                          |  4 +--
 41 files changed, 69 insertions(+), 104 deletions(-)
 delete mode 100644 include/linux/cryptohash.h


base-commit: 12b3cf9093542d9f752a4968815ece836159013f
-- 
2.26.2

