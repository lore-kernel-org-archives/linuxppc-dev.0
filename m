Return-Path: <SRS0=LfhS=C4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3DDC43463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 20:25:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1430E20866
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvQWFnB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1430E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bv2Jw3bSXzDqxG
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 06:25:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com; envelope-from=chunkeey@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VvQWFnB9; dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bv2Gp0FS5zDqgL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2020 06:23:58 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id a12so9180501eds.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2020 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zHuRaA2/CnjUUNxSbT4FFuVSrFckwW2Ag/ouqgH/+jU=;
 b=VvQWFnB9NXB8aiWawVT1ZIxQCSFhnNPawfdmjuNgQhzHNimUidmW+lw9/J3DK4/yPB
 rWS8lv8jYdpYX3Zi7HgEp3Fq5LuR3CdjvsWVmmSQmU8ZV0tKz3Aog/Xfhh3DN/KSLqB5
 7AD+h7wBzFfcug8DnOoZUgaiph4r+23nf5HOW0Gg/K7YzG4+yyk5GAFoLjoDs7mGNpKL
 L1dp5vJut3EW0h8Mml32i/PYKgtRQE1EkMXBLJsX936pPusb5rfCSuAjmMKj55Pwb2VQ
 Nb+WgMQYGUrSSHCsykRFPNb+X6gVkdI3pe/JWMYsLeJBnFG5Mf0Kj1O8ubpfvh1mZ8u3
 ql2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zHuRaA2/CnjUUNxSbT4FFuVSrFckwW2Ag/ouqgH/+jU=;
 b=ZFdwnznx49+R9P+pQPSvPJHsuhsLZ9yW5HRoTUXCu5wszbSOdNIlVkV9t/xNpge2r+
 ae8opS7gdsCZ2y1PzgnZBSWe0DA4VvxMHxJMWZ1Dn1Ru1Ov05u99VJP17D73RhywVq3W
 6TzHGo8euGY2+KtdhdGw6iZ3iEhMVgPEjsQmjI9QAIhqNJIutzFIpcUjRHMa50+b4fc6
 zAwVMczhy00c5z8FBtwuTSMSbvtzX3koXLQ5tDwoQo5Vw350Nz0dB90NIUkKfS+Hrhq5
 yCp1TswD8jgOCrbkGkS6+04rnTZPXzSghQTWOln6JLNfNBSpPGhcaARQkRcN1lVFv2ng
 /1pw==
X-Gm-Message-State: AOAM532z41WCd5ZmXkCPjz295Nmm3F6s/1NiEvQCtMc98iwy4qlMzZNO
 /ABvPsQV5ksU1c6jUGQVQGQ=
X-Google-Smtp-Source: ABdhPJy+l50sz8n7UzSviMLzVte2BOL/AxXz0YDUysZ/WuQPfyWZ43QazhKMB9BCD8aRAQ3yDYGauA==
X-Received: by 2002:a05:6402:1d93:: with SMTP id
 dk19mr45557611edb.198.1600547030580; 
 Sat, 19 Sep 2020 13:23:50 -0700 (PDT)
Received: from debian64.daheim (p4fd09180.dip0.t-ipconnect.de.
 [79.208.145.128])
 by smtp.gmail.com with ESMTPSA id b6sm5097448eds.46.2020.09.19.13.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 13:23:49 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
 by debian64.daheim with esmtp (Exim 4.94)
 (envelope-from <chunkeey@gmail.com>)
 id 1kJjOV-000iiJ-8M; Sat, 19 Sep 2020 22:23:39 +0200
Subject: Re: [PATCH v3 2/5] powerpc: apm82181: create shared dtsi for APM
 bluestone
To: Rob Herring <robh@kernel.org>
References: <cover.1599343429.git.chunkeey@gmail.com>
 <47109d80c7bd481c7747c949e8a3ecd498d9c039.1599343429.git.chunkeey@gmail.com>
 <20200915010543.GB612463@bogus>
From: Christian Lamparter <chunkeey@gmail.com>
Message-ID: <7bf866fd-6499-68e4-9825-5c3e2042ef65@gmail.com>
Date: Sat, 19 Sep 2020 22:23:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915010543.GB612463@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
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
Cc: devicetree@vger.kernel.org, arnd@arndb.de,
 Chris Blake <chrisrblake93@gmail.com>, Paul Mackerras <paulus@samba.org>,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2020-09-15 03:05, Rob Herring wrote:
> On Sun, Sep 06, 2020 at 12:06:12AM +0200, Christian Lamparter wrote:
>> This patch adds an DTSI-File that can be used by various device-tree
>> files for APM82181-based devices.
>>
>> Some of the nodes (like UART, PCIE, SATA) are used by the uboot and
>> need to stick with the naming-conventions of the old times'.
>> I've added comments whenever this was the case.
>>
>> Signed-off-by: Chris Blake <chrisrblake93@gmail.com>
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>> ---
>> rfc v1 -> v2:
>> 	- removed PKA (this CryptoPU will need driver)
>> 	- stick with compatibles, nodes, ... from either
>> 	  Bluestone (APM82181) or Canyonlands (PPC460EX).
>> 	- add labels for NAND and NOR to help with access.
>> v2 -> v3:
>> 	- nodename of pciex@d.... was changed to pcie@d..
>> 	  due to upstream patch.
>> 	- use simple-bus on the ebc, opb and plb nodes
>> ---
>>   arch/powerpc/boot/dts/apm82181.dtsi | 466 ++++++++++++++++++++++++++++
>>   1 file changed, 466 insertions(+)
>>   create mode 100644 arch/powerpc/boot/dts/apm82181.dtsi
>>
>> diff --git a/arch/powerpc/boot/dts/apm82181.dtsi b/arch/powerpc/boot/dts/apm82181.dtsi
>> new file mode 100644
>> index 000000000000..60283430978d
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/apm82181.dtsi
>> @@ -0,0 +1,466 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Device Tree template include for various APM82181 boards.
>> + *
>> + * The SoC is an evolution of the PPC460EX predecessor.
>> + * This is why dt-nodes from the canyonlands EBC, OPB, USB,
>> + * DMA, SATA, EMAC, ... ended up in here.
>> + *
>> + * Copyright (c) 2010, Applied Micro Circuits Corporation
>> + * Author: Tirumala R Marri <tmarri@apm.com>,
>> + *	   Christian Lamparter <chunkeey@gmail.com>,
>> + *	   Chris Blake <chrisrblake93@gmail.com>
>> + */
>> +
>> +#include <dt-bindings/dma/dw-dmac.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +	dcr-parent = <&{/cpus/cpu@0}>;
>> +
>> +	aliases {
>> +		ethernet0 = &EMAC0; /* needed for BSP u-boot */
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			model = "PowerPC,apm82181";
> 
> This doesn't match the existing bluestone dts file.
> 
> Please separate any restructuring from changes.


"I see" (I'm including your comment of the dt-binding as well).

I'm getting the vibe that I better should not touch that bluestone.dts.
An honestly, looking at the series and patches that the APM-engineers
posted back in the day, I can see why this well is so poisoned... and
stuff like SATA/AHBDMA/USB/GPIO/CPM/... was missing.

As for the devices. In the spirit of Arnd Bergmann's post of
<https://lkml.org/lkml/2020/3/30/195>

|It would be nice to move over the the bluestone .dts to the apm82181.dtsi file
|when that gets added, if only to ensure they use the same description for each
|node, but that shouldn't stop the addition of the new file if that is needed for
|distros to make use of a popular device.
|I see a couple of additional files in openwrt.

I mean I don't have the bluestone dev board, just the consumer devices.
Would it be possible to support those? I can start from a "skeleton" apm82181.dtsi
This would just include CPU, Memory (SD-RAM+L2C+OCM), UIC (Interrupt-Controller),
the PLB+OBP+EBC Busses and UART. Just enough to make a board "boot from ram".

And then add nodes for PCIE+MSI, AHBDMA+SATA, I2C, Ethernet, NAND+NOR and finally
the Crypto each in separate patches.
