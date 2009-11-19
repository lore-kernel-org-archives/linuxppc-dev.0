Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id 97C77B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 04:50:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
Date: Thu, 19 Nov 2009 09:32:54 -0800
In-Reply-To: <8B957E110B62714A84290A01A597805F05D2AE38@Exchange.discretix.com>
References: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com><56a3f016-525a-4eb2-9a0f-1477ea2eee91@VA3EHSMHS019.ehs.local>
	<8B957E110B62714A84290A01A597805F05D2AE38@Exchange.discretix.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Alon Ziv" <alonz@discretix.com>,
	"linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <2ed32732-d2a2-42d3-89ef-80c5a25025ba@SG2EHSMHS007.ehs.local>
Cc: John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Alon
Ziv
> Sent: Thursday, November 19, 2009 4:57 AM
> To: Stephen Neuendorffer; linuxppc-dev
> Cc: John Linn
> Subject: RE: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
> =

> Hi,
> =

> On Monday, November 16, 2009, Stephen wrote:
> > There are at least two other ways that you might be able to reset a
> > board:
> > 1) Internally through the ICAP device.
> > 2) Through a GPIO connected externally to the reset logic.
> >
> =

> Unfortunately none of these is relevant for the specific board in
> question (Xilinx ML510 reference system)...

Well, board !=3D system. :)  ML510 could easily include an ICAP device.

> > Probably it would be best to have a mechanism in the device tree
which
> > references the reset mechanism?
> =

> I am sorely lacking in expertise for this :(, and wouldn't even know
> where to begin...  Is it possible at all to add custom information
into
> the device tree?  And even if yes--how will platform code bind to the
> reset mechanism?
> =

> > [...] In any event, you probably don't want a driver to
> > eplicitly reference the plaform code.  If you want to do it
explicitly
> > like this, it would better to have the plaform code reference the
> driver
> > mechanism.
> =

> I don't see how this can be done: if the driver is to publish some
> "driver_reset_system" function to the platform code, it needs _some_
> mechanism for telling this fact to the system...

Think of it this way: The driver is usable on many more platforms than
just
the one you've modified.  Your addition of the hook into the platform
code
requires that that hook always be there.  It would be much better to
provide a configuration-based way of allowing the platform code to
make use of the sysace reset, if it desires.

> And such a mechanism
> won't look all that different from my callback, IMO (except it may be
> slightly prettied up).

The callback isn't the problem, it's how the callback gets registered
with
the platform code/device tree.

> Of course, one obvious thing that must be done is move this code out
of
> arch/powerpc/platforms/44x/virtex.c and into (e.g.)
> arch/powerpc/kernel/setup-common.c, and add some
> "set_machine_restart_function" wrapper to access it more cleanly (also
> defining this function as a null function when inapplicable).  If this
> satisfies your standards, I can easily post an updated patch :)

The driver isn't even powerpc specific, it could also be used on the
microblaze,
and I think you'll find alot of resistance to adding that kind of hook
to an architecture
that has just spent a bunch of time getting rid of alot of direct
binding between
platform code and drivers.  Grant, do you have a comment here?

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
