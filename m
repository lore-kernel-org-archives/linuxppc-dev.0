Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (sg2ehsobe001.messaging.microsoft.com
	[207.46.51.75]) by ozlabs.org (Postfix) with ESMTP id DB8D8B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 09:12:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: Bug in drivers/serial/of_serial.c?
Date: Fri, 20 Nov 2009 15:11:48 -0700
In-Reply-To: <fa686aa40911201358n5e5eb871wbfa523bfc9adb59d@mail.gmail.com>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
	<200911191833.08254.arnd@arndb.de>
	<a1cde516-ea22-4411-bae1-74878f6bee43@SG2EHSMHS002.ehs.local>
	<fa686aa40911201358n5e5eb871wbfa523bfc9adb59d@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Stephen Neuendorffer" <stephenn@xilinx.com>
Message-ID: <e846a32c-5f37-4531-b23d-17c60d8b6449@SG2EHSMHS010.ehs.local>
Cc: Alon Ziv <alonz@discretix.com>, linuxppc-dev@lists.ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Friday, November 20, 2009 2:58 PM
> To: Stephen Neuendorffer
> Cc: Arnd Bergmann; John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Bug in drivers/serial/of_serial.c?
> =

> On Thu, Nov 19, 2009 at 10:42 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.or=
g
> > [mailto:linuxppc-dev-
> >> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Arn=
d
> > Bergmann
> >> Sent: Thursday, November 19, 2009 9:33 AM
> >> To: Stephen Neuendorffer
> >> Cc: John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: Bug in drivers/serial/of_serial.c?
> >>
> >> On Thursday 19 November 2009, Stephen Neuendorffer wrote:
> >> > If the problem is in the device trees that are being generated, we
> >> > should fix the issue there.
> >> > We've been trying to avoid putting the fully specified IP versions
> > in
> >> > the kernel like this, since
> >> > the IP changes so often.
> >>
> >> No, the problem that Alon has is that the firmware currently has no
> >> way whatsoever to give a correct device tree, because of-serial.c
> >> does not even know about ns16550a.
> >>
> >> The patch adds both a special-case for the specific uart he
> >> is using so that one is grandfathered in and a new compatible
> >> value so future boards can specify both ns16550a and ns16550.
> >
> > That's true... =A0The 16550a line still needs to get added, but not the=

> > xlnx-
> > specific line.
> =

> The xlnx- line should be added and is entirely appropriate for exactly
> the reason Arnd stated.

I'm just wanting to make sure I'm on the same page...

It seems like you're saying that adding this line fixes the system before a=
ny device tree generator fix, for existing systems, true?

If that's true, how do you know that the 16550 in the xilinx system is not =
a 16450 as that's the default?

Right now we're not generating the ns16450 as we should be when there are n=
o FIFOs.  Since we've been using 16550 and not 16550A it probably hasn't be=
en a problem.

-- John


> =

> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
