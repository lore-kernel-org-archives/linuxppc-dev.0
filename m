Return-Path: <JAxboe@fusionio.com>
Received: from mx1.fusionio.com (mx1.fusionio.com [64.244.102.30])
	by ozlabs.org (Postfix) with ESMTP id 4E978B6FE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Apr 2011 17:13:08 +1000 (EST)
Message-ID: <4DAA9001.6050203@fusionio.com>
Date: Sun, 17 Apr 2011 09:00:17 +0200
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Hugh Dickins <hughd@google.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>	<1302646173.28876.53.camel@pasglop>	<1302652502.28876.76.camel@pasglop>	<19877.23529.745123.819112@pilspetsen.it.uu.se>	<1302685102.28876.81.camel@pasglop>	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>	<1302736869.28876.91.camel@pasglop>	<BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>	<1302771756.15520.100.camel@thor.local>	<BANLkTimykvKp=bwsFyNE9fWqcE9Ffws6bA@mail.gmail.com>	<1302818089.28876.134.camel@pasglop>
	<BANLkTimGLmQjCNFOy5z64Zg=R2FX--LF9A@mail.gmail.com>
In-Reply-To: <BANLkTimGLmQjCNFOy5z64Zg=R2FX--LF9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Mikael Pettersson <mikpe@it.uu.se>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kevin diggs <diggskevin38@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-04-17 05:16, Hugh Dickins wrote:
> On Thu, Apr 14, 2011 at 2:54 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Thu, 2011-04-14 at 14:25 -0700, Hugh Dickins wrote:
>>>
>>> Something worth trying: turn off CONFIG_IDE.  That's what I need to
>>> boot 2.6.39-rc[1-3] on PowerPC G5.
>>>
>>> I know Jens has been fixing problems with IDE versus his plug/unplug
>>> changes, but it's still not fixed for me in rc3.
>>>
>>> In other mail http://lkml.org/lkml/2011/4/14/614
>>> I see Linus recommending his post-rc3 commit 6631e635c65d
>>> but I've not tried that myself yet.
>>
>> Well, the disk is SATA so it's CONFIG_ATA/libata, which works fine here,
>> unless you somewhat replaced your CD-ROM with a legacy IDE disk :-) Or
>> maybe the problem is related to the CD-ROM drive. There's a libata
>> driver for it nowadays, so you can use PATA_MACIO instead of IDE_PMAC
> 
> Thanks for that, Ben: I remember you were brewing up such a driver,
> but I missed when it actually went in.  I can confirm that switching
> off CONFIG_IDE and switching on CONFIG_PATA_MACIO and
> CONFIG_BLK_DEV_SR now gives me a booting system with a working CD-ROM
> (though I've not yet tried burning).
> 
> Whereas CONFIG_IDE=y with current git still does not boot: hangs for a
> minute or three around the windfarm announcements, then an endless
> splurge of hda error messages - sorry, I'm not being helpful, other
> worries...

It's the media event notification that goes crazy. Try and comment out
this line:

	drive->dev_flags |= IDE_DFLAG_MEDIA_CHANGED;

in drivers/ide/ide-cd.c:cdrom_saw_media_change() and see if it boots.

-- 
Jens Axboe
