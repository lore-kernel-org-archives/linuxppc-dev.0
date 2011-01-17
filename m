Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62192B7142
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 04:37:51 +1100 (EST)
Subject: Re: [PATCH] powerpc: perf: Fix frequency calculation for
	overflowing counters
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110117113250.48098aaa@udp111988uds.am.freescale.net>
References: <20110117161742.5feb3761@kryten>
	<20110117113250.48098aaa@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Jan 2011 18:38:01 +0100
Message-ID: <1295285881.30950.218.camel@laptop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-01-17 at 11:32 -0600, Scott Wood wrote:
> > diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/per=
f_event.c
> > index 5674807..ab6f6be 100644
> > --- a/arch/powerpc/kernel/perf_event.c
> > +++ b/arch/powerpc/kernel/perf_event.c
> > @@ -1212,6 +1212,7 @@ static void record_and_restart(struct perf_event =
*event, unsigned long val,
> >                       if (left <=3D 0)
> >                               left =3D period;
> >                       record =3D 1;
> > +                     event->hw.last_period =3D event->hw.sample_period=
;
> >               }
> >               if (left < 0x80000000LL)
> >                       val =3D 0x80000000LL - left;

> Does perf_event_fsl_emb.c need this as well (it has almost the same
> record_and_restart code)?=20

I would think so.
