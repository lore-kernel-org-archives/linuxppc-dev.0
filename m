Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93237DDF09
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 10:43:00 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 10:42:49 +1000
Message-Id: <1183423369.10386.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-02 at 14:03 +0200, Segher Boessenkool wrote:
> > +	while ((node = of_get_next_child(adap_node, node))) {
> 
> of_for_each_child_node() or whatever it is called?
> 
> > +		addr = of_get_property(node, "reg", &len);
> > +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> > +			continue;
> 
> Addresses aren't 16 bit AFAIK?

Some i2c busses support 10 bits addressing...

Ben.
