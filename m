Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQx0l0xT1zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 04:58:14 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 03F0C201B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 17:58:12 +0000 (UTC)
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0086E20328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 17:58:10 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id g127so109867913ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 10:58:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4107975.rId64mooHz@wuerfel>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop> <4107975.rId64mooHz@wuerfel>
From: Rob Herring <robh@kernel.org>
Date: Thu, 17 Mar 2016 12:57:49 -0500
Message-ID: <CAL_JsqL8NkEQx2NoVHSUGYhtNsybCo-yfBCde+_OuMmfwbhYEw@mail.gmail.com>
Subject: Re: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>,
 Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2016 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 March 2016 12:06:40 Rob Herring wrote:
>> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > similarity index 91%
>> > rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
>> > rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > index b71b203..07adca9 100644
>> > --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
>> > +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > @@ -25,6 +25,9 @@ Recommended properties:
>> >   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
>> >     registers, for those SOCs that have a PAMU device.
>> >
>> > + - little-endian : Indicates that the global utilities block is little
>> > +   endian. The default is big endian.
>>
>> The default is "the native endianness of the system".
>
> This may be what is currently documented, but not what we are doing
> in practice, as there is no "native endianess" for either PowerPC or
> ARM -- both allow running big-endian or little-endian kernels and the
> device registers are fixed.

Notice I said system, not architecture. The way the device registers
are fixed is what I mean by native endianness.

If the purpose of adding this property now is to support GUTS on the
ARM SoCs, then I'd argue using this property is probably wrong. If the
PPC systems are designed with BE device registers and ARM systems with
LE, then this property is not needed.

> I think the property here is fine.

Unless you have studied the FSL ARM based SoCs, then there is not
enough information here to tell.

Rob
