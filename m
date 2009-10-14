Return-Path: <roel.kluin@gmail.com>
Message-ID: <4AD5EF0C.9050603@gmail.com>
Date: Wed, 14 Oct 2009 17:32:28 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Arnd Bergmann <arndbergmann@googlemail.com>
Subject: Re: [Cbe-oss-dev] [PATCH] spufs: Fix test in spufs_switch_log_read()
References: <4AD32B3F.9060804@gmail.com> <200910130849.56671.jk@ozlabs.org>
	<200910131531.45726.arnd@arndb.de>
In-Reply-To: <200910131531.45726.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

size_t len cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
>>> Or can this test be removed?
>>
>> I'd prefer just to remove the test.
> 
> Yes, sounds good.

If you meant only the left-hand part, here you go:

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 884e8bc..64a4c2d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2494,7 +2494,7 @@ static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
 	struct spu_context *ctx = SPUFS_I(inode)->i_ctx;
 	int error = 0, cnt = 0;
 
-	if (!buf || len < 0)
+	if (!buf)
 		return -EINVAL;
 
 	error = spu_acquire(ctx);
