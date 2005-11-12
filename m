Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2535B68739
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Nov 2005 10:30:45 +1100 (EST)
To: "KylongMu" <mqy@263.net.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 13 Nov 2005 00:47:49 +0800."
	<20051112164751.CA6C6DBB@smtp.263.net>
Date: Sun, 13 Nov 2005 00:30:43 +0100
Sender: wd@denx.de
Message-Id: <20051112233043.25181353A2C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 11-11-05 2.6.14 on AMCC Yosemite board(boot error) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051112164751.CA6C6DBB@smtp.263.net> you wrote:
> 
> >What you show is NOT the current code.
> 
>      By update with the most recent code, I did new test, and get
> Different error message, that I can't solve it, pls check the attachment. 

...
> => tftp 4000000 ramdisk.img
...
> Bytes transferred = 8547050 (826aea hex)

That's a ramdisk image of more than 8 MB ... 

> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.14
...
> Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Sat Nov 12 23:29:30 CST 2005

And  this  is  not  the  current  code.  Current   code   is   commit
99a21389...,  and  a U-Boot image built from current code (like that
available at ftp://ftp.denx.de/pub/linux/images/amcc/yosemite/uImage)
will identify itself as "Image Name: Linux-2.6.14-g99a21389".


> Kernel command line:

And you don't pass *any* boot arguments to the kernel.

...
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

Because of not passing appropriate boot  arguments,  nor  configuring
the kernel correctly, your maximum ramdisk size is 4 MB = the default
value.

...
> RAMDISK: Compressed image found at block 0
> RAMDISK: incomplete write (-28 != 32768) 4194304
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 136k init
> attempt to access beyond end of device
> ram0: rw=0, want=32776, limit=8192

And here you see the consequences.


>      I update my source code by "cg-update" directly, after many message and
> file download it shows "full merged",
> 
> I think it is work. But the version only is 2.6.14. 

I don't know what exactly you did, but the current code  on  our  GIT
server as of now shows:

-> cg-log
commit 99a21389c2b0e55f30b6cf6550cb492b87dbaa3b
tree 417c9550fff5763f30f67a1fa041386281339b71
parent ff1df84b3c3154ffdb646941e1c70d17554e3042
author Heiko Schocher <hs@pollux.(none)> Fri, 11 Nov 2005 12:47:32 +0100
committer Heiko Schocher <hs@pollux.(none)> Fri, 11 Nov 2005 12:47:32 +0100

    [PATCH]     ppc32: fix Kernel Panic for PM82x Board with gcc-4.0.0.
        
    Signed-off-by: Heiko Schocher <hs@denx.de>
...

If you don't see commit 99a21389..., then you don't have the current code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Plan to throw one away.  You will anyway."
                              - Fred Brooks, "The Mythical Man Month"
