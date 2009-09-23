Return-Path: <vivek.mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB35AB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 21:33:35 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8NBXWBY001559 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 04:33:33 -0700 (MST)
From: Vivek Mahajan <vivek.mahajan@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/fsl: 85xx: add mbar()
Date: Wed, 23 Sep 2009 17:03:23 +0530
Message-Id: <1253705604-1986-3-git-send-email-vivek.mahajan@freescale.com>
In-Reply-To: <1253705604-1986-2-git-send-email-vivek.mahajan@freescale.com>
References: <1253705604-1986-1-git-send-email-vivek.mahajan@freescale.com>
	<1253705604-1986-2-git-send-email-vivek.mahajan@freescale.com>
Cc: kumar.gala@freescale.com, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds e500/85xx based memory barrier

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
 arch/powerpc/include/asm/synch.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index 28f6ddb..8298089 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -23,6 +23,11 @@ static inline void isync(void)
 {
 	__asm__ __volatile__ ("isync" : : : "memory");
 }
+
+static inline void mbar(int mo)
+{
+	__asm__ __volatile__ ("mbar %0" : : "i" (mo) : "memory");
+}
 #endif /* __ASSEMBLY__ */
 
 #if defined(__powerpc64__)
-- 
1.5.6.5
