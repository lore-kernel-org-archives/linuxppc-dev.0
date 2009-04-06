Return-Path: <hugh@veritas.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-1.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABAB7DDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 07:02:24 +1000 (EST)
Date: Mon, 6 Apr 2009 22:01:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
In-Reply-To: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
Message-ID: <Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: yanok@emcraft.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	prodyuth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
let powerpc 256kB pages coexist with CONFIG_SHMEM again.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Added linuxppc-dev and some other Cc's for this 3/3: sorry
if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.

 arch/powerpc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.29-git13/arch/powerpc/Kconfig	2009-04-06 11:47:57.000000000 +0100
+++ linux/arch/powerpc/Kconfig	2009-04-06 18:18:47.000000000 +0100
@@ -462,7 +462,7 @@ config PPC_64K_PAGES
 
 config PPC_256K_PAGES
 	bool "256k page size" if 44x
-	depends on !STDBINUTILS && (!SHMEM || BROKEN)
+	depends on !STDBINUTILS
 	help
 	  Make the page size 256k.
 
