Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPRrb5hQZzDw0Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:01:51 +1100 (AEDT)
Date: Thu, 24 Nov 2016 16:01:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20161124160151.20206af7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

powerpc-linux-ld: unrecognized option '--no-dynamic-linker'

Caused by patch

  "powerpc: add purgatory for kexec_file_load implementation"

I have disabled KEXEC_FILE for now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 24 Nov 2016 15:52:55 +1100
Subject: [PATCH] disable KEXEC_FILE on powerpc for now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d86643f280d..b72c1c7afcf0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -475,6 +475,7 @@ config KEXEC_FILE
 	depends on PPC64
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
+	depends on BROKEN
 	help
 	  This is a new version of the kexec system call. This call is
 	  file based and takes in file descriptors as system call arguments
-- 
2.10.2

-- 
Cheers,
Stephen Rothwell
