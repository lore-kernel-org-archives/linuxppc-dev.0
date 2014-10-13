Return-Path: <ydroneaud@opteya.com>
From: Yann Droneaud <ydroneaud@opteya.com>
To: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>
Subject: [PATCHv9 2/5] ppc/cell: trivial: replace get_unused_fd() by
 get_unused_fd_flags(0)
Date: Mon, 13 Oct 2014 21:30:59 +0200
Message-Id: <9a145561123e28585d7994b61359a531128a80b8.1413223900.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1413223900.git.ydroneaud@opteya.com>
References: <cover.1413223900.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1413223900.git.ydroneaud@opteya.com>
References: <cover.1413223900.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>, cbe-oss-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch replaces calls to get_unused_fd() with equivalent call to
get_unused_fd_flags(0) to preserve current behavor for existing code.

In a further patch, get_unused_fd() will be removed so that new code
start using get_unused_fd_flags(), with the hope O_CLOEXEC could be
used, either by default or choosen by userspace.

Link: http://lkml.kernel.org/r/cover.1413223900.git.ydroneaud@opteya.com
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: trivial@kernel.org
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 87ba7cf99cd7..51effcec30d8 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -301,7 +301,7 @@ static int spufs_context_open(struct path *path)
 	int ret;
 	struct file *filp;
 
-	ret = get_unused_fd();
+	ret = get_unused_fd_flags(0);
 	if (ret < 0)
 		return ret;
 
@@ -518,7 +518,7 @@ static int spufs_gang_open(struct path *path)
 	int ret;
 	struct file *filp;
 
-	ret = get_unused_fd();
+	ret = get_unused_fd_flags(0);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.3
