Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8C22B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 18:29:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41D3ADDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 18:29:41 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1250063825.15143.43.camel@pasglop>
References: <1250063825.15143.43.camel@pasglop>
Content-Type: text/plain
Date: Wed, 12 Aug 2009 18:29:22 +1000
Message-Id: <1250065762.15143.47.camel@pasglop>
Mime-Version: 1.0
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 17:57 +1000, Benjamin Herrenschmidt wrote:

>  - Device-tree: The idea on top of my mind would be to define a
> clock-map property that has the following format:
> 
> A list of:
> 	- zero terminated string clock ID, padded with zeros
>           to a cell boundary
>  	- a phandle to the clock provider
> 	- a numerical (string ?) ID for that clock within that provider
> 
> The core would thus be able to do a search in that list based on the
> clock-id passed in, or if clk_get(dev, NULL), then, use the first one.

Thinking a bit more about that one, mixing strings and numbers in a
property sucks. What about instead:

 clock-map is a list of phandle, id

 clock-names is an optional list of 0 terminated strings

If there's only one clock, and the ID can be ommited, then the
clock-names property can be ommited completely too. Else, the
entries in clock-names match the entries in clock-map.

It's a bit strange to separate the list into two properties but
I think it will generally suck less than having them mixed, especially
with ASCII representations such as lsprop output.

Cheers,
Ben
