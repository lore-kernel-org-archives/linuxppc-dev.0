Date: Fri, 1 Jan 1999 13:45:51 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: real-root-dev patch for vger
In-Reply-To: <19981231232453.013798@smtp.calvacom.fr>
Message-ID: <Pine.LNX.3.95.990101134036.23936A-200000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-456352377-1686980163-915223551=:23936"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---456352377-1686980163-915223551=:23936
Content-Type: TEXT/PLAIN; charset=US-ASCII

a type problem has rendered /proc/sys/kernel/real-root-dev useless in the
vger tree. this problem has been around for quite a while. also attached. 

--- init/main.c.orig	Fri Jan  1 13:35:28 1999
+++ init/main.c	Mon Nov 30 16:01:56 1998
@@ -349,7 +349,7 @@
 extern int rd_size;		/* Size of the ramdisk(s) */
 extern int rd_image_start;	/* starting block # of image */
 #ifdef CONFIG_BLK_DEV_INITRD
-kdev_t real_root_dev;
+int real_root_dev;
 #endif
 #endif
 
--- include/linux/fs.h.orig	Fri Jan  1 13:35:12 1999
+++ include/linux/fs.h	Mon Nov 30 20:03:00 1998
@@ -850,7 +850,7 @@
 extern void mount_root(void);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-extern kdev_t real_root_dev;
+extern int real_root_dev;
 extern int change_root(kdev_t new_root_dev,const char *put_old);
 #endif
 


---456352377-1686980163-915223551=:23936
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="real-root.diff"
Content-ID: <Pine.LNX.3.95.990101134551.23936B@pacific.pht.com>
Content-Description: 
Content-Transfer-Encoding: BASE64

LS0tIGluaXQvbWFpbi5jLm9yaWcJRnJpIEphbiAgMSAxMzozNToyOCAxOTk5
DQorKysgaW5pdC9tYWluLmMJTW9uIE5vdiAzMCAxNjowMTo1NiAxOTk4DQpA
QCAtMzQ5LDcgKzM0OSw3IEBADQogZXh0ZXJuIGludCByZF9zaXplOwkJLyog
U2l6ZSBvZiB0aGUgcmFtZGlzayhzKSAqLw0KIGV4dGVybiBpbnQgcmRfaW1h
Z2Vfc3RhcnQ7CS8qIHN0YXJ0aW5nIGJsb2NrICMgb2YgaW1hZ2UgKi8NCiAj
aWZkZWYgQ09ORklHX0JMS19ERVZfSU5JVFJEDQota2Rldl90IHJlYWxfcm9v
dF9kZXY7DQoraW50IHJlYWxfcm9vdF9kZXY7DQogI2VuZGlmDQogI2VuZGlm
DQogDQotLS0gaW5jbHVkZS9saW51eC9mcy5oLm9yaWcJRnJpIEphbiAgMSAx
MzozNToxMiAxOTk5DQorKysgaW5jbHVkZS9saW51eC9mcy5oCU1vbiBOb3Yg
MzAgMjA6MDM6MDAgMTk5OA0KQEAgLTg1MCw3ICs4NTAsNyBAQA0KIGV4dGVy
biB2b2lkIG1vdW50X3Jvb3Qodm9pZCk7DQogDQogI2lmZGVmIENPTkZJR19C
TEtfREVWX0lOSVRSRA0KLWV4dGVybiBrZGV2X3QgcmVhbF9yb290X2RldjsN
CitleHRlcm4gaW50IHJlYWxfcm9vdF9kZXY7DQogZXh0ZXJuIGludCBjaGFu
Z2Vfcm9vdChrZGV2X3QgbmV3X3Jvb3RfZGV2LGNvbnN0IGNoYXIgKnB1dF9v
bGQpOw0KICNlbmRpZg0KIA0K
---456352377-1686980163-915223551=:23936--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
