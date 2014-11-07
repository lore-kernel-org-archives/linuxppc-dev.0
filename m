Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2DB01A0622
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 18:31:42 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CFA714012E
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2014 18:31:41 +1100 (AEDT)
Message-ID: <545C754C.9080700@Freescale.com>
Date: Fri, 7 Nov 2014 01:31:24 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH v3 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
References: <1415200734-6978-1-git-send-email-Emilian.Medve@Freescale.com>
 <1415200734-6978-2-git-send-email-Emilian.Medve@Freescale.com>
 <1415310579.23458.402.camel@snotra.buserror.net>
In-Reply-To: <1415310579.23458.402.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 11/06/2014 03:49 PM, Scott Wood wrote:
> On Wed, 2014-11-05 at 09:18 -0600, Emil Medve wrote:
>> +Devices connected to a BMan instance via Direct Connect Portals (DCP) must link
>> +to the respective BMan instance
>> +
>> +- fsl,bman
>> +	Usage:		Required
>> +	Value type:	<prop-encoded-array>
>> +	Description:	List of phandle and DCP index pairs, to the BMan instance
>> +			to which this device is connected via the DCP
> 
> Does software need the DCP index (though for QMan there do seem to be a
> few registers associated with each DCP)?  Where can I find that info in
> the manual?

The DCP index helps describe the topology of the devices connected to
the B/QMan. One might be tempted to use some address to reference said
DCP, unfortunately the pertinent registers/bits for said DCP(s) are not
into a compact region. Look at the CCSR memory map for B/QMan

In the QMan case things are marginally better. For each hardware portal
there are a handful of (vaguely named *DCx*, *DCPx* or *DCP*) registers
(configuration, performance monitoring and debugging). However, still
registers and bits spread here and there

In the BMan case things are a bit worse as the registers names are less
friendly and still spread around

Do you need specific names/offsets?


Cheers,
