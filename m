Return-Path: <vincitoreg@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 63987DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 02:31:03 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2962364rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Dec 2007 07:31:01 -0800 (PST)
Message-ID: <d3ef3b090712300731i24402bbexe38071f7d0e74a6a@mail.gmail.com>
Date: Sun, 30 Dec 2007 07:31:01 -0800
From: Vincitore <vincitoreg@gmail.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: How can I support 2GB of memory in Linux kernel on 440SPe
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03C7D08F@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d3ef3b090712280559s121d9368nc7bc0edafe2d20f4@mail.gmail.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03C7D08F@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rune,

I tried what you suggested. With no luck.

I enabled CONFIG_HIGHMEM=y

Now I panic when  when unpacking_rootfs.

...
Memory: 2076148k available (2160k kernel code, 764k data, 144k init,
1048572k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...Oops: kernel access of bad area, sig: 11 [#1]
NIP: A02A9618 LR: A02A9598 CTR: A002EAE8
REGS: dfc01e60 TRAP: 0300   Not tainted  (2.6.19.2)
MSR: 00029000 <EE,ME>  CR: 24000084  XER: 00000000
DAR: 1FDEA000, DSISR: 00000000
TASK = a13e4ba0[1] 'swapper' THREAD: dfc00000
GPR00: 00000000 DFC01F10 A13E4BA0 DFC10000 000000D0 00000001 2D89B700 A02C0000
GPR08: DFC01D18 A02C0000 00000000 A02C3F78 24000084 70000000 A02D0000 00000000
GPR16: 00000001 00800000 7FFFF0FC 00000000 A02C0000 A02C0000 7FFEE61C 00000001
GPR24: 00000000 007FFE70 00000D80 00184F9D 1FDEA000 A02D0000 A00012F8 A02D0000
NIP [A02A9618] unpack_to_rootfs+0xdc/0xa54
LR [A02A9598] unpack_to_rootfs+0x5c/0xa54
Call Trace:
[DFC01F10] [A02A9598] unpack_to_rootfs+0x5c/0xa54 (unreliable)
[DFC01F60] [A02AA050] populate_rootfs+0x7c/0x104
[DFC01F80] [A0001328] init+0x30/0x2a4
[DFC01FF0] [A00047E0] kernel_thread+0x44/0x60
Instruction dump:
912b0000 3ce0a02c 3d20a02c 914b0004 90074038 90093f8c 3ce0a02c 80074038
2f800000 409e0054 2f9b0000 419e004c <881c0000> 39753f78 2f800030 82cb0000

This is the same if I have CONFIG_HIGHMEM disabled. The only
difference is highmem now shows up as 0k.

Memory: 2076148k available (2160k kernel code, 764k data, 144k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...Oops: kernel access of bad area, sig: 11 [#1]
...


Vincitore

On 12/28/07, Rune Torgersen <runet@innovsys.com> wrote:
> > From: linuxppc-embedded-bounces+runet=innovsys.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+runet=innovsys.com@ozlabs.or
> > g] On Behalf Of Vincitore
> > Sent: Friday, December 28, 2007 8:00 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: How can I support 2GB of memory in Linux kernel on 440SPe
> >
> > Hi,
> >
> > I need to support 2GB of memory on a custom 440SPe board.
> >
> > I see to support 1GB of memory on the 440SPe yucca board the following
> > configuration changes were done.
>
> Just leave the configuration for 1 GB, and enable CONFIG_HIGHMEM
> That gives you 2 (or more) GB of RAM, with 1G as lowmwm.
>
