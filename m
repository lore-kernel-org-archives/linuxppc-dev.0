Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B478CB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 15:44:59 +1000 (EST)
Message-ID: <4C3FF1C8.4070309@firmworks.com>
Date: Thu, 15 Jul 2010 19:44:40 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via 	proc
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
	<1279211961.31679.11.camel@localhost>
	<AANLkTikCDvsrWvtfhpEE0A78Nt3UUT-rzSwPk5nnN95s@mail.gmail.com>
	<1279216999.31679.26.camel@localhost>
	<AANLkTinUBPRsiKMd46EK6_9BBRYwB3jsfg49W9uKEbw-@mail.gmail.com>
	<1279220310.19363.19.camel@localhost>
	<AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
In-Reply-To: <AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kumar Gala <kumar.gala@freescale.com>,
	Matthew McClintock <msm@freescale.com>,
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

Grant Likely wrote:
> On Thu, Jul 15, 2010 at 12:58 PM, Matthew McClintock <msm@freescale.com> wrote:
>   
>> On Thu, 2010-07-15 at 12:37 -0600, Grant Likely wrote:
>>     
>>> On Thu, Jul 15, 2010 at 12:03 PM, Matthew McClintock <msm@freescale.com> wrote:
>>>       
>>>> Yes. Where would we get a list of memreserve sections?
>>>>         
>>> I would say the list of reserves that are not under the control of
>>> Linux should be explicitly described in the device tree proper.  For
>>> instance, if you have a region that firmware depends on, then have a
>>> node for describing the firmware and a property stating the memory
>>> regions that it depends on.  The memreserve regions can be generated
>>> from that.
>>>       
>> Ok, so we could traverse the tree node-by-bode for a
>> persistent-memreserve property and add them to the /memreserve/ list in
>> the kexec user space tools?
>>     
>
> I *think* that is okay, but I'd like to hear from Segher, Ben, Mitch,
> David Gibson, and other device tree experts on whether or not that
> exact property naming is a good one.
>   

In the /memory node, the "reg" property specifies all of memory and the 
"available" property specifies those portions that the OS is permitted 
to use.  Subtracting "available" from "reg" gives you the regions that 
are used for other purposes, such as frame buffers or firmware needs.

Often the OS can just look at "available", as it typically wants to know 
what it can use, not what it can't.

The full size as given by "reg" is useful for system configuration 
reporting purposes - the user thinks he bought 2G of memory, so it's 
good to report that 2G is indeed installed in the system.  (As an aside, 
when I first invented Open Boot, 16M was a typical memory size.  I'm 
rather gratified that the overall device tree design has held up 
reasonably well over the scale factors that have happened since then.)

It would be possible to mark the "used" regions with a finer-grained 
distinction than "they are unavailable to the OS", but that quickly gets 
into the diminishing returns realm - a lot of trouble for fairly small 
incremental value. The PC BIOS "E820" memory description scheme has a 
few extra categories of memory.  The one category that seems like it 
might (just barely) be worth the effort is "temporarily used by firmware 
but reclaimable after a certain point" - but then you have to define 
rather carefully the reclamation time and conditions.

> Write up a proposed binding (you can use devicetree.org).  Post it for
> review (make sure you cc: both devicetree-discuss and linuxppc-dev, as
> well as cc'ing the people listed above.)
>
>   
>>>> Should we export
>>>> the reserve sections instead of the device tree location?
>>>>         
>>> It shouldn't really be something that the kernel is explicitly
>>> exporting because it is a characteristic of the board design.  It is
>>> something that belongs in the tree-proper.  ie. when you extract the
>>> tree you have data telling what the region is, and why it is reserved.
>>>       
>> Agreed.
>>
>>     
>>>> We just need a
>>>> way to preserve what was there at boot to pass to the new kernel.
>>>>         
>>> Yet there is no differentiation between the board-dictated memory
>>> reserves and the things that U-Boot/Linux made an arbitrary decision
>>> on.  The solution should focus not on "can I throw this one away?" but
>>> rather "Is this one I should keep?"  :-)  A subtle difference, I know,
>>> but it changes the way you approach the solution.
>>>       
>> Fair enough. I think the above solution will work nicely, and I can
>> start implementing something if you agree - if I interpreted your idea
>> correctly. Although it should not require any changes to the kernel
>> proper.
>>     
>
> Correct.
>
> g.
>
>
>   
