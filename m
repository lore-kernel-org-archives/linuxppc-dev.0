Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNt5dnszDr0M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBV9R6163122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:11 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fp2vv3r9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:10 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:32:09 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 12/13] ocxl: Documentation
Date: Tue, 23 Jan 2018 12:31:47 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-13-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ocxl.rst gives a quick, high-level view of opencapi.

Update ioctl-number.txt to reflect ioctl numbers being used by the
ocxl driver

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-ocxl |  35 +++++++
 Documentation/accelerators/ocxl.rst        | 160 +++++++++++++++++++++++++++++
 Documentation/ioctl/ioctl-number.txt       |   1 +
 3 files changed, 196 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ocxl
 create mode 100644 Documentation/accelerators/ocxl.rst

diff --git a/Documentation/ABI/testing/sysfs-class-ocxl b/Documentation/ABI/testing/sysfs-class-ocxl
new file mode 100644
index 000000000000..ac11deb71235
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-ocxl
@@ -0,0 +1,35 @@
+What:           /sys/class/ocxl/<afu name>/afu_version
+Date:           January 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+                Version of the AFU, in the format <major>:<minor>
+		Reflects what is read in the configuration space of the AFU
+
+What:           /sys/class/ocxl/<afu name>/contexts
+Date:           January 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Number of contexts for the AFU, in the format <n>/<max>
+		where:
+			n: number of currently active contexts, for debug
+			max: maximum number of contexts supported by the AFU
+
+What:           /sys/class/ocxl/<afu name>/pp_mmio_size
+Date:           January 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Size of the per-process mmio area, as defined in the
+		configuration space of the AFU
+
+What:           /sys/class/ocxl/<afu name>/global_mmio_size
+Date:           January 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Size of the global mmio area, as defined in the
+		configuration space of the AFU
+
+What:           /sys/class/ocxl/<afu name>/global_mmio_area
+Date:           January 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read/write
+		Give access the global mmio area for the AFU
diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
new file mode 100644
index 000000000000..4f7af841d935
--- /dev/null
+++ b/Documentation/accelerators/ocxl.rst
@@ -0,0 +1,160 @@
+========================================================
+OpenCAPI (Open Coherent Accelerator Processor Interface)
+========================================================
+
+OpenCAPI is an interface between processors and accelerators. It aims
+at being low-latency and high-bandwidth. The specification is
+developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
+
+It allows an accelerator (which could be a FPGA, ASICs, ...) to access
+the host memory coherently, using virtual addresses. An OpenCAPI
+device can also host its own memory, that can be accessed from the
+host.
+
+OpenCAPI is known in linux as 'ocxl', as the open, processor-agnostic
+evolution of 'cxl' (the driver for the IBM CAPI interface for
+powerpc), which was named that way to avoid confusion with the ISDN
+CAPI subsystem.
+
+
+High-level view
+===============
+
+OpenCAPI defines a Data Link Layer (DL) and Transaction Layer (TL), to
+be implemented on top of a physical link. Any processor or device
+implementing the DL and TL can start sharing memory.
+
+::
+
+  +-----------+                         +-------------+
+  |           |                         |             |
+  |           |                         | Accelerated |
+  | Processor |                         |  Function   |
+  |           |  +--------+             |    Unit     |  +--------+
+  |           |--| Memory |             |    (AFU)    |--| Memory |
+  |           |  +--------+             |             |  +--------+
+  +-----------+                         +-------------+
+       |                                       |
+  +-----------+                         +-------------+
+  |    TL     |                         |    TLX      |
+  +-----------+                         +-------------+
+       |                                       |
+  +-----------+                         +-------------+
+  |    DL     |                         |    DLX      |
+  +-----------+                         +-------------+
+       |                                       |
+       |                   PHY                 |
+       +---------------------------------------+
+
+
+
+Device discovery
+================
+
+OpenCAPI relies on a PCI-like configuration space, implemented on the
+device. So the host can discover AFUs by querying the config space.
+
+OpenCAPI devices in Linux are treated like PCI devices (with a few
+caveats). The firmware is expected to abstract the hardware as if it
+was a PCI link. A lot of the existing PCI infrastructure is reused:
+devices are scanned and BARs are assigned during the standard PCI
+enumeration. Commands like 'lspci' can therefore be used to see what
+devices are available.
+
+The configuration space defines the AFU(s) that can be found on the
+physical adapter, such as its name, how many memory contexts it can
+work with, the size of its MMIO areas, ...
+
+
+
+MMIO
+====
+
+OpenCAPI defines two MMIO areas for each AFU:
+
+* the global MMIO area, with registers pertinent to the whole AFU.
+* a per-process MMIO area, which has a fixed size for each context.
+
+
+
+AFU interrupts
+==============
+
+OpenCAPI includes the possibility for an AFU to send an interrupt to a
+host process. It is done through a 'intrp_req' defined in the
+Transaction Layer, specifying a 64-bit object handle which defines the
+interrupt.
+
+The driver allows a process to allocate an interrupt and obtain its
+64-bit object handle, that can be passed to the AFU.
+
+
+
+char devices
+============
+
+The driver creates one char device per AFU found on the physical
+device. A physical device may have multiple functions and each
+function can have multiple AFUs. At the time of this writing though,
+it has only been tested with devices exporting only one AFU.
+
+Char devices can be found in /dev/ocxl/ and are named as:
+/dev/ocxl/<AFU name>.<location>.<index>
+
+where <AFU name> is a max 20-character long name, as found in the
+config space of the AFU.
+<location> is added by the driver and can help distinguish devices
+when a system has more than one instance of the same OpenCAPI device.
+<index> is also to help distinguish AFUs in the unlikely case where a
+device carries multiple copies of the same AFU.
+
+
+
+Sysfs class
+===========
+
+An ocxl class is added for the devices representing the AFUs. See
+/sys/class/ocxl. The layout is described in
+Documentation/ABI/testing/sysfs-class-ocxl
+
+
+
+User API
+========
+
+open
+----
+
+Based on the AFU definition found in the config space, an AFU may
+support working with more than one memory context, in which case the
+associated char device may be opened multiple times by different
+processes.
+
+
+ioctl
+-----
+
+OCXL_IOCTL_ATTACH:
+
+  Attach the memory context of the calling process to the AFU so that
+  the AFU can access its memory.
+
+OCXL_IOCTL_IRQ_ALLOC:
+
+  Allocate an AFU interrupt and return an identifier.
+
+OCXL_IOCTL_IRQ_FREE:
+
+  Free a previously allocated AFU interrupt.
+
+OCXL_IOCTL_IRQ_SET_FD:
+
+  Associate an event fd to an AFU interrupt so that the user process
+  can be notified when the AFU sends an interrupt.
+
+
+mmap
+----
+
+A process can mmap the per-process MMIO area for interactions with the
+AFU.
diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 3e3fdae5f3ed..6501389d55b9 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -326,6 +326,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
+0xCA	10-2F	uapi/misc/ocxl.h
 0xCA	80-BF	uapi/scsi/cxlflash_ioctl.h
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
-- 
2.14.1
