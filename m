Return-Path: <apw@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C39067B75
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 11:34:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8M1YO1P011757
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:34:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8M1YOUW289334
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:34:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8M1YOFI008848
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:34:24 -0400
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8M1YOk2008840
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:34:24 -0400
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1GQZvq-0003My-PM
	for linuxppc-dev@ozlabs.org; Thu, 21 Sep 2006 21:34:22 -0400
Date: Thu, 21 Sep 2006 21:34:22 -0400
To: linuxppc-dev@ozlabs.org
Subject: Re: [POWERPC] mark BUG() as noreturn
Message-ID: <20060922013422.GA12753@kvasir.watson.ibm.com>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
	<135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
	<1158886446.8109.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158886446.8109.2.camel@localhost.localdomain>
From: Amos Waterland <apw@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2006 at 10:54:05AM +1000, Michael Ellerman wrote:
> On Thu, 2006-09-21 at 08:18 -0400, Jimi Xenidis wrote:
> > But BUG() _can_ return, if I have a probe, xmon or kgdb configured it  
> > is possible  to play with the state of the world and try to continue/ 
> > recover, (xmon "x" command).  IMHO, this is a powerful debugging  
> > scenario.
> 
> Hmm, ok I hadn't thought of that. Personally I've never tried to recover
> from a BUG(), do people really do that much?

Yes, people do that.  

Especially in the case where you have a bug that only manifests every so
often: you want to capitalize on the fact that you have caught the
machine in that state.

You aren't trying to recover as though nothing has happened, but you are
trying to continue execution to learn about things now that you know the
machine was in the state that triggers the bug.
