Return-Path: <chris@2net.co.uk>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 639D71007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jan 2010 19:29:33 +1100 (EST)
Message-ID: <4B5D560E.2020901@2net.co.uk>
Date: Mon, 25 Jan 2010 08:27:58 +0000
From: Chris Simmonds <chris@2net.co.uk>
MIME-Version: 1.0
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
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
	<cb9ecdfa1001242009x30eabcd3gbd0bb1d8a931199e@mail.gmail.com>
In-Reply-To: <cb9ecdfa1001242009x30eabcd3gbd0bb1d8a931199e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	Marco Stornelli <marco.stornelli@gmail.com>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Matthias Kaehlcke <matthias@kaehlcke.net>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: chris@2net.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Johnny Hung wrote:
> 2010/1/22 Marco Stornelli <marco.stornelli@gmail.com>:
>> 2010/1/22 Johnny Hung <johnny.hacking@gmail.com>:
>>> 2010/1/20 Marco Stornelli <marco.stornelli@gmail.com>:
>>>> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
>>>>> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>>>>>> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>>>>>>
>>>>> I consider to use ramdisk as rootfs because worry about wrong
>>>>> operation in rootfs (is use jffs2 rootfs) and it will cause system
>>>>> boot up failed.
>>>>> Another query, does the syslogd/klogd log files also store in jffs2
>>>>> rootfs? Write to jffs2 frequently will reduce flash life cycle.
>>>>>
>>>>> BRs, H. Johnny
>>>>>> --
>>> It seems there are a lot of file-systems I have to study :P. The same
>>> question is
>>> how to split my rootfs? Re-mount /etc, /var to another file-sysyem mtd part when
>>> system boot up?
>>>
> Yes, I know. So if I want set etc directoyr to /dev/mtd5 not in rootfs
> /, I need to add "/dev/mtdblock5  /etc        jffs2   defaults
> 0       0" in /etc/fstab file but rootfs doesn't contain /etc
> directory because /etc directoyr is store in /dev/mtdblock5.
> Do you know what I mean? The kernel execute /sbin/init after mount
> rootfs and /sbin/init is link to busybox, busybox will read
> /etc/inittab file to initial. The problem is coming, how busybox to
> read /etc in rootfs before mount /dev/mtdblock5 to /etc? There is no
> program to mount /dev/mtdblock5 to /etc before busybox init execute.
> 
> I think I must mistake some concept, please give me a hint.
> Thank you
> BRs, H. Johnny
> 

You have two /etc directories: one in the the read-only root file system 
and one in the jffs2 fs. In the root fs you have /etc/fstab, 
/etc/inittab and any scripts it may call. The init program will mount 
/dev/mtdblock5 over the top of the /etc that is in the rootfs, so giving 
you the read/write version of /etc. Any files open in the old /etc - 
e.g. /etc/inittab - will continue to be open, but any new files opened 
in /etc will use the read/write version in jffs2. You can also do some 
interesting things with symbolic links... This technique works. I have 
used it in several projects.

-- 
Chris Simmonds                   2net Limited
chris@2net.co.uk                 http://www.2net.co.uk/
