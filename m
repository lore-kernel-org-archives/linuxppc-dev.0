From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 11 Nov 2003 21:50:32 -0700
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031112045032.GA3411@zenos.farnsworth.org>
References: <20031110190207.GA12163@zenos.farnsworth.org> <20031112003502.BBA4CC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031112003502.BBA4CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 12, 2003 at 12:34:57AM +0000, Wolfgang Denk wrote:
> Hi Dale & Tom,
> It seems you have an older board? [8 MB flash?] Both USB and PCI have
> been tested here with a cuple of devices. They were working  fine  in
> most cases.

I do have an older board.  Hmm.  I found nowhere in your patch where
the outbound PCI window registers were initialized.  Maybe that's
taken care of by U-Boot.  If so, I'd like to remove the dependency.
I could be missing something obvious, though.  I got farther after
initializing the window regs, but still couldn't read the 5200's
PCI config space registers.

> > I haven't tested this merged code on the MGT5100, and in fact, I removed
> > the MGT5100 FEC support because the #ifdefs in fec.c were just too ugly.
>
> Ummm... but they were working. I understand that you want to clean up
> the code, but IMHO we  should  not  simply  drop  support  for  older
> hardware  if  it was working before. Some people still have (or want)
> to use the old boards.

That code is too ugly to keep around.  It was a hack that I never
intended to publish.  I'm still angry that it was passed along to
you before I had a chance to clean it up.

> > I'll insert a compatibility layer to support the MGT5100 FEC if there
> > is sufficient interest.  Is anyone still using the MGT5100?
>
> Yes, we. Some of our customers. Some of Motorola's customers.

Ok.  I'll try to get to it next week.

> Here a few general questions / remarks:
>
> * Did you actually test the code on a IceCube with MGT5100?

Kent Borg tested on a 5100-based IceCube.  I haven't seen one.
I do have a 5100-based Glacier.

> * Some files/directories have been renamed into 5xxx, others in
>   m5xxx. The same applies to the CONFIG_ options: Maybe we can make
>   this a bit more consistent?
>
>   Given the fact that we use CONFIG_6xx, CONFIG_40x, CONFIG_44x,
>   CONFIG_8xx, ... we should probably use CONFIG_5xxx instead of
>   CONFIG_M5XXX ?
>
>   We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
>   i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?
>
>   There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
>   instead of i2c-algo-m5xxx.h ?

Sounds good to me.

>   We have include/asm-ppc/mpc8xx.h and mpc8260.h and ibm4xx.h - maybe
>   we should use mpc5xxx.h instead of m5xxx.h ?

I chose m5xxx to include both mgt5xxx an mpc5xxx, but I don't feel
strongly about this.

> * Does it make sense to add a "Board uses UBoot" config option to
>   individual boards? [BTW: the name is "U-Boot".] If we do something
>   like this (which I'd appreciate) we should do it right - there
>   might be some other boards that use this, too.

Go for it.

> * In "arch/ppc/config.in" you write:
> 	...
> 	hex 'Flash Rom Size' CONFIG_M5XXX_FLASH_SIZE 0x800000
>
>   I recommend to make this 0x1000000 instead - you will probably  not
>   see new boards with 8 MB flash any more.

Thanks.

> * I think you should not overwrite arch/ppc/defconfig

Doh!  I noted that you included defconfig in your patch and I made
a mental note not to make the same mistake.  Oh well.  :-)

> Will try to run your code ASAP.

Thanks for the help, Wolfgang.

-Dale Farnsworth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
