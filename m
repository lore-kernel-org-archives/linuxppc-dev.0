Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id C88661007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 04:25:33 +1100 (EST)
Received: by ywh39 with SMTP id 39so3464875ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 09:25:30 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <2ed32732-d2a2-42d3-89ef-80c5a25025ba@SG2EHSMHS007.ehs.local>
References: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com>
	<56a3f016-525a-4eb2-9a0f-1477ea2eee91@VA3EHSMHS019.ehs.local>
	<8B957E110B62714A84290A01A597805F05D2AE38@Exchange.discretix.com>
	<2ed32732-d2a2-42d3-89ef-80c5a25025ba@SG2EHSMHS007.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 10:25:08 -0700
Message-ID: <fa686aa40911200925g45f12e48w42eff098720164c6@mail.gmail.com>
Subject: Re: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Linn <linnj@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 10:32 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>> Of course, one obvious thing that must be done is move this code out
> of
>> arch/powerpc/platforms/44x/virtex.c and into (e.g.)
>> arch/powerpc/kernel/setup-common.c, and add some
>> "set_machine_restart_function" wrapper to access it more cleanly (also
>> defining this function as a null function when inapplicable). =A0If this
>> satisfies your standards, I can easily post an updated patch :)
>
> The driver isn't even powerpc specific, it could also be used on the
> microblaze,
> and I think you'll find alot of resistance to adding that kind of hook
> to an architecture
> that has just spent a bunch of time getting rid of alot of direct
> binding between
> platform code and drivers. =A0Grant, do you have a comment here?

Sorry for the delay, I was at a conference and got behind on email.
Yes, I've got comments.

First, the practical matter is that this is only applicable as a reset
mechanism for Xilinx PowerPC (440 or 405) and Microblaze platforms,
but the sysace device also appears on other boards, and is used to
reconfigure FPGA's that don't reset the whole system.  One of the AMCC
boards for example.

So, you want the ability to have the driver reset the system, but you
cannot break other platforms.  You also cannot call out to the driver
from platform code because the xsysace driver may get loaded as a
module.

The cleanest solution would be to call out to the xsysace driver from
platform code; but as already stated that isn't possible because the
xsysace driver may be loaded as a module.  The only way I can think of
to do that cleanly would be to register a bus notifier from platform
code to wait for an xsysace device to get probed.  But still not
exactly pretty.

For the time being, I don't think there is a good way to avoid
architecture specific hooks into the driver itself.  I recommend
adding a new pair of functions to the driver (protected by #if
defined(CONFIG_PPC)) that looks for a 'xlnx,can-reset-system'
property.  It the property is present, then simply replace the
ppc_md.restart hook in the machine definition.  Make sure to also
restore it again when the driver is removed.  Similar code would be
needed for Microblaze too, but someone else can write that.

It is important to trigger the behaviour on whether or not a property
like 'xlnx,can-restart-system' is present so that it can be chosen at
runtime whether or not the sysace should actually be used for restart
so that it doesn't break things for multiplatform.

Also, you need to add documentation about the new property to
Documentation/powerpc/dts-bindings/ before I will merge the change.
The documentation change can appear in the same patch.

It may not be the prettiest thing in the world, but in the absence of
a cross-architecture machine restart infrastructure I think it is the
best option.  At the very least it contains the changes to the driver
itself.

Cheers,
g.
