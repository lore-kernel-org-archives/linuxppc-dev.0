Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C379E67B59
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 13:04:35 +1000 (EST)
In-Reply-To: <928.1158844980@warthog.cambridge.redhat.com>
References: <135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
	<20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
	<928.1158844980@warthog.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED52FA35-CE7C-4308-A257-95CB432C2988@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] mark BUG() as noreturn 
Date: Thu, 21 Sep 2006 17:15:36 +0200
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	Hollis Blanchard <hollisb@us.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> OTOH, it is handy to mark BUG() as not being able to return as that  
> tells the
> compiler that it doesn't have to check that the code path through  
> the BUG()
> call is complete and this means it can be more relaxed about  
> generating
> warnings about potentially unused variables and suchlike.

That's originally the main reason the noreturn attribute exists
at all.  It can also help optimise code (for size too, sure
performance isn't too interesting here); for example, the compiler
can clobber all registers it wants on the branch path jumping into
the noreturn routine (without the noreturn, it would have to save
the nonvolatiles).


Segher
