Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 651BDDDEF3
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:22:16 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2LJMB2n019704
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 15:22:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2LJKsWr296610
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 15:20:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2LJKsEB011065
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 15:20:54 -0400
Date: Wed, 21 Mar 2007 14:20:54 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/11] ppc64: EEH: Tolerate high mmio
Message-ID: <20070321192053.GZ5151@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
	<20070319195322.GC11532@austin.ibm.com>
	<20070321012534.GA2485@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321012534.GA2485@lixom.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:25:34PM -0500, Olof Johansson wrote:
> On Mon, Mar 19, 2007 at 02:53:22PM -0500, Linas Vepstas wrote:
> > 
> > Some drivers will attempt to perform a lot of mmio even after
> > an EEH event was detected. This is especially the case for fast cpu's
> > and PCI-E slots. Be a bit more lenient in allowing this.
> > 
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> > 
> > ----
> >  arch/powerpc/platforms/pseries/eeh.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
> > ===================================================================
> > --- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:26.000000000 -0500
> > +++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:19:30.000000000 -0500
> > @@ -74,7 +74,7 @@
> >   * is broken and panic.  This sets the threshold for how many read
> >   * attempts we allow before panicking.
> >   */
> > -#define EEH_MAX_FAILS	100000
> > +#define EEH_MAX_FAILS	2100000
> 
> 100000 I can understand, it's a nice and round number. but why 2100000
> of all possible values?

After five zeros, I find it hard to count them. So, if the number is less
uniform, it is easier to see how many decimal places it has. 2123123 is
one of my favorites.

--linas
