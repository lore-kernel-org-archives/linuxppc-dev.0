Date: Thu, 27 Mar 2003 07:55:04 +1200
From: Rod Boyce <rod_boyce@stratexnet.com>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash File System
Message-Id: <20030327075504.1954a412.rod_boyce@stratexnet.com>
In-Reply-To: <20030326172709.74531.qmail@web41206.mail.yahoo.com>
References: <3E816D42.AD351615@lucent.com>
	<20030326172709.74531.qmail@web41206.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash,

I had exactly the same issues you are work through.  I evaluated JFFS2 for our development it was good but our board support package did not support loading a Linux kernel out of the JFFS2 partition this may have changed by now.
What you are going to have to do is partition the flash into sections.  A section for your BSP, a section for the linux kernel, and a section for the JFFS2 filesystem.
This way when you boot up copy the linux kernel into RAM and load it telling it to use the JFFS2 filesystem as its root filesystem.
Something like: root=/dev/mtd3 rw (any other parameters you want here)

I'm guessing the device node name here you are going to have to create the device node yourself and it can be called anything.

We strated out using micromon Ed Sutter has done a lot of work and it is very flexable (I really like his book a good read for beginners).  We only switched over to U-Boot because 2 years ago micromon did not support booting a Linux kernel.

I'm not sure about the licensing issues for TFS and micromon but you could create a loadable module to use the TFS file system in Linux but it has some major limitations under Linux Ed may even have something to use as a starting point.

Hope this helps a bit.

Regards,
Rod Boyce.

On Wed, 26 Mar 2003 09:27:09 -0800 (PST)
Prakash kanthi <pkanthi@yahoo.com> wrote:

>
> Hi Jaap Jan,
>
> Thanks for your reply. What do you mean by 'works out
> of the box with denx'? I see the code you referred to
> but not sure how to use it. I still have some
> concerns. Like,
>
> 1. How can i initially store the image into flash? My
> flash chip is on the board.
> 2. How can i boot linux from flash?
>
> 3. Currently i have a 32MB SDRAM along with flash. I
> have tools to download linux image into SDRAM. Even if
> i go with MTD/JFFS, my concern is unless linux runs
> flash can not be accessed and vice versa.
>
> 4. Lets say, i download linux into a safe place in
> SDRAM, boot it and then access flash thru MTD/JFFS and
> store linux image into flash. Even in this case, what
> all i need to take care of for making my flash a boot
> device.
>
> Any detailed documentation is appreciated.
>
> Thanks,
> Prakash
>
>
>
>
> --- Jaap-Jan Boor <jjboor@lucent.com> wrote:
> > Hi,
> >
> > I use strata flash with MTD and JFSS2 as file system
> > on top of it. Works out of the box with denx' eldk
> > kernel and
> > toolchain. I've provided my own flash map but you
> > can also use an existing one (look e.g. in
> > linux/drivers/mtd/maps)
> >
> > Jaap-Jan
> >
> > Wolfgang Denk wrote:
> > >
> > > In message
> > <20030326070131.88176.qmail@web41202.mail.yahoo.com>
> > you wrote:
> > > >
> > > > I have a 32MB Intel Strata flash on my PPC405
> > based
> > > > custom board. I need to create access
> > routines/APIs to
> > > > access the flash. I was thinking of creating a
> > Flash
> > > > File System and mount it as a device in Linux
> > > > environment.
> > > >
> > > > Are there any off the shelf FFS packages
> > available?
> > > > Generally, how the flash is used?
> > >
> > > Use the MTD layer.
> > >
> > > > I am working with micro-monitor to use its Tiny
> > File
> > > > System on flash support and eventually mount
> > into
> > > > linux. Did anyone use this combination before?
> > >
> > > I think you cannot do this. AFAIK the TFS code is
> > not available under
> > > a GPL compatible license which prevents it from
> > being linked with the
> > > Linux kernel code.
> > >
> > > Best regards,
> > >
> > > Wolfgang Denk
> > >
> > > --
> > > Software Engineering:  Embedded and Realtime
> > Systems,  Embedded Linux
> > > Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> >  Email: wd@denx.de
> > > There is is no reason for any individual to have a
> > computer in  their
> > > home.      -- Ken Olsen (President of Digital
> > Equipment Corporation),
> > >               Convention of the World Future
> > Society, in Boston, 1977
> > >
> >
> > --
> > J.G.J. Boor
> > Room:  BE-525
> > Lucent Technologies Nederland b.v.
> > Phone: +31 35 687 4721
> > Optical Networking Group TMS Data
> > Fax:   +31 35 687 5976
> > P.O. Box 1168, 1200 BD, Hilversum, The Netherlands
> mailto:jjboor@lucent.com
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
