Message-ID: <403FB112.3060101@embeddededge.com>
Date: Fri, 27 Feb 2004 16:05:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Bob Beck <beck@assurtech.com>
Cc: mgroeger@sysgo.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ADS860 - unable to load kernel- Bad magic number
References: <Iq959772845498.03218@webmail1.inner-21cn.com>	 <1077816291.4242.6.camel@budweiser>	 <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>	 <1077834132.4625.2.camel@budweiser>	 <Pine.LNX.4.56.0402271825410.24183@mag.sysgo.com>	 <1077835127.4625.5.camel@budweiser>  <403F9B5C.7010707@embeddededge.com> <1077845555.4625.15.camel@budweiser>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Beck wrote:

> Does this mean I should put zImage.embedded into 1 place in memory,
> vmlinux.gz into a different place in memory and jump to the start of
> zImage.embedded ?

No.  zImage.embedded contains everything.

objcopy -O binary zImage.embedded zImage.bin
load zImage.bin at a high address like 4MB or above.
Jump to the first location.

You will have to update some of the files in arch/ppc/boot/simple
to create a configuration descriptor for your board.  There are
plenty of examples to copy.

> Currently, we are not using U-Boot. We load the binaries into RAM
> using a hand rolled program and jump to 0x10000.

That's guaranteed not to work.  Something has to initialize the
environment before the Linux kernel starts running.  This is
accomplished by the boot roms (u-boot is good for this), or the
bootloader wrappers in the arch/ppc/boot directories.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
