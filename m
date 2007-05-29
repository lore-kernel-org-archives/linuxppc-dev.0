Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6511BDDFFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 03:52:37 +1000 (EST)
Message-ID: <465C6596.4030208@ovro.caltech.edu>
Date: Tue, 29 May 2007 10:40:38 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: pcimsg patch from eons ago
References: <fa686aa40705282240p936fda6wdd838b8e33977ab3@mail.gmail.com>
In-Reply-To: <fa686aa40705282240p936fda6wdd838b8e33977ab3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Adrian,
> 
> Way back in the 2.2 timeframe, you had modified the ARM pcimsg patch
> to port it to PPC and add features.
> 
> http://www.cs.helsinki.fi/linux/linux-kernel/2001-07/0572.html
> 
> I'd really like to take a look at it.  I've been unable to find the
> patch archived anywhere online in my searching.  Do you still have a
> copy of it tucked away anywhere?
> 

Hey Grant,

TCP/IP over PCI is also something I want to look into.
I'll have about 8 compact PCI crates, with 15 MPC8349E boards
in each that I will boot with U-Boot, and then TFTP a kernel,
and then NFS mounted filesystem on. I'll put ethernet on
the front-panels for the prototype boards, but ideally
I want TCP/IP over PCI for the final system.

The board support package for the Freescale MPC8349E-MDS-PB
has some sort of support for this, but I haven't had a look
at the code yet.

I'm pretty sure Dan Malek had written something similar for
TCP/IP over RapidIO. Take a look in the kernel source,
I forget the name ... I have some notes around here somewhere ...

I'm working on hardware at the moment, so my software
brain cells are lying dormant. Let me know if you want
me to dig up the Freescale stuff and I'll send it to you,
or send you a link to a copy of the ISO. Downloading the
BSP from Freescale's site is a nightmare. I can also
plug the MDS board in as a peripheral and fire up their
TCP/IP over PCI and see what works.

It really shouldn't be too much trouble to get working.
I started by looking at the PLIP code just to see what
that took, and its pretty short. The most work would
be in defining infrastructure to make adding DMA of
data between the host CPU and the peripherals flexible.
Most (all?) x86 hosts don't have DMA, so both write and
read would be handled by the peripheral board. However,
for PPC hosts with DMA, then writes should be handled
by the respective boards ... I'm not sure what the
easiest way to deal with that would be.

Feel free to start a discussion on this :)

Cheers,
Dave
