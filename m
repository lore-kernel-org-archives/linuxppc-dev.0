Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id DF118DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 00:47:59 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so139846ugf.0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 07:47:57 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 16:45:02 +0200
References: <1217208596.11188.144.camel@pasglop>
	<1217332971.11188.249.camel@pasglop>
	<200807291404.46906.bzolnier@gmail.com>
In-Reply-To: <200807291404.46906.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807291645.03382.bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Well, all I do is call into Bart's new helpers to scan for or
> > > unregister
> > > > devices ...
> > > 
> > > The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> > > bring
> > > such behavior change (ditto for new IDE host addition/removal
> > > helpers)...
> > > 
> > > Please try to git-bisect it when you have some time.
> > 
> > Ok, I will. I worked fine when I last tried your patches. I'll see if I
> > can track it down too. Been a bit too busy lately as you can imagine.
> > 
> > Do you have something that exercise the same code path you can use ?
> 
> I'll see if I can reproduce it with IDE warm-plug support later...

OK, I reproduced it here with IDE warm-plug support
(echo -n "1" > /sys/class/ide_port/ide*/delete_devices)
for devices driven by ide-cd.

It is also reproducible under qemu so I'm scripting it
into git-bisect run now...

Thanks,
Bart
