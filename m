Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B69B21A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 09:44:46 +1100 (AEDT)
Date: Thu, 8 Oct 2015 09:44:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Metcalf
 <cmetcalf@ezchip.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of Linus' tree
Message-ID: <20151008094444.10d9cc68@canb.auug.org.au>
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

Hi Linus,

After merging Linus' tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

lib/string.c: In function 'strscpy':
lib/string.c:209:4: error: implicit declaration of function 'zero_bytemask' [-Werror=implicit-function-declaration]
    *(unsigned long *)(dest+res) = c & zero_bytemask(data);
    ^

Caused by commit

  30035e45753b ("string: provide strscpy()")

but only exposed by commit

  19c22f3a29fa ("word-at-a-time.h: fix some Kbuild files")

BIG_ENDIAN powerpc doesn't have a definition for this function ...

Isn't this why we have linux-next ... to find this stuff early?  :-(

Oh, well, I have applied the following (that just copies zero_bytemask
from asm-generic.  I have done no testing beyond compiling.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 8 Oct 2015 09:29:26 +1100
Subject: [PATCH] word-at-a-time.h: powerpc: implement define zero_bytemask

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/word-at-a-time.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 5b3a903adae6..4f9b6b93c18f 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -40,6 +40,8 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 	return (val + c->high_bits) & ~rhs;
 }
 
+#define zero_bytemask(mask) (~1ul << __fls(mask))
+
 #else
 
 #ifdef CONFIG_64BIT
-- 
2.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
