Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 4CDB6B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 04:37:55 +1000 (EST)
Received: by iwn39 with SMTP id 39so1290783iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 11:37:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279216999.31679.26.camel@localhost>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279211961.31679.11.camel@localhost>
	<AANLkTikCDvsrWvtfhpEE0A78Nt3UUT-rzSwPk5nnN95s@mail.gmail.com>
	<1279216999.31679.26.camel@localhost>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Jul 2010 12:37:33 -0600
Message-ID: <AANLkTinUBPRsiKMd46EK6_9BBRYwB3jsfg49W9uKEbw-@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 15, 2010 at 12:03 PM, Matthew McClintock <msm@freescale.com> wr=
ote:
> On Thu, 2010-07-15 at 10:57 -0600, Grant Likely wrote:
>> On Thu, Jul 15, 2010 at 10:39 AM, Matthew McClintock <msm@freescale.com>=
 wrote:
>> > On Thu, 2010-07-15 at 10:22 -0600, Grant Likely wrote:
>> >> > Thanks for taking a look. My first thought was to just blow away al=
l
>> >> the
>> >> > memreserve regions and start over. But, there are reserve regions
>> >> for
>> >> > other things that I might not want to blow away. For example, on
>> >> mpc85xx
>> >> > SMP systems we have an additional reserve region for our boot page.
>> >>
>> >> What is your starting point? =A0Where does the device tree (and
>> >> memreserve list) come from
>> >> that you're passing to kexec? =A0My first impression is that if you h=
ave
>> >> to scrub the memreserve list, then the source being used to
>> >> obtain the memreserves is either faulty or unsuitable to the task.
>> >
>> > I'm pulling the device tree passed in via u-boot and passing it to
>> > kexec.
>>
>> How? =A0(what mechanism?) =A0I hope you're not using the debugfs
>> flat-device-tree file.
>
> That is one way to get a good working copy. What is wrong with this
> mechanism?

It's unstable.  It is in the debugfs, so there are no guarantees that
the ABI will remain the same.  Plus it doesn't reflect any changes
that the kernel may make to the device tree.  That interface is *debug
only*.  Do not use it.

> Should we duplicate everything u-boot does in kexec to build up a flat
> device tree? Or is there another way to get a good tree?

That is one option.  U-Boot really shouldn't be modifying the tree
very much anyway (I know on some platforms U-Boot is almost creating a
tree from scratch, but that is insane and an entirely different
discussion).  /proc/device-tree always gives the kernel's current view
of the tree.  You can use dtc to extract it and write it into a dtb.

> Ideally, we
> don't make the end user manually edit a device tree.

Of course not, any device tree manipulation is the job of the kexec
tools.  None of this should be manual.  However, the data source is a
significant and important question.

>> > It is the most complete device tree and requires the least amount
>> > of fixup.
>> >
>> > I have to scrub two items, the ramdisk/initrd and the device tree
>> > because upon kexec'ing the kernel we have the ability to pass in new
>> > ramdisk/initrd and device tree. They can also live at different physic=
al
>> > addresses for the second reboot.
>>
>> This sounds like the model is backwards. =A0Rather than scrubbing items,
>> the memreserve list should be built up from a known good source.
>
> You can build one up yourself and it will still work out fine. Or you
> can pull one from debugfs to get yourself started. Or you can pull it
> every time.

What do you mean by "pull it every time"?

Out of curiosity, what is responsible for building up the memreserve
list?  The userspace portion, or the kernel portion of kexec?  Or is
it done by a totally separate program?

>> > The initrd addresses are already exposed, so we can update/remove/reus=
e
>> > that entry, we just need a way for kexec to determine the current devi=
ce
>> > tree address so it can replace the correct memreserve region for the
>> > kexec'ing kernels' device tree.
>> >
>> > The whole problem comes from repeatedly kexec'ing, we need to make sur=
e
>> > we don't keep losing blobs of memory to reserve regions (so we can't
>> > just blindly add). We also need to make sure we don't lose other
>> > memreserve regions that might be important for other things (so we can=
't
>> > just blow them all away).
>>
>> Right, so you need to have a known-good list of reserve sections.
>> Trying to go the other way sounds very fragile.
>>
>
> Yes. Where would we get a list of memreserve sections?

I would say the list of reserves that are not under the control of
Linux should be explicitly described in the device tree proper.  For
instance, if you have a region that firmware depends on, then have a
node for describing the firmware and a property stating the memory
regions that it depends on.  The memreserve regions can be generated
from that.

> Should we export
> the reserve sections instead of the device tree location?

It shouldn't really be something that the kernel is explicitly
exporting because it is a characteristic of the board design.  It is
something that belongs in the tree-proper.  ie. when you extract the
tree you have data telling what the region is, and why it is reserved.

> We just need a
> way to preserve what was there at boot to pass to the new kernel.

Yet there is no differentiation between the board-dictated memory
reserves and the things that U-Boot/Linux made an arbitrary decision
on.  The solution should focus not on "can I throw this one away?" but
rather "Is this one I should keep?"  :-)  A subtle difference, I know,
but it changes the way you approach the solution.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
