Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3CJ0C5czDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:10:36 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id p14so16006975wrg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:10:35 -0700 (PDT)
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, x86@kernel.org, horia.geanta@nxp.com,
 dan.douglass@nxp.com, thomas.lendacky@amd.com, gary.hook@amd.com,
 harsh@chelsio.com, matthias.bgg@gmail.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 00/11] crypto: gcm - add GCM IV size constant
Date: Tue, 22 Aug 2017 10:08:07 +0200
Message-Id: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many GCM users use directly GCM IV size instead of using some constant.

This patch add all IV size constant used by GCM and convert drivers for using them..

Corentin Labbe (11):
  crypto: gcm - add GCM iv size constant
  crypto: caam - Use GCM IV size constant
  crypto: ccp - Use GCM IV size constant
  crypto: nx - Use GCM IV size constant
  crypto: atmel - Use GCM IV size constant
  crypto: bcm - Use GCM IV size constant
  crypto: mediatek - Use GCM IV size constant
  crypto: chelsio - Use GCM IV size constant
  crypto: omap - Use GCM IV size constant
  crypto: gcm - Use GCM IV size constant
  crypto: aesni - Use GCM IV size constant

 arch/x86/crypto/aesni-intel_glue.c         |  7 ++++---
 crypto/gcm.c                               | 23 ++++++++++++-----------
 drivers/crypto/atmel-aes.c                 |  5 +++--
 drivers/crypto/bcm/cipher.c                |  8 ++++----
 drivers/crypto/bcm/cipher.h                |  3 +--
 drivers/crypto/caam/caamalg.c              | 10 +++++-----
 drivers/crypto/caam/compat.h               |  1 +
 drivers/crypto/ccp/ccp-crypto-aes-galois.c |  9 ++++-----
 drivers/crypto/chelsio/chcr_algo.c         |  9 +++++----
 drivers/crypto/mediatek/mtk-aes.c          |  3 ++-
 drivers/crypto/nx/nx-aes-gcm.c             |  9 +++++----
 drivers/crypto/omap-aes-gcm.c              |  7 ++++---
 drivers/crypto/omap-aes.c                  |  5 +++--
 include/crypto/gcm.h                       |  8 ++++++++
 14 files changed, 61 insertions(+), 46 deletions(-)
 create mode 100644 include/crypto/gcm.h

-- 
2.13.0
