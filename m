Return-Path: <andrey.krieger.utkin@gmail.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59B6B1A0189
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 06:13:38 +1000 (EST)
Received: by mail-lb0-f178.google.com with SMTP id c11so5869064lbj.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Aug 2014 13:13:31 -0700 (PDT)
From: Andrey Utkin <andrey.krieger.utkin@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, srivatsa.bhat@linux.vnet.ibm.com,
 sfr@canb.auug.org.au, qiuxishi@huawei.com, wangyun@linux.vnet.ibm.com,
 qiudayu@linux.vnet.ibm.com, joe@perches.com, alistair@popple.id.au,
 rcj@linux.vnet.ibm.com
Subject: [PATCH] arch/powerpc/mm/numa.c: Fix break placement
Date: Mon,  4 Aug 2014 23:13:10 +0300
Message-Id: <1407183190-1397-1-git-send-email-andrey.krieger.utkin@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
 Andrey Utkin <andrey.krieger.utkin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=81631
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3b181b2..d3e9a78 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -611,8 +611,8 @@ static int cpu_numa_callback(struct notifier_block *nfb, unsigned long action,
 	case CPU_UP_CANCELED:
 	case CPU_UP_CANCELED_FROZEN:
 		unmap_cpu_from_node(lcpu);
-		break;
 		ret = NOTIFY_OK;
+		break;
 #endif
 	}
 	return ret;
-- 
1.8.5.5
