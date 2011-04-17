Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AFCFB6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Apr 2011 13:16:41 +1000 (EST)
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com
	[172.24.198.88]) by smtp-out.google.com with ESMTP id p3H3GXO8008083
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2011 20:16:34 -0700
Received: from yxm8 (yxm8.prod.google.com [10.190.4.8])
	by wpaz24.hot.corp.google.com with ESMTP id p3H3GV8m013636
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2011 20:16:32 -0700
Received: by yxm8 with SMTP id 8so2781238yxm.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 20:16:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302818089.28876.134.camel@pasglop>
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
Date: Sat, 16 Apr 2011 20:16:29 -0700
Message-ID: <BANLkTimGLmQjCNFOy5z64Zg=R2FX--LF9A@mail.gmail.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jens Axboe <jaxboe@fusionio.com>,
	linux-kernel@vger.kernel.org, kevin diggs <diggskevin38@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2011 at 2:54 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2011-04-14 at 14:25 -0700, Hugh Dickins wrote:
>>
>> Something worth trying: turn off CONFIG_IDE. =C2=A0That's what I need to
>> boot 2.6.39-rc[1-3] on PowerPC G5.
>>
>> I know Jens has been fixing problems with IDE versus his plug/unplug
>> changes, but it's still not fixed for me in rc3.
>>
>> In other mail http://lkml.org/lkml/2011/4/14/614
>> I see Linus recommending his post-rc3 commit 6631e635c65d
>> but I've not tried that myself yet.
>
> Well, the disk is SATA so it's CONFIG_ATA/libata, which works fine here,
> unless you somewhat replaced your CD-ROM with a legacy IDE disk :-) Or
> maybe the problem is related to the CD-ROM drive. There's a libata
> driver for it nowadays, so you can use PATA_MACIO instead of IDE_PMAC

Thanks for that, Ben: I remember you were brewing up such a driver,
but I missed when it actually went in.  I can confirm that switching
off CONFIG_IDE and switching on CONFIG_PATA_MACIO and
CONFIG_BLK_DEV_SR now gives me a booting system with a working CD-ROM
(though I've not yet tried burning).

Whereas CONFIG_IDE=3Dy with current git still does not boot: hangs for a
minute or three around the windfarm announcements, then an endless
splurge of hda error messages - sorry, I'm not being helpful, other
worries...

Hugh
