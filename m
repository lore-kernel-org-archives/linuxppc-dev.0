Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7797AB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 23:44:07 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so632586rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jul 2009 06:44:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Thu, 2 Jul 2009 08:43:43 -0500
Message-ID: <97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
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

On Thu, Jul 2, 2009 at 2:10 AM, Frank
Svendsb=F8e<frank.svendsboe@gmail.com> wrote:
> On Wed, Jul 1, 2009 at 10:14 PM, Mikhail
> Zaturenskiy<mzaturenskiy.st@gmail.com> wrote:
> Hmm... according to "Kernel command line: console=3DttyCPM0,9600n8
> loglevel=3D7" you haven't
> specified where root is. Add root=3D/dev/ram to the kernel command line,
> and specify where the
> init process is located (for instance init=3D/sbin/init).
>
> I haven't tried Denks ramdisk image. You can create one for yourself
> using dd, gzip and U-Boots
> mkimage tool. If the ramdisk image is larger than 4MB, you must either
> change the default
> CONFIG_BLK_DEV_RAM_SIZE=3D4096, or set ramdisk size in the kernel command=
 line.
>
> Btw, I use an older kernel than you use, but I have these defined:
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
>
> Maybe they're obsolete now, but you can try to add them to your defconfig=
 file.
>
> Good luck ;-)
>

Thanks Frank, this seems to be leading me down the right path. I tried
some of those defines out yesterday and they got the kernel to at
least attempt to load the ramdisk, so I'm getting somewhere. Also
added root=3D/dev/ram (also tried /dev/ram0) and init=3D/sbin/init but for
now things are failing before processing those args.

I haven't tried CONFIG_BLK_DEV or CONFIG_BLK_DEV_LOOP and am still
playing around with the values for CONFIG_BLK_DEV_RAM_COUNT and
CONFIG_BLK_DEV_RAM_SIZE. Strangely, the DEV_RAM defines are completely
missing from my config so I have to put them in manually... (as
opposed to via menuconfig). I'll post back when it's working or when
I've tried all of this and still am getting some error.

Meanwhile a side question - why does BLK_DEV_RAM_COUNT default to 16?
