Return-Path: <michael@ellerman.id.au>
Subject: Re: Next 12 : arch/powerpc/sysdev/axonram build failure
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <49B8C7FA.8090805@in.ibm.com>
References: <20090312171154.11c6ec31.sfr@canb.auug.org.au>
	<49B8C7FA.8090805@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Mar 2009 23:16:27 +1100
Message-Id: <1236860187.12893.5.camel@localhost>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-12 at 13:59 +0530, Sachin Sant wrote:
> Hi Stephen,
> 
> Today's next randconfig build on powerpc fails with
> 
>   CC [M]  arch/powerpc/sysdev/axonram.o
> arch/powerpc/sysdev/axonram.c:108: warning: ‘struct request_queue’ declared inside parameter list
> arch/powerpc/sysdev/axonram.c:108: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_make_request’:
<snip>
> arch/powerpc/sysdev/axonram.c:289: error: implicit declaration of function ‘unregister_blkdev’
> arch/powerpc/sysdev/axonram.c:289: error: dereferencing pointer to incomplete type
> arch/powerpc/sysdev/axonram.c:290: error: dereferencing pointer to incomplete type
> arch/powerpc/sysdev/axonram.c:291: error: implicit declaration of function ‘del_gendisk’
> arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_init’:
> arch/powerpc/sysdev/axonram.c:345: error: implicit declaration of function ‘register_blkdev’
> make[1]: *** [arch/powerpc/sysdev/axonram.o] Error 1
> make: *** [arch/powerpc/sysdev] Error 2
> 
> CONFIG_BLOCK is not set.

So how about this:

>From 7325aea8244ac83d98cde7a509ec8ab5994cdb0e Mon Sep 17 00:00:00 2001
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 12 Mar 2009 23:14:58 +1100
Subject: [PATCH] powerpc/cell: axonram depends on BLOCK

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b4ab372..3fb0851 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -266,7 +266,7 @@ config CPM2
 
 config AXON_RAM
 	tristate "Axon DDR2 memory device driver"
-	depends on PPC_IBM_CELL_BLADE
+	depends on PPC_IBM_CELL_BLADE && BLOCK
 	default m
 	help
 	  It registers one block device per Axon's DDR2 memory bank found
-- 
1.6.1.2
