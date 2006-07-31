Return-Path: <moilanen@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F238767B60
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 06:50:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6VKoaxC013983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 16:50:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6VKoYDp095742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 14:50:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6VKoXJN023223
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 14:50:33 -0600
Subject: Re: [PATCH][2/2] RTAS MSI
From: Jake Moilanen <moilanen@austin.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1154320382.19883.26.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 15:47:00 -0500
Message-Id: <1154378820.29826.392.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +int rtas_enable_msi(struct pci_dev* pdev)
> > +{
> > +	static int seq_num = 1;
> 
> Do we really want seq_num to be static? By my reading of PAPR we only
> need to maintain the seq number across calls that return -2/990x, and we
> handle that all inside this function. If it does need to be unique for
> _all_ calls, then I don't see how seq_num being static is going to work,
> a different cpu could stomp on the seq_num value between calls, which
> presumably would make firmware mad.

Bah...I thought I fixed this a long time ago....must have gotten dropped
somewhere in the mix.

> > +	int reglen;
> > +	int ret[3];
> 
> You only need ret[2] I think, the first return value (status) is handled
> inside rtas_call for you.

Yup...

> > +	int dummy;
> > +	int n_intr;
> > +	int last_virq = NO_IRQ;
> > +	int virq;
> > +	unsigned int addr;
> > +	unsigned long buid = -1;
> 
> No need to set buid to -1 as you unconditionally assign to it later.

Agreed

> > +	struct device_node * dn;
> > +
> > +	dn = pci_device_to_OF_node(pdev);
> > +
> > +	if (!of_find_property(dn, "ibm,req#msi", &dummy))
> > +		return -ENOENT;
> 
> You don't need dummy, just pass NULL.

Yup.

> > +
> > +	reg = (u32 *) get_property(dn, "reg", &reglen);
> > +	if (reg == NULL || reglen < 20)
> > +		return -ENXIO;
> > +
> > +	devfn = (reg[0] >> 8) & 0xff;
> > +	busno = (reg[0] >> 16) & 0xff;
> > +
> > +	buid = get_phb_buid(dn->parent);
> > +	addr = (busno << 16) | (devfn << 8);
> 
> Why do we need to read the reg here, can't we just use the existing
> fields? ie:
> 
>         addr = (pdev->bus->number << 16) | (pdev->devfn << 8);

Patch coming w/ all these fixes.
