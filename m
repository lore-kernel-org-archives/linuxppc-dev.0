Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 83926B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 14:26:30 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1E87551E-BD4C-4B0B-A603-908C7D9C1D5F@kernel.crashing.org>
Date: Sun, 18 Jul 2010 23:24:53 -0500
Message-ID: <F09F2365-3071-4DA4-9164-505F8D76CAEA@freescale.com>
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
	<1E87551E-BD4C-4B0B-A603-908C7D9C1D5F@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
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


On Jul 17, 2010, at 11:41 AM, Segher Boessenkool wrote:

>>>>> Yes. Where would we get a list of memreserve sections?
>>>>=20
>>>> I would say the list of reserves that are not under the control of
>>>> Linux should be explicitly described in the device tree proper.  =
For
>>>> instance, if you have a region that firmware depends on, then have =
a
>>>> node for describing the firmware and a property stating the memory
>>>> regions that it depends on.  The memreserve regions can be =
generated
>>>> from that.
>>>=20
>>> Ok, so we could traverse the tree node-by-bode for a
>>> persistent-memreserve property and add them to the /memreserve/ list =
in
>>> the kexec user space tools?
>>=20
>> I *think* that is okay, but I'd like to hear from Segher, Ben, Mitch,
>> David Gibson, and other device tree experts on whether or not that
>> exact property naming is a good one.
>=20
> Let's take a step back: what exactly _are_ "memreserve sections", what
> are they used for, who (kernel, firmware, bootloader, etc.) holds what
> responsibility wrt them?
>=20

On the platform I'm working on (mpc85xx) they can be the following:

1) Boot page (aka cpu-release-addr) - always present on MP
2) Flat Device Tree - always present
3) Initrd - optional

When kexec'ing a kernel, we will provide new memory regions for the flat =
device tree and the initrd (if present). However, all others will not be =
replaced by kexec and should either be tossed or preserved. The question =
is how to decide what to do... save them all by default? Save none of =
them? If we save them all at a minimum we need to remove/replace the =
device tree and initrd regions as well. So we need a way to identify =
which regions correspond to these.

Grant and I talked and though a property that lives in the device tree =
describing a persistant-memreseve might work. And Mitch talked about an =
available memory property to go along with the current one which could =
be used to determine which ranges were invalid and need a memreserve =
for...

-Matthew

>=20
> Segher
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
