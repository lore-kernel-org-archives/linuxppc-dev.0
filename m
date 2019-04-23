Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F27C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:20:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22576218B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7Yjj+rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22576218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbw21zm7zDqSp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="p7Yjj+rO"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTfd01MfzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:38:48 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id e24so7747014pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
 b=p7Yjj+rOXVZGFWvMUaVBew0BcKpKYzGxWGxAjoMNQchM4vBSSDw0vnGvsNPJirEyiL
 n5NbfqUb1RHTlUYN7aNfVAvu8HVoayJaH73W71SNPRGB/Ukv3tEKp86Znk7nmNGSilS4
 F3biF+V/vfvt89RhOGk8Idar006gMT+0lLhnKFZ7k/u7JZSpL1DEq1dJZBDCBCIhZ6iq
 DjPP+6C7E+6X6dFNPVS9v6dStjwduRZuU20qBMTH8spbk/5qo26idQmGBV62ntVPqL3m
 Hr4J7tzztWwD6M31l5RVMUwUH5QHCBiqaTgXuWs/7UcVgIfBkZwHS+g9U9ZB2k5VV5UI
 YXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
 b=FqXdI/mmdKnijHYJfnbb1N2QLe9ruQ1moquCl9KNMlamoPcs1TwoJaRAerAHzbqc9C
 l/HBXFWvCqm5e3mzM4aThSRmmJb/UAwWzPhYb7E2PtWz/y45sfvIzdPodf5rpkIwAlkb
 4wKBhPmvdPPMKGdn/9KxlnatZ/fSZC9CX/6QPL+XDPtcCt6kWmGXKHf7uBaOyohjq5gj
 L0VPYHwkUqdcVN71P0VLMi2ign/uLmB5MJ/CQCKdzoim/GKE2nIiaXgYMtJF20vrjQQ+
 lNp5ZWuJH7zTVsLTWDDCz8MjAEGSLDUpTKltyHoL971aqjIJULhF5lrvHN/1bTXaX6VA
 F4EA==
X-Gm-Message-State: APjAAAWacTt+wAo6nM5vRdOreLnsxd5kQHJnrBdICJz22SLyyBh+XpX5
 +NZpalGn+Ntch8trwyDJDN0=
X-Google-Smtp-Source: APXvYqwQKECWplBd06QikSOEoBIjyKNxrFMfDtXDax+6IVYtQkG78RIWG7Sym4OfvZvjqbcyGWsdZg==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr27568786pfd.234.1556037526611; 
 Tue, 23 Apr 2019 09:38:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:38:45 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 56/63] Documentation: x86: convert i386/IO-APIC.txt to reST
Date: Wed, 24 Apr 2019 00:29:25 +0800
Message-Id: <20190423162932.21428-57-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:33 +1000
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
---
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 26 ++++++++++++-------
 Documentation/x86/i386/index.rst              | 10 +++++++
 Documentation/x86/index.rst                   |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst

diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
similarity index 93%
rename from Documentation/x86/i386/IO-APIC.txt
rename to Documentation/x86/i386/IO-APIC.rst
index 15f5baf7e1b6..aec98f742763 100644
--- a/Documentation/x86/i386/IO-APIC.txt
+++ b/Documentation/x86/i386/IO-APIC.rst
@@ -1,3 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+IO-APIC
+=======
+
+:Author: Ingo Molnar <mingo@kernel.org>
+
 Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
 which is an enhanced interrupt controller. It enables us to route
 hardware interrupts to multiple CPUs, or to CPU groups. Without an
@@ -13,7 +21,7 @@ usually worked around by the kernel. If your MP-compliant SMP board does
 not boot Linux, then consult the linux-smp mailing list archives first.
 
 If your box boots fine with enabled IO-APIC IRQs, then your
-/proc/interrupts will look like this one:
+/proc/interrupts will look like this one::
 
    ---------------------------->
   hell:~> cat /proc/interrupts
@@ -37,14 +45,14 @@ none of those IRQ sources is performance-critical.
 In the unlikely case that your board does not create a working mp-table,
 you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
 is non-trivial though and cannot be automated. One sample /etc/lilo.conf
-entry:
+entry::
 
 	append="pirq=15,11,10"
 
 The actual numbers depend on your system, on your PCI cards and on their
 PCI slot position. Usually PCI slots are 'daisy chained' before they are
 connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
-lines):
+lines)::
 
                ,-.        ,-.        ,-.        ,-.        ,-.
      PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
@@ -56,7 +64,7 @@ lines):
      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
                `-'        `-'        `-'        `-'        `-'
 
-Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
+Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
 
                                ,-.
                          INTD--| |
@@ -78,19 +86,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
 do not use interrupts normally, thus they are not daisy chained either.
 
 so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
-Slot2, then you'll have to specify this pirq= line:
+Slot2, then you'll have to specify this pirq= line::
 
 	append="pirq=11,9"
 
 the following script tries to figure out such a default pirq= line from
-your PCI configuration:
+your PCI configuration::
 
 	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
 
 note that this script won't work if you have skipped a few slots or if your
 board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
 connected in some strange way). E.g. if in the above case you have your SCSI
-card (IRQ11) in Slot3, and have Slot1 empty:
+card (IRQ11) in Slot3, and have Slot1 empty::
 
 	append="pirq=0,9,11"
 
@@ -105,7 +113,7 @@ won't function properly (e.g. if it's inserted as a module).
 If you have 2 PCI buses, then you can use up to 8 pirq values, although such
 boards tend to have a good configuration.
 
-Be prepared that it might happen that you need some strange pirq line:
+Be prepared that it might happen that you need some strange pirq line::
 
 	append="pirq=0,0,0,0,0,0,9,11"
 
@@ -115,5 +123,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
 linux-kernel@vger.kernel.org if you have any problems that are not covered
 by this document.
 
--- mingo
-
diff --git a/Documentation/x86/i386/index.rst b/Documentation/x86/i386/index.rst
new file mode 100644
index 000000000000..8747cf5bbd49
--- /dev/null
+++ b/Documentation/x86/i386/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+i386 Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   IO-APIC
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 526f7a008b8e..19323c5b89ce 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,3 +26,4 @@ Linux x86 Support
    microcode
    resctrl_ui
    usb-legacy-support
+   i386/index
-- 
2.20.1

