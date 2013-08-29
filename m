Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23FC02C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 00:37:13 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Thu, 29 Aug 2013 11:37:07 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id AE1D71DC0068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 10:37:04 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7TEZZAO16777454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 11:35:35 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7TEb3Kw025601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 11:37:04 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au
Subject: [PATCH v2 00/10] Series of fixes for NX driver
Date: Thu, 29 Aug 2013 11:36:30 -0300
Message-Id: <1377787000-4966-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches contains fixes in several algorithms implemented
by the NX driver. The patches can be separated in three different
categories:
  
 - Changes to split the data in several hyper calls to respect the
   limits of data that the co-processador can handle. This affects
   all AES modes.
 - Fixes in how the driver handle zero length messages. This affects
   XCBC and GCM.
 - Fixes for SHA-2 when chunks bigger than the block size are provided.

v2:
 - Fixed conflict.

Fionnuala Gunter (2):
  crypto: nx - fix limits to sg lists for AES-XCBC
  crypto: nx - fix limits to sg lists for AES-CCM

Marcelo Cerri (8):
  crypto: nx - add offset to nx_build_sg_lists()
  crypto: nx - fix limits to sg lists for AES-ECB
  crypto: nx - fix limits to sg lists for AES-CBC
  crypto: nx - fix limits to sg lists for AES-CTR
  crypto: nx - fix limits to sg lists for AES-GCM
  crypto: nx - fix XCBC for zero length messages
  crypto: nx - fix GCM for zero length messages
  crypto: nx - fix SHA-2 for chunks bigger than block size

 drivers/crypto/nx/nx-aes-cbc.c  |  50 ++++---
 drivers/crypto/nx/nx-aes-ccm.c  | 297 +++++++++++++++++++++++++++++-----------
 drivers/crypto/nx/nx-aes-ctr.c  |  50 ++++---
 drivers/crypto/nx/nx-aes-ecb.c  |  48 ++++---
 drivers/crypto/nx/nx-aes-gcm.c  | 292 ++++++++++++++++++++++++++++++---------
 drivers/crypto/nx/nx-aes-xcbc.c | 191 +++++++++++++++++++-------
 drivers/crypto/nx/nx-sha256.c   |   2 +-
 drivers/crypto/nx/nx-sha512.c   |   2 +-
 drivers/crypto/nx/nx.c          |   9 +-
 drivers/crypto/nx/nx.h          |   2 +-
 10 files changed, 683 insertions(+), 260 deletions(-)

-- 
1.7.12
