Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-qt0-x231.google.com (mail-qt0-x231.google.com
 [IPv6:2607:f8b0:400d:c0d::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skk5W08QhzDrYx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 02:42:39 +1000 (AEST)
Received: by mail-qt0-x231.google.com with SMTP id 38so24941995qte.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:42:38 -0700 (PDT)
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Marcelo Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH 0/3] Fix crypto/vmx/p8_ghash memory corruption
Date: Wed, 28 Sep 2016 13:42:08 -0300
Message-Id: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series fixes the memory corruption found by Jan Stancek in 4.8-rc7. The
problem however also affects previous versions of the driver.

Marcelo Cerri (3):
  crypto: ghash-generic - move common definitions to a new header file
  crypto: vmx - Fix memory corruption caused by p8_ghash
  crypto: vmx - Ensure ghash-generic is enabled

 crypto/ghash-generic.c     | 13 +------------
 drivers/crypto/vmx/Kconfig |  2 +-
 drivers/crypto/vmx/ghash.c | 31 ++++++++++++++++---------------
 include/crypto/ghash.h     | 23 +++++++++++++++++++++++
 4 files changed, 41 insertions(+), 28 deletions(-)
 create mode 100644 include/crypto/ghash.h

-- 
2.7.4
