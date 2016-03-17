Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQw6x4y7GzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 04:18:32 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 ulf.hansson@linaro.org, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
Subject: Re: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
Date: Thu, 17 Mar 2016 18:11:57 +0100
Message-ID: <4107975.rId64mooHz@wuerfel>
In-Reply-To: <20160317170640.GB21009@rob-hp-laptop>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 17 March 2016 12:06:40 Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> > similarity index 91%
> > rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
> > index b71b203..07adca9 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> > @@ -25,6 +25,9 @@ Recommended properties:
> >   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
> >     registers, for those SOCs that have a PAMU device.
> >  
> > + - little-endian : Indicates that the global utilities block is little
> > +   endian. The default is big endian.
> 
> The default is "the native endianness of the system".

This may be what is currently documented, but not what we are doing
in practice, as there is no "native endianess" for either PowerPC or
ARM -- both allow running big-endian or little-endian kernels and the
device registers are fixed.

I think the property here is fine.

	Arnd
