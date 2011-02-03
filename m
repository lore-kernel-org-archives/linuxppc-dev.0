Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4BADB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Feb 2011 10:16:04 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p13N20TC014906
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 16:02:00 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p13NFxlH113820
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 16:16:00 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p13NFxvx007034
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 16:15:59 -0700
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20110203050351.GK3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230844.GG3032@yookeroo>
	<1296690839.12290.108.camel@shaggy-w500>
	<20110203050351.GK3032@yookeroo>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 03 Feb 2011 17:15:57 -0600
Message-ID: <1296774957.14077.23.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-03 at 16:03 +1100, David Gibson wrote:
> On Wed, Feb 02, 2011 at 05:53:59PM -0600, Dave Kleikamp wrote:
> > On Thu, 2011-02-03 at 10:08 +1100, David Gibson wrote:
> > > On Tue, Feb 01, 2011 at 12:48:44PM -0600, Dave Kleikamp wrote:
> > > > Since other OS's may be running on the other cores don't use tlbivax
> > > 
> > > [snip]
> > > > +#ifdef CONFIG_44x
> > > > +void __init early_init_mmu_44x(void)
> > > > +{
> > > > +	unsigned long root = of_get_flat_dt_root();
> > > > +	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
> > > > +		amp = 1;
> > > > +}
> > > > +#endif /* CONFIG_44x */
> > > 
> > > A test against a hardcoded compatible string seems a nasty way to do
> > > this.  Maybe we should define a new boolean property for the root
> > > node.
> > 
> > I'm not crazy about this string, but I needed something in the device
> > tree to key off of.  Freescale has something similar (i.e.
> > MPC8572DS-CAMP), so I chose to follow their example.  I'd be happy to
> > replace it with a boolean property.  Any objection to just using
> > "amp"?
> 
> Bit too short, I think.  I'd suggest either spelling out
> 'asymmetric-multiprocessor' or 'cooperative-partition' (a more
> accurate term, IMO).

I could be wrong, but I thought the A stands for Asynchronous, not
Asymmetric.  I thought Asymmetric means that different types of tasks
run on the secondary processors, as on the Cell.  Anyway, going with
'cooperative-partition' would avoid that confusion.

Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
