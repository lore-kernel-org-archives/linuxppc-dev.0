Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C0B2BDDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:27:12 +1100 (EST)
Date: Wed, 20 Feb 2008 11:27:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] fix warning in pseries/power.c
Message-Id: <20080220112704.0ac7d7f2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Introduced by commit 79393fc46ede43451a500a132e5de9856f5a4c83 ("kobject:
convert pseries/power.c to kobj_attr interface").

sys_create_file takes a "struct attrbute *" not a "struct kobj_addribute *".

arch/powerpc/platforms/pseries/power.c: In function 'apo_pm_init':
arch/powerpc/platforms/pseries/power.c:78: warning: passing argument 2 of 'sysfs_create_file' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/power.c b/arch/powerpc/platforms/pseries/power.c
index e95fc15..6d62662 100644
--- a/arch/powerpc/platforms/pseries/power.c
+++ b/arch/powerpc/platforms/pseries/power.c
@@ -75,7 +75,7 @@ core_initcall(pm_init);
 #else
 static int __init apo_pm_init(void)
 {
-	return (sysfs_create_file(power_kobj, &auto_poweron_attr));
+	return (sysfs_create_file(power_kobj, &auto_poweron_attr.attr));
 }
 __initcall(apo_pm_init);
 #endif
-- 
1.5.4.2

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
