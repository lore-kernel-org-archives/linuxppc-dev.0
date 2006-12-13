Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6672867B89
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 11:20:49 +1100 (EST)
In-Reply-To: <457F300F.7000203@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
	<E8320867-EDC5-42F9-81EE-E66B6D216ADA@kernel.crashing.org>
	<457F300F.7000203@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A0BC548-7BF7-48C3-B1FC-B18C7FF4C0F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Tue, 12 Dec 2006 18:20:44 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 4:41 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Dec 12, 2006, at 3:30 PM, Scott Wood wrote:
>>> They *may* not want to (and they certainly shouldn't be forced  
>>> to),  but
>>> some may not want to define a new ppc_md (or modify a probe  
>>> function)
>>> for every new board if all of the differences are encapsulated in  
>>> the
>>> device tree.  I thought one of the main goals of having a device   
>>> tree is
>>> that if it's done right, the kernel need not know about every single
>>> model of board, just the different components that a device tree can
>>> specify.
>> That's true, and if that's the case you'd just set your "model"  
>> to  match an existing supported ppc_md.
>
> Having an 831x explicitly claim to be an 834x is just a tad icky...
>
>>> If a board has truly board-specific logic that needs custom code  
>>> in  the
>>> kernel itself (rather than the bootloader), then it can go in as a
>>> driver with a device tree node (this should be done with the  
>>> BCSR  stuff
>>> where needed).
>> This is not always the case, there are times when you have board   
>> specific modifications you make in the early kernel code.
>
> Sure -- I'm not proposing doing away with board-specific machine  
> descriptions entirely, just reducing the circumstances where  
> they're required.

And I'm asking why we are arguing over 10-15 lines of code per board.

>> True, but I dont see what the desire is to create a 'generic'  
>> 83xx  support.  Who gets to define what is considered 'generic'?
>
> "Generic" is any board that has needs that aren't expressed in the  
> device tree.

Which device tree specification?  The one today, the one six months  
ago, the one six months from now?  The concept is ever changing and  
doesn't provide much value.

>> I'm all for refactoring code so my board code  is simpler, but at  
>> the end of the day I know there are people that  are going to need  
>> board specific code for their environments.
>
> And an 83xx-generic machine description does not stop them from  
> doing so.  "Generic" does not mean "universal".  It means "there's  
> nothing special about this board".  If you need board-specific code  
> in the kernel, then don't label it generic.

But what value does this have?  83xx, and the majority of freescale's  
devices are not put into something as standard as a desktop computer.

- k
