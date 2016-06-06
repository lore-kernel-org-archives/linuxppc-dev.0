Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNZdW6D4fzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 23:03:43 +1000 (AEST)
Message-Id: <cover.1464390094.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/7] crypto: talitos - implementation of AEAD for SEC1
To: Kim Phillips <kim.phillips@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Mon,  6 Jun 2016 13:20:31 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches provides the implementation of AEAD for
talitos SEC1.

Changes in v2:
* Fixed compilation issue introduced by later cosmetic changes
requested by checkpatch script
* split "making mapping helpers more generic" in two parts
to better see the changes done after the move.
* reworked the DMA sync associated with mapping in order to not
spend time syncing several times

Christophe Leroy (7):
  crypto: talitos - using helpers for all talitos_ptr operations
  crypto: talitos - move mapping helpers before IPSEC functions
  crypto: talitos - making mapping helpers more generic
  crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU
  crypto: talitos - sg_to_link_tbl() not used anymore, remove it
  crypto: talitos - implement cra_priority
  crypto: talitos - templates for AEAD using HMAC_SNOOP_NO_AFEU

 drivers/crypto/talitos.c | 672 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 426 insertions(+), 246 deletions(-)

-- 
2.1.0
