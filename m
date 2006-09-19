Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C293167B54
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:04:29 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JJ4QI2028568
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 15:04:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8JJ4QgR284796
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 15:04:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8JJ4Pmk000536
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 15:04:26 -0400
Date: Tue, 19 Sep 2006 14:04:25 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [POWERPC] convert string i/o operations to C
Message-ID: <20060919190425.GM29167@austin.ibm.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060919135259.303706d3.kim.phillips@freescale.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 01:52:59PM -0500, Kim Phillips wrote:
> On Tue, 19 Sep 2006 13:29:53 -0500
> linas@austin.ibm.com (Linas Vepstas) wrote:
> 
> > 
> > What does this twi do? According to my powerpc docs, this would be a
> > no-op.  Does this have some magic synchronizing powers on certain
> > implementations? If so, there should be at least a comment card added
> > about why the twi is there. (This special ability of twi might be
> > well-known to some, but still, this is not immediately obvious,
> > and not immedately documented in e.g. the PEM.)
> 
> include/asm-p[ower]pc/io.h sheds some light on the matter:
> 
>  * With the sequence below (twi; isync; nop), we have found that
>  * the machine check occurs on one of the three instructions on
>  * all PPC implementations tested so far.  The twi and isync are
>  * needed on the 601 (in fact twi; sync works too), the isync and
>  * nop are needed on 604[e|r], and any of twi, sync or isync will
>  * work on 603[e], 750, 74xx.
>  * The twi creates an explicit data dependency on the returned
>  * value which seems to be needed to make the 601 wait for the
>  * load to finish.


Thanks.  I notice that this commentary appears in asm-ppc/io.h
but not in asm-powerpc/io.h -- Perhaps a patch is in order ...
I'm creating such a patch now ...

--linas
