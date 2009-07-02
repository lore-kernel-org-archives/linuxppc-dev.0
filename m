Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-fx0-f205.google.com (mail-fx0-f205.google.com
	[209.85.220.205])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 78E03B713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 17:10:15 +1000 (EST)
Received: by fxm1 with SMTP id 1so1443690fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jul 2009 00:10:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
Date: Thu, 2 Jul 2009 09:10:11 +0200
Message-ID: <1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 1, 2009 at 10:14 PM, Mikhail
Zaturenskiy<mzaturenskiy.st@gmail.com> wrote:
>> Hi Mikhail,
>> Try setting CONFIG_EXT2_FS=y, then recompile your kernel and reboot.
>
> Hi Frank, just tried that but still getting the same "Unpacking
> initramfs... failed!" output
>

Hmm... according to "Kernel command line: console=ttyCPM0,9600n8
loglevel=7" you haven't
specified where root is. Add root=/dev/ram to the kernel command line,
and specify where the
init process is located (for instance init=/sbin/init).

I haven't tried Denks ramdisk image. You can create one for yourself
using dd, gzip and U-Boots
mkimage tool. If the ramdisk image is larger than 4MB, you must either
change the default
CONFIG_BLK_DEV_RAM_SIZE=4096, or set ramdisk size in the kernel command line.

Btw, I use an older kernel than you use, but I have these defined:
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096

Maybe they're obsolete now, but you can try to add them to your defconfig file.

Good luck ;-)

- Frank
