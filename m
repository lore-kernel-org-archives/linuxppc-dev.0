Date: Thu, 21 Nov 2002 11:17:51 -0800
From: Dennis Khoo <dkhoo@atmxdsl.com>
Subject: Re: Cramfs root file system
To: Flavio Pereira <flavio.pereira@za.flextronics.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Message-id: <001601c29192$afb08870$7ec7c7c7@dkhoo>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <7899847F7C05BE43A0687AD18D97DA2207F285@srv_mail.azisa.co.za>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Flavio,

> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00
>
> Now, is it possible to do what Im trying to do, if so are there any
> suggestions as to what I'm doing wrong?
>

I saw the same error when I was trying to mount jffs2 as root.  Maybe your
problem is similar to mine.

My solution:

1)   in kernel file init/main.c 's dev_name_struct,  add entry for
 "mtdblock", 0x1f00
if it's not there already.

2) in ppcboot =>setenv bootargs init=/linuxrc root=/dev/mtdblockx

Hope this helps.

Dennis Khoo
Software Engineer
Adapcom, Inc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
