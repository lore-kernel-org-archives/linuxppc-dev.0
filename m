Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2018CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68936206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68936206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZTHH6dcNzDq9d
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 23:40:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZTCs4zDdzDqXK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 23:37:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43ZTCs0zQVz9sDL;
 Wed,  9 Jan 2019 23:37:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: Kconfig label updates
In-Reply-To: <20190108223024.GA147017@google.com>
References: <20190108223024.GA147017@google.com>
Date: Wed, 09 Jan 2019 23:37:09 +1100
Message-ID: <87tviiroqy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:
> Hi,
>
> I want to update the PCI Kconfig labels so they're more consistent and
> useful to users, something like the patch below.  IIUC, the items
> below are all IBM-related; please correct me if not.
>
> I'd also like to expand (or remove) "RPA" because Google doesn't find
> anything about "IBM RPA", except Robotic Process Automation, which I
> think must be something else.

Yeah I think just remove it, it's not a well known term and is unlikely
to help anyone these days.

It stands for "RISC Platform Architecture", which was some kind of
specification for Power machines back in the day, but from what I can
tell it was never used in marketing or manuals much (hence so few hits
on Google).

> Is there some text expansion of RPA that we could use that would be
> meaningful to a user, i.e., something he/she might find on a nameplate
> or in a user manual?

No I don't think so.

> Ideally the PCI Kconfig labels would match the terms used in
> arch/.../Kconfig, e.g.,
>
>   config PPC_POWERNV
>     bool "IBM PowerNV (Non-Virtualized) platform support"
>
>   config PPC_PSERIES
>     bool "IBM pSeries & new (POWER5-based) iSeries"

TBH these are pretty unhelpful too. PowerNV is not a marketing name and
so doesn't appear anywhere much in official manuals or brochures and
it's also used on non-IBM branded machines. And pSeries & iSeries were
marketing names but are no longer used.

We should probably update that text, but we can do that later, rather
than blocking this patch.

> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index e9f78eb390d2..1c1d145bfd84 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_POWERNV
> -	tristate "PowerPC PowerNV PCI Hotplug driver"
> +	tristate "IBM PowerNV PCI Hotplug driver"

This is used in non-IBM machines as well.

So perhaps: ?

	tristate "IBM/OpenPower PowerNV (bare metal) PCI Hotplug driver"

> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_RPA
> -	tristate "RPA PCI Hotplug driver"
> +	tristate "IBM Power Systems RPA PCI Hotplug driver"

I think just drop RPA here.

>  	depends on PPC_PSERIES && EEH
>  	help
>  	  Say Y here if you have a RPA system that supports PCI Hotplug.

s/RPA/IBM Power Systems/

> +	  This includes the earlier pSeries and iSeries.

To be complete:
	  This includes the earlier System p, System i, pSeries and iSeries.

>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rpaphp.
> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_RPA_DLPAR
> -	tristate "RPA Dynamic Logical Partitioning for I/O slots"
> +	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"

Again just drop RPA.


cheers
