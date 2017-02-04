Return-Path: <shile.zhang@nokia.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0104.outbound.protection.outlook.com [104.47.1.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFnpx1WjyzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 20:04:08 +1100 (AEDT)
From: Shile Zhang <shile.zhang@nokia.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, Shile Zhang <shile.zhang@nokia.com>
Subject: [PATCH] powerpc/64: Fix checksum folding in csum_add
Date: Sat, 4 Feb 2017 17:03:40 +0800
Message-ID: <1486199020-59977-1-git-send-email-shile.zhang@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fix the missed point in Paul's patch:
"powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
ip_fast_csum_nofold"

Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
---
 arch/powerpc/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 5b1a6e3..430d038 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -108,7 +108,7 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
 
 #ifdef __powerpc64__
 	res += (__force u64)addend;
-	return (__force __wsum)((u32)res + (res >> 32));
+	return (__force __wsum) from64to32(res);
 #else
 	asm("addc %0,%0,%1;"
 	    "addze %0,%0;"
-- 
2.6.2
