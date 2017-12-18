Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBk25HLzDsFY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:22:06 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFL6Gx143904
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:22:03 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exehh5gc8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:22:02 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:22:00 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 12/13] ocxl: Documentation
Date: Mon, 18 Dec 2017 16:21:25 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <08cdb26dd4af4b728496c145fe4ef6103dbf7638.1513608243.git.fbarrat@linux.vnet.ibm.com>
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
 Documentation/accelerators/ocxl.rst  | 151 +++++++++++++++++++++++++++++++++++
 Documentation/ioctl/ioctl-number.txt |   1 +
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/accelerators/ocxl.rst

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
new file mode 100644
index 000000000000..94ccd55f2acd
--- /dev/null
+++ b/Documentation/accelerators/ocxl.rst
@@ -0,0 +1,151 @@
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
+  |           |--| Memory |             |   (AFU)     |--| Memory |
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
