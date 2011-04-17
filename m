Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFE4DB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 03:47:29 +1000 (EST)
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com
	[172.25.149.11]) by smtp-out.google.com with ESMTP id p3HHlKxU023884
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2011 10:47:20 -0700
Received: from ywh1 (ywh1.prod.google.com [10.192.8.1])
	by hpaq11.eem.corp.google.com with ESMTP id p3HHlHqp012099
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2011 10:47:19 -0700
Received: by ywh1 with SMTP id 1so2072474ywh.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Apr 2011 10:47:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DAA9001.6050203@fusionio.com>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
	<1302736869.28876.91.camel@pasglop>
	<BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
	<1302771756.15520.100.camel@thor.local>
	<BANLkTimykvKp=bwsFyNE9fWqcE9Ffws6bA@mail.gmail.com>
	<1302818089.28876.134.camel@pasglop>
	<BANLkTimGLmQjCNFOy5z64Zg=R2FX--LF9A@mail.gmail.com>
	<4DAA9001.6050203@fusionio.com>
Date: Sun, 17 Apr 2011 10:47:16 -0700
Message-ID: <BANLkTinObLcck1EX=UJd4MnVuykafQTf-w@mail.gmail.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Hugh Dickins <hughd@google.com>
To: Jens Axboe <jaxboe@fusionio.com>
Content-Type: text/plain; charset=UTF-8
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

On Sun, Apr 17, 2011 at 12:00 AM, Jens Axboe <jaxboe@fusionio.com> wrote:
> On 2011-04-17 05:16, Hugh Dickins wrote:
>> On Thu, Apr 14, 2011 at 2:54 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>> On Thu, 2011-04-14 at 14:25 -0700, Hugh Dickins wrote:
>>>>
>>>> Something worth trying: turn off CONFIG_IDE. =C2=A0That's what I need =
to
>>>> boot 2.6.39-rc[1-3] on PowerPC G5.
>>>>
>>>> I know Jens has been fixing problems with IDE versus his plug/unplug
>>>> changes, but it's still not fixed for me in rc3.
>>>>
>>>> In other mail http://lkml.org/lkml/2011/4/14/614
>>>> I see Linus recommending his post-rc3 commit 6631e635c65d
>>>> but I've not tried that myself yet.
>>>
>>> Well, the disk is SATA so it's CONFIG_ATA/libata, which works fine here=
,
>>> unless you somewhat replaced your CD-ROM with a legacy IDE disk :-) Or
>>> maybe the problem is related to the CD-ROM drive. There's a libata
>>> driver for it nowadays, so you can use PATA_MACIO instead of IDE_PMAC
>>
>> Thanks for that, Ben: I remember you were brewing up such a driver,
>> but I missed when it actually went in. =C2=A0I can confirm that switchin=
g
>> off CONFIG_IDE and switching on CONFIG_PATA_MACIO and
>> CONFIG_BLK_DEV_SR now gives me a booting system with a working CD-ROM
>> (though I've not yet tried burning).
>>
>> Whereas CONFIG_IDE=3Dy with current git still does not boot: hangs for a
>> minute or three around the windfarm announcements, then an endless
>> splurge of hda error messages - sorry, I'm not being helpful, other
>> worries...
>
> It's the media event notification that goes crazy. Try and comment out
> this line:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0drive->dev_flags |=3D IDE_DFLAG_MEDIA_CHANGED;
>
> in drivers/ide/ide-cd.c:cdrom_saw_media_change() and see if it boots.

Yes, that also boots, with a working CD-ROM: thanks.

Hugh
