Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 4/3] powerpc: increase CRASH_HANDLER_MAX
Date: Thu, 12 Jun 2008 11:34:39 +0200
References: <20080612091433.851620325@arndb.de>
In-Reply-To: <20080612091433.851620325@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806121134.39984.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are now two potential callers of machine_crash_shutdown,
so increase the limit accordingly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/crash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index eae401d..0a8439a 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -48,7 +48,7 @@ int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
-#define CRASH_HANDLER_MAX 1
+#define CRASH_HANDLER_MAX 2
 /* NULL terminated list of shutdown handles */
 static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
 static DEFINE_SPINLOCK(crash_handlers_lock);
-- 
1.5.4.3
