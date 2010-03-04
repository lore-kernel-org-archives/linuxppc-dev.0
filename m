Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DDBDB7D51
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Mar 2010 03:48:09 +1100 (EST)
Subject: Re: [PATCH 2/2] perf_event: e500 support
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100226000945.GA17094@loki.buserror.net>
Date: Thu, 4 Mar 2010 10:48:03 -0600
Message-Id: <42FC542D-2B8A-4AB6-866D-9CBCCE62C3CC@kernel.crashing.org>
References: <20100226000945.GA17094@loki.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 25, 2010, at 6:09 PM, Scott Wood wrote:

> This implements perf_event support for the Freescale embedded =
performance
> monitor, based on the existing perf_event.c that supports =
server/classic
> chips.
>=20
> Some limitations:
> - Performance monitor interrupts are regular EE interrupts, and thus =
you
>  can't profile places with interrupts disabled.  We may want to =
implement
>  soft IRQ-disabling, with perfmon interrupts exempted and treated as =
NMIs.
> - When trying to schedule multiple event groups at once, and using
>  restricted events, situations could arise where scheduling fails even
>  though it would be possible.  Consider three groups, each with two =
events.
>  One group has restricted events, the others don't.  The two =
non-restricted
>  groups are scheduled, then one is removed, which happens to occupy =
the two
>  counters that can't do restricted events.  The remaining =
non-restricted
>  group will not be moved to the non-restricted-capable counters to =
make
>  room if the restricted group tries to be scheduled.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Changes from previous version:
> - Factored out callchain makefile patch
> - Split up header files
> - Renamed pmu struct
> - Added threshold support
>=20
> arch/powerpc/include/asm/perf_event.h              |  133 +----
> arch/powerpc/include/asm/perf_event_fsl_emb.h      |   50 ++
> .../asm/{perf_event.h =3D> perf_event_server.h}      |    4 +-
> arch/powerpc/include/asm/reg_fsl_emb.h             |    2 +-
> arch/powerpc/kernel/Makefile                       |    4 +
> arch/powerpc/kernel/cputable.c                     |    2 +-
> arch/powerpc/kernel/e500-pmu.c                     |  129 ++++
> arch/powerpc/kernel/perf_event_fsl_emb.c           |  654 =
++++++++++++++++++++
> arch/powerpc/platforms/Kconfig.cputype             |   10 +
> 9 files changed, 874 insertions(+), 114 deletions(-)
> rewrite arch/powerpc/include/asm/perf_event.h (92%)
> create mode 100644 arch/powerpc/include/asm/perf_event_fsl_emb.h
> rename arch/powerpc/include/asm/{perf_event.h =3D> =
perf_event_server.h} (98%)
> create mode 100644 arch/powerpc/kernel/e500-pmu.c
> create mode 100644 arch/powerpc/kernel/perf_event_fsl_emb.c

Paul do you intend to Ack this or don't care?

- k
