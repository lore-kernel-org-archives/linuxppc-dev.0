Return-Path: <mchehab@osg.samsung.com>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t52rd69YqzDvM8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 23:20:00 +1100 (AEDT)
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matt Ranostay <mranostay@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] ABI: fix some syntax issues at the ABI database
Date: Fri, 28 Oct 2016 10:19:45 -0200
Message-Id: <d7e0af69cf14fe1cb9cf3298ea3fd98485a8de35.1477656806.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1477656806.git.mchehab@s-opensource.com>
References: <cover.1477656806.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1477656806.git.mchehab@s-opensource.com>
References: <cover.1477656806.git.mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On those three files, the ABI representation described at
README are violated.

- at sysfs-bus-iio-proximity-as3935:
	a ':' character is missing after "What"

- at sysfs-class-devfreq:
	there's a typo at Description

- at sysfs-class-cxl, it is using the ":" character at a
	file preamble, causing it to be misinterpreted as a
	tag.

- On the other files, instead of "What", they use "Where".

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/ABI/testing/pstore                   |  2 +-
 .../testing/sysfs-bus-event_source-devices-format  |  2 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352       |  6 +++---
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  4 ++--
 .../ABI/testing/sysfs-bus-pci-devices-cciss        | 22 +++++++++++-----------
 .../ABI/testing/sysfs-bus-usb-devices-usbsevseg    | 12 ++++++------
 Documentation/ABI/testing/sysfs-class-cxl          |  6 +++---
 Documentation/ABI/testing/sysfs-class-devfreq      |  2 +-
 8 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index 5fca9f5e10a3..8d6e48f4e8ef 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -1,4 +1,4 @@
-Where:		/sys/fs/pstore/... (or /dev/pstore/...)
+What:		/sys/fs/pstore/... (or /dev/pstore/...)
 Date:		March 2011
 Kernel Version: 2.6.39
 Contact:	tony.luck@intel.com
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
index 77f47ff5ee02..b6f8748e0200 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
@@ -1,4 +1,4 @@
-Where:		/sys/bus/event_source/devices/<dev>/format
+What:		/sys/bus/event_source/devices/<dev>/format
 Date:		January 2012
 Kernel Version: 3.3
 Contact:	Jiri Olsa <jolsa@redhat.com>
diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
index feb2e4a87075..29bd447e50a0 100644
--- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
@@ -1,18 +1,18 @@
-Where:		/sys/bus/i2c/devices/.../heading0_input
+What:		/sys/bus/i2c/devices/.../heading0_input
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Reports the current heading from the compass as a floating
 		point value in degrees.
 
-Where:		/sys/bus/i2c/devices/.../power_state
+What:		/sys/bus/i2c/devices/.../power_state
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Sets the power state of the device. 0 sets the device into
 		sleep mode, 1 wakes it up.
 
-Where:		/sys/bus/i2c/devices/.../calibration
+What:		/sys/bus/i2c/devices/.../calibration
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
index 33e96f740639..61a3c9fed07d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
@@ -1,4 +1,4 @@
-What		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
 Date:		March 2014
 KernelVersion:	3.15
 Contact:	Matt Ranostay <mranostay@gmail.com>
@@ -6,7 +6,7 @@ Description:
 		Get the current distance in meters of storm (1km steps)
 		1000-40000 = distance in meters
 
-What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
 Date:		March 2014
 KernelVersion:	3.15
 Contact:	Matt Ranostay <mranostay@gmail.com>
diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
index 53d99edd1d75..eb449169c30b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
@@ -1,66 +1,66 @@
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 model for logical drive
 		Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 revision for logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 83 serial number for logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 vendor for logical drive
 		Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	A symbolic link to /sys/block/cciss!cXdY
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/rescan
+What:		/sys/bus/pci/devices/<dev>/ccissX/rescan
 Date:		August 2009
 Kernel Version:	2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Kicks of a rescan of the controller to discover logical
 		drive topology changes.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the 8-byte LUN ID used to address logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the RAID level of logical drive Y of
 		controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the usage count (number of opens) of logical drive Y
 		of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/resettable
+What:		/sys/bus/pci/devices/<dev>/ccissX/resettable
 Date:		February 2011
 Kernel Version:	2.6.38
 Contact:	iss_storagedev@hp.com
@@ -71,7 +71,7 @@ Description:	Value of 1 indicates the controller can honor the reset_devices
 		a dump device, as kdump requires resetting the device in order
 		to work reliably.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
+What:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
 Date:		July 2011
 Kernel Version:	3.0
 Contact:	iss_storagedev@hp.com
diff --git a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
index 70d00dfa443d..f6199b314196 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
+++ b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
@@ -1,12 +1,12 @@
-Where:		/sys/bus/usb/.../powered
+What:		/sys/bus/usb/.../powered
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls whether the device's display will powered.
 		A value of 0 is off and a non-zero value is on.
 
-Where:		/sys/bus/usb/.../mode_msb
-Where:		/sys/bus/usb/.../mode_lsb
+What:		/sys/bus/usb/.../mode_msb
+What:		/sys/bus/usb/.../mode_lsb
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
@@ -16,7 +16,7 @@ Description:	Controls the devices display mode.
 		for an 8 character display the values are
 			MSB 0x08; LSB 0xFF.
 
-Where:		/sys/bus/usb/.../textmode
+What:		/sys/bus/usb/.../textmode
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
@@ -25,13 +25,13 @@ Description:	Controls the way the device interprets its text buffer.
 		hex:	each character is between 0-15
 		ascii:	each character is between '0'-'9' and 'A'-'F'.
 
-Where:		/sys/bus/usb/.../text
+What:		/sys/bus/usb/.../text
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	The text (or data) for the device to display
 
-Where:		/sys/bus/usb/.../decimals
+What:		/sys/bus/usb/.../decimals
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 4ba0a2a61926..a61758ce81a1 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -1,6 +1,6 @@
-Note: Attributes that are shared between devices are stored in the directory
-pointed to by the symlink device/.
-Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
+Please notice that attributes that are shared between devices are stored in
+the directory pointed to by the symlink device/.
+For example, the real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
 /sys/class/cxl/afu0.0s/device/irqs_max, i.e. /sys/class/cxl/afu0.0/irqs_max.
 
 
diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index ee39acacf6f8..01196e19afca 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -47,7 +47,7 @@ Description:
 What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
-Descrtiption:
+Description:
 		This ABI shows the statistics of devfreq behavior on a
 		specific device. It shows the time spent in each state and
 		the number of transitions between states.
-- 
2.7.4
