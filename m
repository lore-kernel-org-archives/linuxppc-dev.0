Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 273B0DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:00:56 +1000 (EST)
Date: Tue, 28 Apr 2009 14:12:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
Message-ID: <20090428041257.GC11265@yookeroo.seuss>
References: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
	<20090423040642.GG19376@yookeroo.seuss>
	<49668C6D-3A6A-499E-A8AD-85B8E808F6CF@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49668C6D-3A6A-499E-A8AD-85B8E808F6CF@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 11:41:31PM -0500, Kumar Gala wrote:
>
> On Apr 22, 2009, at 11:06 PM, David Gibson wrote:
>
>> Well, yes, I guess I agree.  How immutable you consider the device
>> tree blob to be is a judgement call based on the specific details of
>> platform/board in question.  If it is indeed a reference platform, in
>> the early stages of development where it's reasonably easy to change
>> the dtb, then it's probably best to change the dtb in sync with the
>> kernel to reduce long-term cruft build-up.  But once the board is
>> sufficiently widely deployed, you want to stop doing that and include
>> backwards compatibility workarounds in the kernel to cope with the
>> widely deployed broken trees.
>
> I disagree with the point about providing workarounds to cope w/deployed 
> device trees (at least for the problems I'm thinking off in which nodes 
> didn't exist).  This just sounds like double work and is a disincentive 
> to actually making such changes.
>
> Lets say I had an error driver for our MCM (core to soc coherency  
> module).  It was getting the base address by using get_immrbase().   
> Today I proposed a proper device node for the MCM block as it doesn't  
> exist in .dts today.  We add such a node into .dts and I can clean up my 
> error driver to use proper device node information.  However I've just 
> broken any old .dts that didn't have this node.  You are saying I need to 
> add code into the kernel to create this new node and we have to keep that 
> code around for ever in the kernel.. why would I ever bother to actually 
> changing anything than.

Well, again.  It's a judgement call, balancing the pain of having to
update the dts files (which depends on how widely deployed the
platform is) versus the pain of having to keep the bacwards
compatibility shim in the kernel.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
