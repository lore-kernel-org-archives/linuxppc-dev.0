Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69C6EDDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:24:54 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions
	and -Os
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080502.144220.53637856.davem@davemloft.net>
References: <F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
	<03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>
	<BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
	<20080502.144220.53637856.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 03 May 2008 09:24:41 +1000
Message-Id: <1209770681.26383.11.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 14:42 -0700, David Miller wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Fri, 2 May 2008 16:34:13 -0500
> 
> > We'll hopefully this thread might spark either an explanation for why  
> > we aren't just linking libgcc in a statement that says we should and  
> > we can remove the code that implements libgcc functionality.
> > 
> > How would libgcc linking intermix with modules?  Would we have to  
> > EXPORT_SYMBOL() all functions that libgcc implements?  I'm guessing  
> > that's varies w/different gcc versions.
> 
> If you link in libgcc, all of a sudden you have a whole new class of
> potential problems, don't do it.
> 
> All it takes is one of these libgcc libcalls the kernel actually
> references, needing something else in libc, to make this exercise
> futile.

Hrm... I though you linked it in, I must be confusing with another
arch :-) Oh well, if we fail with something pulling bits off libc etc...
we'll see quickly who is the culprit no ?

Ben.
