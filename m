Return-Path: <johnny.hacking@gmail.com>
Received: from mail-px0-f198.google.com (mail-px0-f198.google.com
	[209.85.216.198]) by ozlabs.org (Postfix) with ESMTP id 428BEB7CB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jan 2010 14:01:47 +1100 (EST)
Received: by pxi36 with SMTP id 36so490078pxi.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 19:01:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.1001200809550.32263@lnxricardw.se.axis.com>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<Pine.LNX.4.64.1001200809550.32263@lnxricardw.se.axis.com>
Date: Fri, 22 Jan 2010 11:01:45 +0800
Message-ID: <cb9ecdfa1001211901u4384f6d4w68698aeb1cfc5cad@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernelnewbies <kernelnewbies@nl.linux.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	Matthias Kaehlcke <matthias@kaehlcke.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/20 Ricard Wanderlof <ricard.wanderlof@axis.com>:
>
> On Wed, 20 Jan 2010, Johnny Hung wrote:
>
>>> i'd also recommend you to consider if you really need the
>>> ramdisk. when using a ram disk its entire content is loaded to the RAM
>>> occupying space, even if you don't use certain files (or part of
>>> them). other filesystems are more efficient in this aspect.
>>> if the main purpose is to have a read only rootfs, i'd suggest a look
>>> at squashfs.
>>
>> I consider to use ramdisk as rootfs because worry about wrong
>> operation in rootfs (is use jffs2 rootfs) and it will cause system
>> boot up failed.
>
> You have a point, however, you could do two things to help:
>
> a) Mount the root file system as read-only. That way you can never write =
to
> it, unless you remount it read-write. But you can still reflash that
> partition if you need to upgrade.
>
> b) Register the mtd partition holding the root file system as read-only.
> This is even more seecure as remounting the file system won't permit writ=
es.
> However, it also means you can't write to it for upgrading. (I
> don't think the mtd core permits changing an already registered mtd
> partition from readonly to writable, but I could be wrong.)
>
>> Another query, does the syslogd/klogd log files also store in jffs2
>> rootfs? Write to jffs2 frequently will reduce flash life cycle.
>
> I think it is fairly common to have a combination of devices:
>
> / (root) =A0 =A0 =A0 =A0is a readonly flash device (mtd partition)
> /etc =A0 =A0 =A0 =A0 =A0 =A0is a writable flash device (mtd partition)
> /tmp and /var =A0 are ramdisks (tmpfs), so they are writable, but lost wh=
en
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0power is cycled.

I think it's a good combination for my board. How do I sepcific the
/etc to another mtd part?
The busybox init will parse /etc/inittab after setup signal handler
and initializes console. I only
know to do it is to re-mount etc directory from another mtd to /etc.
Is it right?

Thank your help.
BRs, H. Johnny

>
> /Ricard
> --
> Ricard Wolf Wanderl=F6f =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden =A0 =A0 =A0 =A0 =A0 =A0www.axis.com
> Phone +46 46 272 2016 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 Fax +46 46 13 61 30
>
