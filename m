Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yllDV13SbzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 22:38:33 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spufs: use timespec64 for timestamps
Date: Mon, 27 Nov 2017 12:31:55 +0100
Message-Id: <20171127113234.2186374-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The switch log prints the tv_sec portion of timespec as a 32-bit
number, while overflows in 2106. It also uses the timespec type,
which is safe on 64-bit architectures, but deprecated because
it causes overflows in 2038 elsewhere.

This changes it to timespec64 and printing a 64-bit number for
consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spufs/file.c  | 6 +++---
 arch/powerpc/platforms/cell/spufs/spufs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 5ffcdeb1eb17..94139135be9c 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2375,8 +2375,8 @@ static int switch_log_sprint(struct spu_context *ctx, char *tbuf, int n)
 
 	p = ctx->switch_log->log + ctx->switch_log->tail % SWITCH_LOG_BUFSIZE;
 
-	return snprintf(tbuf, n, "%u.%09u %d %u %u %llu\n",
-			(unsigned int) p->tstamp.tv_sec,
+	return snprintf(tbuf, n, "%llu.%09u %d %u %u %llu\n",
+			(unsigned long long) p->tstamp.tv_sec,
 			(unsigned int) p->tstamp.tv_nsec,
 			p->spu_id,
 			(unsigned int) p->type,
@@ -2499,7 +2499,7 @@ void spu_switch_log_notify(struct spu *spu, struct spu_context *ctx,
 		struct switch_log_entry *p;
 
 		p = ctx->switch_log->log + ctx->switch_log->head;
-		ktime_get_ts(&p->tstamp);
+		ktime_get_ts64(&p->tstamp);
 		p->timebase = get_tb();
 		p->spu_id = spu ? spu->number : -1;
 		p->type = type;
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 5e59f80e95db..5d85c689c2e9 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -69,7 +69,7 @@ struct switch_log {
 	unsigned long		head;
 	unsigned long		tail;
 	struct switch_log_entry {
-		struct timespec	tstamp;
+		struct timespec64 tstamp;
 		s32		spu_id;
 		u32		type;
 		u32		val;
-- 
2.9.0
