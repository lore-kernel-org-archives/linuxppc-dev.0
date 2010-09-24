Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id AE9EFB70E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 01:02:56 +1000 (EST)
Received: from mail49-db3 (localhost.localdomain [127.0.0.1])	by
	mail49-db3-R.bigfish.com (Postfix) with ESMTP id 1D1A6C78579	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:02:48 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.247])	by
	mail49-db3.bigfish.com (Postfix) with ESMTP id 08092958050	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:02:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8OF2DoE011319	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:02:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8OF2Dxo021527	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 10:02:13 -0500 (CDT)
Date: Fri, 24 Sep 2010 10:02:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Subject: Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM
	pathfor PTE_64BIT
Message-ID: <20100924100211.1b5c8a47@udp111988uds.am.freescale.net>
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C175@ism-mail03.corp.ad.wrs.com>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
	<20100923153347.4b517105@udp111988uds.am.freescale.net>
	<1285279157.5158.17.camel@pasglop>
	<52CF90264091A14888078A031D780F4306C8C175@ism-mail03.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, "Gortmaker,
	Paul" <Paul.Gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Sep 2010 07:04:28 +0200
"Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:

> > -----Original Message-----
> > From: 
> > linuxppc-dev-bounces+tiejun.chen=windriver.com@lists.ozlabs.or
> > g 
> > [mailto:linuxppc-dev-bounces+tiejun.chen=windriver.com@lists.o
> > zlabs.org] On Behalf Of Benjamin Herrenschmidt
> > Sent: Friday, September 24, 2010 5:59 AM
> > To: Scott Wood
> > Cc: Gortmaker, Paul; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc: Fix invalid page flags in 
> > create TLB CAM pathfor PTE_64BIT
> > 
> > On Thu, 2010-09-23 at 15:33 -0500, Scott Wood wrote:
> > > I don't see a generic accessor that can test PTE flags for 
> > user access 
> > > -- in the absence of one, I guess we need an ifdef here.  
> > Or at least 
> > > put in a comment so anyone who adds a userspace use knows 
> > they need to 
> > > fix it.
> > 
> > We could make up one in powerpc arch at least
> > 
> > #define pte_user(val) ((val & _PAGE_USER) == _PAGE_USER)
> > 
> 
> Looks good. 
> 
> Ben and Scott,
> 
> But for the patched issue we're discussing we have to do #ifdef that as
> my original modification. Right? Or do you have other suggestion? Then I
> can improve that as v2.

Ben's version should work without any ifdef, since it makes sure
all bits of _PAGE_USER are set.

-Scott
