Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 123301007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jan 2010 15:09:34 +1100 (EST)
Received: by pwj11 with SMTP id 11so2210556pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jan 2010 20:09:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2ea1731b1001220014v59ea7767m6e1a8547d41c6afb@mail.gmail.com>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
	<cb9ecdfa1001211907u37415485tf3e1d2c443a506f7@mail.gmail.com>
	<2ea1731b1001220014v59ea7767m6e1a8547d41c6afb@mail.gmail.com>
Date: Mon, 25 Jan 2010 12:09:32 +0800
Message-ID: <cb9ecdfa1001242009x30eabcd3gbd0bb1d8a931199e@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Marco Stornelli <marco.stornelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Matthias Kaehlcke <matthias@kaehlcke.net>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/22 Marco Stornelli <marco.stornelli@gmail.com>:
> 2010/1/22 Johnny Hung <johnny.hacking@gmail.com>:
>> 2010/1/20 Marco Stornelli <marco.stornelli@gmail.com>:
>>> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
>>>> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>>>>> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>>>>>
>>>> I consider to use ramdisk as rootfs because worry about wrong
>>>> operation in rootfs (is use jffs2 rootfs) and it will cause system
>>>> boot up failed.
>>>> Another query, does the syslogd/klogd log files also store in jffs2
>>>> rootfs? Write to jffs2 frequently will reduce flash life cycle.
>>>>
>>>> BRs, H. Johnny
>>>>>
>>>>> --
>>>
>>
>> It seems there are a lot of file-systems I have to study :P. The same
>> question is
>> how to split my rootfs? Re-mount /etc, /var to another file-sysyem mtd part when
>> system boot up?
>>
>
Yes, I know. So if I want set etc directoyr to /dev/mtd5 not in rootfs
/, I need to add "/dev/mtdblock5  /etc        jffs2   defaults
0       0" in /etc/fstab file but rootfs doesn't contain /etc
directory because /etc directoyr is store in /dev/mtdblock5.
Do you know what I mean? The kernel execute /sbin/init after mount
rootfs and /sbin/init is link to busybox, busybox will read
/etc/inittab file to initial. The problem is coming, how busybox to
read /etc in rootfs before mount /dev/mtdblock5 to /etc? There is no
program to mount /dev/mtdblock5 to /etc before busybox init execute.

I think I must mistake some concept, please give me a hint.
Thank you
BRs, H. Johnny

> Simply, you can mount each mount point with the fstab file and a
> script, same approach of every linux distribution, nothing more. Even
> in the pc world you can mount your /home on a partition with ext3,
> /var in a partition with ext4, and so on. A very simple approach to
> setup the system, it is to start with NFS for example with "whole" fs,
> copy what you need in the right place, setup the start-up script and
> reboot.
>
> Marco
>
