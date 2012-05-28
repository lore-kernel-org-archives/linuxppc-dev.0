Return-Path: <paulus@ozlabs.org>
Date: Mon, 28 May 2012 12:59:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] lib: Fix generic strnlen_user for 32-bit big-endian
 machines
Message-ID: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The aligned_byte_mask() definition is wrong for 32-bit big-endian
machines: the "7-(n)" part of the definition assumes a long is 8
bytes.  This fixes it by using BITS_PER_LONG - 8 instead of 8*7.
Tested on 32-bit and 64-bit PowerPC.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 lib/strnlen_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 90900ec..a28df52 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -8,7 +8,7 @@
 #ifdef __LITTLE_ENDIAN
 #  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
 #else
-#  define aligned_byte_mask(n) (~0xfful << 8*(7-(n)))
+#  define aligned_byte_mask(n) (~0xfful << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
 /*
-- 
1.7.10.rc3.219.g53414
