Message-Id: <4.3.2.7.2.20000822104941.00b1d058@bucks.si.com>
Date: Tue, 22 Aug 2000 10:55:15 -0400
To: Matt Gessner <mattg@aiinet.com>
From: Jon Diekema <diekema_jon@esseye.si.com>
Subject: Re: Patch to arch/ppc/kernel/m8260_setup.c
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39A28B21.8F91CACA@aiinet.com>
References: <m13RDKd-001SzbC@bucks>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:16 AM 8/22/2000, you wrote:
>diekema_jon wrote:
> >
> > In order to get things to compile for the MPC8260, the following
> > patch was needed:
> >
> > dell 377} bk diffs -r1.7 -u arch/ppc/kernel/m8260_setup.c
> > ===== arch/ppc/kernel/m8260_setup.c 1.7 vs 1.8 =====
> > --- 1.7/arch/ppc/kernel/m8260_setup.c   Wed Aug  2 12:53:58 2000
> > +++ 1.8/arch/ppc/kernel/m8260_setup.c   Mon Aug 21 21:17:00 2000
> > @@ -113,9 +113,8 @@
> >
> >         freq = (binfo->bi_busfreq * 1000000);
> >          divisor = 4;
> > -        decrementer_count = freq / HZ / divisor;
> > -        count_period_num = divisor;
> > -        count_period_den = freq / 1000000;
> > +        tb_ticks_per_jiffy = freq / (divisor * HZ);
> > +        tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
> >  }
> >
> >  /* The 8260 has an internal 1-second timer update register that

>You don't mention the source of this code (i.e. linux rev and test#).

Oops... The patch is working with Linux 2.4.0-test7

For more details on this issue see:

http://lists.linuxppc.org/listarcs/linuxppc-embedded/200008/msg00109.html
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200008/msg00113.html
------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
