Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68E20DDE44
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 08:55:39 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1191279244.6310.32.camel@pasglop>
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
	<1191279244.6310.32.camel@pasglop>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 08:55:28 +1000
Message-Id: <1191279328.6310.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 08:54 +1000, Benjamin Herrenschmidt wrote:
> It shoudn't normally happen. The reason it -does- happen in fact is
> that
> the above node is also missing the #interrupt-cells property, which
> cause the parent-lookup routine to skip it before it gets a chance to
> see that there's an "interrupt-controller" property in there.
> 
> I'm not sure whether linux behaviour is a bug or not since I believe
> we
> are clearly in undefined-land as an interrupt controller should always
> have a #interrupt-cells property.

That's btw something we could add as a warning to dtc...

A node with "interrupt-controller" or "interrupt-map" in it should
always have a #interrupt-cells property.

Ben.
