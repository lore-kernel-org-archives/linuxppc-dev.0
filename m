Return-Path: <SRS0=AZ+D=FL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09291C4361B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Dec 2020 16:52:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A11F23884
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Dec 2020 16:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A11F23884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqTqg0tNPzDqWn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 03:51:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqTnL2wGHzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2020 03:49:55 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id h18so9078378otq.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2020 08:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UuU157skWGSfcX1NxkRT5BCxvQhS6DEbdRKPwY10+n0=;
 b=mfB/zgwm52k/mM7TNF2my5V5G3RlhUxfL0VYykI7FhA8buNad1OiL5HFKunqHNfdsW
 BQ/MKp61pfnYYCk0ck3oZLdWVN6u7F6dmh/Ptn2iv/nl9Z8Ha/eubI9uOOzJcGsx3R/s
 MNmSdG0J1mLHAx7bmJ4jvuXlSW6I0hiDd47Ry2swSV4jtYmkQq+Kj2zQHamBimY5qI9A
 hUt1KI4kL2MSSnP864UZa6bEIQzTkwTwavxV2YS4VlQ317A/r13Caj7UYMmgVQttqfrk
 pDNFXPSMJkEY6F+X4RCWSPpAAMUdmpV3ay8ckF50KjDMWWDfUO4WeB0kZroJ+QhkHS/t
 +0/g==
X-Gm-Message-State: AOAM531z2/+PP0pW+fN63LFYg15gb4437GPQoAiMBqpwynMwxrQRd1E9
 TiYykLrzQejBuhmqcBQ5rw==
X-Google-Smtp-Source: ABdhPJxmcf4zm/wuxPhsKUoUScvOLy83vfBUwi8g1uPSshO3b0CcihsttcupDMYjJmpikbuM3HuZZw==
X-Received: by 2002:a9d:7304:: with SMTP id e4mr4414560otk.228.1607359790146; 
 Mon, 07 Dec 2020 08:49:50 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x72sm3040778oia.16.2020.12.07.08.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:49:48 -0800 (PST)
Received: (nullmailer pid 420892 invoked by uid 1000);
 Mon, 07 Dec 2020 16:49:47 -0000
Date: Mon, 7 Dec 2020 10:49:47 -0600
From: Rob Herring <robh@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v5 10/19] dt-bindings: usb: Convert DWC USB3 bindings to
 DT schema
Message-ID: <20201207164947.GA420349@robh.at.kernel.org>
References: <20201205152427.29537-1-Sergey.Semin@baikalelectronics.ru>
 <20201205152427.29537-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205152427.29537-11-Sergey.Semin@baikalelectronics.ru>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-mips@vger.kernel.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Andy Gross <agross@kernel.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 Mathias Nyman <mathias.nyman@intel.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Manu Gautam <mgautam@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 05 Dec 2020 18:24:17 +0300, Serge Semin wrote:
> DWC USB3 DT node is supposed to be compliant with the Generic xHCI
> Controller schema, but with additional vendor-specific properties, the
> controller-specific reference clocks and PHYs. So let's convert the
> currently available legacy text-based DWC USB3 bindings to the DT schema
> and make sure the DWC USB3 nodes are also validated against the
> usb-xhci.yaml schema.
> 
> Note 1. we have to discard the nodename restriction of being prefixed with
> "dwc3@" string, since in accordance with the usb-hcd.yaml schema USB nodes
> are supposed to be named as "^usb(@.*)".
> 
> Note 2. The clock-related properties are marked as optional to match the
> DWC USB3 driver expectation and to improve the bindings mainainability
> so in case if there is a glue-node it would the responsible for the
> clocks initialization.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Discard '|' from the descriptions, since we don't need to preserve
>   the text formatting in any of them.
> - Drop quotes from around the string constants.
> - Fix the "clock-names" prop description to be referring the enumerated
>   clock-names instead of the ones from the Databook.
> 
> Changelog v3:
> - Apply usb-xhci.yaml# schema only if the controller is supposed to work
>   as either host or otg.
> 
> Changelog v4:
> - Apply usb-drd.yaml schema first. If the controller is configured
>   to work in a gadget mode only, then apply the usb.yaml schema too,
>   otherwise apply the usb-xhci.yaml schema.
> - Discard the Rob'es Reviewed-by tag. Please review the patch one more
>   time.
> 
> Changelog v5:
> - Add "snps,dis-split-quirk" property to the DWC USB3 DT schema.
> - Add a commit log text about the clock-related property changes.
> - Make sure dr_mode exist to apply the USB-gadget-only schema.
> ---
>  .../devicetree/bindings/usb/dwc3.txt          | 128 -------
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 312 ++++++++++++++++++
>  2 files changed, 312 insertions(+), 128 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:55:4: [warning] wrong indentation: expected 4 but found 3 (indentation)

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/usb-drd.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 124
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1411582

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

