Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DA32CDE209
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:09:21 +1000 (EST)
Message-ID: <46730D5B.300@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 23/33] powerpc: Localize mmu_off
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This just removes the dependency __mmu_off has on the symbol
__after_prom_start.  I found the current code inconvenient when I
wanted to put some debugging code between the call to __mmu_off
and the branch to __after_prom_start.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/kernel/head_64.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1695,9 +1695,11 @@ _GLOBAL(__start_initialization_multiplat
 2:
 
 	/* Switch off MMU if not already */
-	LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
+	LOAD_REG_IMMEDIATE(r4, __mmu_off_return - KERNELBASE)
 	add	r4,r4,r30
 	bl	.__mmu_off
+__mmu_off_return:
+
 	b	.__after_prom_start
 
 _STATIC(__boot_from_prom)

-- 
