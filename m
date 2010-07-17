Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF54DB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 18 Jul 2010 02:39:54 +1000 (EST)
In-Reply-To: <AANLkTilDcYYbsH-6f0_HlX9WwaOwG24w1CfhRLplZKS7@mail.gmail.com>
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
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E87551E-BD4C-4B0B-A603-908C7D9C1D5F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
Date: Sat, 17 Jul 2010 18:41:24 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <kumar.gala@freescale.com>, Mitch Bradley <wmb@firmworks.com>,
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

>>>> Yes. Where would we get a list of memreserve sections?
>>>
>>> I would say the list of reserves that are not under the control of
>>> Linux should be explicitly described in the device tree proper.  For
>>> instance, if you have a region that firmware depends on, then have a
>>> node for describing the firmware and a property stating the memory
>>> regions that it depends on.  The memreserve regions can be generated
>>> from that.
>>
>> Ok, so we could traverse the tree node-by-bode for a
>> persistent-memreserve property and add them to the /memreserve/  
>> list in
>> the kexec user space tools?
>
> I *think* that is okay, but I'd like to hear from Segher, Ben, Mitch,
> David Gibson, and other device tree experts on whether or not that
> exact property naming is a good one.

Let's take a step back: what exactly _are_ "memreserve sections", what
are they used for, who (kernel, firmware, bootloader, etc.) holds what
responsibility wrt them?


Segher
