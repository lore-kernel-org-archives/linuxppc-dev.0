Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBEC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:23:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAEE218FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ul/0grnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAEE218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3ww3QZ2zDqSM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:23:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ul/0grnM"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3t04StBzDq9Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:20:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tdmz9Cia/HkrNCPc1DNC1Xiw2CWlxEY7ibOiV8c9+gg=; b=ul/0grnMmAFm1P3KZN1Jt0VkxQ
 WhYD7w57+Za4MDccHGasIGWvMAzuKdQioaJeD9eiib23Rqu+9M+wOy1r2Q2IvpvJp+vCc4OtCcsoY
 q0XXNwc4esgI6f/mXg2E1jRj3wx4cQltElf2pXMZg7jyeuTrtpDLK3lU1DDdVNDFsq9cf1XCYvhW+
 ZtA1EAbz7Vj5lIPela6d1yRm9np/CIKvupfbBvJHleE6y4FXuwcc48cDw1SnOgiqS0F2v9POuQnRs
 ImM8kIj7OrFEt+N0l4kgXriu/5vFeT8AU6WpsoP7iw4UTmuUvL7agyz/7FlgABCn9CT3QIVg9kl57
 y8ALsgpw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJJhB-00027j-Q3; Wed, 24 Apr 2019 15:20:26 +0000
Date: Wed, 24 Apr 2019 12:20:19 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 26/63] Documentation: PCI: convert pci.txt to reST
Message-ID: <20190424122019.364092e8@coco.lan>
In-Reply-To: <20190423162932.21428-27-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-27-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:28:55 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst            |   2 +
>  Documentation/PCI/{pci.txt => pci.rst} | 267 +++++++++++++------------
>  2 files changed, 140 insertions(+), 129 deletions(-)
>  rename Documentation/PCI/{pci.txt => pci.rst} (78%)
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index c2f8728d11cf..7babf43709b0 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -7,3 +7,5 @@ Linux PCI Bus Subsystem
>  .. toctree::
>     :maxdepth: 2
>     :numbered:
> +
> +   pci

See my comments to patch 25/63. It applies to all PCI stuff,
so I won't keep repeating it. Anyway, the final decision with
regards to file naming belongs to the docs maintainer and to
the PCI maintainer.

> diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.rst
> similarity index 78%
> rename from Documentation/PCI/pci.txt
> rename to Documentation/PCI/pci.rst
> index badb26ac33dc..29ddd2e9177a 100644
> --- a/Documentation/PCI/pci.txt
> +++ b/Documentation/PCI/pci.rst

I would either rename this file or Documentation/driver-api/pci/pci.rst.

Even if the decision is to keep those on different directories, it
sounds a very bad idea on my eyes to keep two files with different
content and identical names on different directories that belong to
the same subsystem.

@PCI maintainers:

The MAINTAINERS file, at the PCI SUBSYSTEM part is missing 
an entry for Documentation/driver-api/pci/. 

> @@ -1,10 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -			How To Write Linux PCI Drivers
> +==============================
> +How To Write Linux PCI Drivers
> +==============================
>  
> -		by Martin Mares <mj@ucw.cz> on 07-Feb-2000
> -	updated by Grant Grundler <grundler@parisc-linux.org> on 23-Dec-2006
> +:Authors: - Martin Mares <mj@ucw.cz>
> +          - Grant Grundler <grundler@parisc-linux.org>
>  
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  The world of PCI is vast and full of (mostly unpleasant) surprises.
>  Since each CPU architecture implements different chip-sets and PCI devices
>  have different requirements (erm, "features"), the result is the PCI support
> @@ -26,8 +28,8 @@ Please send questions/comments/patches about Linux PCI API to the
>  
>  
>  
> -0. Structure of PCI drivers
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Structure of PCI drivers
> +========================
>  PCI drivers "discover" PCI devices in a system via pci_register_driver().
>  Actually, it's the other way around. When the PCI generic code discovers
>  a new device, the driver with a matching "description" will be notified.
> @@ -42,24 +44,25 @@ pointers and thus dictates the high level structure of a driver.
>  Once the driver knows about a PCI device and takes ownership, the
>  driver generally needs to perform the following initialization:
>  
> -	Enable the device
> -	Request MMIO/IOP resources
> -	Set the DMA mask size (for both coherent and streaming DMA)
> -	Allocate and initialize shared control data (pci_allocate_coherent())
> -	Access device configuration space (if needed)
> -	Register IRQ handler (request_irq())
> -	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
> -	Enable DMA/processing engines
> +  - Enable the device
> +  - Request MMIO/IOP resources
> +  - Set the DMA mask size (for both coherent and streaming DMA)
> +  - Allocate and initialize shared control data (pci_allocate_coherent())
> +  - Access device configuration space (if needed)
> +  - Register IRQ handler (request_irq())
> +  - Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
> +  - Enable DMA/processing engines
>  
>  When done using the device, and perhaps the module needs to be unloaded,
>  the driver needs to take the follow steps:
> -	Disable the device from generating IRQs
> -	Release the IRQ (free_irq())
> -	Stop all DMA activity
> -	Release DMA buffers (both streaming and coherent)
> -	Unregister from other subsystems (e.g. scsi or netdev)
> -	Release MMIO/IOP resources
> -	Disable the device
> +
> +  - Disable the device from generating IRQs
> +  - Release the IRQ (free_irq())
> +  - Stop all DMA activity
> +  - Release DMA buffers (both streaming and coherent)
> +  - Unregister from other subsystems (e.g. scsi or netdev)
> +  - Release MMIO/IOP resources
> +  - Disable the device
>  
>  Most of these topics are covered in the following sections.
>  For the rest look at LDD3 or <linux/pci.h> .
> @@ -70,13 +73,12 @@ completely empty or just returning an appropriate error codes to avoid
>  lots of ifdefs in the drivers.
>  
>  
> -
> -1. pci_register_driver() call
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +pci_register_driver() call
> +==========================
>  
>  PCI device drivers call pci_register_driver() during their
>  initialization with a pointer to a structure describing the driver
> -(struct pci_driver):
> +(struct pci_driver)::
>  
>  	field name	Description
>  	----------	------------------------------------------------------
> @@ -125,7 +127,7 @@ initialization with a pointer to a structure describing the driver
>  The ID table is an array of struct pci_device_id entries ending with an
>  all-zero entry.  Definitions with static const are generally preferred.

Better to format this as a table, e. g.:

	=============== =======================================================
	field name	Description
	=============== =======================================================
	id_table	Pointer to table of device ID's the driver is
			interested in.  Most drivers should export this
			table using MODULE_DEVICE_TABLE(pci,...).

	probe		This probing function gets called (during execution
			of pci_register_driver() for already existing
			devices or later if a new device gets inserted) for
			all PCI devices which match the ID table and are not
			"owned" by the other drivers yet. This function gets
			passed a `struct pci_dev *` for each device whose
			entry in the ID table matches the device. The probe
			function returns zero when the driver chooses to
			take "ownership" of the device or an error code
			(negative number) otherwise.
			The probe function always gets called from process
			context, so it can sleep.

	remove		The remove() function gets called whenever a device
			being handled by this driver is removed (either during
			deregistration of the driver or when it's manually
			pulled out of a hot-pluggable slot).
			The remove function always gets called from process
			context, so it can sleep.

	suspend		Put device into low power state.
	suspend_late	Put device into low power state.

	resume_early	Wake device from low power state.
	resume		Wake device from low power state.

		        (Please see Documentation/power/pci.rst for
		        descriptions of PCI Power Management and the
		        related functions.)

	shutdown	Hook into reboot_notifier_list (kernel/sys.c).
			Intended to stop any idling DMA operations.
			Useful for enabling wake-on-lan (NIC) or changing
			the power state of a device before reboot.
			e.g. drivers/net/e100.c.

	err_handler	See Documentation/PCI/pci-error-recovery.rst
	=============== =======================================================


>  
> -Each entry consists of:
> +Each entry consists of::
>  
>  	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)

Same here:

   Each entry consists of:

	====================	=======================================================
	vendor, device		Vendor and device ID to match (or PCI_ANY_ID)

	subvendor, subdevice	Subsystem vendor and device ID to match (or PCI_ANY_ID)
	

	class			Device class, subclass, and "interface" to match.
				See Appendix D of the PCI Local Bus Spec or
				include/linux/pci_ids.h for a full list of classes.
				Most drivers do not need to specify class/class_mask
				as vendor/device is normally sufficient.

	class_mask		limit which sub-fields of the class field are compared.
				See drivers/scsi/sym53c8xx_2/ for example of usage.

	driver_data		Data private to the driver.
				Most drivers don't need to use driver_data field.
				Best practice is to use driver_data as an index
				into a static list of equivalent device types,
				instead of using it as a pointer.
	====================	=======================================================


>  
> @@ -160,9 +162,10 @@ echo "vendor device subvendor subdevice class class_mask driver_data" > \
>  All fields are passed in as hexadecimal values (no leading 0x).
>  The vendor and device fields are mandatory, the others are optional. Users
>  need pass only as many optional fields as necessary:
> -	o subvendor and subdevice fields default to PCI_ANY_ID (FFFFFFFF)
> -	o class and classmask fields default to 0
> -	o driver_data defaults to 0UL.
> +
> +  - subvendor and subdevice fields default to PCI_ANY_ID (FFFFFFFF)
> +  - class and classmask fields default to 0
> +  - driver_data defaults to 0UL.
>  
>  Note that driver_data must match the value used by any of the pci_device_id
>  entries defined in the driver. This makes the driver_data field mandatory
> @@ -175,29 +178,30 @@ When the driver exits, it just calls pci_unregister_driver() and the PCI layer
>  automatically calls the remove hook for all devices handled by the driver.
>  
>  
> -1.1 "Attributes" for driver functions/data
> +"Attributes" for driver functions/data
> +--------------------------------------
>  
>  Please mark the initialization and cleanup functions where appropriate
> -(the corresponding macros are defined in <linux/init.h>):
> +(the corresponding macros are defined in <linux/init.h>)::
>  
>  	__init		Initialization code. Thrown away after the driver
>  			initializes.
>  	__exit		Exit code. Ignored for non-modular drivers.

Same here:

  Please mark the initialization and cleanup functions where appropriate
  (the corresponding macros are defined in <linux/init.h>):

	=============== =================================================
	__init		Initialization code. Thrown away after the driver
			initializes.
	__exit		Exit code. Ignored for non-modular drivers.
	=============== =================================================


>  
>  Tips on when/where to use the above attributes:
> -	o The module_init()/module_exit() functions (and all
> +	- The module_init()/module_exit() functions (and all
>  	  initialization functions called _only_ from these)
>  	  should be marked __init/__exit.
>  
> -	o Do not mark the struct pci_driver.
> +	- Do not mark the struct pci_driver.
>  
> -	o Do NOT mark a function if you are not sure which mark to use.
> +	- Do NOT mark a function if you are not sure which mark to use.
>  	  Better to not mark the function than mark the function wrong.
>  
>  
>  
> -2. How to find PCI devices manually
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +How to find PCI devices manually
> +================================
>  
>  PCI drivers should have a really good reason for not using the
>  pci_register_driver() interface to search for PCI devices.
> @@ -207,17 +211,17 @@ E.g. combined serial/parallel port/floppy controller.
>  
>  A manual search may be performed using the following constructs:
>  
> -Searching by vendor and device ID:
> +Searching by vendor and device ID::
>  
>  	struct pci_dev *dev = NULL;
>  	while (dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))
>  		configure_device(dev);
>  
> -Searching by class ID (iterate in a similar way):
> +Searching by class ID (iterate in a similar way)::
>  
>  	pci_get_class(CLASS_ID, dev)
>  
> -Searching by both vendor/device and subsystem vendor/device ID:
> +Searching by both vendor/device and subsystem vendor/device ID::
>  
>  	pci_get_subsys(VENDOR_ID,DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
>  
> @@ -231,20 +235,20 @@ decrement the reference count on these devices by calling pci_dev_put().
>  
>  
>  
> -3. Device Initialization Steps
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Device Initialization Steps
> +===========================
>  
>  As noted in the introduction, most PCI drivers need the following steps
>  for device initialization:
>  
> -	Enable the device
> -	Request MMIO/IOP resources
> -	Set the DMA mask size (for both coherent and streaming DMA)
> -	Allocate and initialize shared control data (pci_allocate_coherent())
> -	Access device configuration space (if needed)
> -	Register IRQ handler (request_irq())
> -	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
> -	Enable DMA/processing engines.
> +  - Enable the device
> +  - Request MMIO/IOP resources
> +  - Set the DMA mask size (for both coherent and streaming DMA)
> +  - Allocate and initialize shared control data (pci_allocate_coherent())
> +  - Access device configuration space (if needed)
> +  - Register IRQ handler (request_irq())
> +  - Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
> +  - Enable DMA/processing engines.
>  
>  The driver can access PCI config space registers at any time.
>  (Well, almost. When running BIST, config space can go away...but
> @@ -252,17 +256,18 @@ that will just result in a PCI Bus Master Abort and config reads
>  will return garbage).
>  
>  
> -3.1 Enable the PCI device
> -~~~~~~~~~~~~~~~~~~~~~~~~~
> +Enable the PCI device
> +---------------------
>  Before touching any device registers, the driver needs to enable
>  the PCI device by calling pci_enable_device(). This will:
> -	o wake up the device if it was in suspended state,
> -	o allocate I/O and memory regions of the device (if BIOS did not),
> -	o allocate an IRQ (if BIOS did not).
>  
> -NOTE: pci_enable_device() can fail! Check the return value.
> +  - wake up the device if it was in suspended state,
> +  - allocate I/O and memory regions of the device (if BIOS did not),
> +  - allocate an IRQ (if BIOS did not).
> +
> +.. note:: pci_enable_device() can fail! Check the return value.
>  
> -[ OS BUG: we don't check resource allocations before enabling those
> +.. warning:: OS BUG: we don't check resource allocations before enabling those
>    resources. The sequence would make more sense if we called
>    pci_request_resources() before calling pci_enable_device().
>    Currently, the device drivers can't detect the bug when when two
> @@ -271,7 +276,7 @@ NOTE: pci_enable_device() can fail! Check the return value.
>  
>    This has been discussed before but not changed as of 2.6.19:
>  	http://lkml.org/lkml/2006/3/2/194
> -]
> +
>  
>  pci_set_master() will enable DMA by setting the bus master bit
>  in the PCI_COMMAND register. It also fixes the latency timer value if
> @@ -288,8 +293,8 @@ pci_try_set_mwi() to have the system do its best effort at enabling
>  Mem-Wr-Inval.
>  
>  
> -3.2 Request MMIO/IOP resources
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Request MMIO/IOP resources
> +--------------------------
>  Memory (MMIO), and I/O port addresses should NOT be read directly
>  from the PCI device config space. Use the values in the pci_dev structure
>  as the PCI "bus address" might have been remapped to a "host physical"
> @@ -304,9 +309,9 @@ Conversely, drivers should call pci_release_region() AFTER
>  calling pci_disable_device().
>  The idea is to prevent two devices colliding on the same address range.
>  
> -[ See OS BUG comment above. Currently (2.6.19), The driver can only
> +.. tip:: See OS BUG comment above. Currently (2.6.19), The driver can only
>    determine MMIO and IO Port resource availability _after_ calling
> -  pci_enable_device(). ]
> +  pci_enable_device().

Hmm... indentation seems to be wrong here

>  
>  Generic flavors of pci_request_region() are request_mem_region()
>  (for MMIO ranges) and request_region() (for IO Port ranges).
> @@ -316,12 +321,12 @@ BARs.
>  Also see pci_request_selected_regions() below.
>  
>  
> -3.3 Set the DMA mask size
> -~~~~~~~~~~~~~~~~~~~~~~~~~
> -[ If anything below doesn't make sense, please refer to
> +Set the DMA mask size
> +---------------------
> +.. note:: If anything below doesn't make sense, please refer to
>    Documentation/DMA-API.txt. This section is just a reminder that
>    drivers need to indicate DMA capabilities of the device and is not
> -  an authoritative source for DMA interfaces. ]
> +  an authoritative source for DMA interfaces.

and here.

To be frank, when handling note/tip/warning/..., I prefer to indent
it like:


  .. note:: 

     If anything below doesn't make sense, please refer to
     Documentation/DMA-API.txt. This section is just a reminder that
     drivers need to indicate DMA capabilities of the device and is not
     an authoritative source for DMA interfaces.

As this makes it more visible when reading as a plain text file.


>  
>  While all drivers should explicitly indicate the DMA capability
>  (e.g. 32 or 64 bit) of the PCI bus master, devices with more than
> @@ -342,23 +347,23 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
>  ("consistent") data.
>  
>  
> -3.4 Setup shared control data
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Setup shared control data
> +-------------------------
>  Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
>  memory.  See Documentation/DMA-API.txt for a full description of
>  the DMA APIs. This section is just a reminder that it needs to be done
>  before enabling DMA on the device.
>  
>  
> -3.5 Initialize device registers
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Initialize device registers
> +---------------------------
>  Some drivers will need specific "capability" fields programmed
>  or other "vendor specific" register initialized or reset.
>  E.g. clearing pending interrupts.
>  
>  
> -3.6 Register IRQ handler
> -~~~~~~~~~~~~~~~~~~~~~~~~
> +Register IRQ handler
> +--------------------
>  While calling request_irq() is the last step described here,
>  this is often just another intermediate step to initialize a device.
>  This step can often be deferred until the device is opened for use.
> @@ -396,6 +401,7 @@ and msix_enabled flags in the pci_dev structure after calling
>  pci_alloc_irq_vectors.
>  
>  There are (at least) two really good reasons for using MSI:
> +
>  1) MSI is an exclusive interrupt vector by definition.
>     This means the interrupt handler doesn't have to verify
>     its device caused the interrupt.
> @@ -411,23 +417,23 @@ of MSI/MSI-X usage.
>  
>  
>  
> -4. PCI device shutdown
> -~~~~~~~~~~~~~~~~~~~~~~~
> +PCI device shutdown
> +===================
>  
>  When a PCI device driver is being unloaded, most of the following
>  steps need to be performed:
>  
> -	Disable the device from generating IRQs
> -	Release the IRQ (free_irq())
> -	Stop all DMA activity
> -	Release DMA buffers (both streaming and consistent)
> -	Unregister from other subsystems (e.g. scsi or netdev)
> -	Disable device from responding to MMIO/IO Port addresses
> -	Release MMIO/IO Port resource(s)
> +  - Disable the device from generating IRQs
> +  - Release the IRQ (free_irq())
> +  - Stop all DMA activity
> +  - Release DMA buffers (both streaming and consistent)
> +  - Unregister from other subsystems (e.g. scsi or netdev)
> +  - Disable device from responding to MMIO/IO Port addresses
> +  - Release MMIO/IO Port resource(s)
>  
>  
> -4.1 Stop IRQs on the device
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Stop IRQs on the device
> +-----------------------
>  How to do this is chip/device specific. If it's not done, it opens
>  the possibility of a "screaming interrupt" if (and only if)
>  the IRQ is shared with another device.
> @@ -446,16 +452,16 @@ MSI and MSI-X are defined to be exclusive interrupts and thus
>  are not susceptible to the "screaming interrupt" problem.
>  
>  
> -4.2 Release the IRQ
> -~~~~~~~~~~~~~~~~~~~
> +Release the IRQ
> +---------------
>  Once the device is quiesced (no more IRQs), one can call free_irq().
>  This function will return control once any pending IRQs are handled,
>  "unhook" the drivers IRQ handler from that IRQ, and finally release
>  the IRQ if no one else is using it.
>  
>  
> -4.3 Stop all DMA activity
> -~~~~~~~~~~~~~~~~~~~~~~~~~
> +Stop all DMA activity
> +---------------------
>  It's extremely important to stop all DMA operations BEFORE attempting
>  to deallocate DMA control data. Failure to do so can result in memory
>  corruption, hangs, and on some chip-sets a hard crash.
> @@ -467,8 +473,8 @@ While this step sounds obvious and trivial, several "mature" drivers
>  didn't get this step right in the past.
>  
>  
> -4.4 Release DMA buffers
> -~~~~~~~~~~~~~~~~~~~~~~~
> +Release DMA buffers
> +-------------------
>  Once DMA is stopped, clean up streaming DMA first.
>  I.e. unmap data buffers and return buffers to "upstream"
>  owners if there is one.
> @@ -478,8 +484,8 @@ Then clean up "consistent" buffers which contain the control data.
>  See Documentation/DMA-API.txt for details on unmapping interfaces.
>  
>  
> -4.5 Unregister from other subsystems
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Unregister from other subsystems
> +--------------------------------
>  Most low level PCI device drivers support some other subsystem
>  like USB, ALSA, SCSI, NetDev, Infiniband, etc. Make sure your
>  driver isn't losing resources from that other subsystem.
> @@ -487,31 +493,31 @@ If this happens, typically the symptom is an Oops (panic) when
>  the subsystem attempts to call into a driver that has been unloaded.
>  
>  
> -4.6 Disable Device from responding to MMIO/IO Port addresses
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Disable Device from responding to MMIO/IO Port addresses
> +--------------------------------------------------------
>  io_unmap() MMIO or IO Port resources and then call pci_disable_device().
>  This is the symmetric opposite of pci_enable_device().
>  Do not access device registers after calling pci_disable_device().
>  
>  
> -4.7 Release MMIO/IO Port Resource(s)
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Release MMIO/IO Port Resource(s)
> +--------------------------------
>  Call pci_release_region() to mark the MMIO or IO Port range as available.
>  Failure to do so usually results in the inability to reload the driver.
>  
>  
>  
> -5. How to access PCI config space
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +How to access PCI config space
> +==============================
>  
> -You can use pci_(read|write)_config_(byte|word|dword) to access the config
> -space of a device represented by struct pci_dev *. All these functions return 0
> -when successful or an error code (PCIBIOS_...) which can be translated to a text
> -string by pcibios_strerror. Most drivers expect that accesses to valid PCI
> +You can use `pci_(read|write)_config_(byte|word|dword)` to access the config
> +space of a device represented by `struct pci_dev *`. All these functions return
> +0 when successful or an error code (`PCIBIOS_...`) which can be translated to a
> +text string by pcibios_strerror. Most drivers expect that accesses to valid PCI
>  devices don't fail.
>  
>  If you don't have a struct pci_dev available, you can call
> -pci_bus_(read|write)_config_(byte|word|dword) to access a given device
> +`pci_bus_(read|write)_config_(byte|word|dword)` to access a given device
>  and function on that bus.
>  
>  If you access fields in the standard portion of the config header, please
> @@ -522,28 +528,29 @@ pci_find_capability() for the particular capability and it will find the
>  corresponding register block for you.
>  
>  
> +Other interesting functions
> +===========================
>  
> -6. Other interesting functions
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +::
>  
> -pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
> -				bus and slot and number. If the device is
> -				found, its reference count is increased.
> -pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
> -pci_find_capability()		Find specified capability in device's capability
> +  pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
> +  				bus and slot and number. If the device is
> +  				found, its reference count is increased.
> +  pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
> +  pci_find_capability()		Find specified capability in device's capability
>  				list.
> -pci_resource_start()		Returns bus start address for a given PCI region
> -pci_resource_end()		Returns bus end address for a given PCI region
> -pci_resource_len()		Returns the byte length of a PCI region
> -pci_set_drvdata()		Set private driver data pointer for a pci_dev
> -pci_get_drvdata()		Return private driver data pointer for a pci_dev
> -pci_set_mwi()			Enable Memory-Write-Invalidate transactions.
> -pci_clear_mwi()			Disable Memory-Write-Invalidate transactions.
> +  pci_resource_start()		Returns bus start address for a given PCI region
> +  pci_resource_end()		Returns bus end address for a given PCI region
> +  pci_resource_len()		Returns the byte length of a PCI region
> +  pci_set_drvdata()		Set private driver data pointer for a pci_dev
> +  pci_get_drvdata()		Return private driver data pointer for a pci_dev
> +  pci_set_mwi()			Enable Memory-Write-Invalidate transactions.
> +  pci_clear_mwi()			Disable Memory-Write-Invalidate transactions.

Better to use a list here:

=============================== ================================================
pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
				bus and slot and number. If the device is
				found, its reference count is increased.
pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
pci_find_capability()		Find specified capability in device's capability
				list.
pci_resource_start()		Returns bus start address for a given PCI region
pci_resource_end()		Returns bus end address for a given PCI region
pci_resource_len()		Returns the byte length of a PCI region
pci_set_drvdata()		Set private driver data pointer for a pci_dev
pci_get_drvdata()		Return private driver data pointer for a pci_dev
pci_set_mwi()			Enable Memory-Write-Invalidate transactions.
pci_clear_mwi()			Disable Memory-Write-Invalidate transactions.
=============================== ================================================


>  
>  
>  
> -7. Miscellaneous hints
> -~~~~~~~~~~~~~~~~~~~~~~
> +Miscellaneous hints
> +===================
>  
>  When displaying PCI device names to the user (for example when a driver wants
>  to tell the user what card has it found), please use pci_name(pci_dev).
> @@ -560,8 +567,8 @@ to be handled by platform and generic code, not individual drivers.
>  
>  
>  
> -8. Vendor and device identifications
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Vendor and device identifications
> +=================================
>  
>  Do not add new device or vendor IDs to include/linux/pci_ids.h unless they
>  are shared across multiple drivers.  You can add private definitions in
> @@ -576,18 +583,20 @@ and https://github.com/pciutils/pciids.
>  
>  
>  
> -9. Obsolete functions
> -~~~~~~~~~~~~~~~~~~~~~
> +Obsolete functions
> +==================
>  
>  There are several functions which you might come across when trying to
>  port an old driver to the new PCI interface.  They are no longer present
>  in the kernel as they aren't compatible with hotplug or PCI domains or
>  having sane locking.
>  
> -pci_find_device()	Superseded by pci_get_device()
> -pci_find_subsys()	Superseded by pci_get_subsys()
> -pci_find_slot()		Superseded by pci_get_domain_bus_and_slot()
> -pci_get_slot()		Superseded by pci_get_domain_bus_and_slot()
> +::
> +
> +  pci_find_device()	Superseded by pci_get_device()
> +  pci_find_subsys()	Superseded by pci_get_subsys()
> +  pci_find_slot()	Superseded by pci_get_domain_bus_and_slot()
> +  pci_get_slot()	Superseded by pci_get_domain_bus_and_slot()

A list works better here:

======================= ===========================================
pci_find_device()	Superseded by pci_get_device()
pci_find_subsys()	Superseded by pci_get_subsys()
pci_find_slot()		Superseded by pci_get_domain_bus_and_slot()
pci_get_slot()		Superseded by pci_get_domain_bus_and_slot()
======================= ===========================================


>  
>  
>  The alternative is the traditional PCI device driver that walks PCI
> @@ -595,8 +604,8 @@ device lists. This is still possible but discouraged.
>  
>  
>  
> -10. MMIO Space and "Write Posting"
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +MMIO Space and "Write Posting"
> +==============================
>  
>  Converting a driver from using I/O Port space to using MMIO space
>  often requires some additional changes. Specifically, "write posting"
> @@ -609,14 +618,14 @@ the CPU before the transaction has reached its destination.
>  
>  Thus, timing sensitive code should add readl() where the CPU is
>  expected to wait before doing other work.  The classic "bit banging"
> -sequence works fine for I/O Port space:
> +sequence works fine for I/O Port space::
>  
>         for (i = 8; --i; val >>= 1) {
>                 outb(val & 1, ioport_reg);      /* write bit */
>                 udelay(10);
>         }
>  
> -The same sequence for MMIO space should be:
> +The same sequence for MMIO space should be::
>  
>         for (i = 8; --i; val >>= 1) {
>                 writeb(val & 1, mmio_reg);      /* write bit */



Thanks,
Mauro
