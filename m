Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id D40D3DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 06:03:31 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so5054424wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:03:30 -0800 (PST)
Message-ID: <fa686aa40802121103s650fc10by197e9d5b65f09ceb@mail.gmail.com>
Date: Tue, 12 Feb 2008 12:03:30 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Could the DTS experts look at this?
In-Reply-To: <20080212185251.GB4042@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
	<20080212002030.GE18348@localhost.localdomain>
	<47B0EB23.9040101@pikatech.com>
	<20080212185251.GB4042@loki.buserror.net>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 11:52 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Feb 11, 2008 at 07:41:07PM -0500, Sean MacLennan wrote:
> > David Gibson wrote:
> > > Err.. now I'm doubly confused.  Initially I thought you'd need to
> > > change the size part of reg somewhere, but your description above just
> > > convinced me you didn't (because you were essentially just shifting a
> > > 4M map up into the high rather than low 4M of the 64M space).  Now
> > > you're saying you do..
> > >
> > If you tell the mtd driver that the flash is 64M, when it is really 4M,
> > it goes oops. So you do have to get the size right in the reg field.
>
> It'd be nice if we could pass in a flag to tell it not to try to find
> additional consecutive chips in the mapping...  It's a shame to have
> probable chips, and still have to know how big they are anyway.

That is the job of the boot loader or wrapper.  The whole concept of
the device tree is that by the time it gets to the kernel it is an
accurate representation of the hardware; not a list of things which
might or might not be present.

I see two choices here;
1. have a different .dts variant for each board config (or a .dts with
macros that can generate different .dtb variants)
2. make the boot code massage the tree so it is accurate before it
gets to the kernel.

Either way, the mtd driver must be able to trust that the dt is
correct and complete.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
