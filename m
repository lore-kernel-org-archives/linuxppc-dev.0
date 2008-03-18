Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62CAEDDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 07:32:37 +1100 (EST)
Subject: Re: [PATCH v2] Force 4K pages for IO addresses.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080318144511.GQ4712@localdomain>
References: <20080317034758.GG6887@bakeyournoodle.com>
	<20080317035419.GH6887@bakeyournoodle.com>
	<20080318003434.GA671@lixom.net>
	<1205808221.26869.207.camel@pasglop>
	<20080318144511.GQ4712@localdomain>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 07:31:25 +1100
Message-Id: <1205872285.26869.251.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-18 at 09:45 -0500, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > 
> > On Mon, 2008-03-17 at 19:34 -0500, Olof Johansson wrote:
> > > On Mon, Mar 17, 2008 at 02:54:19PM +1100, Tony Breeds wrote:
> > > > Currently HEA requires 4K pages for IO resources.  Just set the pages size to
> > > > IO to 4K.
> > > 
> > > Well, that's too bad. Why penalize all platforms for it?
> > > 
> > > I.e.: Nack, we use 64K iopages on pa6t and it works well. No need to
> > > waste tlb and erat space.
> > 
> > We would have to make that pSeries specific for now I suppose...
> > 
> > We don't have a way to know that there "can" be an EHEA right ? It may
> > not be in the device-tree at boot and dynamically added to the
> > partition...
> 
> The ibm,drc-names property of the root node should have "HEA" strings
> in it on systems where EHEA can potentially be present.

Ah good, I didn't know. That will force us to stick an ugly wart
somewhere to test it though, maybe we can just force mmu_ci_restrictions
to 1 ? Paul what do you think ?

Ben.
