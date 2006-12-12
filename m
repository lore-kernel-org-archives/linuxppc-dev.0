Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BBF567D15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:06:49 +1100 (EST)
In-Reply-To: <1165960058.11914.72.camel@localhost.localdomain>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
	<1165960058.11914.72.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Tue, 12 Dec 2006 16:06:41 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 3:47 PM, Benjamin Herrenschmidt wrote:

>>>
>>> The point here is that other developpers making their own mpc83xx  
>>> based
>>> boards will not want to use your ppc_md.
>>
>> They *may* not want to (and they certainly shouldn't be forced  
>> to), but
>> some may not want to define a new ppc_md (or modify a probe function)
>> for every new board if all of the differences are encapsulated in the
>> device tree.  I thought one of the main goals of having a device  
>> tree is
>> that if it's done right, the kernel need not know about every single
>> model of board, just the different components that a device tree can
>> specify.
>
> That's the ideal situation yes. However, from a more realistic  
> point of
> view, I do expect embedded vendors to have their own ppc_md (though it
> may cover multiple boards from that vendor). For things like board
> specific initialisations, magic GPIOs, reset lines, etc...
>
> The problem with Kim initial patch is that it matches on anything that
> says "mpc83xx", thus you completely lose the ability to match  
> somethign
> else unless you remove that property, which I find a bit gross.
>
> I do prefer the middle ground approach he (and you) proposed to  
> have an
> "mpc83xx_generic" in the compatible property and match on that, but  
> I'm
> not 100% certain we are really there yet and I would have been a bit
> more comfortable limiting that to known fsl boards. But you are the  
> guys
> to maintain those things, so do as you like there.

I'm against the idea of "mpc83xx_generic" if they want to introduce a  
"mpc83xx_freescale" or "mpc83xx_fsl_generic" I'm fine with that, but  
there is not such thing as a "mpc83xx_generic".

- kumar
