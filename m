Return-Path: <hpa@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89DC2DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 22:55:09 +1100 (EST)
Date: Thu, 19 Mar 2009 11:54:27 GMT
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-tip-commits@vger.kernel.org
In-Reply-To: <20090319220322.3baa4613.sfr@canb.auug.org.au>
References: <20090319220322.3baa4613.sfr@canb.auug.org.au>
Subject: [tip:cpus4096] numa,
	cpumask: move numa_node_id default implementation to topology.h, fix
Message-ID: <tip-17ad6ea621b1c7952ebd7330ce65de26b6ee9cca@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, mingo@elte.hu
Reply-To: mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	sfr@canb.auug.org.au, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit-ID:  17ad6ea621b1c7952ebd7330ce65de26b6ee9cca
Gitweb:     http://git.kernel.org/tip/17ad6ea621b1c7952ebd7330ce65de26b6ee9cca
Author:     Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate: Thu, 19 Mar 2009 22:03:22 +1100
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Thu, 19 Mar 2009 12:51:25 +0100

numa, cpumask: move numa_node_id default implementation to topology.h, fix

Impact: build fix for powerpc and sparc

Today's linux-next build (powerpc allyesconfig) failed like this:

> In file included from include/linux/mmzone.h:776,
>                  from include/linux/gfp.h:5,
>                  from include/linux/kmod.h:23,
>                  from include/linux/module.h:14,
>                  from init/version.c:11:
> arch/powerpc/include/asm/mmzone.h:32: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'numa_cpumask_lookup_table'

Caused by commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,
cpumask: move numa_node_id default implementation to topology.h") from
the cpus4096 tree which removed the include of linux/topology.h from
linux/mmzone.h.

Same for sparc64 defconfig.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-b: Rusty Russell <rusty@rustcorp.com.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
LKML-Reference: <20090319220322.3baa4613.sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


---
 arch/powerpc/include/asm/mmzone.h |    1 +
 arch/sparc/include/asm/mmzone.h   |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 19f299b..35acac9 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -8,6 +8,7 @@
 #define _ASM_MMZONE_H_
 #ifdef __KERNEL__
 
+#include <linux/cpumask.h>
 
 /*
  * generic non-linear memory support:
diff --git a/arch/sparc/include/asm/mmzone.h b/arch/sparc/include/asm/mmzone.h
index ebf5986..e8c6487 100644
--- a/arch/sparc/include/asm/mmzone.h
+++ b/arch/sparc/include/asm/mmzone.h
@@ -3,6 +3,8 @@
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
 
+#include <linux/cpumask.h>
+
 extern struct pglist_data *node_data[];
 
 #define NODE_DATA(nid)		(node_data[nid])
