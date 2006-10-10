Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF54267BC1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 09:05:28 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AN5aNl000510
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 19:05:36 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AN5Pr9280512
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 19:05:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AN5ODs022452
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 19:05:25 -0400
Date: Tue, 10 Oct 2006 18:05:23 -0500
To: Vadim Lobanov <vlobanov@speakeasy.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-ID: <20061010230523.GT4381@austin.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<20061010121519.447d62f8@localhost.localdomain>
	<20061010202034.GV4381@austin.ibm.com>
	<200610101331.11842.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610101331.11842.vlobanov@speakeasy.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2006 at 01:31:11PM -0700, Vadim Lobanov wrote:
> On Tuesday 10 October 2006 13:20, Linas Vepstas wrote:
> > On Tue, Oct 10, 2006 at 12:15:19PM -0500, Olof Johansson wrote:
> > > I keep hitting this on -rc1-mm1. The system comes up but I can't login
> > > since login hits it.
> > >
> > > Bisect says that
> > > fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.
> > >
> > > CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's
> > > fine.
> > >
> > > (Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES,
> > > defaults on all new options)
> > >
> > > kernel BUG in copy_fdtable at fs/file.c:138!
> >
> > FWIW, I too was hitting this bug, during init:
> >
> > [   41.659823] Freeing unused kernel memory: 320k freed
> > INIT: version 2.86 bootin[   42.509322] kernel BUG in copy_fdtable at
> > fs/file.c:138!
> >
> > and of course systm does not come up.

I forgot to mention my h/w was completely different (a cell)

> I'm digging through this right now, trying to figure out exactly what went 
> wrong (and why some people are seeing this, while others are not). All the 
> code seems correct; another pair of eyes is always welcome though.

The patch that AKPM just posted at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes/revert-fdtable-implement-new-pagesize-based-fdtable-allocator.patch

boots for me.

Thanks Andrew!

--linas
