Return-Path: <sjmunroe@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3B59DDFE0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 04:10:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4UI9uLE030056
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 14:09:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4UI9u4i506598
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 14:09:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4UI9tfx002459
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 14:09:56 -0400
In-Reply-To: <1180529892.19517.282.camel@localhost.localdomain>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF822D3D4D.694C1BEE-ON862572EB.00626499-862572EB.0063C22A@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 30 May 2007 13:09:37 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/30/2007
07:58:12 AM:

> On Wed, 2007-05-30 at 21:48 +0900, Hiroyuki Machida wrote:
> >
> > I think same framework as proposed at follwoing URLs,  works.
> > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html

This is about keeping the cpu-specific code separated out in the glibc
build system. The appropriat code can be selected by configuring
--with=cpu=<cpu-type>

> > http://sources.redhat.com/ml/libc-alpha/2006-01/msg00094.html
>

This is about selecting whole cpu-tuned libraries dynamically (at load
time) that separated in the directory structure.

> Yeah, it would make sense to define a new feature bit to trigger
> automatic loading of optimized libs...
>
For dynamic library selection the primary selection is based on
AT_PLATFORM. Specific bits from AT_WHCAP can qualify the search path. For
example /lib/power4 is searched on POWER4 systems based on AT_PLATFORM. The
directory /lib/ppc970/altivec is searched on 970s from AT_PLATFORM=ppc970
and AT_HWCAP=PPC_FEATURE_HAS_ALTIVEC.

Not all bits in the AT_HWCAP effect the search, controls be the
HWCAP_IMPORTANT mask. Current only optional ISA features are includes in
the mask at this time (PPC_FEATURE_HAS_ALTIVEC and PPC_FEATURE_HAS_DFP).

> Steve, how hard do you think it would be to extend AT_HWCAP ? Like
> adding an AT_HWCAP2 or something like that ?
>
If needed, I dont think we are there yet.


Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
