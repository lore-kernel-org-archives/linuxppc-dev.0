Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86C71A0039
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 11:33:35 +1000 (EST)
Date: Sat, 7 Jun 2014 11:33:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, nfont@linux.vnet.ibm.com,
 mhcerri@linux.vnet.ibm.com, herbert@gondor.apana.org.au,
 davem@davemloft.net
Subject: [PATCH] crypto/nx: disable NX on little endian builds
Message-ID: <20140607113334.474343b8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NX driver has endian issues so disable it for now.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 03ccdb0..8280a7a3 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -313,7 +313,7 @@ config CRYPTO_DEV_S5P
 
 config CRYPTO_DEV_NX
 	bool "Support for IBM Power7+ in-Nest cryptographic acceleration"
-	depends on PPC64 && IBMVIO
+	depends on PPC64 && IBMVIO && !CPU_LITTLE_ENDIAN
 	default n
 	help
 	  Support for Power7+ in-Nest cryptographic acceleration.
