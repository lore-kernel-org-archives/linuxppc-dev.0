Date: Tue, 11 Jun 2002 19:47:09 -0700
From: Matt Porter <porter@cox.net>
To: Tim Lai <laitingwai@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT setting after bootrom? and where to load elf image?
Message-ID: <20020611194709.B28767@home.com>
References: <20020611192119.48805.qmail@web21104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020611192119.48805.qmail@web21104.mail.yahoo.com>; from laitingwai@yahoo.com on Tue, Jun 11, 2002 at 12:21:19PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 11, 2002 at 12:21:19PM -0700, Tim Lai wrote:
>
> Hi, I am new to linux and trying to get some help from
> some linux experts out here. I've been reading and
> searching the mail list archive for the past few
> weeks.
> Here is what I have so far:
>
> I have a ppc750 broad with vxWorks bootrom. I do not
> have any device to reflash the broad. I read one of
> the mail archive that someone write a program to
> work with vxWorks bootrom. And this is what I want
> to do. I plan to convert the vmlinux image to asm and
> put it in the .text section of another elf file.
> Load this elf file and relocate the vmlinux image to
> 0xC000000. Is this a feasible approach?
>
> After the vxWorks bootrom come up, the BAT setting is
> phy = virt. The board has 8Meg of RAM. Knowing the
> linux kernel need to be at 0xC000000, should I change
> the BAT setting to map 7-8M to 0xC0000000, then
> copy the image to 0xC0000000?
>
> I am a little confuse about the MMU in linux. Here is
> what I understand:
> after the bootrom, the CPU MMU should be phy = virt
> after linux booted, linux MMU takes over, and kernel
> space is 0xc0000000, and user space is 0x0 to
> 0xc0000000. What happened in between? Who is
> responible for doing the mapping?

However you want to do it, get the vmlinux located
at physical 0 and set r3-r7 as documented in head.S

Read head.S and you will see that it takes care of
(with some outside calls) all core MMU init for Linux.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
