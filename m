To: linuxppc-dev@lists.linuxppc.org
Subject: Fix bogus ioctl definitions
From: Andreas Schwab <schwab@suse.de>
Date: 01 May 2003 22:12:56 +0200
Message-ID: <m3ptn22zp3.fsf@whitebox.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch fixes the definitions of a few ioctl numbers: the third
argument of _IOR/_IOW/_IOWR is supposed to be a type, not a number.
Fortunately the actual values will not change (on a 32 bit system),
except that PMU_IOC_GRAB_BACKLIGHT should have been _IO('B', 6) in the
first place.

Andreas.

--- linux-2.4.20-ben10.orig/include/linux/pmu.h	2003-04-03 23:54:47.000000000 +0200
+++ linux-2.4.20-ben10/include/linux/pmu.h	2003-05-01 09:55:50.000000000 +0200
@@ -121,18 +121,18 @@

 /* no param */
 #define PMU_IOC_SLEEP		_IO('B', 0)
-/* out param: u32*	backlight value: 0 to 15 */
-#define PMU_IOC_GET_BACKLIGHT	_IOR('B', 1, sizeof(__u32*))
+/* out param: u32	backlight value: 0 to 15 */
+#define PMU_IOC_GET_BACKLIGHT	_IOR('B', 1, __u32)
 /* in param: u32	backlight value: 0 to 15 */
-#define PMU_IOC_SET_BACKLIGHT	_IOW('B', 2, sizeof(__u32))
-/* out param: u32*	PMU model */
-#define PMU_IOC_GET_MODEL	_IOR('B', 3, sizeof(__u32*))
-/* out param: u32*	has_adb: 0 or 1 */
-#define PMU_IOC_HAS_ADB		_IOR('B', 4, sizeof(__u32*))
-/* out param: u32*	can_sleep: 0 or 1 */
-#define PMU_IOC_CAN_SLEEP	_IOR('B', 5, sizeof(__u32*))
-/* no param */
-#define PMU_IOC_GRAB_BACKLIGHT	_IOR('B', 6, 0)
+#define PMU_IOC_SET_BACKLIGHT	_IOW('B', 2, __u32)
+/* out param: u32	PMU model */
+#define PMU_IOC_GET_MODEL	_IOR('B', 3, __u32)
+/* out param: u32	has_adb: 0 or 1 */
+#define PMU_IOC_HAS_ADB		_IOR('B', 4, __u32)
+/* out param: u32	can_sleep: 0 or 1 */
+#define PMU_IOC_CAN_SLEEP	_IOR('B', 5, __u32)
+/* in param: u32	ignored for compatibility */
+#define PMU_IOC_GRAB_BACKLIGHT	_IOR('B', 6, __u32)

 #ifdef __KERNEL__


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
