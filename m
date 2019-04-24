Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9CDC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:00:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F10218FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WH6CgPHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F10218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q65Z4R3wzDqXt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:00:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="WH6CgPHt"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q63c23wlzDqWx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 02:59:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EquihUCty+ZcFfE5dWtYBS32BiOe8KzbeB7dO0oQ3KI=; b=WH6CgPHtXHsiSC0oRrWer8MaVG
 VPqRt3ery5umY4lIPzwecIIsD3vjzlhJe9vR0krUDJYaHJ2gLfNKD+CFtPEzZH5MYDMQXZpRFYlom
 pFh6nojZ4kkw6fdGGpbrW0gek0MFf7aHPzBeLUKeUciNJ6O992UELDEOwg2KhYPvWEZVa6agg4ku5
 sBUfW5N5uOR7Rcvz5XwHhZ3IBdzdw6gLtZUbkvhIkCVHYazsJ2rMa0k/MmeVZgNWCGV5iFqNdI0ru
 KQvp/pkSK1tAOvlfLP/EdMoV4plpKp0ExniykHkladzTJIxDWnJjw3V2CgSBXZYjukWFn/WzYAF0f
 qlZgC3Gg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJLEY-0005rG-Kg; Wed, 24 Apr 2019 16:58:59 +0000
Date: Wed, 24 Apr 2019 13:58:52 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 35/63] Documentation: PCI: convert
 endpoint/pci-test-function.txt to reST
Message-ID: <20190424135852.08810789@coco.lan>
In-Reply-To: <20190423162932.21428-36-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-36-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:29:04 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/endpoint/index.rst          |  1 +
>  ...est-function.txt => pci-test-function.rst} | 32 +++++++++++--------
>  2 files changed, 20 insertions(+), 13 deletions(-)
>  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 3951de9f923c..b680a3fc4fec 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -9,3 +9,4 @@ PCI Endpoint Framework
>  
>     pci-endpoint
>     pci-endpoint-cfs
> +   pci-test-function
> diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
> similarity index 84%
> rename from Documentation/PCI/endpoint/pci-test-function.txt
> rename to Documentation/PCI/endpoint/pci-test-function.rst
> index 5916f1f592bb..ba02cddcec37 100644
> --- a/Documentation/PCI/endpoint/pci-test-function.txt
> +++ b/Documentation/PCI/endpoint/pci-test-function.rst
> @@ -1,5 +1,10 @@
> -				PCI TEST
> -		    Kishon Vijay Abraham I <kishon@ti.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI Test Function
> +=================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  Traditionally PCI RC has always been validated by using standard
>  PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
> @@ -23,30 +28,31 @@ The PCI endpoint test device has the following registers:
>  	8) PCI_ENDPOINT_TEST_IRQ_TYPE
>  	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
>  
> -*) PCI_ENDPOINT_TEST_MAGIC
> +* PCI_ENDPOINT_TEST_MAGIC

Same comment as on a previous patch. I suspect that the author's intention
for all stuff under Documentation/PCI/endpoint/ (or perhaps this is due
tothe markup language he uses) is to have:

	 *) foo

as a chapter, e. g. the right conversion would be, instead:

	PCI_ENDPOINT_TEST_MAGIC
	=======================

(same applies to the other similar markups here and on other files under
the endpoint/ directory)

>  
>  This register will be used to test BAR0. A known pattern will be written
>  and read back from MAGIC register to verify BAR0.
>  
> -*) PCI_ENDPOINT_TEST_COMMAND:
> +* PCI_ENDPOINT_TEST_COMMAND:
>  
>  This register will be used by the host driver to indicate the function
>  that the endpoint device must perform.
>  
> -Bitfield Description:
> +Bitfield Description::
> +
>    Bit 0		: raise legacy IRQ
>    Bit 1		: raise MSI IRQ
>    Bit 2		: raise MSI-X IRQ
>    Bit 3		: read command (read data from RC buffer)
>    Bit 4		: write command (write data to RC buffer)
> -  Bit 5		: copy command (copy data from one RC buffer to another
> -		  RC buffer)
> +  Bit 5		: copy command (copy data from one RC buffer to another RC buffer)

Please use a table instead:

 Bitfield Description:

  =====		=======================================================
  Bit 0		raise legacy IRQ
  Bit 1		raise MSI IRQ
  Bit 2		raise MSI-X IRQ
  Bit 3		read command (read data from RC buffer)
  Bit 4		write command (write data to RC buffer)
  Bit 5		copy command (copy data from one RC buffer to another
		RC buffer)
  =====		=======================================================



>  
> -*) PCI_ENDPOINT_TEST_STATUS
> +* PCI_ENDPOINT_TEST_STATUS
>  
>  This register reflects the status of the PCI endpoint device.
>  
> -Bitfield Description:
> +Bitfield Description::
> +
>    Bit 0		: read success
>    Bit 1		: read fail
>    Bit 2		: write success
> @@ -57,17 +63,17 @@ Bitfield Description:
>    Bit 7		: source address is invalid
>    Bit 8		: destination address is invalid

Same here:

 Bitfield Description:

  =====		==============================
  Bit 0		read success
  Bit 1		read fail
  Bit 2		write success
  Bit 3		write fail
  Bit 4		copy success
  Bit 5		copy fail
  Bit 6		IRQ raised
  Bit 7		source address is invalid
  Bit 8		destination address is invalid
  =====		==============================


>  
> -*) PCI_ENDPOINT_TEST_SRC_ADDR
> +* PCI_ENDPOINT_TEST_SRC_ADDR
>  
>  This register contains the source address (RC buffer address) for the
>  COPY/READ command.
>  
> -*) PCI_ENDPOINT_TEST_DST_ADDR
> +* PCI_ENDPOINT_TEST_DST_ADDR
>  
>  This register contains the destination address (RC buffer address) for
>  the COPY/WRITE command.
>  
> -*) PCI_ENDPOINT_TEST_IRQ_TYPE
> +* PCI_ENDPOINT_TEST_IRQ_TYPE
>  
>  This register contains the interrupt type (Legacy/MSI) triggered
>  for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
> @@ -77,7 +83,7 @@ Possible types:

You need a blank line before - MSI, in order to not use a bold font for
"Possible types:".

>   - MSI		: 1
>   - MSI-X	: 2
>  
> -*) PCI_ENDPOINT_TEST_IRQ_NUMBER
> +* PCI_ENDPOINT_TEST_IRQ_NUMBER
>  
>  This register contains the triggered ID interrupt.
>  

Same here: ou need a blank line on this text:

	 Admissible values:
+
	  - Legacy      : 0
	  - MSI         : [1 .. 32]
	  - MSI-X       : [1 .. 2048]


In order to avoid using bold font for "Admissible values".


Thanks,
Mauro
