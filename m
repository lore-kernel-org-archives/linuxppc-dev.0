Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A497CDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:09:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4EF9W3T015540
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 11:09:32 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EF9Wbc267040
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 09:09:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EF9V6N024688
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 09:09:32 -0600
Subject: Re: Small fixes for the Ebony device tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
References: <20070514045404.GP6517@localhost.localdomain>
	<3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 10:09:28 -0500
Message-Id: <1179155368.3420.30.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 14:59 +0200, Segher Boessenkool wrote:
> > -			i-cache-size = <0>;
> > -			d-cache-size = <0>;
> > +			i-cache-size = <2000000>; /* 32 kB */
> > +			d-cache-size = <2000000>; /* 32 kB */
> 
> That's 32MB, not 32kB.  Better fix this :-)

Argh.  What's even sadder is I just did the exact same thing for Bamboo.

> > +		SRAM0: sram {
> > +			compatible = "ibm,sram440gp";
> > +			dcr-reg = <020 8 00a 1>;
> > +		};
> 
> Is this thing _only_ addressable over DCRs?  Weird.

Yes.

> 
> >  		MAL0: mcmal {
> > -			device_type = "mcmal-dma";
> > +			device_type = "dma-controller";
> >  			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
> 
> Remove "device_type", change name to "dma-controller"?
> 
> >  			EBC0: ebc {
> > -				device_type = "ibm,ebc";
> >  				compatible = "ibm,ebc-440gp";
> 
> You forgot "ibm,ebc" here.

/me notes that for Bamboo

josh
