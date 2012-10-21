Return-Path: <chmeeedalf@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 074F12C008D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 13:56:27 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id f13so1711040vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2012 19:56:23 -0700 (PDT)
Date: Sat, 20 Oct 2012 22:56:20 -0400
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerMac PMU programming
Message-ID: <20121020225620.19fc9258@narn.knownspace>
In-Reply-To: <1339449862.9220.13.camel@pasglop>
References: <20120610092932.38857c77@narn.knownspace>
 <1339369393.24838.101.camel@pasglop>
 <20120610233127.1284fec0@narn.knownspace>
 <1339449862.9220.13.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Looking at this again, so bringing up this thread, although it is 4
months old.

On Tue, 12 Jun 2012 07:24:22 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2012-06-10 at 23:31 -0400, Justin Hibbits wrote:
>=20
> > I'll settle on just getting the CPU speed change working, losing
> > 333MHz on my TiBook is a few too many MHz for the poor thing to
> > lose :)  I do have a desktop, but that's my development platform,
> > so needs to be at least somewhat stable, so my TiBook is my guinea
> > pig.
> >=20
> > I've googled everything I can think of, but do you know of any
> > definitive PMU documentation?  Or can you give me any hints on
> > what's needed just for that simple operation?
>=20
> No doco no, Darwin and Linux source code are your best bet.
>=20
> It works like sleep as in: you send the switch command and the PMU
> will reboot the processor with the new frequency whenever the
> processor enters NAP mode.
>=20
> This is tricky because there's a loss of cache coherency vs. ongoing
> DMAs, hence tricky bits of code in there to deal with the various
> caches.
>=20
> > I noticed that you wind down the ADB queue before killing the PMU.
> > Is this necessary?  I only disable the interrupt by writing 0x10 to
> > the IER, but our interrupt model for the PMU is different from the
> > Linux one.=20
>=20
> Well that will not disable CB1 (or the external GPIO one). You need to
> make sure no other communication with the PMU takes place once you've
> sent the sleep command and until you're back.
>=20
> >  Is it also necessary to disable the interrupt input, even though
> > the register write should be disabling the PMU's asserting of the
> > line?  There doesn't seem to be much more different than that, and
> > setting the openpic priority, Linux sets it to 0x0f but I didn't see
> > anything in OS X doing that (might that be a problem, too?)
> >=20
> > I would love to get my TiBook using the full 1GHz.
>=20
> I don't remember what openpic does in Darwin, I think interrupts are
> all masked there as a side effect of the code in KeyLargo.cpp but I'm
> not sure that applies to frequency changes.
>=20
> Cheers,
> Ben.

=46rom looking at the Linux PMU source, and the FreeBSD source, I can see
only cosmetic differences.  However, the biggest thing I see between
the Linux PPC code and the FreeBSD code is that Linux quiesces Open
Firmware right away.  I haven't tried this with FreeBSD yet, but from
your experience with development on this platform, would you think that
not quiescing OFW might cause the catatonic state?

- Justin
