Message-ID: <014101c2bc70$dc57b610$9900010a@aztec.local>
From: "Frederic Soulier" <soulier@aztec-radiomedia.com>
To: "Prakash kanthi" <pkanthi@yahoo.com>
Cc: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
References: <20030114184236.43688.qmail@web41211.mail.yahoo.com>
Subject: Re: ramdisk mount problem
Date: Wed, 15 Jan 2003 09:33:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash,

   It seems that your kernel didn't get any information about where is your
init ramdisk.
  Which boot loader do you use ? On which board ?

  In the kernel sources, I guess your initrd_start is set to NULL, so you
have to verify in the platform_init() function (usually found in
arch/ppc/platforms/<your board>_setup.c) that you are really handling
parameters from the boot loader. This is done something like that :

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5, unsigned
long r6, unsigned long r7)
{
[...]
 if (r4) {
  initrd_start = r4 + KERNELBASE;
  initrd_end = r5 + KERNELBASE;
 }
[...]

Hope this could help,

Frederic Soulier

----- Original Message -----
From: "Prakash kanthi" <pkanthi@yahoo.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, January 14, 2003 7:42 PM
Subject: ramdisk mount problem


>
> Hi Folks,
>
> I am trying to use 2MB ramdisk image from denx as my
> linux filesystem. Linux kernel fails to mount the
> 'ext2' type file system from initrd. I pin pointed the
> problem.
>
> Looks like the problem is in 'do_mounts.c ->
> mount_block_root' function where a call is made to
> sys_mount as follows:
>
> 'int err = sys_mount(name, "/root", p, flags,
> root_mount_data);'
>
> In my case name="/dev/root", p="ext2", flags=32768 and
> root_mount_data=<NULL>.
>
> The result of this call is EINVAL, i.e. invalid
> argument. Can anyone help me out find which one of the
> arguements could be invalid? If 'root_mount_data' is
> the culprit, why is it null? I see that it's value is
> set in one of the __setup functions. When are these
> functions supposed be executed? I know that all
> __initcalls are executed from dO_initcalls.
>
> This failure causes Kernel Panic, complaing about
> "Unable to mount root fs at 01:00".
>
>
> Thanks,
> Prakash
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
