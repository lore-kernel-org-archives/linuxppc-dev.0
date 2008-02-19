Return-Path: <mattias.bostroem@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 6BA2BDE006
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:18:03 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so2186898anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:18:01 -0800 (PST)
Message-ID: <10d674cb0802190718r13af85a6w89557e4ca052432f@mail.gmail.com>
Date: Tue, 19 Feb 2008 16:18:01 +0100
From: "=?ISO-8859-1?Q?Mattias_Bostr=F6m?=" <mattias.bostroem@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Patch fixing rmmod -> kernel panic for Peak CAN driver for MPC5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch that solves the problem with kernel panic when
removing the peak-linux-driver-3.17 on a MPC5200B. If someone else
apart from us have experienced that.
The patches to peak-linux-driver-3.17 needed to run on MPC5200B are:
peak-linux-driver-3.17-mpc5200.patch (DENX)
peak-linux-driver-3.17-mpc5200-platform_driver.patch (Sylvain Munaut &
MontaVista)

Mattias

diff --exclude CVS -uNr
peak-linux-driver-3.17/driver/src/pcan_mpc5200.c
peak-linux-driver-3.17.modified/driver/src/pcan_mpc5200.c
--- peak-linux-driver-3.17/driver/src/pcan_mpc5200.c    2008-02-19
16:06:54.000000000 +0100
+++ peak-linux-driver-3.17.modified/driver/src/pcan_mpc5200.c
2008-02-19 16:06:46.000000000 +0100
@@ -752,7 +752,16 @@
 {
        DPRINTK(KERN_DEBUG "%s: mgt_mscan_cleanup()\n", DEVICE_NAME);

-       platform_driver_unregister(&mscan_driver);
+       /* In mgt_mscan_init platform_driver_register is called only once
+        * for module 1.
+        * We should only call platform_driver_unregister once and we do it
+        * for module 1 since it is the last module to cleanup.
+        */
+       if (!(dev->port.mscan.module_num-1)) {
+          DPRINTK(KERN_DEBUG "platform_driver_unregister(&mscan_driver)\n");
+          (void) platform_driver_unregister(&mscan_driver);
+       }
+

 #if 0  /* seems like it's been freed already */
        mgt_mscan_free_irq(dev);
