Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D88E6B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 07:01:15 +1000 (EST)
Received: by bwz17 with SMTP id 17so23087bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 14:01:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
Date: Sat, 27 Jun 2009 23:01:07 +0200
Message-ID: <1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 26, 2009 at 7:12 PM, Mikhail
Zaturenskiy<mzaturenskiy.st@gmail.com> wrote:
> Hi Scott,
>
>> This isn't the denx list;
> I've noticed :) but I'm still learning about this whole process so I
> though I could get some general suggestions.
>
>> what kernel version is that, and with what
>> modifications from mainline?
> Kernel is v2.6.30, I'm not yet familiar enough with it to know what's
> been modified from mainline, just following instructions.
>
>> Note that ep88xc.dts in mainline is intended for use with PlanetCore, wh=
ich
>> is what ships on that board. =A0You may need to make modifications for i=
t to
>> work with u-boot (at the least, the IMMR base is probably different).
> Hmm, this hasn't occurred to me, thank you for pointing it out.
>

I don't have access to this board, but have experience with a similar
one (Adder 875), and
I might be able to help out. Scott's right. According to U-Boots
include/configs/EP88x.h,
CONFIG_SYS_IMMR is 0xf0000000, but the Linux the ep88xc.dts is
referring to an IMMR set
to 0xfa200000. Replace every instance of 0xfa20 with 0xf000, and it may wor=
k.

>> Also, make sure u-boot is properly updating the memory size in the devic=
e
>> tree. =A0Can you dump the post-fixup device tree in u-boot?
> Not sure, but I'll try to find out if that's possible. It'd certainly
> answer a lot of questions...
>
> Thanks,
> Mikhail Zaturenskiy
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
