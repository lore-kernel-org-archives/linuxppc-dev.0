To: "Dale Farnsworth" <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Nov 2003 12:02:07 MST."
             <20031110190207.GA12163@zenos.farnsworth.org>
Date: Wed, 12 Nov 2003 01:34:57 +0100
Message-Id: <20031112003502.BBA4CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dale & Tom,

in message <20031110190207.GA12163@zenos.farnsworth.org> Dale Farnsworth wrote:
>
> I have merged your code, benh's and mine and placed it at
> ftp://source.mvista.com/pub/linuxppc/mpc5200/linuxppc_2_4_devel.mpc5200.patch
>
> This patch doesn't require uboot.  I retained the uboot code and added
> CONFIG_UBOOT, but haven't tested with it.

I've been browsing the code a bit for now.  No  actual  testing  doen
yet. Please see questions below.


> I would appreciate it if you could take some time to test it with your
> hardware.  I find that USB and PCI are not working here, but they also
> fail with your patch, so it may be my icecube hardware.

It seems you have an older board? [8 MB flash?] Both USB and PCI have
been tested here with a cuple of devices. They were working  fine  in
most cases.


> I haven't tested this merged code on the MGT5100, and in fact, I removed
> the MGT5100 FEC support because the #ifdefs in fec.c were just too ugly.

Ummm... but they were working. I understand that you want to clean up
the code, but IMHO we  should  not  simply  drop  support  for  older
hardware  if  it was working before. Some people still have (or want)
to use the old boards.

> I'll insert a compatibility layer to support the MGT5100 FEC if there
> is sufficient interest.  Is anyone still using the MGT5100?

Yes, we. Some of our customers. Some of Motorola's customers.


Here a few general questions / remarks:

* Did you actually test the code on a IceCube with MGT5100?

* Some files/directories have been renamed into 5xxx, others in
  m5xxx. The same applies to the CONFIG_ options: Maybe we can make
  this a bit more consistent?

  Given the fact that we use CONFIG_6xx, CONFIG_40x, CONFIG_44x,
  CONFIG_8xx, ... we should probably use CONFIG_5xxx instead of
  CONFIG_M5XXX ?

  We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
  i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?

  There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
  instead of i2c-algo-m5xxx.h ?

  We have include/asm-ppc/mpc8xx.h and mpc8260.h and ibm4xx.h - maybe
  we should use mpc5xxx.h instead of m5xxx.h ?

* Does it make sense to add a "Board uses UBoot" config option to
  individual boards? [BTW: the name is "U-Boot".] If we do something
  like this (which I'd appreciate) we should do it right - there
  might be some other boards that use this, too.

* In "arch/ppc/config.in" you write:
	...
	hex 'Flash Rom Size' CONFIG_M5XXX_FLASH_SIZE 0x800000

  I recommend to make this 0x1000000 instead - you will probably  not
  see new boards with 8 MB flash any more.

* I think you should not overwrite arch/ppc/defconfig


Will try to run your code ASAP.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I know engineers. They love to change things.             - Dr. McCoy

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
