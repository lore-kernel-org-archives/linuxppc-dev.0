Return-Path: <prvs=441ccb01c=michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id D27B31A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 04:38:33 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Tue, 6 Jan 2015 17:38:29 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E2009E5@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E2009B9@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1501061144320.1602-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1501061144320.1602-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > > That is interresting, however, I have an older kernel running an=20
> > > > OHCI driver which is able to handle 4 codecs. Same usb hardware=20
> > > > (codecs and hub), but older kernel on a different CPU, with much=20
> > > > less power. This makes me believe that there's a solution to make i=
t work...
> > >=20
> > > Of course there is: Install an OHCI host controller and use it to dri=
ve your codecs.  It should work fine.

What do you mean by that? The host controller is embedded in the i.MX CPU..=
.
Changing the CPU is not really an option to me. Unless I am missing
something?

> > >=20
> > > The periodic scheduling algorithm for OHCI is very different from the=
 algorithm for EHCI.
> >=20
> > According to your knowledge, how much time would you think it takes to=
=20
> > change the EHCI driver with an OHCI one?
>
> I don't understand the question.
>
> >  And can you tell if the OHCI driver
> > will work on my hardware given that the Host controller of the i.MX512=
=20
> > is a USB2.0 host controller? (OHCI was implemented for USB 1.x from=20
> > what I
> > understand)
>
> The OHCI driver works with OHCI hardware and the EHCI driver works with E=
HCI hardware.  OHCI is USB-1.1 and EHCI is USB-2.  They are not interchange=
able.

That was what I thought first...

>
> > I tried to do so several days ago with the built-in configurator (I am=
=20
> > using "ltib"), but the configurator does not allow selecting the OHCI=20
> > driver; I tried manually but it turned into compiler errors...
>
> It looks like the configurator is smart; it won't let you select the wron=
g driver for your hardware.
>
> Alan Stern
