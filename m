Return-Path: <jj@chaosbits.net>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by ozlabs.org (Postfix) with ESMTP id 02BF1B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 05:20:59 +1100 (EST)
Date: Sat, 30 Oct 2010 20:10:41 +0200 (CEST)
From: Jesper Juhl <jj@chaosbits.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PowerPC/Cell: use vzalloc rather than vmalloc and memset in
	spu_alloc_lscsa_std
Message-ID: <alpine.LNX.2.00.1010302004290.1572@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We can get rid of a memset in 
arch/powerpc/platforms/cell/spufs/lscsa_alloc.c::spu_alloc_lscsa_std() by 
using vzalloc() rather than vmalloc()+memset().

Completely untested patch below since I have no hardware nor tools to 
compile this.


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 lscsa_alloc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
index a101abf..3b894f5 100644
--- a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
+++ b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
@@ -36,10 +36,9 @@ static int spu_alloc_lscsa_std(struct spu_state *csa)
 	struct spu_lscsa *lscsa;
 	unsigned char *p;
 
-	lscsa = vmalloc(sizeof(struct spu_lscsa));
+	lscsa = vzalloc(sizeof(struct spu_lscsa));
 	if (!lscsa)
 		return -ENOMEM;
-	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
 
 	/* Set LS pages reserved to allow for user-space mapping. */


-- 
Jesper Juhl <jj@chaosbits.net>             http://www.chaosbits.net/
Plain text mails only, please      http://www.expita.com/nomime.html
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
