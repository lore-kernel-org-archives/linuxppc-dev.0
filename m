Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AFF367B1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 15:45:21 +1000 (EST)
Date: Fri, 15 Apr 2005 07:45:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Elston <chris.elston@radstone.co.uk>
Message-ID: <20050415054523.GC32689@wohnheim.fh-wedel.de>
References: <F38DEABE0E171746B133C1ABBD142D9703691B00@radmail.Radstone.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <F38DEABE0E171746B133C1ABBD142D9703691B00@radmail.Radstone.Local>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 12 April 2005 11:07:38 +0100, Chris Elston wrote:
> 
> Thanks for everyone's input on this, I've moved the kernel virtual
> base address to 0xa0000000, and it works fine now.  
> 
> I'm still not convinced that this is a future proof solution 
> though.  What happens when I get a board with 512MB Flash 1GB SDRAM?
> I can push the top of the SDRAM out to the high mem area, but I'll 
> have to encroach further into user space to map the Flash.  There's
> no good reason that the whole of the Flash need be mapped at the same
> time. (Perhaps performance?)

Definitely performance.  At the end of the day, you need a bigger
namespace of some sorts.  Possible solutions are:

o a 64bit machine,
o a 4GiB/4GiB kernel/user split and
o a PPC440 with 36bit addressing and some hardware and ioremap tricks
  to move flash above the 32bit limit.

The 4/4 split also costs some performance.  It doesn't violate the
'flash read must be atomic' requirement, though.

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
