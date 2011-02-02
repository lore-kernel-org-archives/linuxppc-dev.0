Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8BA4B7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 10:54:05 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p12JZrrB024146
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 14:36:08 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7125B4DE8026
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 18:53:25 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p12Ns0F72171042
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 18:54:00 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p12Ns00s026323
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 21:54:00 -0200
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20110202230844.GG3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230844.GG3032@yookeroo>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 02 Feb 2011 17:53:59 -0600
Message-ID: <1296690839.12290.108.camel@shaggy-w500>
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

On Thu, 2011-02-03 at 10:08 +1100, David Gibson wrote:
> On Tue, Feb 01, 2011 at 12:48:44PM -0600, Dave Kleikamp wrote:
> > Since other OS's may be running on the other cores don't use tlbivax
> 
> [snip]
> > +#ifdef CONFIG_44x
> > +void __init early_init_mmu_44x(void)
> > +{
> > +	unsigned long root = of_get_flat_dt_root();
> > +	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
> > +		amp = 1;
> > +}
> > +#endif /* CONFIG_44x */
> 
> A test against a hardcoded compatible string seems a nasty way to do
> this.  Maybe we should define a new boolean property for the root
> node.

I'm not crazy about this string, but I needed something in the device
tree to key off of.  Freescale has something similar (i.e.
MPC8572DS-CAMP), so I chose to follow their example.  I'd be happy to
replace it with a boolean property.  Any objection to just using "amp"?

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
