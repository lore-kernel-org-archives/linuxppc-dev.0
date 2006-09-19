Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 0A70567B69
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 07:27:03 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so682ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 14:27:02 -0700 (PDT)
Message-ID: <528646bc0609191427o11146c54q650738bcb10f8d98@mail.gmail.com>
Date: Tue, 19 Sep 2006 15:27:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <451055D2.5080308@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<87hcz4z47p.fsf@sleipner.barco.com>
	<528646bc0609190717u1c7cd349m7e08e5bafd341c38@mail.gmail.com>
	<528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com>
	<451055D2.5080308@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/19/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>
>  Grant Likely wrote:
>
>  Avast! After getting quizzed on IRC about this off-the-cuff comment,
> I should probably clarify. Since the Xilinx IP could be wired up to a
> ublaze core or an off-chip processor, the drivers still need to use a
> platform bus attachment to keep it all cross platform.
>
> So, replace above comment with the following:
>
> Populating the platform device with static code during initialization
> is sooo last year.
>
> Time to hack device trees to populate it instead.
>
>      So I got another X V4 board. I hacked in the Platform device stuff from
> you ml403 code with changes needed for my hardware.
>      and my brain is slowly begining to actually grasp  what is going on - I
> am begining to grasp the platform devices big picture (over a mountain
> through a spyglass in the fog)
>
>      Where do I begin with Device Trees ?

Step 1: run away
Step 2: don't look back.

Just kidding.  Unless you want to help move Virtex support from
arch/ppc to arch/powerpc, you don't really need to worry about device
trees for a while.

If you are interested, look at
Documentation/powerpc/booting-without-of.txt.  Then start poking Matt
Porter about when he's going to get 4xx ported to arch/powerpc.

I've been half heartedly looking at what needs to be done to generate
a device tree based on either system.mhs or xparameters.h.  I'm
probably going to write a tiny C program that is compiled against
xparameters.h and spits out a valid dts file.  The dts file can then
be run through the device tree compiler to produce the flattened
device tree structure.

>
>      The vague Picture I have is the have something to do with some
> datastructure that Mac's typically create at or prior to boot. And that for
> embedded systems we are building them
>      externally compiling them and then attaching the compiled device tree
> to our project.

That right.  You don't compile device base addresses, irqs, etc into
the kernel.  You pass them in at boot time with a data structure.

>
>      I got a Xilinv V4 device currently with a Pic, UartLite, TEMAC, Flash
> and Keyhole (pseuodo serial host interface). Of those it is only certain
> that the flash will always be there.
>      We have bit images with Keyhole only, Uartlite only TEMAC only,
> Sometimes we have a Pic sometimes not. I was trying to get to the point were
> I could dynamically add what was there
>      to Platform devices during initialization.
>
>      If Device trees are static, then do they even apply to what I have to
> deal with ?

Device trees don't have to be static.  They can be generated/modified
on the fly if the bootloader supports it.  Or you can pass a different
tree depending on what IP you have on the board.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
