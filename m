Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 715DDDDE05
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 11:25:29 +1100 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JSC00KLHH5I2200@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 30 Nov 2007 17:24:54 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSC00MRAH5ILL00@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 30 Nov 2007 17:24:55 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JSC00DSVH5HDS82@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 30 Nov 2007 17:24:54 -0700 (MST)
Date: Fri, 30 Nov 2007 17:24:56 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] Add machine initcall macros
To: linuxppc-dev@ozlabs.org, vitb@kernel.crashing.org,
	galak@kernel.crashing.org, olof@lixom.net, jwboyer@linux.vnet.ibm.com,
	benh@kernel.crashing.org
Message-id: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The machine initcall macros allow initcalls to be registered which
test machine_is() before executing the initcall.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Ben, is this the sort of thing you're considering?

g.

 include/asm-powerpc/machdep.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 6968f43..f24af06 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -326,5 +326,24 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 		ppc_md.log_error(buf, err_type, fatal);
 }
 
+#define __define_machine_initcall(mach,level,fn,id) \
+	static int __init __machine_initcall_##mach##_##fn(void) { \
+		if (machine_is(mach)) return fn(); \
+		return 0; \
+	} \
+	__define_initcall(level,__machine_initcall_##mach##_##fn,id);
+
+#define machine_arch_initcall(mach,fn)		__define_machine_initcall(mach,"3",fn,3)
+#define machine_arch_initcall_sync(mach,fn)	__define_machine_initcall(mach,"3s",fn,3s)
+#define machine_subsys_initcall(mach,fn)	__define_machine_initcall(mach,"4",fn,4)
+#define machine_subsys_initcall_sync(mach,fn)	__define_machine_initcall(mach,"4s",fn,4s)
+#define machine_fs_initcall(mach,fn)		__define_machine_initcall(mach,"5",fn,5)
+#define machine_fs_initcall_sync(mach,fn)	__define_machine_initcall(mach,"5s",fn,5s)
+#define machine_rootfs_initcall(mach,fn)	__define_machine_initcall(mach,"rootfs",fn,rootfs)
+#define machine_device_initcall(mach,fn)	__define_machine_initcall(mach,"6",fn,6)
+#define machine_device_initcall_sync(mach,fn)	__define_machine_initcall(mach,"6s",fn,6s)
+#define machine_late_initcall(mach,fn)		__define_machine_initcall(mach,"7",fn,7)
+#define machine_late_initcall_sync(mach,fn)	__define_machine_initcall(mach,"7s",fn,7s)
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MACHDEP_H */
