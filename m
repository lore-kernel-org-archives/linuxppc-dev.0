Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7qbm4pqbzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:04:35 +1100 (AEDT)
Message-Id: <cover.1507284818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/18] crypto: talitos - fixes and performance improvement
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri,  6 Oct 2017 15:04:31 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie fixes and improves the talitos crypto driver.

First 6 patchs are fixes of failures reported by the new tests in the
kernel crypto test manager.

The 8 following patches are cleanups and simplifications.

The last 4 ones are performance improvement. The main improvement is
in the one before the last, it divides by 2 the time needed for a md5
hash on the SEC1.

Christophe Leroy (18):
  crypto: talitos - fix AEAD test failures
  crypto: talitos - fix memory corruption on SEC2
  crypto: talitos - fix setkey to check key weakness
  crypto: talitos - fix AEAD for sha224 on non sha224 capable chips
  crypto: talitos - fix use of sg_link_tbl_len
  crypto: talitos - fix ctr-aes-talitos
  crypto: talitos - zeroize the descriptor with memset()
  crypto: talitos - declare local functions static
  crypto: talitos - use devm_kmalloc()
  crypto: talitos - use of_property_read_u32()
  crypto: talitos - use devm_ioremap()
  crypto: talitos - don't check the number of channels at each interrupt
  crypto: talitos - remove to_talitos_ptr_len()
  crypto: talitos - simplify tests in ipsec_esp()
  crypto: talitos - DMA map key in setkey()
  crypto: talitos - do hw_context DMA mapping outside the requests
  crypto: talitos - chain in buffered data for ahash on SEC1
  crypto: talitos - avoid useless copy

 drivers/crypto/talitos.c | 544 ++++++++++++++++++++++++++++++-----------------
 drivers/crypto/talitos.h |   7 +-
 2 files changed, 356 insertions(+), 195 deletions(-)

-- 
2.13.3
