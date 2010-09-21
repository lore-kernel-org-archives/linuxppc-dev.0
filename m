Return-Path: <tanderson@curtisswright.com>
Received: from mail95.messagelabs.com (mail95.messagelabs.com [216.82.242.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail95.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 208CEB70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 07:37:22 +1000 (EST)
From: "Anderson, Trevor" <tanderson@curtisswright.com>
To: "david.hagood@gmail.com" <david.hagood@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 Sep 2010 17:37:15 -0400
Subject: RE: Questions on interrupt vector assignment on MPC8641D
Message-ID: <1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
In-Reply-To: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IRQ assignments for MPC8641D are "virtual", meaning "made up" and quite di=
fficult to determine by looking through code.
But I believe the plan goes something like this:

  IRQ
---------
    0           No interrupt
  1 - 15        External interrupts (only 1..12 would be used)
 16 - 127       Internal interrupts - see Table 9-2 of 8641D ref man,
            Add 15 to the numbers shown
128 - 255       Yours, or your BSP's, to do with as you like
256 - 511       Message Signaled Interrupts

If you look in the sample device trees for 8641 cards you'll see that
the interrupt values cited there for various devices match the 16..127
group above.



> -----Original Message-----
> From: linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.or=
g [mailto:linuxppc-dev-
> bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.org] On Behalf Of dav=
id.hagood@gmail.com
> Sent: Tuesday, September 21, 2010 7:12 AM
> To: linuxppc-dev@lists.ozlabs.org
> Subject: Questions on interrupt vector assignment on MPC8641D
>
> I'm new to developing on the PPC (most of my experience is on x86), and =
I
> have a couple of questions about mapping of interrupts on the PPC,
> specifically on the Freescale 8641D embedded CPU.
>
> 1) How does one allocate interrupt vectors for the embedded devices, suc=
h
> as the MPIC? All the kernel how-tos are really targeting the x86 and PCI=
,
> so I've been unable to find a good document on "that which is not an X86=
".
>
> 2) Are there any good guides to programming the PPC generally, and the
> MPC8641 specifically, that I can go read to answer my other questions?
>
> I'm trying to write a driver to map the 8641D's PCIe controllers *as
> endpoints* into something frobablbe from user space - to allow setting t=
he
> BARs and outbound address translation units via sysfs files, and to allo=
w
> mapping of inbound interrupts to sysfs "doorbell"-style files. If I can
> get it worked out I want to submit it back to the kernel for general
> distribution.
>
> If anybody has any insights, I'd greatly appreciate it if you'd copy my
> work email (david.hagood at aeroflex.com) as well (I am using my persona=
l
> email as work insisted upon adding a one paragraph "wart" to all outboun=
d
> email that isn't acceptable for a list like this.)
>
> Also, if anybody out there has experience with the 8641D PEX's in endpoi=
nt
> mode and wouldn't mind answering a couple of questions about programming=

> the OWBARs, I'd be greatly obliged.
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

_______________________________________________________________________
This e-mail and any files transmitted with it are proprietary and intended=
 solely for the use of the individual or entity to whom they are addressed=
. If you have reason to believe that you have received this e-mail in erro=
r, please notify the sender and destroy this email and any attached files.=
 Please note that any views or opinions presented in this e-mail are solel=
y those of=20the author and do not necessarily represent those of the Curt=
iss-Wright Corporation or any of its subsidiaries.  Documents attached her=
eto may contain technology subject to government export regulations. Recip=
ient is solely responsible for ensuring that any re-export, transfer or di=
sclosure of this information is in accordance with applicable government e=
xport regulations.  The recipient should check this e-mail and any attachm=
ents for the presence of viruses. Curtiss-Wright Corporation and its subsi=
diaries accept no liability for any damage caused by any virus transmitted=
 by this e-mail.
