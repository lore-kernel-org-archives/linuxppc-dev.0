Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C87121A06A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:12 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 05/19] cxl: Document external user of existing API
Date: Tue, 19 May 2015 21:22:22 +1000
Message-Id: <1432034556-32400-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that libcxl is public, let's document it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 Documentation/ABI/testing/sysfs-class-cxl | 22 ++++++++++++++++++++++
 Documentation/powerpc/cxl.txt             |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index d46bba8..7cd9f2e 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -15,6 +15,7 @@ Description:    read/write
                 that hardware can support (eg. 2037). Write values will limit
                 userspace applications to that many userspace interrupts. Must
                 be >= irqs_min.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/irqs_min
 Date:           September 2014
@@ -24,6 +25,7 @@ Description:    read only
                 userspace must request on a CXL_START_WORK ioctl. Userspace may
                 omit the num_interrupts field in the START_WORK IOCTL to get
                 this minimum automatically.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/mmio_size
 Date:           September 2014
@@ -31,6 +33,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the size of the MMIO space that may be mmaped
                 by userspace.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/modes_supported
 Date:           September 2014
@@ -38,6 +41,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 List of the modes this AFU supports. One per line.
                 Valid entries are: "dedicated_process" and "afu_directed"
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/mode
 Date:           September 2014
@@ -46,6 +50,7 @@ Description:    read/write
                 The current mode the AFU is using. Will be one of the modes
                 given in modes_supported. Writing will change the mode
                 provided that no user contexts are attached.
+Users:		https://github.com/ibm-capi/libcxl
 
 
 What:           /sys/class/cxl/<afu>/prefault_mode
@@ -59,6 +64,7 @@ Description:    read/write
                                  descriptor as an effective address and
                                  prefault what it points to.
                         all: all segments process calling START_WORK maps.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/reset
 Date:           September 2014
@@ -66,12 +72,14 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    write only
                 Writing 1 here will reset the AFU provided there are not
                 contexts active on the AFU.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/api_version
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the current version of the kernel/user API.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/api_version_compatible
 Date:           September 2014
@@ -79,6 +87,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the the lowest version of the userspace API
                 this this kernel supports.
+Users:		https://github.com/ibm-capi/libcxl
 
 
 AFU configuration records (eg. /sys/class/cxl/afu0.0/cr0):
@@ -92,6 +101,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
 		Hexadecimal value of the vendor ID found in this AFU
 		configuration record.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/cr<config num>/device
 Date:           February 2015
@@ -99,6 +109,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
 		Hexadecimal value of the device ID found in this AFU
 		configuration record.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/cr<config num>/class
 Date:           February 2015
@@ -106,6 +117,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
 		Hexadecimal value of the class code found in this AFU
 		configuration record.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>/cr<config num>/config
 Date:           February 2015
@@ -115,6 +127,7 @@ Description:    read only
 		record. The format is expected to match the either the standard
 		or extended configuration space defined by the PCIe
 		specification.
+Users:		https://github.com/ibm-capi/libcxl
 
 
 
@@ -126,18 +139,21 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the size of the MMIO space that may be mmaped
                 by userspace. This includes all slave contexts space also.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>m/pp_mmio_len
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the Per Process MMIO space length.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<afu>m/pp_mmio_off
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Decimal value of the Per Process MMIO space offset.
+Users:		https://github.com/ibm-capi/libcxl
 
 
 Card info (eg. /sys/class/cxl/card0)
@@ -147,12 +163,14 @@ Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Identifies the CAIA Version the card implements.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<card>/psl_revision
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Identifies the revision level of the PSL.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<card>/base_image
 Date:           September 2014
@@ -162,6 +180,7 @@ Description:    read only
                 that support loadable PSLs. For FPGAs this field identifies
                 the image contained in the on-adapter flash which is loaded
                 during the initial program load.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<card>/image_loaded
 Date:           September 2014
@@ -169,6 +188,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Will return "user" or "factory" depending on the image loaded
                 onto the card.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<card>/load_image_on_perst
 Date:           December 2014
@@ -183,6 +203,7 @@ Description:    read/write
                 user or factory image to be loaded.
                 Default is to reload on PERST whichever image the card has
                 loaded.
+Users:		https://github.com/ibm-capi/libcxl
 
 What:           /sys/class/cxl/<card>/reset
 Date:           October 2014
@@ -190,3 +211,4 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    write only
                 Writing 1 will issue a PERST to card which may cause the card
                 to reload the FPGA depending on load_image_on_perst.
+Users:		https://github.com/ibm-capi/libcxl
diff --git a/Documentation/powerpc/cxl.txt b/Documentation/powerpc/cxl.txt
index 2c71ecc..2a230d01 100644
--- a/Documentation/powerpc/cxl.txt
+++ b/Documentation/powerpc/cxl.txt
@@ -133,6 +133,9 @@ User API
     The following file operations are supported on both slave and
     master devices.
 
+    A userspace library libcxl is avaliable here:
+	https://github.com/ibm-capi/libcxl
+    This provides a C interface to this kernel API.
 
 open
 ----
@@ -366,6 +369,7 @@ Sysfs Class
     enumeration and tuning of the accelerators. Its layout is
     described in Documentation/ABI/testing/sysfs-class-cxl
 
+
 Udev rules
 ==========
 
-- 
2.1.0
