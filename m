Return-Path: <nathanpilatzke@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 126E0679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 14:06:42 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id x3so386567nzd
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 21:06:37 -0700 (PDT)
Message-ID: <98889dd30605152106m9090ba3ga1a4c7706aace3ef@mail.gmail.com>
Date: Tue, 16 May 2006 00:06:37 -0400
From: "Nathan Pilatzke" <nathanpilatzke@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: ppc32 kernel boot problem (pmu related?)
In-Reply-To: <1147658309.21291.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
	<1147403525.7343.19.camel@localhost.localdomain>
	<98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
	<1147658309.21291.73.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here is the new log:

time_init: processor frequency =3D 700.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7,524288 bytes)
Inode-cache hash table entries: 65536 (order: 6,262144 bytes)
Memory: 643456k/655360k available (2908k kernel code, 11564k reserved,
272k data, 131k bss, 156k init)
Mount-cache hash table entries: 512
device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
NET: Registered protocol family 16

KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
 channel 1 bus <multibus>
 channel 2 bus <multibus>
PCI: Probing PCI hardware

And that's where is locks hard.  Just as an alternative I tried
compiling without i2c support, but the kernel locks hard at the exact
same point.  Compiling without the pmu code is the only way I can get
the kernel to boot.  There are some kernel messages missing from a
kernel compiled with pmu versus a kernel without pmu, namely:

On node 0 total pages: 163840
 DMA zone: 163840 pages, LIFO batch: 31

and

Calibrating delay loop... 49.79 BogoMIPS (lpj=3D99584)

but they do not seem to be anything serious.  Where to go from here?
Thanks for the debugging suggestions so far, keep them coming please.


On 5/14/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Hrm... that's pretty much when console_init() gets called, which means
> no message until the fbdev kicks in, thus we just "miss" the messages
> from there to the crash.... Can you edit arch/powerpc/kernel/udbg.c,
> there is a function called disable_early_printk() which contains a #if
> 1, turn that into #if 0 and tell me if you get a more useful log after
> the time_init thing. Thanks !
>
>
>
