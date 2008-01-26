Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 78306DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 14:29:01 +1100 (EST)
Date: Fri, 25 Jan 2008 21:40:55 -0600
From: Olof Johansson <olof@lixom.net>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 063/196] kset: convert /sys/devices to use kset_create
Message-ID: <20080126034055.GA28786@lixom.net>
References: <20080125071127.GA4860@kroah.com>
	<1201245134-4876-63-git-send-email-gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201245134-4876-63-git-send-email-gregkh@suse.de>
Cc: linuxppc-dev@ozlabs.org, Kay Sievers <kay.sievers@vrfy.org>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 11:10:01PM -0800, Greg Kroah-Hartman wrote:
> Dynamically create the kset instead of declaring it statically.  We also
> rename devices_subsys to devices_kset to catch all users of the
> variable.

Guess what, you broke powerpc again!

olof@quad:~/work/linux/k.org $ git grep devices_subsys
arch/powerpc/kernel/vio.c:extern struct kset devices_subsys; /* needed for vio_find_name() */
arch/powerpc/kernel/vio.c:      found = kset_find_obj(&devices_subsys, kobj_name);

Obviously causes build failues, even of ppc64_defconfig.

(I can unfortunately not boot test, since I lack hardware that uses vio)


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 19a5656..ee752ab 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -37,7 +37,7 @@
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/iommu.h>
 
-extern struct kset devices_subsys; /* needed for vio_find_name() */
+extern struct kset *devices_kset; /* needed for vio_find_name() */
 
 static struct bus_type vio_bus_type;
 
@@ -369,7 +369,7 @@ static struct vio_dev *vio_find_name(const char *kobj_name)
 {
 	struct kobject *found;
 
-	found = kset_find_obj(&devices_subsys, kobj_name);
+	found = kset_find_obj(devices_kset, kobj_name);
 	if (!found)
 		return NULL;
 
