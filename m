Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 34681679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 06:43:44 +1000 (EST)
Message-ID: <428905F8.4030204@mvista.com>
Date: Mon, 16 May 2005 13:43:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <1116222720.5095.86.camel@gaston>	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>	<1116255938.5095.133.camel@gaston>	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>	<1116261725.5095.139.camel@gaston>
	<4288DFCB.2080208@mvista.com> <4288E10A.9030408@mvista.com>
	<2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
In-Reply-To: <2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

>
> On May 16, 2005, at 2:06 PM, Mark A. Greer wrote:
>
>> Oops...
>> /me unintentionally stepped into the middle of a flame war  :)
>
>
> Just pee on it :-)


Heh!

>
>
>> To be clear, "offender" == board that has an io_block_mapping below 
>> the 3 GB line.
>
>
> That is one of the obvious changes. You are likely to find some other 
> assumptions
> that may need attention.  The problem with io_block_mapping is you 
> just can't
> remove it, you have to fix up all of the code that is based on the 
> assumption these
> spaces are mapped.  You are likely to find yourself in a situation 
> where you need
> access to some board control registers before VM is set up and you can 
> call
> ioremap().  So, you will find yourself doing some hack in head.S to 
> map BAT
> registers to get access to this, which is exactly what 
> io_block_mapping() does,
> only in a way that is obvious :-)


I think I understand all of that.  I wasn't clear in my email.  I was 
talking about "fixing" such that 3GB works (i.e., io_block_mapping are 
above 3GB virt, if possible) not "fixing" such that we can get rid of 
io_block_mapping altogether.  We still need io_block_mapping for exactly 
the reasons you state.

I need to learn how to write better emails...  :(

Mark
