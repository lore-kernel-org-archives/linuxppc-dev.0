Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 2374BDDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 20:55:53 +1000 (EST)
Date: Fri, 20 Jul 2007 12:55:50 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: [PATCH] powerpc: mpc5200 low power mode, .globl fix
Message-ID: <20070720105550.GA1385@moe.telargo.com>
References: <11847043512142-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11847043512142-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

flush_data_cache doesn't need to be global, and can cause problems.
Thanks to Milton Miller for noticing this.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
---
 arch/powerpc/platforms/52xx/lite5200_sleep.S |    1 -
 1 file changed, 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
===================================================================
--- work-powerpc.git.orig/arch/powerpc/platforms/52xx/lite5200_sleep.S
+++ work-powerpc.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
@@ -400,7 +400,6 @@ restore_regs:
  * Flush data cache
  * Do this by just reading lots of stuff into the cache.
  */
-        .globl flush_data_cache
 flush_data_cache:
 	lis	r3,CONFIG_KERNEL_START@h
 	ori	r3,r3,CONFIG_KERNEL_START@l
