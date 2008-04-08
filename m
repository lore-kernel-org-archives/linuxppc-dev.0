Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id F1356DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 00:53:06 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so460100anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Apr 2008 07:52:56 -0700 (PDT)
Message-ID: <fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
Date: Tue, 8 Apr 2008 08:52:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: Question on mpc52xx_common.c
In-Reply-To: <47FB3CD6.2090706@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com> <200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Raquel and Bill <bbrv@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 8, 2008 at 3:37 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> I'd not thank Grant.
>
>  I think the prom_init fixes are bordering on disgusting.. it would
>  make it's way into commercial code for sure, but only because nobody
>  would see what a hideous mess it is :)
>
>  The best solution by far is to release a new firmware with the
>  device tree fixed. The script method is just not tolerated by users,
>  and patching the Linux kernel to keep track with broken firmwares
>  is exactly what we hoped to AVOID with Aura in the first place.

It may be ideal, but I don't think it is realistic.  I'm now of the
firm opinion that device trees and firmware are *never* perfect.
Especially when the definition of perfect is a moving target.

There are certainly a number of things that are wrong and missing in
the Efika device tree, but in the long run it is proof that the design
of OF and the device tree is good.  The tree is unique.  Linux and
other OSes can derive the information they need.  Current Linux
drivers want data in a way slightly different from the way the Efika
offers it; some of that is Efika's fault, some of that is the driver's
fault, but OF provides the ability to massage the data and ensure the
board will boot.

As of right now; Linux support for the Efika contains only 4 distinct fixups:
1. Change device_type property of the / node from "chrp" to "efika".
Linux will run the wrong initialization code if this is "chrp"
2. change the format of the bestcomm interrupts property.  The Linux
drivers wants a list of interrupts and kind of treats the bestcomm
engine as it's own interrupt controller.  I think this was probably a
design flaw on the Linux driver, but it is what we currently have.
3. the /builtin/sound node is missing an interrupts property
4. The FEC driver wants MDIO and PHY nodes to talk to the Ethernet
Phy.  This one is big, but it is really just a single fixup.

All the other things that many not be what we *like* in the device
tree are really not serious flaws.  Mostly compatible properties are
missing any mfg prefix like 'fsl,'.  Of course, as Segher points out,
'fsl,' is better, but doesn't match recommended practice either
because UPPERCASE is supposed to be used with the prefix is the stock
ticker symbol.  See?  Device tree bindings are never perfect.  :-)
Regardless, the drivers deal with it and Linux is happy.

Cheers,
g.

>
>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>
>  Raquel and Bill wrote:
>
> > Thanks Grant.
> >
> > R&B
> >
> >
> > On Mon, Apr 7, 2008 at 9:25 PM, Grant Likely <grant.likely@secretlab.ca
> <mailto:grant.likely@secretlab.ca>> wrote:
> >
> >    On Mon, Apr 7, 2008 at 8:14 PM, Arnd Bergmann <arnd@arndb.de
> >
> >    <mailto:arnd@arndb.de>> wrote:
> >     > On Tuesday 08 April 2008, Matt Sealey wrote:
> >     >
> >     > > Grant Likely wrote:
> >     >  > >
> >     >  > > Sure, why not?  If the firmware has already set it up
> >    correctly and no
> >     >  > > devices using it are in use, then the kernel should be okay.
> >     :-)
> >     >  > > That said, I can't imagine choosing to not put the cdm node
> >    into the
> >     >  > > device tree.
> >     >  >
> >     >  > *ahem* Efika.
> >     >
> >     >  Maybe we should just give up on making the efika boot with its
> >    regular
> >     >  device tree and instead add a boot wrapper that either fixes up the
> >     >  data provided by its firmware or just adds a proper dt blob?
> >
> >    Current kernels boot the Efika without any firmware scripts.
> >    prom_init.c is able to handle the few fixups that the kernel really
> >    wants to see.  (So life is mostly happy in Efika land now.  :-)
> >
> >    Cheers,
> >    g.
> >
> >    --
> >    Grant Likely, B.Sc., P.Eng.
> >    Secret Lab Technologies Ltd.
> >    _______________________________________________
> >    Linuxppc-dev mailing list
> >    Linuxppc-dev@ozlabs.org <mailto:Linuxppc-dev@ozlabs.org>
> >
> >    https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> >
> >
> > --
> > http://bbrv.blogspot.com/
> >
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
