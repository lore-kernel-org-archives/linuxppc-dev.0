Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcK5CXLzF1Mn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:22:57 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id s5so18865817wra.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:22:57 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 02/21] powerpc: Move the inline keyword at the beginning of
 function declaration
Date: Sun, 25 Feb 2018 18:22:17 +0100
Message-Id: <20180225172236.29650-3-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The inline keyword was not at the beginning of the function declaration.
Fix the following warning (treated as error in W=1)

  CC      kernel/sys.o
arch/powerpc/lib/sstep.c:283:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
 static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
 ^~~~~~
arch/powerpc/lib/sstep.c:388:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
 static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
 ^~~~~~
  CC      arch/powerpc/kernel/setup_32.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/sstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 70274b7b4773..34d68f1b1b40 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -280,7 +280,7 @@ static nokprobe_inline int read_mem_aligned(unsigned long *dest,
  * Copy from userspace to a buffer, using the largest possible
  * aligned accesses, up to sizeof(long).
  */
-static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
+static nokprobe_inline int copy_mem_in(u8 *dest, unsigned long ea, int nb,
 				       struct pt_regs *regs)
 {
 	int err = 0;
@@ -385,7 +385,7 @@ static nokprobe_inline int write_mem_aligned(unsigned long val,
  * Copy from a buffer to userspace, using the largest possible
  * aligned accesses, up to sizeof(long).
  */
-static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
+static nokprobe_inline int copy_mem_out(u8 *dest, unsigned long ea, int nb,
 					struct pt_regs *regs)
 {
 	int err = 0;
-- 
2.11.0
