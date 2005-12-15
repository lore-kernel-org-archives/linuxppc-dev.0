Return-Path: <Kristian-M@kristian-m.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 1C9DA68802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 14:59:05 +1100 (EST)
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Emk4n-0003D1-00
	for linuxppc-dev@ozlabs.org; Thu, 15 Dec 2005 04:46:41 +0100
Received: from 62.4.70.142.eliott-ness.com ([62.4.70.142] helo=localhost)
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Emk4m-0007hS-00
	for linuxppc-dev@ozlabs.org; Thu, 15 Dec 2005 04:46:40 +0100
From: Kristian Mueller <Kristian-M@Kristian-M.de>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-SYL+LP9ziiUiuDHtMI81"
Date: Thu, 15 Dec 2005 11:45:22 +0800
Message-Id: <1134618322.4972.10.camel@pismo>
Mime-Version: 1.0
Subject: [PATCH] via-mpu: compile without Power Management support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SYL+LP9ziiUiuDHtMI81
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Don't check for sleep_in_progress if there is no 
Power Management support.


--=-SYL+LP9ziiUiuDHtMI81
Content-Disposition: attachment; filename=pmu-without-pm.patch
Content-Type: text/x-patch; name=pmu-without-pm.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux/drivers/macintosh/via-pmu.c.orig	2005-12-15 11:28:28.000000000 +0800
+++ linux/drivers/macintosh/via-pmu.c	2005-12-15 10:04:53.000000000 +0800
@@ -2911,8 +2911,10 @@ pmu_ioctl(struct inode * inode, struct f
 	 * the fbdev
 	 */
 	case PMU_IOC_GET_BACKLIGHT:
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)	   
 		if (sleep_in_progress)
 			return -EBUSY;
+#endif /* CONFIG_PM && CONFIG_PPC32 */
 		error = get_backlight_level();
 		if (error < 0)
 			return error;
@@ -2920,8 +2922,10 @@ pmu_ioctl(struct inode * inode, struct f
 	case PMU_IOC_SET_BACKLIGHT:
 	{
 		__u32 value;
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)	   
 		if (sleep_in_progress)
 			return -EBUSY;
+#endif /* CONFIG_PM && CONFIG_PPC32 */
 		error = get_user(value, argp);
 		if (!error)
 			error = set_backlight_level(value);

--=-SYL+LP9ziiUiuDHtMI81--
