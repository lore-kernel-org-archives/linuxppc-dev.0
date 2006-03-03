Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28871679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 16:11:13 +1100 (EST)
Message-ID: <4407CFD3.4060206@ovro.caltech.edu>
Date: Thu, 02 Mar 2006 21:10:43 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: rtos <rtos123@gmail.com>
Subject: Re: Linux on PPC
References: <190edfbd0603021801g5505cab9h8e285fdc7bf476d1@mail.gmail.com>
In-Reply-To: <190edfbd0603021801g5505cab9h8e285fdc7bf476d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hiya,

I'm no expert in this, but here's the basics;

> We have a customized board running on IBM PPC 750. The customer boot 
> loader is provided by the vendor. Also, the vendor has provided
> the BSP on vxworks.

The PPC 750 is a fairly old processor, so there will be Linux
support for it. For example, I picked up a couple of Artesyn
PrPMC boards that contain a PPC 750, and this board can run
Linux, though I have not had time to try booting it yet.

If the vendor provided the VxWorks BSP, then hopefully they
also provided you with the physical memory map of the board.
This is what you really need to get another bootloader (eg. U-Boot)
and Linux up-and-running. If the vendor will provide schematics
for the board, that would also help (hey, it never hurts to
ask for them).

> We are planning to use linux on this processor. What are the steps 
> involved in booting the board with linux.
> Which linux to be used and what are the procedures involved. I dint come 
> across a documents which had these details.
>  
> I am new to the linux front. So any help is highly appreciated.
>  

Step 1. Get the memory map of the board.

Step 2. Find a PPC 750 port in the Linux source.

      For example, in the 2.6 series kernel, the place to start
      looking is under arch/ppc/platforms. grep -Ie 750 shows
      up some of the PPC 750 based systems.

      chestnut.c 750FX/GX evaluation board
      katana.c   Looks like one too
      prpmc750.c Looks like a Motorola board

      Look at the comments in the code, look at the memory map
      of the reference board versus your custom board. There is
      a very good chance that the custom board is based on a
      reference design - thats the whole point of them.

Step 3. Build a minimal kernel

Step 4. Boot

Step 5. Purchase a BDI2000 JTAG debugger and use it to figure
         out why Step 4 didn't work.

         Repeat at Step 3.

When I get time to play with my Artesyn board, I'll go back to
the katana.c file, the grep above had some comments about Artesyn
boards. If it fails to boot, I'll use the BDI2000 to see where it
dies and go from there.

Once you can boot Linux, you might decide that the custom bootloader
on the board is inflexible. The U-Boot bootloader is very nice
and will have support for other 750-based boards, it shouldn't
take too much to port that too. But first, try to get a Linux
kernel booted, even if it has a hard-wired command line.

Also take a look over on the Freescale web site, search for
'porting linux', it'll show up AN2145, AN2222, AN2579, and
a bunch of other application notes. They'll give you an idea
of what it takes to port to a new processor.

 > I am new to the linux front. So any help is highly appreciated.

So it depends how much time you have versus how much you
want to spend.

There are also commercial companies that will do the job for you.
If you can come up with the memory map and hardware details of
the board, you could always post a request on this list, and
I am sure there are people reading this list that would
respond. (I'm not one of them though, so I'm not trying to
drum up business ok)

Regards,
Dave
