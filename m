Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09760B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 07:58:41 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51F2CDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 07:58:39 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: blackluck@ktk.bme.hu
In-Reply-To: <1245724218.4017.35.camel@pasglop>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 07:57:08 +1000
Message-Id: <1245794228.10356.31.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I tried on a POWER3 box I have here "IBM,7044-170" and things work fine
> here with current upstream. (I suspect a much smaller machine).
> 
> I will really need an actual bisection here... In the meantime, I'll see
> if I can get my hand on one of these machines here.

Ok so I think we may have found it... looks like
CONFIG_MPIC_BROKEN_REGREAD is what breaks it which is enabled by PA-Semi
support in the .config.

Can you verify that disabling PA-Semi support removes that option from
your .config and that once removed, it works again ?

We don't know yet -why- it breaks it, still investigating.

Cheers,
Ben.

> Cheers,
> Ben.
> 
> > Cheers,
> > Ben.
> > 
> > > Thanks: blackluck
> > > 
> > > Laszlo Fekete wrote:
> > > > Hello!
> > > >
> > > > I'm sorry about the annoyances, but I'd welcome all ideas, suggestions 
> > > > to see what needs to be done or should be tested for the solution.
> > > >
> > > > Thank you very much!
> > > >
> > > > Guennadi Liakhovetski wrote:
> > > >> Ok, first attempt to forward this to scsi was wrong, as pointed out 
> > > >> by Matthew Wilcox this does indeed look like an interrupt problem - 
> > > >> no interrupts drom SCSI, IDE, keyboar. Might be a known problem, I 
> > > >> guess. In any case, I think, the OP would be grateful for any hints.
> > > >>
> > > >> Thanks
> > > >> Guennadi
> > > >> ---
> > > >> Guennadi Liakhovetski, Ph.D.
> > > >> Freelance Open-Source Software Developer
> > > >> http://www.open-technology.de/
> > > >>
> > > >> ---------- Forwarded message ----------
> > > >> Date: Sat, 13 Jun 2009 16:22:07 +0200
> > > >> From: Laszlo Fekete <blackluck@ktk.bme.hu>
> > > >> To: debian-powerpc@lists.debian.org
> > > >> Subject: sym scsi driver problem with 2.6.26 or newer debian kernel 
> > > >> on p610
> > > >> Resent-Date: Sat, 13 Jun 2009 14:29:55 +0000 (UTC)
> > > >> Resent-From: debian-powerpc@lists.debian.org
> > > >>
> > > >> This is a multi-part message in MIME format.
> > > >> ------------------------------------------------------------------------
> > > >>
> > > >> Hello!
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>
> > > >> Pls help me with sym scsi driver problem.
> > > >>
> > > >>
> > > >>
> > > >> I have Ibm P610 (and tested it on P630 and P640 too), installed debian
> > > >>
> > > >> etch and upgraded to lenny.
> > > >>
> > > >>
> > > >>
> > > >> But with 2.6.26 or newer kernel it's not booting, it's hang on sym scsi
> > > >>
> > > >> bus scan.
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>
> > > >> Whats the problem with it, or how can I fix this?
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>
> > > >> I attach the output from minicom with 2.6.29, 2.6.26, and the working
> > > >>
> > > >> 2.6.24 kernel booting.
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>
> > > >> Thank you very much!
> > > >>
> > > >>
> > > >>   
> > > >
> > > >
> > > 
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
