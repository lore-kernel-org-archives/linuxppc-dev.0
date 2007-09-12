Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <628a383203480c3ce59125feccc32168de919014.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 07/15] Don't return -ENOSYS as extra notes size if spufs is
	not loaded
Date: Wed, 12 Sep 2007 17:43:44 +1000 (EST)
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because the SPU coredump code might be built as part of a module (spufs),
we have a stub which is called by the coredump code, this routine then calls
into spufs if it's loaded.

Unfortunately the stub returns -ENOSYS if spufs is not loaded, which is
interpreted by the coredump code as an extra note size of -38 bytes. This
leads to a corrupt core dump.

If spufs is not loaded there will be no SPU ELF notes to write, and so the
extra notes size will be == 0.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spu_coredump.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_coredump.c b/arch/powerpc/platforms/cell/spu_coredump.c
index 4fd37ff..656a8c5 100644
--- a/arch/powerpc/platforms/cell/spu_coredump.c
+++ b/arch/powerpc/platforms/cell/spu_coredump.c
@@ -31,15 +31,19 @@ static DEFINE_MUTEX(spu_coredump_mutex);
 
 int arch_notes_size(void)
 {
-	long ret;
+	int ret;
 
-	ret = -ENOSYS;
 	mutex_lock(&spu_coredump_mutex);
+
 	if (spu_coredump_calls && try_module_get(spu_coredump_calls->owner)) {
 		ret = spu_coredump_calls->arch_notes_size();
 		module_put(spu_coredump_calls->owner);
+	} else {
+		ret = 0;
 	}
+
 	mutex_unlock(&spu_coredump_mutex);
+
 	return ret;
 }
 
-- 
1.5.1.3.g7a33b
