Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D1C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:57:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFA42148D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N2hDZE6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFA42148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcjy1CFCzDqW4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:57:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="N2hDZE6q"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbgb5XJdzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:10:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wCa3nFyIHBkX+W7L08Ddl9/YQMFyOa83nnq8nn7FoI=; b=N2hDZE6qZ5seHNnDs2TmZ6DEwF
 sapUo2Ma+lbARcWApPNvphi0Kp+5CJ4vZ4obzBQhef/uJTpi7YWjwdZDKYPzLCxyF0y7vTZxxlj4T
 arPi4FZm1vFa39rVgoYEVK3U53KRUGszkCl18oY8DXYQTkHMdZJQ3K9FD393XK1mDuYPv8j8wAH+S
 OTRIlrp+do3u+T7UlcsCWUgYXea7GoExQ3u+fyGEyHEOJiuVNgKJ/jqh4Ou2ui3hPc4fZE+vZdU6U
 C06x/wrfk1xsJJD4X5jcUVCBhaHbpyWcGTX5IEhQtinPda1tvY8qZsMkqidbsWMb5xKIz3F/JH+1l
 PcbaCB0g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2fq-0003nY-Po; Tue, 23 Apr 2019 21:09:55 +0000
Date: Tue, 23 Apr 2019 18:09:48 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 12/63] Documentation: ACPI: move i2c-muxes.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423180948.326fd3d8@coco.lan>
In-Reply-To: <20190423162932.21428-13-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-13-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:41 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/i2c-muxes.txt              | 58 ------------------
>  .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  3 +-
>  3 files changed, 63 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/acpi/i2c-muxes.txt
>  create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
> 
> diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
> deleted file mode 100644
> index 9fcc4f0b885e..000000000000
> --- a/Documentation/acpi/i2c-muxes.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -ACPI I2C Muxes
> ---------------
> -
> -Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> -Device () scope per mux channel.
> -
> -Consider this topology:
> -
> -+------+   +------+
> -| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> -|      |   | 0x70 |--CH01--> i2c client B (0x50)
> -+------+   +------+
> -
> -which corresponds to the following ASL:
> -
> -Device (SMB1)
> -{
> -    Name (_HID, ...)
> -    Device (MUX0)
> -    {
> -        Name (_HID, ...)
> -        Name (_CRS, ResourceTemplate () {
> -            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> -                          AddressingMode7Bit, "^SMB1", 0x00,
> -                          ResourceConsumer,,)
> -        }
> -
> -        Device (CH00)
> -        {
> -            Name (_ADR, 0)
> -
> -            Device (CLIA)
> -            {
> -                Name (_HID, ...)
> -                Name (_CRS, ResourceTemplate () {
> -                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> -                                  AddressingMode7Bit, "^CH00", 0x00,
> -                                  ResourceConsumer,,)
> -                }
> -            }
> -        }
> -
> -        Device (CH01)
> -        {
> -            Name (_ADR, 1)
> -
> -            Device (CLIB)
> -            {
> -                Name (_HID, ...)
> -                Name (_CRS, ResourceTemplate () {
> -                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> -                                  AddressingMode7Bit, "^CH01", 0x00,
> -                                  ResourceConsumer,,)
> -                }
> -            }
> -        }
> -    }
> -}
> diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
> new file mode 100644
> index 000000000000..3a8997ccd7c4
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +ACPI I2C Muxes
> +==============
> +
> +Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> +Device () scope per mux channel.
> +
> +Consider this topology::
> +
> +    +------+   +------+
> +    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> +    |      |   | 0x70 |--CH01--> i2c client B (0x50)
> +    +------+   +------+
> +
> +which corresponds to the following ASL::
> +
> +    Device (SMB1)
> +    {
> +        Name (_HID, ...)
> +        Device (MUX0)
> +        {
> +            Name (_HID, ...)
> +            Name (_CRS, ResourceTemplate () {
> +                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> +                            AddressingMode7Bit, "^SMB1", 0x00,
> +                            ResourceConsumer,,)
> +            }
> +
> +            Device (CH00)
> +            {
> +                Name (_ADR, 0)
> +
> +                Device (CLIA)
> +                {
> +                    Name (_HID, ...)
> +                    Name (_CRS, ResourceTemplate () {
> +                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                    AddressingMode7Bit, "^CH00", 0x00,
> +                                    ResourceConsumer,,)
> +                    }
> +                }
> +            }
> +
> +            Device (CH01)
> +            {
> +                Name (_ADR, 1)
> +
> +                Device (CLIB)
> +                {
> +                    Name (_HID, ...)
> +                    Name (_CRS, ResourceTemplate () {
> +                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                    AddressingMode7Bit, "^CH01", 0x00,
> +                                    ResourceConsumer,,)
> +                    }
> +                }
> +            }
> +        }
> +    }
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index d1d069b26bbc..1c89888f6ee8 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -12,4 +12,5 @@ ACPI Support
>     osi
>     method-customizing
>     DSD-properties-rules
> -   gpio-properties
> \ No newline at end of file
> +   gpio-properties
> +   i2c-muxes



Thanks,
Mauro
