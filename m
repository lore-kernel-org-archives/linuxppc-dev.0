Return-Path: <sonny@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3042DDE22
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 10:25:56 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA7NPnl8020619
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 18:25:49 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA7NPo8e104588
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 18:25:50 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA7NPcxR018138
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 18:25:38 -0500
Date: Fri, 7 Nov 2008 17:25:49 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20081107232549.GE16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18707.53757.132643.518167@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 07, 2008 at 04:28:29PM +1100, Paul Mackerras wrote:
> Sonny Rao writes:
> 
> > Fix the BSR driver to allow small BSR devices, which are limited to a
> > single 4k space, on a 64k page kernel.  Previously the driver would
> > reject the mmap since the size was smaller than PAGESIZE (or because
> > the size was greater than the size of the device).  Now, we check for
> > this case use remap_4k_pfn(). Also, take out code to set vm_flags,
> > as the remap_pfn functions will do this for us.
> 
> Thanks.
> 
> Do we know that the BSR size will always be 4k if it's not a multiple
> of 64k?  Is it possible that we could get 8k, 16k or 32k or BSRs?
> If it is possible, what does the user need to be able to do?  Do they
> just want to map 4k, or might then want to map the whole thing?

Hi Paul, the BSR comes in 4 different sizes, 8, 16, 64, 128.

The 8 byte BSR registers are always contained to 4k pages and are
always representing a piece of a larger BSR, but can be assigned to
individual LPARs.  

The 16 byte BSR is contained in two 4k pages, and so the code as
patched would not allow both 4k pages to be mapped.  However, I don't
see any reason for the user to need both 4k pages.  

To give some background as to why the BSR exists in multiple pages at
all I'll say that one proposed way to use the BSR is to have each
participating cpu "own" a cache-line sized piece of the BSR mapped
page and write only to that piece.  The reasoning is that using this approach,
software could use either a BSR or regular cachable memory for the
barrier operation, and I would not need to know which it is actually
using.  So in this type of scenario, there should be enough
cache-lines sized pieces mappable. In the case of the 16 byte BSR, one
4k page contains 32 128byte cache-line pieces.  So this is enough to
still use the BSR in this way.

The 64 byte BSR is contained in 16 4k-pages -- so one 64k page works
there, and the 128 byte BSR is contained in 32 4k pages.

The case of the 16 byte BSR is the only one where it matters, I can
change the code to map both 4k pages if the user requests it, but I
don't see any extra utility.  For consistency though, maybe we should
reject a request to map more than 4k but less than 64k on a 64k kernel?

Sonny
