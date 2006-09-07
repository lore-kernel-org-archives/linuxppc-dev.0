Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B2FD67B79
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 10:58:41 +1000 (EST)
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060906101034.404014f7@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
	<20060906101034.404014f7@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:58:26 +1000
Message-Id: <1157590706.22705.272.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> How about I keep it this way until Maple is fixed then? It's better to keep it
> fairly common anyway. Functionally there's no difference.

Well, the platform-open-pic thingy comes from the CHRP spec. I'm no fan
of it but it looks like we do need it on pseries and I haven't
completely given up with having common mpic discovery routine...

> > > +	mpic = mpic_alloc(mpic_node, openpic_addr, MPIC_PRIMARY, 0, 0,
> > > +			  " PAS-OPIC  ");
> > > +	BUG_ON(mpic == NULL);
> > > +
> > > +	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
> > > +	mpic_init(mpic);
> > 
> > Very nice, I'll convert maple to do the same (unless someone beats
> > me to it, heh).
> 
> Maple isn't that different there. It just has to deal with multiple ISUs, 
> while we currently only have one.

Maple doesn't have multiple ISUs

Ben.
