Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0DF5DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 09:00:00 +1100 (EST)
Subject: patch powerpc-fix-typo-in-pseries-power.c.patch added to gregkh-2.6
	tree
To: sfr@canb.auug.org.au, greg@kroah.com, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, paulus@au.ibm.com
From: <gregkh@suse.de>
Date: Wed, 20 Feb 2008 13:57:27 -0800
In-Reply-To: <20080220112704.0ac7d7f2.sfr@canb.auug.org.au>
Message-ID: <1203544647817@kroah.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: POWERPC: fix typo in pseries/power.c

to my gregkh-2.6 tree.  Its filename is

     powerpc-fix-typo-in-pseries-power.c.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From sfr@canb.auug.org.au  Wed Feb 20 12:57:53 2008
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Feb 2008 11:27:04 +1100
Subject: POWERPC: fix typo in pseries/power.c
To: paulus@samba.org
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Greg KH <greg@kroah.com>
Message-ID: <20080220112704.0ac7d7f2.sfr@canb.auug.org.au>


Introduced by commit 79393fc46ede43451a500a132e5de9856f5a4c83 ("kobject:
convert pseries/power.c to kobj_attr interface").

sys_create_file takes a "struct attrbute *" not a "struct kobj_addribute *".

arch/powerpc/platforms/pseries/power.c: In function 'apo_pm_init':
arch/powerpc/platforms/pseries/power.c:78: warning: passing argument 2 of 'sysfs_create_file' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@au.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/platforms/pseries/power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


Patches currently in gregkh-2.6 which might be from sfr@canb.auug.org.au are

bad/battery-class-driver.patch
driver/powerpc-fix-typo-in-pseries-power.c.patch
