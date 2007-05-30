Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DBF3DDFB4
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:44:54 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:44:44 +1000
Message-Id: <1180525484.19517.266.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 00:32 -0500, Kumar Gala wrote:
> > I think actually it would be useful to have the saving/restoring of
> > the high 32 bits controlled by a prctl, so that programs have to ask
> > explicitly for the new behaviour (and programs that don't want to
> use
> > the high 32 bits don't incur the extra overhead).
> 
> I like this, it means we can error if HW doesn't support it and  
> requires applications to do something specific to enable the feature.

Yeah well.... I liked the prctl at first.. but then, I though twice :-)

Thing is, a typical usage pattern would be some library having a hand
optimized tigh loop or something like that using 64 bits registers. An
example, would be some memcpy-type thing in glibc.

You don't want those things to do prctl's all over the place on behalf
of the host application.

Ben.
