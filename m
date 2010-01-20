Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 97A24B7CEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 13:32:17 +1100 (EST)
Received: by pwj11 with SMTP id 11so3172069pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 18:32:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100119140600.GH16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
Date: Wed, 20 Jan 2010 10:32:15 +0800
Message-ID: <cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernelnewbies <kernelnewbies@nl.linux.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>
>> On Tue, 19 Jan 2010, Johnny Hung wrote:
>>
>>> Okay, I think the steps is below if my rootfs is ramdisk and configure
>>> files in jffs2,
>>>
>>> 1. cp /etc/* /mnt/mtd/etc/ =A0 =A0(/mnt/mtd is my jffs2 fs)
>>> 2. rm -rf /etc/*
>>> 3. make symbolic links from all /etc/xx to /mnt/mtd/etc/xxx
>>> 4. remake ramdisk rootfs
>>>
>>> It seems all files in ramdisk rootfs /etc all links to /mnt/mtd/etc/
>>> and try to modify these files is effective after reboot.
>>> But is this a common way in embedded linux ?
>>

Thanks, I understand.

>> In principle, but it is easier (and cleaner) to make a symbolic link fro=
m
>> (say) /etc -> /mnt/mtd/etc without linking every individual file and
>> directory.
>
> i totally agree with ricard when you want to move the entire directory
> to jffs2 and not only some selected files
>
>> You could also use a jffs2 file system in flash for your rootfs, that wa=
y
>> you wouldn't need a ramdisk at all.
>
> i'd also recommend you to consider if you really need the
> ramdisk. when using a ram disk its entire content is loaded to the RAM
> occupying space, even if you don't use certain files (or part of
> them). other filesystems are more efficient in this aspect.
> if the main purpose is to have a read only rootfs, i'd suggest a look
> at squashfs.

I consider to use ramdisk as rootfs because worry about wrong
operation in rootfs (is use jffs2 rootfs) and it will cause system
boot up failed.
Another query, does the syslogd/klogd log files also store in jffs2
rootfs? Write to jffs2 frequently will reduce flash life cycle.

BRs, H. Johnny
>
> --
> Matthias Kaehlcke
> Embedded Linux Developer
> Barcelona
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0La posibilidad de realizar un suenyo es lo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 que hace que la vida sea interesante
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .''`.
> =A0 =A0using free software / Debian GNU/Linux | http://debian.org =A0: :'=
 =A0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0`. `'`
> gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0`-
>
