Return-Path: <will_schmidt@vnet.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8E84679F3
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 07:31:18 +1000 (EST)
Received: from e5.ny.us.ibm.com (e5.pok.ibm.com [9.56.232.145])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3IJ2WCX006258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 15:02:33 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3IJ2Qfi017878
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 15:02:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3IJ2Q3d216384
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 15:02:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3IJ2Pc2017258
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 15:02:25 -0400
Subject: Re: [PATCH] Remove stale iseries global
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1145382862.20176.5.camel@localhost.localdomain>
References: <20060418162553.GC26746@pb15.lixom.net>
	<1145381474.20493.5.camel@localhost.localdomain>
	<1145382862.20176.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 14:02:17 -0500
Message-Id: <1145386937.20493.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-04-18 at 19:54 +0200, Michael Ellerman wrote:
> On Tue, 2006-04-18 at 12:31 -0500, Will Schmidt wrote:
> > On Tue, 2006-04-18 at 11:25 -0500, Olof Johansson wrote:
> > > Hi,
> > > 
> > > Not even the iSeries maintainer seems to have access to this legendary
> > > piranha simulator. It adds a bit of ugliness in the common time init
> > > code, and if it's no longer used we might as well be done with it and
> > > remove the bloat.
> > 
> > Yes, the piranha tools are no longer used with linux.   I see no reason
> > why this needs to stay.  
> 
> So can we get rid of this from head_64.S as well? Or is that a different
> debugger?

It's likely the same (piranha) debugger.  I'm not aware of any other
debuggers that would be involved here.

What I dont know is if this offset to the mschunks_map array is also
used by the hypervisor for some non debug purposes.   If iSeries
continues to work without it, then it can probably go too.

Just be sure that PPC_EARLY_DEBUG_ISERIES will continue to work for
getting info out of the system.  :-)

>         /*
>          * At offset 0x28 and 0x30 are offsets to the mschunks_map
>          * array (used by the iSeries LPAR debugger to do translation
>          * between physical addresses and absolute addresses) and
>          * to the pidhash table (also used by the debugger)
>          */
>         .llong mschunks_map-KERNELBASE
>         .llong 0        /* pidhash-KERNELBASE SFRXXX */
> 
> cheers
> 
