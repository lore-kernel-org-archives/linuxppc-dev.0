Return-Path: <fvoegel@carangul.com>
Received: from asgard.akp-net.com (carangul.com [83.149.88.131])
	by ozlabs.org (Postfix) with ESMTP id 43EFDDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 03:13:31 +1000 (EST)
Date: Fri, 20 Jul 2007 19:39:27 +0200
From: "Florian A. Voegel" <fvoegel@carangul.com>
To: lokowich <lokowich@acdstar.com>
Subject: Re: SDRAM failures on MPC5200B
Message-Id: <20070720193927.858cd85b.fvoegel@carangul.com>
In-Reply-To: <46A0D76E.4030101@acdstar.com>
References: <46A0D76E.4030101@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Considering the age of the U-Boot version you're using, it's most likely the problem with the SD-RAM controller of the 5200B. Later U-Boot versions fix this I think by writing a value of 4 to the register at MBAR+0x0190, which does _something_ to resolve the problem. It worked for us. However, we still had problems with SD-RAM in conjunction with other components, so we switched to DDR which has worked flawlessly so far - you might want to consider doing the same.

Greets,

Florian Voegel
Carangul.Tech

On Fri, 20 Jul 2007 10:40:30 -0500
lokowich <lokowich@acdstar.com> wrote:

> We're working on bringing up a MPC5200B version of our original MPC5200 
> board using U-Boot 1.1.4 configured for Icecube/Lite5200B.  Other than 
> the CPU, the board is identical.  The bootloader crashes just after 
> relocation to RAM, often with a Program Check Exception, typically a 
> memory corruption issue.  I noticed failures at different stages after 
> relocation based on content, suggesting problems with upper SDRAM.  If I 
> force the initram to 1/2 the determined size (64MB instead of 128MB), 
> then everything works well through kernel load and initialization.  
> We've added termination resistors to improve AD signals, to no avail.  
> Memory tests work fine too.  Any help is appreciated.
> 
> Thanks,
> Mark Lokowich
> Systems Engineer
> Advanced Communication Design
> 7901 12th Ave. So.
> Bloomington, MN 55425
> 952-854-4000
> lokowich@acdstar.com
> 
> This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
> 
> 
