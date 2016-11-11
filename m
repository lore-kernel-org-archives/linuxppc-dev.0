Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFtCy4cVbzDvhZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 08:22:21 +1100 (AEDT)
Subject: Re: [PATCH 1/2] usb: dwc2: add amcc,dwc-otg support
To: Christian Lamparter <chunkeey@googlemail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
From: John Youn <John.Youn@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Felipe Balbi <felipe.balbi@linux.intel.com>
Message-ID: <bfd8be90-930d-1648-e663-0e0e8c496e02@synopsys.com>
Date: Fri, 11 Nov 2016 13:22:16 -0800
MIME-Version: 1.0
In-Reply-To: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2016 12:59 PM, Christian Lamparter wrote:
> This patch adds support for the "amcc,usb-otg" device
> which is found in the PowerPC Canyonlands' dts.
> 
> The device definition was added by:
> commit c89b3458d8cc ("powerpc/44x: Add USB DWC DTS entry to Canyonlands board")'
> but without any driver support as the dwc2 driver wasn't
> available at that time.
> 
> Note: The system can't use the generic "snps,dwc2" compatible
> because of the special ahbcfg configuration. The default
> GAHBCFG_HBSTLEN_INCR4 of snps,dwc2 can cause a system hang
> when the USB and SATA is used concurrently.

Hi,

I don't want to add any more of these param structures to the driver
unless really necessary. We're trying to remove usage of them in favor
of using auto-detected defaults and device properties to override
them.

The AHB Burst is actually one of the ones we were going to do next
because our platform also doesn't work well with INCR4. In fact I'm
thinking of making the default INCR.

If that's all you need then a devicetree binding should be enough
right?

Regards,
John
