Subject: [PATCH] Fix compilation problem with 2.6.0-test2 on PPC
From: Jocelyn Mayer <jma@netgem.com>
To: Linux PPC <linuxppc-dev@lists.linuxppc.org>,
	linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz
Content-Type: multipart/mixed; boundary="=-0hU7Y3uiaJztAxn/j0J/"
Message-Id: <1060114295.1914.6988.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Date: 05 Aug 2003 22:11:36 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-0hU7Y3uiaJztAxn/j0J/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

There is a compilation issue in driver/input/evdev.c
due to the fact a "complex" expression is used as an argument
for an inline assembly construction (get_user)
The fix I done is to use a temporary variable to get the argument
and then use this variable for get_user.

--
Jocelyn Mayer <jma@netgem.com>

--=-0hU7Y3uiaJztAxn/j0J/
Content-Disposition: attachment; filename=evdev.c.diff
Content-Type: text/plain; name=evdev.c.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- evdev.c.orig	Mon Jun 16 06:39:02 2003
+++ evdev.c	Thu Jul 31 02:41:35 2003
@@ -208,7 +208,7 @@
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
-	int i, t, u;
+	int i, t, u, v;

 	if (!evdev->exist) return -ENODEV;

@@ -240,7 +240,8 @@
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
 			u = INPUT_KEYCODE(dev, t);
-			if (get_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
+                        v = INPUT_KEYCODE(dev, t);
+			if (get_user(v, ((int *) arg) + 1)) return -EFAULT;

 			for (i = 0; i < dev->keycodemax; i++)
 				if(INPUT_KEYCODE(dev, t) == u) break;

--=-0hU7Y3uiaJztAxn/j0J/--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
