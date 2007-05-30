Return-Path: <sjmunroe@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4502EDE06F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 12:54:30 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4U2sRQS004990
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 22:54:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4U2sRb9490946
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 22:54:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4U2sQnd015881
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 22:54:26 -0400
In-Reply-To: <16FB57DB-8E02-4F7D-A7B5-BF9719A61BC6@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <OFD102D897.20376982-ON862572EB.000F677F-862572EB.000FF942@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Tue, 29 May 2007 21:54:22 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala <galak@kernel.crashing.org> wrote on 05/29/2007 07:43:05 PM:

>
> On May 29, 2007, at 6:46 PM, Olof Johansson wrote:
>
> > On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt
> > wrote:
> >> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
> >>> This is all problematic since some 64-bit implementations may not
> >>> guarantee the upper bits are valid when in 32-bit mode.  Look at the
> >>> 'Computation Modes' section in the architecture specs 2.03 or
> >>> greater
> >>> for embedded processors.
> >>
> >> Yuck. Well, we might need to export a spearate CPU feature bit to
> >> indicate that it's the case then.
> >
> > No need for a new bit, you should be able to key off of PPC_FEATURE_64
> > && !PPC_FEATURE_BOOKE.
>
> Nope, the architecture allows embedded to behave like server parts
> and support the full 64-bit registers.  We really should have a new
> feature bit so that if someone has an implementation of an embedded
> part that supports the functionality, they get the benefit.
>
When such exists we can add a bit, until then we can wait. The current
32-bit AT_HWCAP is almost full. so we should not allocate bits on
speculation.

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
