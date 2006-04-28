Return-Path: <dwm@bebe.enoyolf.org>
Received: from bebe.enoyolf.org (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.maxeymade.com",
	Issuer "ChainedSSL Certificate Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A1104679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 17:03:45 +1000 (EST)
Message-Id: <200604280605.k3S65tjv012348@bebe.enoyolf.org>
To: yaboot-devel@ozlabs.org
Subject: [PATCH] yaboot: enable boot from iscsi target via ethernet devices on
	js20.
Date: Fri, 28 Apr 2006 01:05:55 -0500
From: Doug Maxey <dwm@bebe.enoyolf.org>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>, Doug Maxey <dwm@enoyolf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Certain levels of JS20 firmware will allow the system to boot from an
iscsi target.  System OFW accomplishes this by setting up a virtual
disk device with parameters.  These parameters, when passed back to
OFW by yaboot, directs the FW to use virtual device over the ethernet
port that will then access iscsi target as a block device.  This patch
extracts those parameters from the property of the virtual device and
passes them back to OFW to indicate the kernel is to be retrieved via
the iscsi protocol.

Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

---

 Makefile         |    2 +-
 include/errors.h |    1 +
 include/prom.h   |    1 +
 second/file.c    |   47 +++++++++++++++++++++++++++++++++++++++++------
 second/prom.c    |    3 +++
 second/yaboot.c  |    6 +++---
 ybin/ybin        |    2 +-
 7 files changed, 51 insertions(+), 11 deletions(-)

5ad3702f0585f73834f8c66b78091184a125c2d2
diff --git a/Makefile b/Makefile
index 39f8633..72ec680 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ ## Setup
 
 include Config
 
-VERSION = 1.3.13
+VERSION = 1.3.14rc1-iscsi
 # Debug mode (spam/verbose)
 DEBUG = 0
 # make install vars
diff --git a/include/errors.h b/include/errors.h
index dfe7e5f..e994dd5 100644
--- a/include/errors.h
+++ b/include/errors.h
@@ -38,3 +38,4 @@ #define FILE_ERR_BADDEV         -12
 /* Device kind */
 #define FILE_DEVICE_BLOCK       1
 #define FILE_DEVICE_NET         2
+#define FILE_DEVICE_ISCSI       3
diff --git a/include/prom.h b/include/prom.h
index 9700803..194b927 100644
--- a/include/prom.h
+++ b/include/prom.h
@@ -34,6 +34,7 @@ typedef void *ihandle;
 typedef void *phandle;
 
 #define PROM_INVALID_HANDLE	((prom_handle)-1UL)
+#define BOOTDEVSZ               (2048) /* iscsi args can be in excess of 1040 bytes */
 
 struct prom_args;
 typedef int (*prom_entry)(struct prom_args *);
diff --git a/second/file.c b/second/file.c
index 0e58286..0ab3623 100644
--- a/second/file.c
+++ b/second/file.c
@@ -1,6 +1,9 @@
 /*
  *  file.c - Filesystem related interfaces
  *
+ *  Copyright (C) IBM Corporation, 2006
+ *  Doug Maxey <dwm@austin.ibm.com>
+ *
  *  Copyright (C) 2001, 2002 Ethan Benson
  *
  *  parse_device_path()
@@ -36,7 +39,7 @@ #include "fs.h"
 #include "errors.h"
 #include "debug.h"
 
-extern char bootdevice[1024];
+extern char bootdevice[];
 
 static char *netdev_path_to_filename(const char *path)
 {
@@ -177,7 +180,7 @@ parse_device_path(char *imagepath, char 
      char *ptr;
      char *ipath = NULL;
      char *defdev = NULL;
-     int device_kind;
+     int device_kind = -1;
 
      result->dev = NULL;
      result->part = -1;
@@ -185,16 +188,45 @@ parse_device_path(char *imagepath, char 
 
      if (!imagepath)
 	  return 0;
+
+      /*
+       * Do preliminary checking for an iscsi device; it may appear as
+       * pure a network device (device_type == "network") if this is
+       * ISWI.  This is the case on IBM systems doing an iscsi OFW
+       * boot.
+       */
+     if (strstr(imagepath, ",iscsi")) {
+ 	  /*
+	   * get the virtual device information from the
+	   * "nas-bootdevice" property.
+	   */
+ 	  if (! prom_get_chosen("nas-bootdevice", bootdevice, BOOTDEVSZ)) {
+	       DEBUG_F("reset boot-device to"
+		       " /chosen/nas-bootdevice = %s\n", bootdevice);
+	       device_kind = FILE_DEVICE_ISCSI;
+	       ipath = strdup(bootdevice);
+	       if (!ipath)
+		    return 0;
+ 	  }
+ 	  else
+ 	       return 0;
+     }
      else if (!(ipath = strdup(imagepath)))
 	  return 0;
 
      if (defdevice) {
 	  defdev = strdup(defdevice);
 	  device_kind = prom_get_devtype(defdev);
-     } else
+     } else if (device_kind == -1)
 	  device_kind = prom_get_devtype(ipath);
 
-     if (device_kind != FILE_DEVICE_NET && strchr(defdev, ':') != NULL) {
+     /*
+      * When an iscsi iqn is present, it may have embedded colons, so
+      * don't parse off anything.
+      */
+     if (device_kind != FILE_DEVICE_NET &&
+	 device_kind != FILE_DEVICE_ISCSI &&
+	 strchr(defdev, ':') != NULL) {
            if ((ptr = strrchr(defdev, ':')) != NULL)
                 *ptr = 0; /* remove trailing : from defdevice if necessary */
      }
@@ -202,7 +234,9 @@ parse_device_path(char *imagepath, char 
      /* This will not properly handle an obp-tftp argument list
       * with elements after the filename; that is handled below.
       */
-     if (device_kind != FILE_DEVICE_NET && strchr(ipath, ':') != NULL) {
+     if (device_kind != FILE_DEVICE_NET &&
+	 device_kind != FILE_DEVICE_ISCSI &&
+	 strchr(ipath, ':') != NULL) {
 	  if ((ptr = strrchr(ipath, ',')) != NULL) {
 	       char *colon = strrchr(ipath, ':');
 	       /* If a ':' occurs *after* a ',', then we assume that there is
@@ -223,7 +257,8 @@ parse_device_path(char *imagepath, char 
 
 	  if (!defdev)
 	       result->dev = netdev_path_to_dev(ipath);
-     } else if ((ptr = strchr(ipath, ':')) != NULL) {
+     } else if (device_kind != FILE_DEVICE_ISCSI &&
+		(ptr = strrchr(ipath, ':')) != NULL) {
 	  *ptr = 0;
 	  result->dev = strdup(ipath);
 	  if (*(ptr+1))
diff --git a/second/prom.c b/second/prom.c
index 5ec06b8..9bc5415 100644
--- a/second/prom.c
+++ b/second/prom.c
@@ -174,6 +174,9 @@ prom_get_devtype (char *device)
      int        result;
      char       tmp[64];
 
+     if (strstr(device, ",iscsi"))
+	  device = strcpy(tmp, "/vdevice/gscsi/disk");
+
      /* Find OF device phandle */
      dev = prom_finddevice(device);
      if (dev == PROM_INVALID_HANDLE) {
diff --git a/second/yaboot.c b/second/yaboot.c
index d7a3a20..bf10b01 100644
--- a/second/yaboot.c
+++ b/second/yaboot.c
@@ -111,7 +111,7 @@ static void     setup_display(void);
 /* Locals & globals */
 
 int useconf = 0;
-char bootdevice[1024];
+char bootdevice[BOOTDEVSZ];
 char *password = NULL;
 struct boot_fspec_t boot;
 int _machine = _MACH_Pmac;
@@ -1474,10 +1474,10 @@ yaboot_main(void)
      if (_machine == _MACH_Pmac)
 	  setup_display();
 
-     prom_get_chosen("bootpath", bootdevice, sizeof(bootdevice));
+     prom_get_chosen("bootpath", bootdevice, BOOTDEVSZ);
      DEBUG_F("/chosen/bootpath = %s\n", bootdevice);
      if (bootdevice[0] == 0) {
-	  prom_get_options("boot-device", bootdevice, sizeof(bootdevice));
+	  prom_get_options("boot-device", bootdevice, BOOTDEVSZ);
 	  DEBUG_F("boot-device = %s\n", bootdevice);
      }
      if (bootdevice[0] == 0) {
diff --git a/ybin/ybin b/ybin/ybin
index 210711f..224b50e 100755
--- a/ybin/ybin
+++ b/ybin/ybin
@@ -29,7 +29,7 @@ fi
 PRG="${0##*/}"
 ABSPRG="$0"
 SIGINT="$PRG: Interrupt caught ... exiting"
-VERSION=1.3.13
+VERSION=1.3.14rc1-iscsi
 DEBUG=0
 VERBOSE=0
 TMP="${TMPDIR:-/tmp}"
-- 
1.3.0
