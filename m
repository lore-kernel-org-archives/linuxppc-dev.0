Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5E1D67BAD
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 12:21:32 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB91LRdV012645
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 20:21:27 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB91LReQ405658
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 18:21:27 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB91LQ62016490
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 18:21:27 -0700
Date: Fri, 8 Dec 2006 19:21:26 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o macros.
Message-ID: <20061209012126.GC13128@austin.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
	<17786.267.627624.105175@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17786.267.627624.105175@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 09, 2006 at 11:19:23AM +1100, Paul Mackerras wrote:
> Segher Boessenkool writes:
> 
> > If you argue it is *not* a branch, where in the architecture
> > documentation can we find any language that gives us the
> > guarantee we depend on here?
> 
> isync is context synchronizing.  In the definition of context
> synchronization, it says "2.  The operation is not initiated, or in
> the case of isync, does not complete, until all instructions already
> in execution have completed to a point at which they have reported all
> exceptions they will cause".  The twi conditionally causes an
> exception depending on the data from the previous load, therefore it
> cannot complete to a point at which is has reported all exceptions it
> will cause until it sees the data from the load.  Therefore the isync
> cannot complete (and allow following instructions to start) until the
> data from the load has returned.

I'd be happy if this text, verbatim or suitably massaged, were 
included in the header file. 

--linas
