Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6822AB7BFA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 20:04:10 +1100 (EST)
In-Reply-To: <OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
Message-ID: <OFF16562FA.194FEE9D-ONC12576DB.00313B12-C12576DB.003164A5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 3 Mar 2010 09:59:30 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, hs@denx.de,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Heiko Schocher <hs@denx.de> wrote on 2010/03/03 09:02:47:
> >
> > Hello Joakim,
> >
> > I tried your 4 patches on a MPC855M based system:
>
> Thanks a lot for testing this for me!
>
> >
> > -bash-3.2# cat /proc/cpuinfo
> > processor       : 0
> > cpu             : 8xx
> > clock           : 66.000000MHz
> > revision        : 0.0 (pvr 0050 0000)
> > bogomips        : 8.25
> > timebase        : 4125000
> > platform        : TQM8xx
> > model           : TQM8xx
> > Memory          : 32 MB
> > -bash-3.2# cat /proc/version
> > Linux version 2.6.33-rc6-01500-gbddcb41-dirty (hs@xpert.denx.de) (gcc version
> > 4.2.2) #9 Tue Mar 2 18:08:49 CET 2010
> > -bash-3.2#
> >
> > First I looked for the Boottime:
> >
> > Booting Linux:
> >
> >                            2.6.33 2.6.33tunned
> > ... until "Freeing unused kernel memory" message (= enter user space)    ~4s    ~4s
> > ... until "login:" message (= full multi-user mode)          56s    56s
> >
> > and I did a Performance test with lmbench, see:
> > http://sourceforge.net/projects/lmbench
> >
> > Here the results:
> > (The first 4 rows are the results for the kernel without your patches,
> >  the next 4 rows are the results for the kernel with your patches)
> >
> > make[1]: Entering directory `/home/hs/lmbench-3.0-a9/results'
>
> I see both ups and downs in this test, don't quite understand why.
> What is your config w.r.t SWAP, MODULES, CPU6 and CPU15?

Forgot to ask for PIN_TLB too
