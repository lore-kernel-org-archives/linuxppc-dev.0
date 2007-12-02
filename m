Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2BEDFDDDFC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 17:10:31 +1100 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JSE004B8RTIBL90@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 23:10:30 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSE00HQWRTIZD40@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 01 Dec 2007 23:10:31 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JSE00G7PRTGX600@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 23:10:29 -0700 (MST)
Date: Sat, 01 Dec 2007 23:10:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 1/2] [POWERPC] Add machine initcall macros
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net,
	jwboyer@linux.vnet.ibm.com
Message-id: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
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

 include/asm-powerpc/machdep.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 6968f43..d5cd982 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -326,5 +326,28 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 		ppc_md.log_error(buf, err_type, fatal);
 }
 
+#define __define_machine_initcall(mach,level,fn,id) \
+	static int __init __machine_initcall_##mach##_##fn(void) { \
+		if (machine_is(mach)) return fn(); \
+		return 0; \
+	} \
+	__define_initcall(level,__machine_initcall_##mach##_##fn,id);
+
+#define machine_core_initcall(mach,fn)		__define_machine_initcall(mach,"1",fn,1)
+#define machine_core_initcall_sync(mach,fn)	__define_machine_initcall(mach,"1s",fn,1s)
+#define machine_postcore_initcall(mach,fn)	__define_machine_initcall(mach,"2",fn,2)
+#define machine_postcore_initcall_sync(mach,fn)	__define_machine_initcall(mach,"2s",fn,2s)
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
