Message-ID: <3B61C6AA.9030400@brocade.com>
Date: Fri, 27 Jul 2001 12:53:14 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/ram0
References: <3B607757.6D4BFE4A@seranoa.com> <01072616453702.25105@sarge> <3B608CA5.2A774BD9@seranoa.com> <3B60D970.7080201@brocade.com> <3B616383.E539C269@seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Interesting, try the following,
Don't specify root= anywhere including kernel cmdline

in your initrd, ensure thet there is a symlink /linuxrc to /bin/sh(or
equivalent).

Amit

Andrew Dixon wrote:

> Amit D Chaudhary wrote:
>
>>Hi,
>>
>>Can you give the following details,
>>Are you trying to load it as initrd? Not I assume, else confirm that
>>CONFIG_BLK_DEV_INITRD=y
>>
>
> I am trying to load it as initrd.
>
> andrew.dixon@pig2:/usr/src/linux$ cat .config |grep
> CONFIG_BLK_DEV_INITRD
> CONFIG_BLK_DEV_INITRD=y
>
> And this is set up correctly in the kernel.  Just to make sure that my
> configuration was a workable solution I recompiled everything for an i86
> architecture and I tried it out on my laptop.  I put my compressed
> ramdisk image and kernel onto a floppy and used ldlinux.sys as a boot
> loader passing it the command:
>
> 	root=/dev/ram0 initrd=fs.gz
>
> and it works fine.  This prompted me to do a little searching through
> the ramdisk source (/usr/src/linux/drivers/block/rd.c) and I found that
> the ramdisk expects to find the ramdisk image on the floppy drive:
>
> 	if (MAJOR(ROOT_DEV) != FLOPPY_MAJOR
> #ifdef CONFIG_BLK_DEV_INITRD
> 		&& MAJOR(real_root_dev) != FLOPPY_MAJOR
> #endif
> 	)
> 	  //ADD
> 	  //we don't want to return here because our real_root_dev is not the
> 	  //floppy but the disk or flash device.  Right?  Right!
> 	  //		return;
>
>
> It still doesn't work but I've got that feeling that I'm getting
> closer.  I'm going to make sure that the hard disk is detected before
> the ramdisk tries to load the image
>
> later,
> Andy
>
> P.S. Do people on the list like to be cc'd on responses or should I keep
> all mail to the list only?
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
