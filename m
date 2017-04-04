Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxqgb5kZ2zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 10:32:43 +1000 (AEST)
Message-ID: <1491265953.2944.78.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Roy Pledge <roy.pledge@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Date: Mon, 03 Apr 2017 19:32:33 -0500
In-Reply-To: <VI1PR04MB32166AA6361CD6F24DBC3AAF86080@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
 <20170403154229.mf63zeiwv5naxyrr@rob-hp-laptop>
 <VI1PR04MB32166AA6361CD6F24DBC3AAF86080@VI1PR04MB3216.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH 4/5] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 19:49 +0000, Roy Pledge wrote:
> On 4/3/2017 11:42 AM, Rob Herring wrote:
> > 
> > On Wed, Mar 29, 2017 at 05:13:56PM -0400, Roy Pledge wrote:
> > > 
> > > Updates the QMan and BMan device tree bindings for reserved memory
> > > nodes. This makes the reserved memory allocation compatiable with
> > s/compatiable/compatible/
> > 
> > > 
> > > the shared-dma-pool usage.
> > This change is not backwards compatible. Please state that and explain 
> > why that is okay. If PPC needs to not change, then the old strings and 
> > properties should remain, but deprecated.
> I think I can make the old device trees compatible since the
> "compatible" string changed without too much effort or ifdefery in the
> code.  However I would like to eventually see all PPC users move to the
> new mode as I do believe it is more in alignment with the spirit of the
> reserved-memory framework that is in the kernel.

How much benefit is there to changing PPC if you have to retain the old method
anyway for compatibility?  Whereas if you don't convert, you retain test
coverage for the old device trees, and don't have to worry about
the memblock_end_of_DRAM() questions.

>   Do I need to mention the old mode in the binding.txt file? 

Yes.

>  I'm trying to keep things clean
> so someone reading the binding doesn't get a headache and trying to
> preserve my own sanity as we move forward with adding new features to
> this driver.

If they're sufficiently different then just describe the new and old nodes
separately rather than putting a bunch of if/else clauses in there.

-Scott
