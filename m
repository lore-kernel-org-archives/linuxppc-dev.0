Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DDF667B6E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 12:12:48 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7T2Cijj010698
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 22:12:44 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7T2CiV8268506
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 22:12:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7T2CiUi005448
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 22:12:44 -0400
Subject: Re: copy_4K_page() doesn't use dcbtst?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17651.34629.132793.190742@cargo.ozlabs.ibm.com>
References: <1156786523.28490.52.camel@basalt.austin.ibm.com>
	<17651.34629.132793.190742@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 21:11:53 -0500
Message-Id: <1156817513.13497.12.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-29 at 10:16 +1000, Paul Mackerras wrote:
> Hollis Blanchard writes:
> 
> > Hi Paul, some Xen people were just noticing that copy_4K_page
> > (arch/powerpc/lib/copypage_64.S) doesn't use the dcbtst instruction. Why
> > doesn't it help there?
> 
> Why would we want to read the cache lines for the destination from
> memory when we're only going to overwrite them completely anyway?
> 
> A stronger argument would be for using dcbz, but IIRC it actually made
> things slower (on POWER4 at least).  I suspect the hardware is
> gathering the stores for the whole of each cache line automatically,
> so using dcbz doesn't provide any benefit.

Yes, dcbz makes more sense.

> I did a lot of measurements of memory copy speed on POWER4 (using
> different copy loops, copy sizes, alignments, cache hot/cold cases)
> and the copy_4K_page loop is the fastest I could come up with for
> POWER4.  If anyone can come up with a routine that is measurably
> faster on current machines, I'm happy to look at it, of course.

I figured you had done measurements; we were just curious about the
unexpected results. Thanks!

-- 
Hollis Blanchard
IBM Linux Technology Center
