Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07B8A2C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 21:43:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFC v9 5/6] dma: mpc512x: add device tree binding document
Date: Fri, 14 Mar 2014 11:43:01 +0100
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
 <1394624875-24411-6-git-send-email-a13xp0p0v88@gmail.com>
 <20140313180916.GF25870@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140313180916.GF25870@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201403141143.01288.arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 13 March 2014, Mark Rutland wrote:
> > +
> > +Example:
> > +
> > +     dma0: dma@14000 {
> > +             compatible = "fsl,mpc5121-dma";
> > +             reg = <0x14000 0x1800>;
> > +             interrupts = <65 0x8>;
> > +             #dma-cells = <1>;
> > +     };
> > +
> > +
> > +Client node properties:
> > +
> > +Required properties:
> > +- dmas:                      list of DMA specifiers, consisting each of a handle
> > +                     for the DMA controller and integer cells to specify
> > +                     the channel used within the DMA controller
> > +- dma-names:         list of identifier strings for the DMA specifiers,
> > +                     client device driver code uses these strings to
> > +                     have DMA channels looked up at the controller
> 
> List the exact names you expect, or the dma-names property is useless.

Listing specific names makes no sense in the binding for the provider,
they should be part of the slave device binding. A reference to the
generic bindings/dma/dma.txt file should be enough here.

	Arnd
