Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyFh95wBfzDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 18:04:57 +1000 (AEST)
Date: Wed, 28 Jun 2017 18:04:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20170628180456.30cb9242@canb.auug.org.au>
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

Hi Jens,

After merging the block tree, today's linux-next build (powerpc
allnoconfig) failed like this:

fs/fcntl.o: In function `do_fcntl': 
fcntl.c:(.text+0x6d4): undefined reference to `__get_user_bad'
fcntl.c:(.text+0x730): undefined reference to `__get_user_bad'

Probably caused by commit

  c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")

On powerpc (at least) you cannot use get_user() to fetch anything larger
than "unsigned long" i.e. 32 bits on 32 bit powerpc.

This has been discussed before (and, I think, a fix attempted).

For now I have applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jun 2017 17:50:31 +1000
Subject: [PATCH] fs: don't read an enum directly from a u64 __user *

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/fcntl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 24e233c75a33..19825eb7c40d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -277,6 +277,7 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 {
 	struct inode *inode = file_inode(file);
 	u64 *argp = (u64 __user *)arg;
+	u64 h;
 	enum rw_hint hint;
 
 	switch (cmd) {
@@ -285,8 +286,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_FILE_RW_HINT:
-		if (get_user(hint, argp))
+		if (copy_from_user(&h, argp, sizeof(h)))
 			return -EFAULT;
+		hint = (enum rw_hint)h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 
@@ -299,8 +301,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
-		if (get_user(hint, argp))
+		if (copy_from_user(&h, argp, sizeof(h)))
 			return -EFAULT;
+		hint = (enum rw_hint)h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 
-- 
2.11.0

-- 
Cheers,
Stephen Rothwell
