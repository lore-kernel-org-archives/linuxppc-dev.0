Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 13BE2B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 23:54:23 +1000 (EST)
Message-ID: <4A4CBC0C.1040001@mlbassoc.com>
Date: Thu, 02 Jul 2009 07:54:20 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: RAMDISK on EP88xc
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
In-Reply-To: <97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
> On Thu, Jul 2, 2009 at 2:10 AM, Frank
> Svendsbøe<frank.svendsboe@gmail.com> wrote:
>> On Wed, Jul 1, 2009 at 10:14 PM, Mikhail
>> Zaturenskiy<mzaturenskiy.st@gmail.com> wrote:
>> Hmm... according to "Kernel command line: console=ttyCPM0,9600n8
>> loglevel=7" you haven't
>> specified where root is. Add root=/dev/ram to the kernel command line,
>> and specify where the
>> init process is located (for instance init=/sbin/init).
>>
>> I haven't tried Denks ramdisk image. You can create one for yourself
>> using dd, gzip and U-Boots
>> mkimage tool. If the ramdisk image is larger than 4MB, you must either
>> change the default
>> CONFIG_BLK_DEV_RAM_SIZE=4096, or set ramdisk size in the kernel command line.
>>
>> Btw, I use an older kernel than you use, but I have these defined:
>> CONFIG_BLK_DEV=y
>> CONFIG_BLK_DEV_LOOP=y
>> CONFIG_BLK_DEV_RAM=y
>> CONFIG_BLK_DEV_RAM_COUNT=16
>> CONFIG_BLK_DEV_RAM_SIZE=4096
>>
>> Maybe they're obsolete now, but you can try to add them to your defconfig file.
>>
>> Good luck ;-)
>>
> 
> Thanks Frank, this seems to be leading me down the right path. I tried
> some of those defines out yesterday and they got the kernel to at
> least attempt to load the ramdisk, so I'm getting somewhere. Also
> added root=/dev/ram (also tried /dev/ram0) and init=/sbin/init but for
> now things are failing before processing those args.
> 
> I haven't tried CONFIG_BLK_DEV or CONFIG_BLK_DEV_LOOP and am still
> playing around with the values for CONFIG_BLK_DEV_RAM_COUNT and
> CONFIG_BLK_DEV_RAM_SIZE. Strangely, the DEV_RAM defines are completely
> missing from my config so I have to put them in manually... (as
> opposed to via menuconfig). I'll post back when it's working or when
> I've tried all of this and still am getting some error.

If you don't have CONFIG_BLK_DEV defined, you can't have CONFIG_BLK_DEV_RAM_COUNT
or CONFIG_BLK_DEV_RAM_SIZE.  Use 'menuconfig' to help straighten this out.

> Meanwhile a side question - why does BLK_DEV_RAM_COUNT default to 16?

This is just the number of unique RAM disk devices supported.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
