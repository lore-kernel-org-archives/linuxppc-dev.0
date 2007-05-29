Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id C558EDE1E4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 04:25:24 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so1646835nzb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 11:25:23 -0700 (PDT)
Message-ID: <fa686aa40705291125m2096b198yba60c38f048c1cbb@mail.gmail.com>
Date: Tue, 29 May 2007 12:25:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Hawkins" <dwh@ovro.caltech.edu>
Subject: Re: pcimsg patch from eons ago
In-Reply-To: <465C6596.4030208@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <fa686aa40705282240p936fda6wdd838b8e33977ab3@mail.gmail.com>
	<465C6596.4030208@ovro.caltech.edu>
Cc: Behan Webster <behanw@websterwood.com>,
	Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/29/07, David Hawkins <dwh@ovro.caltech.edu> wrote:
> Hey Grant,
>
> TCP/IP over PCI is also something I want to look into.
> I'll have about 8 compact PCI crates, with 15 MPC8349E boards
> in each that I will boot with U-Boot, and then TFTP a kernel,
> and then NFS mounted filesystem on. I'll put ethernet on
> the front-panels for the prototype boards, but ideally
> I want TCP/IP over PCI for the final system.
>
> The board support package for the Freescale MPC8349E-MDS-PB
> has some sort of support for this, but I haven't had a look
> at the code yet.

Cool,

I'm not actually going to be using PCI on this project, but it is a
shared memory system, and so I expect the bulk of the protocol could
be similar.  The system I'm working on consists of a DSP and an
MPC8349 connected via 128K of shared ram.  I need to put together a
low level protocol which will support multiple interfaces on top of
it, and I figured that the old IP-over-PCI would be good place to
start.  I need to layer console and filesystem interfaces on top to
begin with, and then additional interfaces as the product matures.

>
> I'm pretty sure Dan Malek had written something similar for
> TCP/IP over RapidIO. Take a look in the kernel source,
> I forget the name ... I have some notes around here somewhere ...

Hmm, yes I hadn't thought of looking at RapidIO.  If the low level
protocol was a straight forward message passing interface, then the
stuff on top could potentially be the same.

>
> I'm working on hardware at the moment, so my software
> brain cells are lying dormant. Let me know if you want
> me to dig up the Freescale stuff and I'll send it to you,
> or send you a link to a copy of the ISO. Downloading the
> BSP from Freescale's site is a nightmare. I can also
> plug the MDS board in as a peripheral and fire up their
> TCP/IP over PCI and see what works.

Yes, please send me whatever you have.

> It really shouldn't be too much trouble to get working.
> I started by looking at the PLIP code just to see what
> that took, and its pretty short. The most work would
> be in defining infrastructure to make adding DMA of
> data between the host CPU and the peripherals flexible.
> Most (all?) x86 hosts don't have DMA, so both write and
> read would be handled by the peripheral board. However,
> for PPC hosts with DMA, then writes should be handled
> by the respective boards ... I'm not sure what the
> easiest way to deal with that would be.
>
> Feel free to start a discussion on this :)
>
> Cheers,
> Dave
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
