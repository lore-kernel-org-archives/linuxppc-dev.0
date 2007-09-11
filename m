Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A056DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:52:33 +1000 (EST)
Message-ID: <46E6B98C.1070207@freescale.com>
Date: Tue, 11 Sep 2007 10:51:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] fsl_soc.c cleanup
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
	<20070911135717.GD1932@ld0162-tx32.am.freescale.net>
	<3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
In-Reply-To: <3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Yep.  However, after some discussion with Segher on this for 
> 83xx/85xx/86xx I think we want to keep the reg prop and have it cover 
> the initial soc registers [size on 83xx is 0x100, size on 85xx/86xx 
> would be 0x1000].
> 
> What we need is a saner way to determine immr on 82xx & 8xx.  Segher's 
> rule is that a given "reg" prop shouldn't overlap w/any other reg.  We 
> currently violate that on 8xx.  Not as clear on 82xx if we do that.
> 
> I'm thinking on 8xx we should move to grabbing a top level compat value 
> (mpc8xx) and use the SPRN_IMMR to set immrbase.

Any particular reason to special-case it, when we already need code to 
do it the other way for every other fsl soc?

> On mpc82xx-pq2 we could 
> add a immr "device" to search for.

Enh.  The soc node *is* the immr "device".  I'd rather add a node for 
the "initial" registers (they generally don't involve configuring the 
immr "bus" itself, but rather the chipselect bus and other miscellaneous 
things) if needed, get rid of /soc/reg, and have ranges cover the whole 
immr.

And why is 82xx-pq2 special?  Wouldn't you need this on 83xx, 85xx, and 
86xx as well?

-Scott
