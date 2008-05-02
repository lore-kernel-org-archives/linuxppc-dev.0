Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19644DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 23:53:24 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m42DrKJW014522
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:53:20 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m42DrKB4218584
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:53:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m42DrJ0G024480
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:53:19 -0400
Date: Fri, 2 May 2008 08:53:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Message-ID: <20080502085304.1c58d995@zod.rchland.ibm.com>
In-Reply-To: <E55D097A-13D0-45BF-9AE8-E9741A0A869D@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<1209730435.2946.160.camel@vader.jdub.homelinux.org>
	<E55D097A-13D0-45BF-9AE8-E9741A0A869D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2 May 2008 08:32:12 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On May 2, 2008, at 7:13 AM, Josh Boyer wrote:
> 
> > On Fri, 2008-05-02 at 03:11 -0500, Kumar Gala wrote:
> >> GCC 4.4.x looks to be adding support for generating out-of-line  
> >> register
> >> saves/restores based on:
> >>
> >> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
> >>
> >> This breaks the bootwrapper as we'd need to link with libgcc to get  
> >> the
> >> implementation of the register save/restores.
> >
> > We don't link with libgcc anywhere in the kernel.  Is this going to  
> > have
> > similar impacts for building the vmlinux itself?
> 
> Not by default.  The issue only shows up with -Os.  Not sure if we can  
> build the kernel that way.

We can.  See CONFIG_CC_OPTIMIZE_FOR_SIZE.  That's set in at least
pseries_defconfig and ps3_defconfig.  It's also something I've been
thinking about trying with 4xx.

Seems we need a bit more than just the bootwrapper.

josh
