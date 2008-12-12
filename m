Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93C0ADE0BE
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 08:50:18 +1100 (EST)
Subject: Re: Trying to understand ppc4xx_configure_pciex_PIMs mapping to
	physical address 0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F8B7@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F8B7@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Sat, 13 Dec 2008 08:50:11 +1100
Message-Id: <1229118611.22413.224.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-12 at 10:49 -0600, Ayman El-Khashab wrote:
> I am using the ppc460ex as an endpoint and I see that the mentioned
> function setups a 32Mb
> window at address 0 in sdram.  what i want is some memory that the
> host can read/write to.
> But the 32Mb that are already mapped at the bottom of ram, so it would
> not be good do writes
> to those addresses.  Am I missing something?  My driver right now is
> not touching the PIM 
> registers.
>  
> So is the right way to do this to change the PIM registers after I get
> a buffer in the kernel -- or
> something else?
>  
> How would I make sure that it was aligned on a 32Mb boundry per the
> 44x requirements?  

either that or just allocate some memory and expose the 32MB region that
contains that memory... 

There isn't really much existing code to support endpoint mode. IE, the
code in ppc4xx_pci.c is really mostly host oriented, so it's up to you
to define what you want here. We have no API defined for drivers to use
etc.. 

Ben.
