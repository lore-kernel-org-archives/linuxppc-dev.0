Return-Path: <anton@samba.org>
Date: Thu, 6 Mar 2014 16:10:11 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: compat: 32 bit little endian machine name is
 ppcle, not ppc
Message-ID: <20140306161011.4b6bd05b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I noticed this when testing setarch. No, we don't magically
support a big endian userspace on a little endian kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org # v3.10+
---

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 84fdf68..ef22898 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -8,7 +8,11 @@
 #include <linux/sched.h>
 
 #define COMPAT_USER_HZ		100
+#ifdef __BIG_ENDIAN__
 #define COMPAT_UTS_MACHINE	"ppc\0\0"
+#else
+#define COMPAT_UTS_MACHINE	"ppcle\0\0"
+#endif
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
