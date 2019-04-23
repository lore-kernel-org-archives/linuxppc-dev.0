Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB594C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4788A218B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3qV1j/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4788A218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZw12lnkzDqBh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:35:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="q3qV1j/r"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTZS5LHbzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:35:12 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h5so7770607pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r30BuVTEkfz816kYgjZwkEOyK5c3wp16TB066btRDaU=;
 b=q3qV1j/r+aV2lzngOX2Tu5cQ9/ZIsC9A7p3xNC+jhnnEH/Mj24u6JAl+EdO8Sbl9YJ
 wMVvnK70amogVERtC1t9tZlEKcJG6bAm3woNdedEFOYM22DAvgk6EROdnKlqggiGV5Vz
 giU3TmOXzWxy7MbA1xARacqFwlyBgRxmfiO765n50KmtI4IZWk+bJ5pFplVIaPMVZd6u
 hvPQXRbV608UQH/GisZmhJTsaD83da4fhALop3f0FUHvdL7w74ofianygsow4A4sw4bl
 3pS6lTT8Trv8pDu89gWn5vBzr76h0Fk+Es3Cxic7nUR1Sm3rf3J8/uXyA2S0mMLh6Zk3
 JKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r30BuVTEkfz816kYgjZwkEOyK5c3wp16TB066btRDaU=;
 b=EFg5JEwiHyXWZhVJxzKCMtDvo9F1mD05ZBleXjH+kj73gyBPjYxyF+31Y31mZJnJCu
 PJBTTHSqthEx1RjBNAbDqtEEYF2XBGiQ+3NxKHmVi9M3DCmjX02QApCX6pPHUd0yPFI6
 HuIfqxnDBpFpPwx9lx69BkPattLG3nWVcpWQ/rtdATbtjPWjILmI8VzIz9hcGiNNEkX2
 RtDH44tAHTICEdWns9mAS9ez4sRDy0bWLTdovXX/sakXtmKAkPD7E7voKh515k5PxZyG
 LEJHGADiBZ/tN/gOsGDVj+ki2iJwKMyzKAWGTs5K2VBlD0Keh6vtCj0o9s2fs4B9Aku2
 VduA==
X-Gm-Message-State: APjAAAVVLHShuLzO7u7j0OBtveslI6pl1ZPLOgnsqG+gnW4Urw6lofMe
 OLohCqvR1nvyv+R2FQo1L0iLl26x
X-Google-Smtp-Source: APXvYqzXWw18c7FzRwMUd2bWi6/x/QaZe37quJJ155jjxO+Ur9n8EFw6Z71dleVf7w61frm/WkKtNQ==
X-Received: by 2002:a62:1881:: with SMTP id 123mr27639024pfy.25.1556037310421; 
 Tue, 23 Apr 2019 09:35:10 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:35:09 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 29/63] Documentation: PCI: convert MSI-HOWTO.txt to reST
Date: Wed, 24 Apr 2019 00:28:58 +0800
Message-Id: <20190423162932.21428-30-changbin.du@gmail.com>
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
v2:
  o drop numbering.
  o simplify author list
---
 .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      | 83 +++++++++++--------
 Documentation/PCI/index.rst                   |  1 +
 2 files changed, 50 insertions(+), 34 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (88%)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.rst
similarity index 88%
rename from Documentation/PCI/MSI-HOWTO.txt
rename to Documentation/PCI/MSI-HOWTO.rst
index 618e13d5e276..18cc3700489b 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.rst
@@ -1,13 +1,14 @@
-		The MSI Driver Guide HOWTO
-	Tom L Nguyen tom.l.nguyen@intel.com
-			10/03/2003
-	Revised Feb 12, 2004 by Martine Silbermann
-		email: Martine.Silbermann@hp.com
-	Revised Jun 25, 2004 by Tom L Nguyen
-	Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
-		Copyright 2003, 2008 Intel Corporation
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-1. About this guide
+==========================
+The MSI Driver Guide HOWTO
+==========================
+
+:Authors: Tom L Nguyen; Martine Silbermann; Matthew Wilcox
+
+About this guide
+================
 
 This guide describes the basics of Message Signaled Interrupts (MSIs),
 the advantages of using MSI over traditional interrupt mechanisms, how
@@ -15,7 +16,8 @@ to change your driver to use MSI or MSI-X and some basic diagnostics to
 try if a device doesn't support MSIs.
 
 
-2. What are MSIs?
+What are MSIs?
+==============
 
 A Message Signaled Interrupt is a write from the device to a special
 address which causes an interrupt to be received by the CPU.
@@ -29,7 +31,8 @@ Devices may support both MSI and MSI-X, but only one can be enabled at
 a time.
 
 
-3. Why use MSIs?
+Why use MSIs?
+=============
 
 There are three reasons why using MSIs can give an advantage over
 traditional pin-based interrupts.
@@ -61,14 +64,16 @@ Other possible designs include giving one interrupt to each packet queue
 in a network card or each port in a storage controller.
 
 
-4. How to use MSIs
+How to use MSIs
+===============
 
 PCI devices are initialised to use pin-based interrupts.  The device
 driver has to set up the device to use MSI or MSI-X.  Not all machines
 support MSIs correctly, and for those machines, the APIs described below
 will simply fail and the device will continue to use pin-based interrupts.
 
-4.1 Include kernel support for MSIs
+Include kernel support for MSIs
+-------------------------------
 
 To support MSI or MSI-X, the kernel must be built with the CONFIG_PCI_MSI
 option enabled.  This option is only available on some architectures,
@@ -76,14 +81,15 @@ and it may depend on some other options also being set.  For example,
 on x86, you must also enable X86_UP_APIC or SMP in order to see the
 CONFIG_PCI_MSI option.
 
-4.2 Using MSI
+Using MSI
+---------
 
 Most of the hard work is done for the driver in the PCI layer.  The driver
 simply has to request that the PCI layer set up the MSI capability for this
 device.
 
 To automatically use MSI or MSI-X interrupt vectors, use the following
-function:
+function::
 
   int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags);
@@ -101,12 +107,12 @@ any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
 pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
 
 To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
-vectors, use the following function:
+vectors, use the following function::
 
   int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 
 Any allocated resources should be freed before removing the device using
-the following function:
+the following function::
 
   void pci_free_irq_vectors(struct pci_dev *dev);
 
@@ -126,7 +132,7 @@ The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
 as possible, likely up to the limit supported by the device.  If nvec is
 larger than the number supported by the device it will automatically be
 capped to the supported limit, so there is no need to query the number of
-vectors supported beforehand:
+vectors supported beforehand::
 
 	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_ALL_TYPES)
 	if (nvec < 0)
@@ -135,7 +141,7 @@ vectors supported beforehand:
 If a driver is unable or unwilling to deal with a variable number of MSI
 interrupts it can request a particular number of interrupts by passing that
 number to pci_alloc_irq_vectors() function as both 'min_vecs' and
-'max_vecs' parameters:
+'max_vecs' parameters::
 
 	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
@@ -143,23 +149,24 @@ number to pci_alloc_irq_vectors() function as both 'min_vecs' and
 
 The most notorious example of the request type described above is enabling
 the single MSI mode for a device.  It could be done by passing two 1s as
-'min_vecs' and 'max_vecs':
+'min_vecs' and 'max_vecs'::
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		goto out_err;
 
 Some devices might not support using legacy line interrupts, in which case
-the driver can specify that only MSI or MSI-X is acceptable:
+the driver can specify that only MSI or MSI-X is acceptable::
 
 	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nvec < 0)
 		goto out_err;
 
-4.3 Legacy APIs
+Legacy APIs
+-----------
 
 The following old APIs to enable and disable MSI or MSI-X interrupts should
-not be used in new code:
+not be used in new code::
 
   pci_enable_msi()		/* deprecated */
   pci_disable_msi()		/* deprecated */
@@ -174,9 +181,11 @@ number of vectors.  If you have a legitimate special use case for the count
 of vectors we might have to revisit that decision and add a
 pci_nr_irq_vectors() helper that handles MSI and MSI-X transparently.
 
-4.4 Considerations when using MSIs
+Considerations when using MSIs
+------------------------------
 
-4.4.1 Spinlocks
+Spinlocks
+~~~~~~~~~
 
 Most device drivers have a per-device spinlock which is taken in the
 interrupt handler.  With pin-based interrupts or a single MSI, it is not
@@ -188,7 +197,8 @@ acquire the spinlock.  Such deadlocks can be avoided by using
 spin_lock_irqsave() or spin_lock_irq() which disable local interrupts
 and acquire the lock (see Documentation/kernel-hacking/locking.rst).
 
-4.5 How to tell whether MSI/MSI-X is enabled on a device
+How to tell whether MSI/MSI-X is enabled on a device
+----------------------------------------------------
 
 Using 'lspci -v' (as root) may show some devices with "MSI", "Message
 Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
@@ -196,7 +206,8 @@ has an 'Enable' flag which is followed with either "+" (enabled)
 or "-" (disabled).
 
 
-5. MSI quirks
+MSI quirks
+==========
 
 Several PCI chipsets or devices are known not to support MSIs.
 The PCI stack provides three ways to disable MSIs:
@@ -205,7 +216,8 @@ The PCI stack provides three ways to disable MSIs:
 2. on all devices behind a specific bridge
 3. on a single device
 
-5.1. Disabling MSIs globally
+Disabling MSIs globally
+-----------------------
 
 Some host chipsets simply don't support MSIs properly.  If we're
 lucky, the manufacturer knows this and has indicated it in the ACPI
@@ -219,7 +231,8 @@ on the kernel command line to disable MSIs on all devices.  It would be
 in your best interests to report the problem to linux-pci@vger.kernel.org
 including a full 'lspci -v' so we can add the quirks to the kernel.
 
-5.2. Disabling MSIs below a bridge
+Disabling MSIs below a bridge
+-----------------------------
 
 Some PCI bridges are not able to route MSIs between busses properly.
 In this case, MSIs must be disabled on all devices behind the bridge.
@@ -230,7 +243,7 @@ as the nVidia nForce and Serverworks HT2000).  As with host chipsets,
 Linux mostly knows about them and automatically enables MSIs if it can.
 If you have a bridge unknown to Linux, you can enable
 MSIs in configuration space using whatever method you know works, then
-enable MSIs on that bridge by doing:
+enable MSIs on that bridge by doing::
 
        echo 1 > /sys/bus/pci/devices/$bridge/msi_bus
 
@@ -244,7 +257,8 @@ below this bridge.
 Again, please notify linux-pci@vger.kernel.org of any bridges that need
 special handling.
 
-5.3. Disabling MSIs on a single device
+Disabling MSIs on a single device
+---------------------------------
 
 Some devices are known to have faulty MSI implementations.  Usually this
 is handled in the individual device driver, but occasionally it's necessary
@@ -252,7 +266,8 @@ to handle this with a quirk.  Some drivers have an option to disable use
 of MSI.  While this is a convenient workaround for the driver author,
 it is not good practice, and should not be emulated.
 
-5.4. Finding why MSIs are disabled on a device
+Finding why MSIs are disabled on a device
+-----------------------------------------
 
 From the above three sections, you can see that there are many reasons
 why MSIs may not be enabled for a given device.  Your first step should
@@ -260,8 +275,8 @@ be to examine your dmesg carefully to determine whether MSIs are enabled
 for your machine.  You should also check your .config to be sure you
 have enabled CONFIG_PCI_MSI.
 
-Then, 'lspci -t' gives the list of bridges above a device.  Reading
-/sys/bus/pci/devices/*/msi_bus will tell you whether MSIs are enabled (1)
+Then, 'lspci -t' gives the list of bridges above a device. Reading
+`/sys/bus/pci/devices/*/msi_bus` will tell you whether MSIs are enabled (1)
 or disabled (0).  If 0 is found in any of the msi_bus files belonging
 to bridges between the PCI root and the device, MSIs are disabled.
 
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index e1c19962a7f8..1b25bcc1edca 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -11,3 +11,4 @@ Linux PCI Bus Subsystem
    pci
    PCIEBUS-HOWTO
    pci-iov-howto
+   MSI-HOWTO
-- 
2.20.1

