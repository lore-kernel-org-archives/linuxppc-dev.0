Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from tama500.ecl.ntt.co.jp (tama500.ecl.ntt.co.jp [129.60.39.148])
	by ozlabs.org (Postfix) with ESMTP id 8A98FDDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 11:51:50 +1000 (EST)
To: bzolnier@gmail.com
Subject: Re: ide pmac breakage
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <200807292126.12238.bzolnier@gmail.com>
References: <200807291404.46906.bzolnier@gmail.com>
	<200807291645.03382.bzolnier@gmail.com>
	<200807292126.12238.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20080730102308B.fujita.tomonori@lab.ntt.co.jp>
Date: Wed, 30 Jul 2008 10:23:08 +0900
Cc: fujita.tomonori@lab.ntt.co.jp, petkovbb@gmail.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jul 2008 21:26:11 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > > Well, all I do is call into Bart's new helpers to scan for or
> > > > > unregister
> > > > > > devices ...
> > > > > 
> > > > > The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> > > > > bring
> > > > > such behavior change (ditto for new IDE host addition/removal
> > > > > helpers)...
> > > > > 
> > > > > Please try to git-bisect it when you have some time.
> > > > 
> > > > Ok, I will. I worked fine when I last tried your patches. I'll see if I
> > > > can track it down too. Been a bit too busy lately as you can imagine.
> > > > 
> > > > Do you have something that exercise the same code path you can use ?
> > > 
> > > I'll see if I can reproduce it with IDE warm-plug support later...
> > 
> > OK, I reproduced it here with IDE warm-plug support
> > (echo -n "1" > /sys/class/ide_port/ide*/delete_devices)
> > for devices driven by ide-cd.
> > 
> > It is also reproducible under qemu so I'm scripting it
> > into git-bisect run now...
> 
> I WON!!!

Great, seems that I don't need to learn how ide does ref counting. :)

Thanks a lot!
