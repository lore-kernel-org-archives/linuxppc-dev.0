Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDC8CDDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:50:20 +1000 (EST)
Message-ID: <49F7093F.1000500@freescale.com>
Date: Tue, 28 Apr 2009 08:48:47 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Subject: Re: removing get_immrbase()??
References: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
	<20090423040642.GG19376@yookeroo.seuss>
	<49668C6D-3A6A-499E-A8AD-85B8E808F6CF@kernel.crashing.org>
	<20090428041257.GC11265@yookeroo.seuss>
In-Reply-To: <20090428041257.GC11265@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Apr 22, 2009 at 11:41:31PM -0500, Kumar Gala wrote:
>> Lets say I had an error driver for our MCM (core to soc coherency  
>> module).  It was getting the base address by using get_immrbase().   
>> Today I proposed a proper device node for the MCM block as it doesn't  
>> exist in .dts today.  We add such a node into .dts and I can clean up my 
>> error driver to use proper device node information.  However I've just 
>> broken any old .dts that didn't have this node.  You are saying I need to 
>> add code into the kernel to create this new node and we have to keep that 
>> code around for ever in the kernel.. why would I ever bother to actually 
>> changing anything than.
> 
> Well, again.  It's a judgement call, balancing the pain of having to
> update the dts files (which depends on how widely deployed the
> platform is) versus the pain of having to keep the bacwards
> compatibility shim in the kernel.

I agree with this sentiment.  I'm only asking for a reasonable attempt
at adding backwards compatibility via an isolated code block.  Sprinkle
in a few comments, and that should be enough.  It won't always be
possible to add such code, but at the very least, I expect the
driver/kernel to clearly indicate what's missing from the device tree.
In Kumar's example above, I expect the kernel to say that the MCM node
is missing.

-- 
Timur Tabi
Linux kernel developer at Freescale
