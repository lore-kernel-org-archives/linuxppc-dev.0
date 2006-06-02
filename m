Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42EB667A0E
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 16:26:41 +1000 (EST)
Subject: Re: pSeries_mach_cpu_die() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060602061929.GM8934@localdomain>
References: <1149225392.16202.52.camel@localhost.localdomain>
	<20060602061929.GM8934@localdomain>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 16:26:26 +1000
Message-Id: <1149229586.16202.57.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-02 at 01:19 -0500, Nathan Lynch wrote:

> The cpu parameter is actually unused by in the lpar case:

Ok, missed that :)

> >  - xics has a xics_teardown_cpu() now, used by kexec, that does
> > something very similar except that it passes the proper CPU number, and
> > for secondary CPUs also does an EOI of any pending IPI (just in case). I
> > think that could be used instead of the direct call to the low level
> > pSeriesLP_* funciton (which I itend to unexport and rename anyway as
> > part of my rework). Can whoever knows that code confirm ?
> 
> Sounds okay to me.

Ok. I'll call it with 0 for the "secondary" argument so it doesn't do
the additional EOI of the IPI in order to not change behaviour from the
current code. We can do differently in the future if we want.

> The comment should be changed or removed really.  We got away without
> doing plpar_cppr() on the Power4 hypervisor but we found out it was
> necessary when testing Power5.  I think it's required by the
> architecture regardless, and yes, it's safe on both platforms.

I'll remove the comment.

Thanks !

Cheers,
Ben.
