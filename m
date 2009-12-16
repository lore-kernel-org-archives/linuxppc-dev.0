Return-Path: <yong.zhang0@gmail.com>
Received: from mail-px0-f188.google.com (mail-px0-f188.google.com
	[209.85.216.188]) by ozlabs.org (Postfix) with ESMTP id C59C2B6F10
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 01:36:18 +1100 (EST)
Received: by pxi26 with SMTP id 26so776121pxi.17
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 06:36:17 -0800 (PST)
From: Yong Zhang <yong.zhang0@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc/iseries: use DECLARE_COMPLETION_ONSTACK for
	non-constant completion
Date: Wed, 16 Dec 2009 22:35:57 +0800
Message-Id: <1260974161-6934-2-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1260974161-6934-1-git-send-email-yong.zhang0@gmail.com>
References: <1260974161-6934-1-git-send-email-yong.zhang0@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The _ONSTACK variant should be used for on-stack completion,
otherwise it will break lockdep.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/platforms/iseries/viopath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index 49ff4dc..5aea94f 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -116,7 +116,7 @@ static int proc_viopath_show(struct seq_file *m, void *v)
 	u16 vlanMap;
 	dma_addr_t handle;
 	HvLpEvent_Rc hvrc;
-	DECLARE_COMPLETION(done);
+	DECLARE_COMPLETION_ONSTACK(done);
 	struct device_node *node;
 	const char *sysid;
 
-- 
1.6.3.3
