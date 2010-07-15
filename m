Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id D3360B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 05:18:43 +1000 (EST)
Received: by iwn39 with SMTP id 39so1325165iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 12:18:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279220310.19363.19.camel@localhost>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279211961.31679.11.camel@localhost>
	<AANLkTikCDvsrWvtfhpEE0A78Nt3UUT-rzSwPk5nnN95s@mail.gmail.com>
	<1279216999.31679.26.camel@localhost>
	<AANLkTinUBPRsiKMd46EK6_9BBRYwB3jsfg49W9uKEbw-@mail.gmail.com>
	<1279220310.19363.19.camel@localhost>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Jul 2010 13:18:21 -0600
Message-ID: <AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kumar Gala <kumar.gala@freescale.com>, Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 15, 2010 at 12:58 PM, Matthew McClintock <msm@freescale.com> wr=
ote:
> On Thu, 2010-07-15 at 12:37 -0600, Grant Likely wrote:
>> On Thu, Jul 15, 2010 at 12:03 PM, Matthew McClintock <msm@freescale.com>=
 wrote:
>> > Yes. Where would we get a list of memreserve sections?
>>
>> I would say the list of reserves that are not under the control of
>> Linux should be explicitly described in the device tree proper. =A0For
>> instance, if you have a region that firmware depends on, then have a
>> node for describing the firmware and a property stating the memory
>> regions that it depends on. =A0The memreserve regions can be generated
>> from that.
>
> Ok, so we could traverse the tree node-by-bode for a
> persistent-memreserve property and add them to the /memreserve/ list in
> the kexec user space tools?

I *think* that is okay, but I'd like to hear from Segher, Ben, Mitch,
David Gibson, and other device tree experts on whether or not that
exact property naming is a good one.

Write up a proposed binding (you can use devicetree.org).  Post it for
review (make sure you cc: both devicetree-discuss and linuxppc-dev, as
well as cc'ing the people listed above.)

>> > Should we export
>> > the reserve sections instead of the device tree location?
>>
>> It shouldn't really be something that the kernel is explicitly
>> exporting because it is a characteristic of the board design. =A0It is
>> something that belongs in the tree-proper. =A0ie. when you extract the
>> tree you have data telling what the region is, and why it is reserved.
>
> Agreed.
>
>>
>> > We just need a
>> > way to preserve what was there at boot to pass to the new kernel.
>>
>> Yet there is no differentiation between the board-dictated memory
>> reserves and the things that U-Boot/Linux made an arbitrary decision
>> on. =A0The solution should focus not on "can I throw this one away?" but
>> rather "Is this one I should keep?" =A0:-) =A0A subtle difference, I kno=
w,
>> but it changes the way you approach the solution.
>
> Fair enough. I think the above solution will work nicely, and I can
> start implementing something if you agree - if I interpreted your idea
> correctly. Although it should not require any changes to the kernel
> proper.

Correct.

g.
