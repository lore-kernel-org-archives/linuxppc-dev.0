Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 17/25] spufs: Don't return -ENOSYS as extra notes size if
	spufs is not loaded
Message-Id: <1189751574.108367.474576463466.17.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

Because the SPU coredump code might be built as part of a module (spufs),
we have a stub which is called by the coredump code, this routine then calls
into spufs if it's loaded.

Unfortunately the stub returns -ENOSYS if spufs is not loaded, which is
interpreted by the coredump code as an extra note size of -38 bytes. This
leads to a corrupt core dump.

If spufs is not loaded there will be no SPU ELF notes to write, and so the
extra notes size will be == 0.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/cell/spu_coredump.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

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
 
