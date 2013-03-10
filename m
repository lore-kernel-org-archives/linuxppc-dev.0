Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68AB02C0334
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 11:45:32 +1100 (EST)
Message-ID: <1362876308.6977.42.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Sun, 10 Mar 2013 11:45:08 +1100
In-Reply-To: <513BD33B.7020305@mail.ru>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
 <1362687724.6977.1.camel@pasglop> <513BD33B.7020305@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Denis Kirjanov <kirjanov@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-03-10 at 01:26 +0100, Phileas Fogg wrote:

> i managed to find the bad commit after a couple of days bisecting.

Thanks !

> ----------------------------
> 44ae3ab3358e962039c36ad4ae461ae9fb29596c is the first bad commit
> commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c
> Author: Matt Evans <matt@ozlabs.org>
> Date:   Wed Apr 6 19:48:50 2011 +0000
> 
>      powerpc: Free up some CPU feature bits by moving out MMU-related 
> features
> 
>      Some of the 64bit PPC CPU features are MMU-related, so this patch moves
>      them to MMU_FTR_ bits.  All cpu_has_feature()-style tests are moved to
>      mmu_has_feature(), and seven feature bits are freed as a result.
> 
>      Signed-off-by: Matt Evans <matt@ozlabs.org>
>      Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --------------------------------

Have you verified that if you checkout git at the above commit point, it
fails and if you then just revert that commit on top, it works again ?

The above should have been mostly a NOP change but I'll have a closer
look in case a typo of some kind actually broke something.

> Actually, there are 2 problems i found.
> The first problem occurs when i enable IDE CDROM driver on my machine.
> The following commit causes hangs on my machine at boot:

Ok. You may want to switch to the new libata instead of the old IDE
driver too

(CONFIG_IDE off, CONFIG_ATA on, CONFIG_PATA_MACIO on and from there it
will use the SCSI CDROM driver).

> ----------------------
> commit 5b03a1b140e13a28ff6be1526892a9dc538ddef6
> Author: Tejun Heo <tj@kernel.org>
> Date:   Wed Mar 9 19:54:27 2011 +0100
> 
>      ide: Convert to bdops->check_events()
> 
>      Convert ->media_changed() to the new ->check_events() method.  The
>      conversion is mostly mechanical.  The only notable change is that
>      cdrom now doesn't generate any event if @slot_nr isn't CDSL_CURRENT.
>      It used to return -EINVAL which would be treated as media changed.  As
>      media changer isn't supported anyway, this doesn't make any
>      difference.
> 
>      This makes ide emit the standard disk events and allows kernel event
>      polling.  Currently, only MEDIA_CHANGE event is implemented.  Adding
>      support for EJECT_REQUEST shouldn't be difficult; however, given that
>      ide driver is already deprecated, it probably is best to leave it
>      alone.
> 
>      Signed-off-by: Tejun Heo <tj@kernel.org>
> ----------------------------
> 
> 
> 
> 
> If i disable IDE CDROM driver then the Linux kernel boots again
> and then it hits the commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c
> and hangs again :)
> 
> The commit eca590f402332ab873d13f2d8d00fa0b91cfff36 which is before
> the commit 44ae3ab3358e962039c36ad4ae461ae9fb29596c works fine,
> i tested it myself to be on the safe side.

Ok thanks. I'll dig a bit if I get a chance next week.

Cheers,
Ben.
> 
> 
> Regards
