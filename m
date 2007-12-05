Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F1ABDDE42
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 05:34:16 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB5HWf7P018778
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 12:32:41 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB5IY7Pe142910
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 11:34:07 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB5IY67f031371
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 11:34:06 -0700
Date: Wed, 5 Dec 2007 12:31:19 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add aliases node to 8641hpcn DTS file.
Message-ID: <20071205123119.22c70455@zod.rchland.ibm.com>
In-Reply-To: <1196877907.8544.15.camel@ld0161-tx32>
References: <1196875970.8544.12.camel@ld0161-tx32>
	<fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
	<1196877907.8544.15.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 05 Dec 2007 12:05:07 -0600
Jon Loeliger <jdl@freescale.com> wrote:

> On Wed, 2007-12-05 at 11:38, Grant Likely wrote:
> 
> > >
> > > +       aliases {
> > > +               ethernet0 = &enet0;
> > > +               ethernet1 = &enet1;
> > > +               ethernet2 = &enet2;
> > > +               ethernet3 = &enet3;
> > > +               serial0 = &serial0;
> > > +               serial1 = &serial1;
> > > +               pci0 = &pci0;
> > > +               pci1 = &pci1;
> > > +       };
> > 
> > I had thought aliases were supposed to be full paths to nodes instead
> > of phandles.  Was I wrong?
> 
> Indeed, that is correct.  And they are!
> 
> => fdt addr c00000
> => fdt print /aliases
> aliases {
>         ethernet0 = "/soc8641@f8000000/ethernet@24000";
>         ethernet1 = "/soc8641@f8000000/ethernet@25000";
>         ethernet2 = "/soc8641@f8000000/ethernet@26000";
>         ethernet3 = "/soc8641@f8000000/ethernet@27000";
>         serial0 = "/soc8641@f8000000/serial@4500";
>         serial1 = "/soc8641@f8000000/serial@4600";
>         pci0 = "/pcie@f8008000";
>         pci1 = "/pcie@f8009000";
> };
> => bootm 1000000 - c00000
> 
> Grant, you need to keep up, man.  Just this morning
> I pushed Gibson's patch to DTC to support this. :-)

So now the in-kernel version of DTC needs to support this.

josh
