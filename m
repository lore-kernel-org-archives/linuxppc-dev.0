Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2E9B2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 18:47:10 +1000 (EST)
Received: from mail147-ch1 (localhost [127.0.0.1])	by
 mail147-ch1-R.bigfish.com (Postfix) with ESMTP id E37DC360220	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 08:47:05 +0000 (UTC)
Received: from CH1EHSMHS001.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.228])	by mail147-ch1.bigfish.com (Postfix) with ESMTP id
 8C6772C00A7	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 08:47:03
 +0000 (UTC)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 10 Aug 2012 08:47:02 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A52814@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
 <50213342.8020600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A518E4@039-SN1MPN1-002.039d.mgd.msft.net>
 <50228CA5.801@freescale.com>
 <3F366E73-1EED-4DFE-85B3-F37BCCFFFFB5@freescale.com>
In-Reply-To: <3F366E73-1EED-4DFE-85B3-F37BCCFFFFB5@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Gala Kumar-B11780
> Sent: Thursday, August 09, 2012 3:04 AM
> To: Wood Scott-B07421
> Cc: Jia Hongtao-B38951; Wood Scott-B07421; Li Yang-R58472; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
> >>>>>>> As I explained before, this has to be done globally, not from
> >>>>>>> the probe function, so we can assign a default primary bus if
> >>>>>>> there
> >>> isn't any ISA.
> >>>>>>> There are bugs in the Linux PPC PCI code relating to not having
> >>>>>>> any primary bus.
> >>>>>>>
> >>>>>>> -Scott
> >>>>>>
> >>>>>> In my way of searching ISA you can also assign a default primary
> >>>>>> bus in board specific files.
> >>>>>
> >>>>> That was meant for when the board file had an alternate way of
> >>>>> searching for the primary bus (e.g. look for i8259), not as a
> >>>>> replacement for the mechanism that guarantees there's a primary bus=
.
> >>>>>
> >>>>> You are causing a regression in the qemu_e500.c platform.
> >>>>
> >>>> Can we fix the qemu device tree to address the problem if we do
> >>>> make it a rule to use the ISA node to indicate the primary bus?
> >>>
> >>> No.  There is no ISA, and we're not going to lie and say there is.
> >>
> >> But we can assign a default primary for qemu.
> >
> > Not in the device tree.  What other mechanism do you propose?  And why
> > do you want to fix it only for QEMU and not other boards, where things
> > happen to work but not as designed?
> >
> > Kumar, can you speak up here as maintainer so we can stop going back
> > and forth endlessly?
>=20
> I'd rather we stick with the code that works for this purpose at this
> point.  That would be Scott's current upstream code.  Lets get the other
> aspects of this patchset closed (SWIOTLB, conversion to platform driver,
> PM, etc.).  The primary bus code Scott wrote does NOT need to change at
> this point.
>=20
> - k


I just submitted a new version of PCI patch in which I improve the primary =
part.
The reasons I want to change the way of primary assignment listed below:

1. This approach is functionally equivalent to the Scott's code. In my appr=
oach
there might be no primary assigned but it fixed by "quick fix" introduced b=
y Ben.
Please refer to this link:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html

2. Scott's and my way could not handle the situation that "the primary is n=
ot the
first PCI bus detected". I found that only ge_imp3a got this problem so I f=
ixed it
by adding ISA node to its device tree. By adding this I think the solution =
is
logically completed.

3. The key advantage of my way is better unified for platform driver. If I =
use
the Scott's way I have to make an routine and called in all boards code. Th=
e goal
of my PCI patch is unifying all PCI initialization code and obviously prima=
ry
determination is part of PCI code.

4. The other advantage is efficiency. All my search for ISA node is just un=
der
PCI node instead of all device tree.

- Hongtao.
