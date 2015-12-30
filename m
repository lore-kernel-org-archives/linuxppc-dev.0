Return-Path: <curt@cumulusnetworks.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1963A1A0E67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 03:36:19 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id cy9so140434909pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 08:36:19 -0800 (PST)
Date: Wed, 30 Dec 2015 08:36:01 -0800
From: Curt Brune <curt@cumulusnetworks.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com,
 pawel.moll@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/1] powerpc: legacy serial port use device tree cell-index
 property
Message-ID: <20151230163601.GX14046@cumulusnetworks.com>
References: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
 <20151220150225.GA27380@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151220150225.GA27380@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun Dec 20 09:02, Segher Boessenkool wrote:
> On Wed, Nov 25, 2015 at 10:46:49AM -0800, Curt Brune wrote:
> > +	/* Check if the ports have an ordering, defined by 'cell-index' */
> > +	if (((indexp = (u32*)of_get_property(np, "cell-index", &len)) != NULL) &&
> > +	    (len == sizeof(u32)))
> > +		index = *indexp;
> > +
> >  	/* Add port, irq will be dealt with later. We passed a translated
> >  	 * IO port value. It will be fixed up later along with the irq
> >  	 */
> >  	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
> > -		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
> > +		return add_legacy_port(np, index, UPIO_TSI, addr, addr,
> >  				       NO_IRQ, legacy_port_flags, 0);
> >  	else
> > -		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
> > +		return add_legacy_port(np, index, UPIO_MEM, addr, addr,
> >  				       NO_IRQ, legacy_port_flags, 0);
> 
> What does this do if the value in cell-index is a duplicate. or the port
> with that number is already created some other way?  Are the numbers in
> cell-index global anyway, or relative to some parent device (I couldn't
> find the documentation for this).
> 
> 
> Segher

add_legacy_port() has support for handling duplicate index entries.
Reading that code it looks like the recent entry wins and the older
entry is moved to the next available index.

The numbers in cell-index are not global nor explicitly relative to a
parent device.  I also could not find documentation on this.

In common usage, however, the cell-index property is used in two
different ways:

1.  For devices that have "channels" or "regions" (DMA for example),
the parent device node has child nodes enumerated by cell-index.  For
example see:  arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi

2.  For multiple instances of a device, for example UARTS,
each device node is enumerated using cell-index.  See:
arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi

Cheers,
Curt
