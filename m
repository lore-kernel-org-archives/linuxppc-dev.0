Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5441A1A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 21:49:27 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v3 0/16] POWER8 Coherent Accelerator device driver
Date: Tue,  7 Oct 2014 21:48:06 +1100
Message-Id: <1412678902-18672-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the latest version of the cxl driver.  Change log below:

v3:
 - Updates based on comments from mpe, benh, aneesh and offline reviews.
 - Fixed bug freeing AFU IRQs that also freed the multiplexed PSL IRQ
 - Change copro_flush_all_slbs to a static inline as suggested by mpe
 - Implement sanitisation routines to clear out more registers and do full
   adapter wide tlbia and slbia when initialising hardware
 - Add self testcase to msi_bitmap to test allocations are aligned to a power of
   2 and cleanup comment as suggested by mpe
 - Clean up cxl_use_count
 - Split out detach_process_native into two logical functions
 - Improve comment in set_msi_irq_chip as requested by mpe
 - Move cxl functions in pci-ioda.c to be under just one #ifdef CONFIG_CXL_BASE
 - Cleanup hash_page and hash_page_mm from mpes and Aneesh' reviews
 - Remove dead code in cxl_alloc_sst
 - Add timeout in afu_slbia_native
 - Remove cxl backend and driver ops abstractions
   - Removed separate cxl-pci module
   - Merged cxl pci module init calls into main driver init
 - Refactor afu_read() to be a bit simpler and more closely follow exising
   patterns in the kernel
 - Userspace API updates from reviews:
   - Added ioctl to get the process element number, and removed it as a return
     from the start work ioctl
   - Alter cxl_event to have one common header struct
   - Dropped check error ioctl
   - Added current and binary compatible API version numbers to sysfs
   - read() now takes a 4K (or greater) buffer
   - Pack event structs to reduce unecessary reserved fields
     - Event sizes can now differ
     - All event sizes are 64bit multiples to allow future event coalescing
   - Add flags fields to indicate which fields contain valid data
   - Add BUILD_BUG_ONs to protect against inadvertantly changing API without
     bumping version number and/or flags
   - Update documentation
 - Skip CXL SLBIA codepath if CXL is not in use
 - Split cxl_slbia_core into two functions to be easier to read
 - Refactor copro_data_segment (renamed to copro_calc_slb) since we are no
   longer merging with hash_page and cleaned up parameters.
 - Some renames:
   - struct cxl_t -> struct cxl
   - struct cxl_afu_t -> struct cxl_afu
   - struct cxl_context_t -> struct cxl_context
   - copro_data_segment -> copro_calc_slb
   - ctx->ph -> ctx->pe
 - Added ctx->status mutex lock around for start and release context

v2:
 - Updates based on comments from, Anton, Gavin, Aneesh, jk and offline reviews
 - Simplified copro_data_segment() and merged code with hash_page_mm()
    (New patch 10/17)
 - PCIe code simplifications based on Gavin's review
 - Removed redundant comment in msi_bitmap_alloc_hwirqs()
 - Fix for locking in idr_remove in core driver
 - Ensure PSL is enabled when PHB is flipped to CXL mode
 - Added CONFIG_PPC_COPRO_BASE to compile copro_fault.c
 - Merged SPU and cxl slb flushing calls into copro_flush_all_slbs()
    (New patch 03/17)
 - Moved slb_vsid_shift() to static inline from #define
 - Don't write paca->context when demoting segments and mm != current
 - Fix minor typos in documentation

v1:
 - Initial post

This add support for the Coherent Accelerator (cxl) attached to POWER8
processors.  This coherent accelerator interface is designed to allow the
coherent connection of FPGA based accelerators (and other devices) to a POWER
systems.

IBM refers to this as the Coherent Accelerator Processor Interface or CAPI.  In
this driver it's referred to by the name cxl to avoid confusion with the ISDN
CAPI subsystem.

An overview of the patches:
  Patches  1-3:  Split some of the old Cell co-processor code out so it can be
		   reused.
  Patches  4-10: Add infrastructure to arch/powerpc needed by cxl.
  Patches  11:   Add call backs needed for invalidating cxl mm contexts.
  Patch    12:   Add cxl specific support that needs to be built in to the
		   kernel (can't be a module).
  Patches 13-15: Add the majority of the device driver and API header.
  Patch    16:   Documentation.

The documentation in this last patch gives an overview of the hardware
architecture as well as the userspace API.

The cxl driver has a user-space interface described in include/uapi/misc/cxl.h
and Documentation/powerpc/cxl.txt.  There are two ioctls which can be used to
talk to the driver once the new /dev/cxl/afu0.0 device is opened.  This device
can also be read and mmaped.

There's also sysfs entries used to communicate information about the cxl
configuration to userspace.  These are documented in
Documentation/ABI/testing/sysfs-class-cxl.

Many contributed to this device driver but Ian Munsie is the principal author.

Driver can also be found here (based on 3.17-rc5):
   git://github.com/mikey/linux.git cxl
   https://github.com/mikey/linux/commits/cxl
(Series rebases on recent linux-next with one trivial include file conflict)

Please consider for inclusion.  Feedback welcome!

Regards,
Mikey
