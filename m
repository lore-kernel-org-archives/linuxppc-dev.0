Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7CA1BDDDD8
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 22:22:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76CMYm7015635
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:22:34 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76CMYGt479808
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:22:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76CMYsL008672
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:22:34 -0400
Date: Mon, 6 Aug 2007 07:36:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, dwg@au1.ibm.com
Subject: Re: [patch 04/10] 4xx bootwrapper reworks
Message-ID: <20070806123602.GZ3925@crusty.rchland.ibm.com>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161710.676644000@linux.vnet.ibm.com>
	<20070806043855.GF6103@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070806043855.GF6103@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 02:38:55PM +1000, David Gibson wrote:
> On Fri, Aug 03, 2007 at 11:09:04AM -0500, Josh Boyer wrote:
> > -#define SPRN_DBCR0		0x134
> > -#define   DBCR0_RST_SYSTEM	0x30000000
> > +#define DBCR0_RST_SYSTEM 0x30000000
> 
> Rather than just removing these defines and using hardcoded values,
> I'd prefer to see separate SPRN_DBCR0_40X and SPRN_DBCR0_44X defines.

Ok.  And place them where?  In the same file since they aren't DCR defines?
Seems fairly trivial, but ok.

> [snip]
> > +#define EMAC_RESET 0x20000000
> > +#define MAL_RESET 0x80000000
> 
> I think the MAL_RESET definition should go in the same place as the
> DCR number definition.

Ok.  Trivial.

> As I think I said before, I'm not really happy with this being
> hardcoded assuming exactly 2 ethernets.

Well, it's hardcoded to assume one or two.  I know of only one board that has
more than two EMACs.  I was hoping we could get this in for 2.6.24 as-is and
change it when needs be.  But I'll look at making it var-args or similar.

josh
