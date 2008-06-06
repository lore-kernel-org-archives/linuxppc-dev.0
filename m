Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 4CEE6DE7EE
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 02:19:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Fri, 6 Jun 2008 09:16:49 -0700
In-Reply-To: <fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com>
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
	<fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080606161932.0650C1500054@mail96-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


legacy_serial identifies a valid ns16550 on a simple-bus, but the
legacy_serial driver doesn't understand the shift and offset flags
necessary to get it to work, which results in no console.

I think the easiest solution is to change the Kconfig so that
PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done this
in my tree, but I've been swamped with other things at the moment, so I
haven't verified it.

Or is legacy_serial just legacy at this point and can go away entirely?
I got the impression from some of the earlier discussion that it wasn't
preferred, at least....

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Friday, June 06, 2008 8:29 AM
> To: Stephen Neuendorffer
> Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
linuxppc-dev@ozlabs.org; git
> Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.
> =

> On Tue, Jun 3, 2008 at 3:41 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > It appears that this turns out to interact badly with the probing of
> > PPC_UDBG_16550, which is always enabled on PPC405 (and apparently
> > found!) even though Virtex devices don't have them.
> =

> What is the symptom?
> =

> g.
> =

> >
> > Steve
> >
> >> -----Original Message-----
> >> From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
> >> Sent: Thursday, May 08, 2008 11:25 AM
> >> To: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
> > grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org
> >> Cc: Stephen Neuendorffer
> >> Subject: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.
> >>
> >> ePAPR drafts propose 'simple-bus' as a generic compatibility type
for
> >> busses which cannot be probed for devices.  In addition, the Xilinx
> >> versions of these IPs seem to be proliferating.  Hence, in the
future
> >> let's prefer to use the standard names.  I've left the old names in
> >> for short term backward compatibility for existing device trees.
> >>
> >> Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
> >> ---
> >>  arch/powerpc/platforms/40x/virtex.c |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/40x/virtex.c
> > b/arch/powerpc/platforms/40x/virtex.c
> >> index 6c72994..b1ab7b8 100644
> >> --- a/arch/powerpc/platforms/40x/virtex.c
> >> +++ b/arch/powerpc/platforms/40x/virtex.c
> >> @@ -16,6 +16,7 @@
> >>  #include <asm/xilinx_intc.h>
> >>
> >>  static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
> >> +     { .compatible =3D "simple-bus", },
> >>       { .compatible =3D "xlnx,plb-v46-1.00.a", },
> >>       { .compatible =3D "xlnx,plb-v46-1.02.a", },
> >>       { .compatible =3D "xlnx,plb-v34-1.01.a", },
> >> --
> >> 1.5.3.4
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
