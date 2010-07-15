Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 00E3CB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 02:57:37 +1000 (EST)
Received: by iwn39 with SMTP id 39so1205788iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 09:57:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279211961.31679.11.camel@localhost>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279211961.31679.11.camel@localhost>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Jul 2010 10:57:16 -0600
Message-ID: <AANLkTikCDvsrWvtfhpEE0A78Nt3UUT-rzSwPk5nnN95s@mail.gmail.com>
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

On Thu, Jul 15, 2010 at 10:39 AM, Matthew McClintock <msm@freescale.com> wr=
ote:
> On Thu, 2010-07-15 at 10:22 -0600, Grant Likely wrote:
>> > Thanks for taking a look. My first thought was to just blow away all
>> the
>> > memreserve regions and start over. But, there are reserve regions
>> for
>> > other things that I might not want to blow away. For example, on
>> mpc85xx
>> > SMP systems we have an additional reserve region for our boot page.
>>
>> What is your starting point? =A0Where does the device tree (and
>> memreserve list) come from
>> that you're passing to kexec? =A0My first impression is that if you have
>> to scrub the memreserve list, then the source being used to
>> obtain the memreserves is either faulty or unsuitable to the task.
>
> I'm pulling the device tree passed in via u-boot and passing it to
> kexec.

How?  (what mechanism?)  I hope you're not using the debugfs
flat-device-tree file.

> It is the most complete device tree and requires the least amount
> of fixup.
>
> I have to scrub two items, the ramdisk/initrd and the device tree
> because upon kexec'ing the kernel we have the ability to pass in new
> ramdisk/initrd and device tree. They can also live at different physical
> addresses for the second reboot.

This sounds like the model is backwards.  Rather than scrubbing items,
the memreserve list should be built up from a known good source.

> The initrd addresses are already exposed, so we can update/remove/reuse
> that entry, we just need a way for kexec to determine the current device
> tree address so it can replace the correct memreserve region for the
> kexec'ing kernels' device tree.
>
> The whole problem comes from repeatedly kexec'ing, we need to make sure
> we don't keep losing blobs of memory to reserve regions (so we can't
> just blindly add). We also need to make sure we don't lose other
> memreserve regions that might be important for other things (so we can't
> just blow them all away).

Right, so you need to have a known-good list of reserve sections.
Trying to go the other way sounds very fragile.

g.


>
> -M
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
