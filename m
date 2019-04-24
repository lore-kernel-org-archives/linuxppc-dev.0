Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:51:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC4020878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A128JDq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC4020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q4Yz4TnszDqX2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:51:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="A128JDq1"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q4WM195ZzDqWv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:49:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yXZ1NYx6H1URNwa1Z0y2prcGWOT/5MP9r1eu1eg+Nf0=; b=A128JDq1SoFgRrfsXu3Jk2c8GR
 Hb+GRBUdLzp4YPWTKu66yZVm3Cyb4U2sWZ0UoHU3s761cm4E/0k//W+ZLenQCV5avd3ko0g/BrTb5
 Fw4ozt4ip58VHeZpEiExvpak920bY7GmbPdpUMkI0vQk7AhmaFzrzak8DGA9NziBu0BnIbIMe6H3d
 XuK9M7VgI5CZJ0cfHsL4VcDj0WvrTW9Lw4Hk0sNFHmnkwiujGsdOVvVNq4dCHPa5izL8j4IeBf8h/
 W8p3eO7Zo9bf9CWig/syhG9FHVZIdTic+OP5dWHfGJMG5vAIX3eqXO88q9S4T87lAh/I9C24g8eR1
 xS5CfRfQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJK9E-0003Gm-RF; Wed, 24 Apr 2019 15:49:25 +0000
Date: Wed, 24 Apr 2019 12:49:17 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 32/63] Documentation: PCI: convert pcieaer-howto.txt
 to reST
Message-ID: <20190424124917.5fd2c8d5@coco.lan>
In-Reply-To: <20190423162932.21428-33-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-33-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:29:01 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst                   |   1 +
>  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 110 ++++++++++++------
>  2 files changed, 74 insertions(+), 37 deletions(-)
>  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (81%)
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 5ee4dba07116..86c76c22810b 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -14,3 +14,4 @@ Linux PCI Bus Subsystem
>     MSI-HOWTO
>     acpi-info
>     pci-error-recovery
> +   pcieaer-howto
> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.rst
> similarity index 81%
> rename from Documentation/PCI/pcieaer-howto.txt
> rename to Documentation/PCI/pcieaer-howto.rst
> index 48ce7903e3c6..67f77ff76865 100644
> --- a/Documentation/PCI/pcieaer-howto.txt
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -1,21 +1,29 @@
> -   The PCI Express Advanced Error Reporting Driver Guide HOWTO
> -		T. Long Nguyen	<tom.l.nguyen@intel.com>
> -		Yanmin Zhang	<yanmin.zhang@intel.com>
> -				07/29/2006
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> +===========================================================
> +The PCI Express Advanced Error Reporting Driver Guide HOWTO
> +===========================================================
>  
> -1. Overview
> +:Authors: - T. Long Nguyen <tom.l.nguyen@intel.com>
> +          - Yanmin Zhang <yanmin.zhang@intel.com>
>  
> -1.1 About this guide
> +:Copyright: |copy| 2006 Intel Corporation
> +
> +Overview
> +===========
> +
> +About this guide
> +----------------
>  
>  This guide describes the basics of the PCI Express Advanced Error
>  Reporting (AER) driver and provides information on how to use it, as
>  well as how to enable the drivers of endpoint devices to conform with
>  PCI Express AER driver.
>  
> -1.2 Copyright (C) Intel Corporation 2006.
>  
> -1.3 What is the PCI Express AER Driver?
> +What is the PCI Express AER Driver?
> +-----------------------------------
>  
>  PCI Express error signaling can occur on the PCI Express link itself
>  or on behalf of transactions initiated on the link. PCI Express
> @@ -30,17 +38,19 @@ The PCI Express AER driver provides the infrastructure to support PCI
>  Express Advanced Error Reporting capability. The PCI Express AER
>  driver provides three basic functions:
>  
> --	Gathers the comprehensive error information if errors occurred.
> --	Reports error to the users.
> --	Performs error recovery actions.
> +  - Gathers the comprehensive error information if errors occurred.
> +  - Reports error to the users.
> +  - Performs error recovery actions.
>  
>  AER driver only attaches root ports which support PCI-Express AER
>  capability.
>  
>  
> -2. User Guide
> +User Guide
> +==========
>  
> -2.1 Include the PCI Express AER Root Driver into the Linux Kernel
> +Include the PCI Express AER Root Driver into the Linux Kernel
> +-------------------------------------------------------------
>  
>  The PCI Express AER Root driver is a Root Port service driver attached
>  to the PCI Express Port Bus driver. If a user wants to use it, the driver
> @@ -48,7 +58,8 @@ has to be compiled. Option CONFIG_PCIEAER supports this capability. It
>  depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
>  CONFIG_PCIEAER = y.
>  
> -2.2 Load PCI Express AER Root Driver
> +Load PCI Express AER Root Driver
> +--------------------------------
>  
>  Some systems have AER support in firmware. Enabling Linux AER support at
>  the same time the firmware handles AER may result in unpredictable
> @@ -56,30 +67,34 @@ behavior. Therefore, Linux does not handle AER events unless the firmware
>  grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
>  Specification for details regarding _OSC usage.
>  
> -2.3 AER error output
> +AER error output
> +----------------
>  
>  When a PCIe AER error is captured, an error message will be output to
>  console. If it's a correctable error, it is output as a warning.
>  Otherwise, it is printed as an error. So users could choose different
>  log level to filter out correctable error messages.
>  
> -Below shows an example:
> -0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
> -0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
> -0000:50:00.0:    [20] Unsupported Request    (First)
> -0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
> +Below shows an example::
> +
> +  0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
> +  0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
> +  0000:50:00.0:    [20] Unsupported Request    (First)
> +  0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
>  
>  In the example, 'Requester ID' means the ID of the device who sends
>  the error message to root port. Pls. refer to pci express specs for
>  other fields.
>  
> -2.4 AER Statistics / Counters
> +AER Statistics / Counters
> +-------------------------
>  
>  When PCIe AER errors are captured, the counters / statistics are also exposed
>  in the form of sysfs attributes which are documented at
>  Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>  
> -3. Developer Guide
> +Developer Guide
> +===============
>  
>  To enable AER aware support requires a software driver to configure
>  the AER capability structure within its device and to provide callbacks.
> @@ -120,7 +135,8 @@ hierarchy and links. These errors do not include any device specific
>  errors because device specific errors will still get sent directly to
>  the device driver.
>  
> -3.1 Configure the AER capability structure
> +Configure the AER capability structure
> +--------------------------------------
>  
>  AER aware drivers of PCI Express component need change the device
>  control registers to enable AER. They also could change AER registers,
> @@ -128,9 +144,11 @@ including mask and severity registers. Helper function
>  pci_enable_pcie_error_reporting could be used to enable AER. See
>  section 3.3.
>  
> -3.2. Provide callbacks
> +Provide callbacks
> +-----------------
>  
> -3.2.1 callback reset_link to reset pci express link
> +callback reset_link to reset pci express link
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  This callback is used to reset the pci express physical link when a
>  fatal error happens. The root port aer service driver provides a
> @@ -140,13 +158,15 @@ upstream ports should provide their own reset_link functions.
>  
>  In struct pcie_port_service_driver, a new pointer, reset_link, is
>  added.
> +::
>  
> -pci_ers_result_t (*reset_link) (struct pci_dev *dev);
> +	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
>  
>  Section 3.2.2.2 provides more detailed info on when to call
>  reset_link.
>  
> -3.2.2 PCI error-recovery callbacks
> +PCI error-recovery callbacks
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The PCI Express AER Root driver uses error callbacks to coordinate
>  with downstream device drivers associated with a hierarchy in question
> @@ -161,7 +181,8 @@ definitions of the callbacks.
>  
>  Below sections specify when to call the error callback functions.
>  
> -3.2.2.1 Correctable errors
> +Correctable errors
> +~~~~~~~~~~~~~~~~~~
>  
>  Correctable errors pose no impacts on the functionality of
>  the interface. The PCI Express protocol can recover without any
> @@ -169,13 +190,16 @@ software intervention or any loss of data. These errors do not
>  require any recovery actions. The AER driver clears the device's
>  correctable error status register accordingly and logs these errors.
>  
> -3.2.2.2 Non-correctable (non-fatal and fatal) errors
> +Non-correctable (non-fatal and fatal) errors
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  If an error message indicates a non-fatal error, performing link reset
>  at upstream is not required. The AER driver calls error_detected(dev,
>  pci_channel_io_normal) to all drivers associated within a hierarchy in
> -question. for example,
> -EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort.
> +question. for example::
> +
> +  EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort
> +
>  If Upstream port A captures an AER error, the hierarchy consists of
>  Downstream port B and EndPoint.
>  
> @@ -199,23 +223,33 @@ function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
>  reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
>  to mmio_enabled.
>  
> -3.3 helper functions
> +helper functions
> +----------------
> +::
> +
> +  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  
> -3.3.1 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  pci_enable_pcie_error_reporting enables the device to send error
>  messages to root port when an error is detected. Note that devices
>  don't enable the error reporting by default, so device drivers need
>  call this function to enable it.
>  
> -3.3.2 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> +::
> +
> +  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> +
>  pci_disable_pcie_error_reporting disables the device to send error
>  messages to root port when an error is detected.
>  
> -3.3.3 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
> +::
> +
> +  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
> +
>  pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
>  error status register.
>  
> -3.4 Frequent Asked Questions
> +Frequent Asked Questions
> +------------------------
>  
>  Q: What happens if a PCI Express device driver does not provide an
>  error recovery handler (pci_driver->err_handler is equal to NULL)?

I strongly suspect that you also need to touch the Q/A, as otherwise
you'll have either bad output and/or sphinx warnings. Something like:

Q:
   What happens if a PCI Express device driver does not provide an
   error recovery handler (pci_driver->err_handler is equal to NULL)?

A:
   The devices attached with the driver won't be recovered. If the
   error is fatal, kernel will print out warning messages. Please refer
   to section 3 for more information.

Q:
   What happens if an upstream port service driver does not provide
   callback reset_link?

A:
   Fatal error recovery will fail if the errors are reported by the
   upstream ports who are attached by the service driver.

Q:
   How does this infrastructure deal with driver that is not PCI
   Express aware?

A:
   This infrastructure calls the error callback functions of the
   driver when an error happens. But if the driver is not aware of
   PCI Express, the device might not report its own errors to root
   port.

Q:
   What modifications will that driver need to make it compatible
   with the PCI Express AER Root driver?

A:
   It could call the helper functions to enable AER in devices and
   cleanup uncorrectable status register. Pls. refer to section 3.3.


> @@ -245,7 +279,8 @@ A: It could call the helper functions to enable AER in devices and
>  cleanup uncorrectable status register. Pls. refer to section 3.3.
>  
>  
> -4. Software error injection
> +Software error injection
> +========================
>  
>  Debugging PCIe AER error recovery code is quite difficult because it
>  is hard to trigger real hardware errors. Software based error
> @@ -261,6 +296,7 @@ After reboot with new kernel or insert the module, a device file named
>  
>  Then, you need a user space tool named aer-inject, which can be gotten
>  from:
> +
>      https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  More information about aer-inject can be found in the document comes



Thanks,
Mauro
