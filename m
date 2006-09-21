Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 0C72067C1C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 23:23:22 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com> 
References: <135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
	<20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [POWERPC] mark BUG() as noreturn 
Date: Thu, 21 Sep 2006 14:23:00 +0100
Message-ID: <928.1158844980@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
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

Jimi Xenidis <jimix@watson.ibm.com> wrote:

> > We finish the BUG() macro with a call to a function marked with  
> > attribute
> > "noreturn" so that the compiler will know that BUG() and BUG_ON()
> > (with a constant, non-zero argument) will not return.
> 
> But BUG() _can_ return, if I have a probe, xmon or kgdb configured it  
> is possible  to play with the state of the world and try to continue/ 
> recover, (xmon "x" command).  IMHO, this is a powerful debugging  
> scenario.

It could be made configurable.

OTOH, it is handy to mark BUG() as not being able to return as that tells the
compiler that it doesn't have to check that the code path through the BUG()
call is complete and this means it can be more relaxed about generating
warnings about potentially unused variables and suchlike.

David
