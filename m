Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F193DE8D5
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:39:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4KDZj0Y022004
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:35:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4KDd7H8095004
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:39:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4KDd7Xh025681
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:39:07 -0600
Date: Tue, 20 May 2008 08:34:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Giuseppe Coviello <cjg@cruxppc.org>
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080520083450.57ab279a@zod.rchland.ibm.com>
In-Reply-To: <20080520075028.0b286c73@zod.rchland.ibm.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
	<20080519074701.4cb15c86@zod.rchland.ibm.com>
	<1211210447.11958.10.camel@marquez.cjg.home>
	<20080520075028.0b286c73@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 May 2008 07:50:28 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Mon, 19 May 2008 17:20:47 +0200
> Giuseppe Coviello <cjg@cruxppc.org> wrote:
> 
> 
> > +			usb@ef601000 {
> > +				compatible = "ohci-be";
> > +				reg = <ef601000 80>;
> > +				interrupts = <8 4 9 4>;
> > +				interrupt-parent = < &UIC1 >;
> 
> Are you sure the trigger/level settings on those interrupts is
> correct?
> 
> > +			};	
> > +		};
> > +
> > +		PCI0: pci@ec000000 {
> > +			device_type = "pci";
> > +			#interrupt-cells = <1>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
> > +			primary;
> > +			reg = <0 eec00000 8	/* Config space access */
> > +			       0 eed00000 4	/* IACK */
> > +			       0 eed00000 4	/* Special cycle */
> > +			       0 ef400000 40>;	/* Internal registers */
> > +
> > +			/* Outbound ranges, one memory and one IO,
> > +			 * later cannot be changed. Chip supports a second
> > +			 * IO range but we don't use it for now
> > +			 */
> > +			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
> > +				  01000000 0 00000000 0 e8000000 0 00010000>;
> > +
> > +			/* Inbound 2GB range starting at 0 */
> > +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> 
> You have no interrupt mapping for the PCI node.  How do you have
> working PCI here?

Also, if these questions result in changes to the DTS, could you please
convert it to a dts-v1 format?  Otherwise I'll have to do it myself and
it's cleaner if it comes in that way.

josh
