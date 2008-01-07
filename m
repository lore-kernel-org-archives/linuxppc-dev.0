Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3EC9DDED7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:09:15 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/3] Add StorCenter DTS first draft. 
In-Reply-To: Your message of "Mon, 07 Jan 2008 12:26:13 MST."
	<fa686aa40801071126o1dd9798eub6006e1f0f33797f@mail.gmail.com>
References: <E1JBwBQ-0006Iy-54@jdl.com>
	<fa686aa40801071126o1dd9798eub6006e1f0f33797f@mail.gmail.com>
Date: Mon, 07 Jan 2008 14:09:09 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JByHV-0007Lk-HK@jdl.com>
Cc: linuxppc-dev@ozlabs.org, andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Grant Likely" mumbled:
> > +
> > +               ranges = <80000000 80000000 70000000    /* pci mem space */
> > +                         fdf00000 fdf00000 00100000    /* EUMB */
> > +                         fe000000 fe000000 00c00000    /* pci i/o space */
> > +                         fec00000 fec00000 00300000    /* pci cfg regs */
> > +                         fef00000 fef00000 00100000>;  /* pci iack */
> 
> This doesn't look nice.  On the other ppc boards, Kumar moved the pci
> bus node out of the soc node so the the internal register range is
> separate from the soc.

Oh crap.  I forgot about that.  Yes, you are right.

> I think it should look like this:
> 
> {
>     soc@fdf00000 {
>         compatible = "fsl,mpc8241-immr";
>         ranges = <0 fe000000 00100000>;
>         serial@4500 {
>             blah....
>         };
>         blah....
>     };
>     pci@800000000 {
>         ranges = blah....
>     };
> };

So, I'll definitely rework that part as in indicated

> > +                       clock-frequency = <d# 97553800>; /* Hz */
> 
> That's kind of an odd number for clock frequency.  Usually clock
> frequencies are *big* and *round*.  :-)

And this one, according to Andy, is nice-n-measured right
off the crystal!  I had 10M in there originally even.
But I'll double check that with him to be sure.

Thanks,
jdl
