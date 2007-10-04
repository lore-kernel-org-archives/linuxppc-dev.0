Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B364DDE17
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 00:42:42 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l94EgJKa005913
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 10:42:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l94EgJ4w429472
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 08:42:19 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l94EgIvs020560
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 08:42:18 -0600
Date: Thu, 4 Oct 2007 09:42:17 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
Message-ID: <20071004094217.523a73a9@weaponx.rchland.ibm.com>
In-Reply-To: <1191508485.7014.7.camel@concordia>
References: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
	<1191495405.3647.3.camel@localhost.localdomain>
	<1191508485.7014.7.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 05 Oct 2007 00:34:45 +1000
Michael Ellerman <michael@ellerman.id.au> wrote:

> On Thu, 2007-10-04 at 05:56 -0500, Josh Boyer wrote:
> > On Wed, 2007-10-03 at 22:50 -0600, Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > > 
> > > dcr.c is an arch/powerpc only thing.
> > > 
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > > 
> > > Ben/Paulus,
> > > 
> > > As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/ppc
> > > build spits out warnings.  Grep doesn't show anything in arch/ppc that
> > > is using it.
> > 
> > Sorry, no.  The ibm_emac driver uses it, which is arch/ppc.  (Yes, the
> > old one.)
> > 
> > If there are warnings, let's fix those up.  Perhaps Michael's recent
> > patches in that area introduced something.
> 
> Hmm, I picked a good time to be away :)
> 
> I think it's OK. ibm_emac uses dcr_write() but it should always be using
> the native one from dcr-native.h. So I think this patch is good.

Agreed.

> Just another reason to get rid of arch/ppc :D

Agreed.

josh
