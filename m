Message-ID: <36E4F691.2D2FC8BE@wanadoo.fr>
Date: Tue, 09 Mar 1999 11:23:14 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: No-IDE kernel compile link errors
References: <Pine.LNX.3.96L.990308225823.26298C-100000@unix48.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Satadru Pramanik had the same error recently:
http://lists.linuxppc.org/listarcs/linuxppc-dev/199902/msg00373.html

There was no solution posted on the list. Maybe he has one?

I suspect that you have CONFIG_PARPORT=y and this doesn't work without
some of the IDE stuff. It's certainly a bug in the config files, like so
many others.

Hollis R Blanchard wrote:
> 
> I've been having this problem recently with 2.2.2 source from kernel.org and
> now the NMT vger snapshot:
> 
> So I 'make menuconfig'. And since I have a PowerCenter (with no IDE anything),
> I turn off all IDE support, in General and Block Devices.
> 
> I get the following link error:
> arch/ppc/kernel/kernel.o: In function `find_ide_boot':
> arch/ppc/kernel/kernel.o(.text.init+0x1ca6): undefined reference to
> `pmac_ide_count'
> arch/ppc/kernel/kernel.o(.text.init+0x1caa): undefined reference to
> `pmac_ide_count'
> arch/ppc/kernel/kernel.o(.text.init+0x1cc2): undefined reference to
> `pmac_ide_node'
> arch/ppc/kernel/kernel.o(.text.init+0x1cc6): undefined reference to
> `pmac_ide_node'
> arch/ppc/kernel/kernel.o(.text.init+0x1cce): undefined reference to
> `pmac_ide_count'
> arch/ppc/kernel/kernel.o(.text.init+0x1d06): undefined reference to
> `pmac_ide_count'
> 
> Awesome. Of course it can't find those symbols - I haven't compiled (and don't
> want) any IDE stuff.
> 
> When I rerun 'make menuconfig', I find that the IDE stuff has been re-enabled
> on me. My other changes were saved, though. Examining the .config file, I find
> that CONFIG_BLK_DEV_IDE_PMAC and CONFIG_PARIDE_PARPORT are both set to y.
> 
> On a related note, I've always wondered who maintains the Makefiles for the
> kernel. Is it communal, and if so, are patches to the Makefiles submitted just
> like source patches?

I think this is a problem of some defconfig or config.in file, and these
are changed whenever a driver is introduced. It looks to me that nobody
takes them very seriously. It took years to fix the xconfig stuff. I
tried to understand it once, but it is a horrible mess of self-modifying
spaghetti code.

A quote from drivers/block/Config.in which may be relevant to your
problem:

# Paride Doesn'T Need Parport, But If Parport Is Configured As A Module,
# Paride Must Also Be A Module.  The Bogus Config_Paride_Parport Option
# Controls The Choices Given To The User ...

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
