Return-Path: <matthias@kaehlcke.net>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
	[217.70.183.194]) by ozlabs.org (Postfix) with ESMTP id AC7ACB7CEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 18:22:20 +1100 (EST)
Date: Wed, 20 Jan 2010 08:17:39 +0100
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
Message-ID: <20100120071739.GS16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<Pine.LNX.4.64.1001200809550.32263@lnxricardw.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.1001200809550.32263@lnxricardw.se.axis.com>
Cc: Johnny Hung <johnny.hacking@gmail.com>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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

El Wed, Jan 20, 2010 at 08:15:01AM +0100 Ricard Wanderlof ha dit:

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
> a) Mount the root file system as read-only. That way you can never write  
> to it, unless you remount it read-write. But you can still reflash that  
> partition if you need to upgrade.
>
> b) Register the mtd partition holding the root file system as read-only.
> This is even more seecure as remounting the file system won't permit  
> writes. However, it also means you can't write to it for upgrading. (I
> don't think the mtd core permits changing an already registered mtd  
> partition from readonly to writable, but I could be wrong.)

AFAIK the mtd core doesn't permit changing a partition from ro to
rw. but if you happen to need to reflash the partition anyway, you can
load a tiny kernel modules that changes the flag indicating if a
partition is writable.

i once had to recurr to this solution and it works ;)

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

    Tant qu'il y aura sur terre des hommes pour qui existe un concept
    d' 'honneur national', la menace d'une nouvelle guerre subsistera
                              (B. Traven)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
