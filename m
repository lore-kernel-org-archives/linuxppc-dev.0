Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 3F76367B22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 11:03:19 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id F26BFA4009
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 03:03:16 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Sat, 14 May 2005 04:55:29 +0200
References: <005b01c557bd$c04e2770$0301a8c0@chuck2>
	<ed43f07150d50a594be2bc2589e902a0@freescale.com>
In-Reply-To: <ed43f07150d50a594be2bc2589e902a0@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505140455.29179.roger.larsson@norran.net>
Subject: floating point in kernel (Re: insmod problem)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 13 May 2005 15.46, Kumar Gala wrote:
> On May 13, 2005, at 8:14 AM, Mark Chambers wrote:
> >  > You're using floating arithmetic in the kernel.
> >  >
> >  > That's not supported.
> >  >
> >  > Regards
> >  >
> >  > Pantelis
> >
> > Just for my edification:=A0 Is floating point itself not supported
> > (floating
> >  point register
> >  corruption or something like that) or just linking to user space
> > libraries?
>
> Use of floating point registers and instructions.  Its possible to use
> FP in rare cases inside the kernel buts its extremely discouraged.
>

The kernel is doing lazy saving of FP registers, only saving for user=20
processes that uses them.  And especially avoiding to save for every
interrupt!

So if you like to use any FP (registers) in kernel you have to:
=2D disable kernel preemption (YES)
=2D save previous value
=2D do your stuff
=2D restore
=2D enable preemption

I remember a preemption bug caused by using MMX/SSE to copy
memory uncached.

/RogerL
