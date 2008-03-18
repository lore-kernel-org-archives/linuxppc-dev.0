Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D276DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 13:44:39 +1100 (EST)
Subject: Re: [PATCH v2] Force 4K pages for IO addresses.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080318003434.GA671@lixom.net>
References: <20080317034758.GG6887@bakeyournoodle.com>
	<20080317035419.GH6887@bakeyournoodle.com>
	<20080318003434.GA671@lixom.net>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 13:43:41 +1100
Message-Id: <1205808221.26869.207.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Jan-Bernd Themann <themann@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 19:34 -0500, Olof Johansson wrote:
> On Mon, Mar 17, 2008 at 02:54:19PM +1100, Tony Breeds wrote:
> > Currently HEA requires 4K pages for IO resources.  Just set the pages size to
> > IO to 4K.
> 
> Well, that's too bad. Why penalize all platforms for it?
> 
> I.e.: Nack, we use 64K iopages on pa6t and it works well. No need to
> waste tlb and erat space.

We would have to make that pSeries specific for now I suppose...

We don't have a way to know that there "can" be an EHEA right ? It may
not be in the device-tree at boot and dynamically added to the
partition... And we can't dynamically "demote" the ioremap area like we
do for userspace as we have no tracking of bolted entries hashed in
early during boot (I plan to fix that but that will take a while).

Cheers,
Ben.
