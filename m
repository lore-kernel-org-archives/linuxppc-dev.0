Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB4BC76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 07:02:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69822145D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 07:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeBoxRpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69822145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrv75XJlzDqYp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 17:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeBoxRpW"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrs10DbSzDqTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 17:00:52 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id t16so8614075pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=1y49HN60KcSp+xXZpmOlvT4Oej+3E1aeaKvxopjK+jo=;
 b=LeBoxRpWg4IQN5FTi/wBVKC9Y2GuHHxFQYyIefoKM8HW7OhtsjkOrTKK18TDF+KuZd
 aGI6ItS7cXzMUT9Uvc8rvtrHSickBshGmUzmkQqyPmcNmV39XSKp1igLtavJO/1MHiNi
 ogwFgVl8gg9+7dswzDLG0lcX4Ooc5ij5IQLedgYxex0h+9QtY4EpvIQms+lSNrLSk/i2
 NsMI1L2VdpTY6agcA3uCSubHIPJQKid+N6XoCNM5F/hHvriZ0JaaT/+qHB+4zYqzovHu
 yKMfcMmCFhKQc7URfHbn14yOI0drl1HDkIo4xHMBvFlJWUhpnDFw3NBpy9vpkkTqcbnv
 dUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=1y49HN60KcSp+xXZpmOlvT4Oej+3E1aeaKvxopjK+jo=;
 b=ElQ2GxXaiFOH9rGWLkDHu2SSogZFqa0xZGDhPRlqVpOns1LXX6uVgBioMiOEnluBiI
 mX4VVI0z+/uPXbRWGB/5mREKE0xEPnYBFiUw1ZE8jLhPQAX67gRgZiGzhSA7Bhi8rBcU
 AQeNdMXw5+a1xcX9HVYDb43LvLTlq5ayBNKg16F5YDHyEvyhYu0EE/Zi1ZZuDdNSWAnS
 As4XuXP+HP5ay1R9jbcmUvEIuDID2WZjpq2tM6Bl3JRmLQGeovfI9A8AFCR1Xub97Bqc
 vbT3PN0qmqzW5Ht22KF3isbMXu5uqo/ZUAgw3RR8k5IkKTuwFbiOxOo6LE92+2kaneMK
 W6Ww==
X-Gm-Message-State: APjAAAXIoDRG5w1awjkJvGJq210tqfy8kEGhdNMLw2mexUnxOibDI/50
 wz8ErLWwydWLceAnkslVghwvhCv4RE8=
X-Google-Smtp-Source: APXvYqwNUVLNKf7xqZZYsV9ikTxLGNw9Tz+MVUSrVVxpdeyLyD2jpUlsYJ8TPnEoPjDWBsb4ltBRSw==
X-Received: by 2002:a65:640a:: with SMTP id a10mr31208324pgv.338.1563260449274; 
 Tue, 16 Jul 2019 00:00:49 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id r13sm23992992pfr.25.2019.07.16.00.00.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 00:00:48 -0700 (PDT)
Message-ID: <8cadf8fd4540c2e3ca2426fc195226aa93bdbe65.camel@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 3/6] powerpc/eeh: Improve debug
 messages around device addition
From: Oliver O'Halloran <oohall@gmail.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Date: Tue, 16 Jul 2019 17:00:44 +1000
In-Reply-To: <20190716064827.GF3645@tungsten.ozlabs.ibm.com>
References: <cover.1557203383.git.sbobroff@linux.ibm.com>
 <8deaedffad8ed3327f296a561c2a31c930c65f88.1557203383.git.sbobroff@linux.ibm.com>
 <ef181b9d-54df-23f9-2f06-f0f4d0bd8e8a@ozlabs.ru>
 <20190619042706.GA24143@tungsten.ozlabs.ibm.com>
 <e8f68068-bb62-6d2e-f484-d6a111811fbc@ozlabs.ru>
 <CAOSf1CFwj93TYGppJVU5djEe4TN6ezo36G=DxWbFU4buaCWM4g@mail.gmail.com>
 <20190716064827.GF3645@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-07-16 at 16:48 +1000, Sam Bobroff wrote:
> On Thu, Jun 20, 2019 at 01:45:24PM +1000, Oliver O'Halloran wrote:
> > On Thu, Jun 20, 2019 at 12:40 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > On 19/06/2019 14:27, Sam Bobroff wrote:
> > > > On Tue, Jun 11, 2019 at 03:47:58PM +1000, Alexey Kardashevskiy wrote:
> > > > > On 07/05/2019 14:30, Sam Bobroff wrote:
> > > > > > Also remove useless comment.
> > > > > > 
> > > > > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > > > > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > ---
> > > *snip*
> > > > I can see that edev will be non-NULL here, but that pr_debug() pattern
> > > > (using the PDN information to form the PCI address) is quite common
> > > > across the EEH code, so I think rather than changing a couple of
> > > > specific cases, I should do a separate cleanup patch and introduce
> > > > something like pdn_debug(pdn, "...."). What do you think?
> > > 
> > > I'd switch them all to already existing dev_dbg/pci_debug rather than
> > > adding pdn_debug as imho it should not have been used in the first place
> > > really...
> > > 
> > > > (I don't know exactly when edev->pdev can be NULL.)
> > > 
> > > ... and if you switch to dev_dbg/pci_debug, I think quite soon you'll
> > > know if it can or cannot be NULL :)
> > 
> > As far as I can tell edev->pdev is NULL in two cases:
> > 
> > 1. Before eeh_device_add_late() has been called on the pdev. The late
> > part of the add maps the pdev to an edev and sets the pdev's edev
> > pointer and vis a vis.
> > 2. While recoverying EEH unaware devices. Unaware devices are
> > destroyed and rescanned and the edev->pdev pointer is cleared by
> > pcibios_device_release()
> > 
> > In most of these cases it should be safe to use the pci_*() functions
> > rather than making a new one up for printing pdns. In the cases where
> > we might not have a PCI dev i'd make a new set of prints that take an
> > EEH dev rather than a pci_dn since i'd like pci_dn to die sooner
> > rather than later.
> > 
> > Oliver
> 
> I'll change the calls in {pnv,pseries}_pcibios_bus_add_device() and
> eeh_add_device_late() to use dev_dbg() and post a new version.
> 
> For {pnv,pseries}_eeh_probe() I'm not sure what we can do; there's no
> pci_dev available yet and while it would be nice to use the eeh_dev
> rather than the pdn, it doesn't seem to have the bus/device/fn
> information we need. Am I missing something there?  (The code in the
> probe functions seems to get it from the pci_dn.)

We do have a pci_dev in the powernv case since pnv_eeh_probe() isn't
called until the late probe happens (which is after the pci_dev has
been created). I've got some patches to rework the probe path to make
this a bit clearer, but they need a bit more work.

> 
> If there isn't an easy way around this, would it therefore be reasonable
> to just leave them open-coded as they are?

I've had this patch floating around a while that should do the trick.
The PCI_BUSNO macro is probably unnecessary since I'm sure there is
something that does it in generic code, but I couldn't find it.


From 61ff8c23c4d13ff640fb2d069dcedacdf2ee22dd Mon Sep 17 00:00:00 2001
From: Oliver O'Halloran <oohall@gmail.com>
Date: Thu, 18 Apr 2019 18:25:13 +1000
Subject: [PATCH] powerpc/eeh: Add bdfn field to eeh_dev

Preperation for removing pci_dn from the powernv EEH code. The only thing we
really use pci_dn for is to get the bdfn of the device for config space
accesses, so adding that information to eeh_dev reduces the need to carry
around the pci_dn.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h     | 2 ++
 arch/powerpc/include/asm/ppc-pci.h | 2 ++
 arch/powerpc/kernel/eeh_dev.c      | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7fd476d..a208e02 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -131,6 +131,8 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
 	int class_code;			/* Class code of the device	*/
+	int bdfn; 			/* bdfn of device (for cfg ops) */
+	struct pci_controller *controller;
 	int pe_config_addr;		/* PE config address		*/
 	u32 config_space[16];		/* Saved PCI config space	*/
 	int pcix_cap;			/* Saved PCIx capability	*/
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index cec2d64..72860de 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -74,6 +74,8 @@ static inline const char *eeh_driver_name(struct pci_dev *pdev)
 
 #endif /* CONFIG_EEH */
 
+#define PCI_BUSNO(bdfn) ((bdfn >> 8) & 0xff)
+
 #else /* CONFIG_PCI */
 static inline void init_pci_config_tokens(void) { }
 #endif /* !CONFIG_PCI */
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index c4317c4..7370185 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -47,6 +47,8 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 	/* Associate EEH device with OF node */
 	pdn->edev = edev;
 	edev->pdn = pdn;
+	edev->bdfn = (pdn->busno << 8) | pdn->devfn;
+	edev->controller = pdn->phb;
 
 	return edev;
 }
-- 
2.9.5

