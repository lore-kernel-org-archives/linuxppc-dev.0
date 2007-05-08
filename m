Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD82CDDE40
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:47:44 +1000 (EST)
Subject: Re: [PATCH v4 4/7] Add support for 750CL Holly board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1178643686.3453.37.camel@zod.rchland.ibm.com>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573318.2990.206.camel@zod.rchland.ibm.com>
	<20070508164513.GD19780@localdomain>
	<1178643686.3453.37.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:47:36 +1000
Message-Id: <1178668056.14928.132.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +
> > > +	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> > > +	if (tsi_pic) {
> > > +		unsigned int size;
> > > +		const void *prop = of_get_property(tsi_pic, "reg", &size);
> > > +		mpic_paddr = of_translate_address(tsi_pic, prop);
> > > +	}
> > 
> > You don't actually need 'size' there; it's legal to pass NULL to
> > of_get_property.

Probably easier to use of_address_to_resource

Ben.
