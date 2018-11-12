Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6AFC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:50:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143DE21527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRPo9aZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143DE21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tfxn6fSQzF3Tc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 16:50:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRPo9aZ8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRPo9aZ8"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tftp4fHKzF3N6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 16:48:18 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id u3-v6so1078181pfm.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 21:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0rI7aHn7uedZuF8H8kWsTC16RnFu7xe9LB9UVgPSR1k=;
 b=lRPo9aZ8otfc5qTuW8+H5mke4Zi9KAEINGuHkp5GtZ6EY/dIZjkdeHhHbvzb9M3+k2
 4RkoDvl/84lIhlAQT/Z/urzvcDaiJ4jJ1ioeeVuNiGgMredXi2xgBuB6gG/ma2zIAJD2
 v++zIGWuP7oIJknFZrS8+9LbM3H/6Qf44nrPNtMWJK5PAOc7D0HL5zYyAwqmWrk0Lrjp
 eS66sWkXq95njjOOO6W3UlQmqjIdNfWjbGn7GBPDpgwmvW9cDRy4SGH6u5+Y1VAYO4NG
 azkpYy7xEuX3PoSCfJ5qBGq+GIoD9IyIXxu6k0/zYuTO1zxz2L/7iR3fPX0SPr7hiUb1
 U4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0rI7aHn7uedZuF8H8kWsTC16RnFu7xe9LB9UVgPSR1k=;
 b=eL4FPebr4G1DC950sNmMqLOsQ3v8HYqsGaKfYYg2xpQB3+yAyVY899yQpeb/D2HcEo
 gIkn/DmspwlEnUimn5yQCPePoqnkl5SNZkd4sqXxuhmavsYUx9OAEflABFdUiJgJh2T9
 OiW/YXW+vXJFA/GS8Zmn2k88C/hoS1LZ2ek2qnzyahLj5wsyAag7JZPPFEhplQ33ToFZ
 tzqCm4u2NKVX5Og+kkqdsAYgvGPwNeN3gZV5klRM3cWjGjzAh4txt67qMCwn7eQuAdAx
 vKevvLNSfnDeKCFeliSaxRUjC8O9+Z/qL2AJx59hpk1IJRi0OD9FZZc/WpYM32Nqo3mJ
 dLLA==
X-Gm-Message-State: AGRZ1gKP8byzmyFE8GhLi9S3q4aO3IPM3tlutXg8JzGUNphpvlTIk5r/
 SRLk3nViIO9jioebOdCCIIU=
X-Google-Smtp-Source: AJdET5dzvZW+fyvnXsJUmaPprMToZT7cSO4vKRFaN8chdCSNiK9+4NvzNX1OjaqsEcCYjofxVsHElQ==
X-Received: by 2002:a62:1e42:: with SMTP id
 e63-v6mr18775808pfe.149.1542001695705; 
 Sun, 11 Nov 2018 21:48:15 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id
 g27-v6sm33542299pfj.162.2018.11.11.21.48.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 21:48:14 -0800 (PST)
Message-ID: <9da5bbe3a76c6adf09804d88d0a9edc3ddedff4d.camel@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
From: Oliver O'Halloran <oohall@gmail.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 12 Nov 2018 16:48:08 +1100
In-Reply-To: <20181109071139.uxa6gu7jwsvr7ve6@wunner.de>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
 <20181109071139.uxa6gu7jwsvr7ve6@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 linux-pci@vger.kernel.org, shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Jonathan Derrick <jonathan.derrick@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-09 at 08:11 +0100, Lukas Wunner wrote:
> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > +	/*
> > +	 * If an MMIO read from the device returns ~0 data, that data may
> > +	 * be valid, or it may indicate a bus error.  If config space is
> > +	 * readable, assume it's valid data; otherwise, assume a bus error.
> > +	 */
> > +	if (val == ~0) {
> > +		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> > +		if (id == ~0)
> > +			pci_dev_set_disconnected(dev, NULL);
> > +	}
> 
> This isn't safe unfortunately because "all ones" may occur for other
> reasons besides disconnectedness.  E.g. on an Uncorrectable Error,
> the device may likewise respond with all ones, but revert to valid
> responses if the error can be recovered through a Secondary Bus Reset.
> In such a case, marking the device disconnected would be inappropriate.

I don't really see why we're trying to make a distinction between
recoverable errors and disconnected devices at this stage. In either
case we should assume the device is broken and shouldn't be accessed
until we perform some kind of recovery action.

Bjorn's MMIO wrappers are more-or-less an opt-in software emulation of
the freeze-MMIO-on-error behaviour that the EEH mechanism provides on 
IBM hardware so I think it makes sense. It also has the nice side
effect of giving driver writers an error injection mechanism so they
might actually test how their drivers deal with errors.

> Accessing a device in D3cold would be another example where all ones
> is returned both from mmio and config space despite the device still
> being present and future accesses having a chance to succeed.

Is doing a MMIO to a device in D3cold (or hot) ever a valid thing to
do?

> In fact, in v2 of Keith's patches adding pci_dev_set_disconnected()
> he attempted the same as what you're doing here and caused issues
> for me with devices in D3cold:
> 
> https://spinics.net/lists/linux-pci/msg54337.html
> 
> 
> > One thing I'm uncomfortable with is that [...].  Another is that the
> > only place we call pci_dev_set_disconnected() is in pciehp and acpiphp,
> > so the only "disconnected" case we catch is if hotplug happens to be
> > involved.
> 
> Yes, that's because the hotplug drivers are the only ones who can
> identify removal authoritatively and unambiguously.  They *know*
> when the device is gone and don't have to resort to heuristics
> such as all ones.  (ISTR that dpc also marks devices disconnected.)

The herustics shouldn't be used to work out when the device is gone,
rather they should be used to work out when we need to check on the
device.

One of the grosser bits of EEH support is a hook in readl() and friends
that checks for a 0xFF response. If it finds one, it looks at the EEH
state and will start the recovery process if the device is marked as
frozen.

(don't look at the code. you won't like what you find)

> > sprinkling pci_dev_is_disconnected() around feels ad hoc
> > instead of systematic, in the sense that I don't know how we convince
> > ourselves that this (and only this) is the correct place to put it.
> 
> We need to add documentation for driver authors how to deal with
> surprise removal.  Briefly:
> 
> * If (pdev->error_state == pci_channel_io_perm_failure), the device
>   is definitely gone and any further device access can be skipped.
>   Otherwise presence of the device is likely, but not guaranteed.
>
> * If a device access can significantly delay device removal due to
>   Completion Timeouts, or can cause an infinite loop, MCE or crash,
>   do check pdev->error_state before carrying out the device access.
> 
> * Always be prepared that a device access may fail due to surprise
>   removal, do not blindly trust mmio or config space reads or
>   assume success of writes.

Completely agree. We really need better documentation of what drivers
should be doing.

Oliver

