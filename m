Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58176C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 23:18:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B60620652
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxU5oyTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B60620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DXrd2ZZMzDqDL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 10:18:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fxU5oyTE"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DXpd1WDmzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 10:16:56 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B4E020652;
 Tue,  5 Mar 2019 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551827814;
 bh=zwqZZsThZQ6nowJFulARgnU52hfdsiy0qYX3oid09v4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fxU5oyTEoYzO/8/bDOiE3EDCuPG1CB3YOWzpuv75fOQtoIG+6Wr16ZiaOuqyz/UYw
 v+HAMLS4Xc3RpgdMc2ZNPDKAeAcpVcC6ag4lYV4A7laDsMS/9kUvtqK6bXr9Ur29k7
 oxuUoO0XzuFFr0L3IlxHxVpfk6CQW/qfxpxJti04=
Date: Tue, 5 Mar 2019 17:16:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Message-ID: <20190305231650.GC215617@google.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: alex_gagniuc@dellteam.com, helgaas@google.com,
 Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Shyam_Iyer@Dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, keith.busch@intel.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 05:16:01PM -0600, Alexandru Gagniuc wrote:
> Thanks to Keith for pointing out that it doesn't make sense to disable
> AER services when only one device has a FIRMWARE_FIRST HEST.
> 
> AER ownership is an interesting issue brought in by FFS (firmware-first)
> model. In a nutshell if FFS handles AER, then OS should not touch any
> of the AER bits. FW might set things up so that it receives AER
> notifications via SMI. It's theoretically possible to receive SCIs,
> but the exact mechanism is platform-dependent. OS touching AER bits
> when firmware owns them may interfere with these notifications.
> 
> The ACPI mechanism for negotiating control of AER is _OSC, and is
> described in detail in ACPI 6.2 Ch. 6.2.11.3. _OSC is negotiated at
> the root bus level. Any root port, switch, or endpoint under the bus
> would have its AER ownership negotiated in one _OSC call.
> 
> Then there is HEST, which is part of ACPI Platform Error Interfaces
> (APEI). HEST tables describe the errors that FW may report to the OS.
> A types 6,7 and 7 HEST tables describe AER errors from PCIe devices.
> As part of this description, we're told if the error source is FFS.
> 
> Information in HEST seems to be redundant, as each error reported by
> FW will have a CPER table that describes it in detail.
> 
> Because HEST describes an error source as firmware-first or not, we've
> taken this to mean ownership of AER. Because AER ownership and error
> reporting are coupled, _OSC and HEST usually agree on the matter of
> ownership. However, that doesn't seem to be required by ACPI.
> 
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER. In linux, we
> use the result of _OSC to enable AER services, but we use HEST to
> determine AER ownership. That's inconsistent. This series drops the
> use of HEST in favor of _OSC.
> 
> [1] https://lkml.org/lkml/2018/11/15/62
> 
> Alexandru Gagniuc (2):
>   PCI/AER: Do not use APEI/HEST to disable AER services globally
>   PCI/AER: Determine AER ownership based on _OSC instead of HEST
> 
>  drivers/acpi/pci_root.c  |  9 +----
>  drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
>  include/linux/pci-acpi.h |  6 ---
>  3 files changed, 5 insertions(+), 92 deletions(-)

I'm pretty sure we do need to do something here, but there was quite a
lot of discussion that didn't seem to really get resolved, so I'm
dropping these for now.

Please repost them with any relevant updates and we'll see if we can
get a consensus that we're going the right direction.

Bjorn
