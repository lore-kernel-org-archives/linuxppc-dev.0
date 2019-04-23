Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE3C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:42:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C9A217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOr2ZuDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C9A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pb4K3SSbzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:42:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOr2ZuDJ"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTbD29tQzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:35:51 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id e6so7878562pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RxPz3kqf9b1KlwYkSSSltNJ55Lu6mN3Thr3gyuYUboU=;
 b=MOr2ZuDJNekAB9kJ7Adk0et0Sm3d/YF6dlzFWk4nZZjYUtWCSz8PVO9KQhk/3i9phn
 ioWVfUjVOc0TNkAkDPaqimU25Ld/fq9bA87I0Mou+AQdOeizd1GEtj+NOnq6rieIbcxX
 dMrNg3ZbmUaT6ZOQ/3GIJ/t5LbllplKQd1jYrud625N1f2m9VUj9xBR71lWQznasp7Za
 qw5LG7S571G/D9GZgremqDh/T52ttEymQCReu46r7C8lk14Pi3c/bNx+xvFqR+ySVuMB
 8ffpeOrsibBnf8r/NckFEK3nll3i8eD0SHNrub7C+k+KghV9tizGFiza/YYBEaJ2ecX7
 8c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RxPz3kqf9b1KlwYkSSSltNJ55Lu6mN3Thr3gyuYUboU=;
 b=KyweWtk5rx76B1J004kV0KdISB2DtqphTzFFnIGBkJnS6mX/DNhkvJxbWiQh97f/dB
 qxfD8eMJ1zRYdz0a7Bf6QeDLgLMK4km1utIvW8UtZJ2lQfmiCgVPqVKtJVghPjkqVf70
 vdAIZVbAudH9wwxq6XXb5oRvA+WmdtqvcSWW3wuE3FwVita+WY5RWAybG1kwrmT1deQ7
 fCFrcQtL5kgJMnRJdcB6GGzva3bGnafCY2mIRnGApAZzO9j5l+yrHzETYryN2K7aaty6
 sK0I0YEQhzvCiFU7HhJh5/+O/qYOm/vM5MxiLlmvokhH8VmAzepIPlXWVVUAnD3t8GxX
 eIRw==
X-Gm-Message-State: APjAAAU362EHoTP3OKhEJ7PiUC5y4CUBHsqyK5RBa0cUG92XUQs+d9ym
 6KGSmW9QGLk91fCpKLKnbVQ=
X-Google-Smtp-Source: APXvYqyNRWQOTLUvi/QwogkQbLTRB71dx5FShhKAsd/WU5o6PyWWnKtgAH5W1BE9eoQwCaZZtYdyxg==
X-Received: by 2002:a62:6587:: with SMTP id z129mr28611587pfb.88.1556037349541; 
 Tue, 23 Apr 2019 09:35:49 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.35.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:35:48 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 33/63] Documentation: PCI: convert
 endpoint/pci-endpoint.txt to reST
Date: Wed, 24 Apr 2019 00:29:02 +0800
Message-Id: <20190423162932.21428-34-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:31 +1000
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/endpoint/index.rst          | 10 ++
 .../{pci-endpoint.txt => pci-endpoint.rst}    | 95 +++++++++++--------
 Documentation/PCI/index.rst                   |  1 +
 3 files changed, 68 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
new file mode 100644
index 000000000000..0db4f2fcd7f0
--- /dev/null
+++ b/Documentation/PCI/endpoint/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI Endpoint Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   pci-endpoint
diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.rst
similarity index 82%
rename from Documentation/PCI/endpoint/pci-endpoint.txt
rename to Documentation/PCI/endpoint/pci-endpoint.rst
index e86a96b66a6a..6674ce5425bf 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -1,11 +1,17 @@
-			    PCI ENDPOINT FRAMEWORK
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI Endpoint Framework
+======================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to use the PCI Endpoint Framework in order to create
 endpoint controller driver, endpoint function driver, and using configfs
 interface to bind the function driver to the controller driver.
 
-1. Introduction
+Introduction
+============
 
 Linux has a comprehensive PCI subsystem to support PCI controllers that
 operates in Root Complex mode. The subsystem has capability to scan PCI bus,
@@ -19,24 +25,27 @@ add endpoint mode support in Linux. This will help to run Linux in an
 EP system which can have a wide variety of use cases from testing or
 validation, co-processor accelerator, etc.
 
-2. PCI Endpoint Core
+PCI Endpoint Core
+=================
 
 The PCI Endpoint Core layer comprises 3 components: the Endpoint Controller
 library, the Endpoint Function library, and the configfs layer to bind the
 endpoint function with the endpoint controller.
 
-2.1 PCI Endpoint Controller(EPC) Library
+PCI Endpoint Controller(EPC) Library
+------------------------------------
 
 The EPC library provides APIs to be used by the controller that can operate
 in endpoint mode. It also provides APIs to be used by function driver/library
 in order to implement a particular endpoint function.
 
-2.1.1 APIs for the PCI controller Driver
+APIs for the PCI controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI controller driver.
 
-*) devm_pci_epc_create()/pci_epc_create()
+* devm_pci_epc_create()/pci_epc_create()
 
    The PCI controller driver should implement the following ops:
 	 * write_header: ops to populate configuration space header
@@ -51,110 +60,116 @@ by the PCI controller driver.
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
 
-*) devm_pci_epc_destroy()/pci_epc_destroy()
+* devm_pci_epc_destroy()/pci_epc_destroy()
 
    The PCI controller driver can destroy the EPC device created by either
    devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
    pci_epc_destroy().
 
-*) pci_epc_linkup()
+* pci_epc_linkup()
 
    In order to notify all the function devices that the EPC device to which
    they are linked has established a link with the host, the PCI controller
    driver should invoke pci_epc_linkup().
 
-*) pci_epc_mem_init()
+* pci_epc_mem_init()
 
    Initialize the pci_epc_mem structure used for allocating EPC addr space.
 
-*) pci_epc_mem_exit()
+* pci_epc_mem_exit()
 
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
-2.1.2 APIs for the PCI Endpoint Function Driver
+
+APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epc_write_header()
+* pci_epc_write_header()
 
    The PCI endpoint function driver should use pci_epc_write_header() to
    write the standard configuration header to the endpoint controller.
 
-*) pci_epc_set_bar()
+* pci_epc_set_bar()
 
    The PCI endpoint function driver should use pci_epc_set_bar() to configure
    the Base Address Register in order for the host to assign PCI addr space.
    Register space of the function driver is usually configured
    using this API.
 
-*) pci_epc_clear_bar()
+* pci_epc_clear_bar()
 
    The PCI endpoint function driver should use pci_epc_clear_bar() to reset
    the BAR.
 
-*) pci_epc_raise_irq()
+* pci_epc_raise_irq()
 
    The PCI endpoint function driver should use pci_epc_raise_irq() to raise
    Legacy Interrupt, MSI or MSI-X Interrupt.
 
-*) pci_epc_mem_alloc_addr()
+* pci_epc_mem_alloc_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_alloc_addr(), to
    allocate memory address from EPC addr space which is required to access
    RC's buffer
 
-*) pci_epc_mem_free_addr()
+* pci_epc_mem_free_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
-2.1.3 Other APIs
+Other APIs
+~~~~~~~~~~
 
 There are other APIs provided by the EPC library. These are used for binding
 the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
 using these APIs.
 
-*) pci_epc_get()
+* pci_epc_get()
 
    Get a reference to the PCI endpoint controller based on the device name of
    the controller.
 
-*) pci_epc_put()
+* pci_epc_put()
 
    Release the reference to the PCI endpoint controller obtained using
    pci_epc_get()
 
-*) pci_epc_add_epf()
+* pci_epc_add_epf()
 
    Add a PCI endpoint function to a PCI endpoint controller. A PCIe device
    can have up to 8 functions according to the specification.
 
-*) pci_epc_remove_epf()
+* pci_epc_remove_epf()
 
    Remove the PCI endpoint function from PCI endpoint controller.
 
-*) pci_epc_start()
+* pci_epc_start()
 
    The PCI endpoint function driver should invoke pci_epc_start() once it
    has configured the endpoint function and wants to start the PCI link.
 
-*) pci_epc_stop()
+* pci_epc_stop()
 
    The PCI endpoint function driver should invoke pci_epc_stop() to stop
    the PCI LINK.
 
-2.2 PCI Endpoint Function(EPF) Library
+
+PCI Endpoint Function(EPF) Library
+----------------------------------
 
 The EPF library provides APIs to be used by the function driver and the EPC
 library to provide endpoint mode functionality.
 
-2.2.1 APIs for the PCI Endpoint Function Driver
+APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epf_register_driver()
+* pci_epf_register_driver()
 
    The PCI Endpoint Function driver should implement the following ops:
 	 * bind: ops to perform when a EPC device has been bound to EPF device
@@ -166,50 +181,54 @@ by the PCI endpoint function driver.
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
 
-*) pci_epf_unregister_driver()
+* pci_epf_unregister_driver()
 
   The PCI Function driver can unregister the PCI EPF driver by using
   pci_epf_unregister_driver().
 
-*) pci_epf_alloc_space()
+* pci_epf_alloc_space()
 
   The PCI Function driver can allocate space for a particular BAR using
   pci_epf_alloc_space().
 
-*) pci_epf_free_space()
+* pci_epf_free_space()
 
   The PCI Function driver can free the allocated space
   (using pci_epf_alloc_space) by invoking pci_epf_free_space().
 
-2.2.2 APIs for the PCI Endpoint Controller Library
+APIs for the PCI Endpoint Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint controller library.
 
-*) pci_epf_linkup()
+* pci_epf_linkup()
 
    The PCI endpoint controller library invokes pci_epf_linkup() when the
    EPC device has established the connection to the host.
 
-2.2.2 Other APIs
+Other APIs
+~~~~~~~~~~
+
 There are other APIs provided by the EPF library. These are used to notify
 the function driver when the EPF device is bound to the EPC device.
 pci-ep-cfs.c can be used as reference for using these APIs.
 
-*) pci_epf_create()
+* pci_epf_create()
 
    Create a new PCI EPF device by passing the name of the PCI EPF device.
    This name will be used to bind the the EPF device to a EPF driver.
 
-*) pci_epf_destroy()
+* pci_epf_destroy()
 
    Destroy the created PCI EPF device.
 
-*) pci_epf_bind()
+* pci_epf_bind()
 
    pci_epf_bind() should be invoked when the EPF device has been bound to
    a EPC device.
 
-*) pci_epf_unbind()
+* pci_epf_unbind()
 
    pci_epf_unbind() should be invoked when the binding between EPC device
    and EPF device is lost.
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 86c76c22810b..c8ea2e626c20 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -15,3 +15,4 @@ Linux PCI Bus Subsystem
    acpi-info
    pci-error-recovery
    pcieaer-howto
+   endpoint/index
-- 
2.20.1

