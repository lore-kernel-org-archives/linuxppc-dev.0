Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bf4b616c4d842cf1fc4fa29db340284b6ddc1c7a.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 06/12] Add a declaration for xmon()
Date: Thu,  8 May 2008 14:27:13 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Usually we call xmon() via debugger(), so this could be static.
Sometimes when debugging it's nice to be able to call xmon()
directly though, so add a declaration.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/xmon.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/xmon.h b/include/asm-powerpc/xmon.h
index 88320a0..81477f2 100644
--- a/include/asm-powerpc/xmon.h
+++ b/include/asm-powerpc/xmon.h
@@ -15,6 +15,8 @@
 #ifdef CONFIG_XMON
 extern void xmon_setup(void);
 extern void xmon_register_spus(struct list_head *list);
+struct pt_regs;
+extern int xmon(struct pt_regs *excp);
 #else
 static inline void xmon_setup(void) { };
 static inline void xmon_register_spus(struct list_head *list) { };
-- 
1.5.5
