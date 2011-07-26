Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05722B6F89
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jul 2011 08:24:33 +1000 (EST)
Subject: Re: [PATCH RFC] perf event: Torrent,
	add support for the various PMUs on the Torrent chip.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311698974.28685.4.camel@oc5652146517.ibm.com>
Date: Tue, 26 Jul 2011 17:24:30 -0500
Message-Id: <D2D2FD5D-3E1B-43D9-B02D-60DBE33EC322@kernel.crashing.org>
References: <1311698974.28685.4.camel@oc5652146517.ibm.com>
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, ltc-interlock@lists.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2011, at 11:49 AM, Carl E. Love wrote:

>=20
>=20
> We are requesting your help to review the following patch prior to =
posting it=20
> upstream. The patch is against the 2.6.39 tree (which is already out =
of date).
> Thank your for your help and input.
>=20
>                       Carl Love
> =
--------------------------------------------------------------------------=

> [PATCH RFC] perf event: Torrent, add support for the various PMUs on =
the Torrent chip.
>=20
> Support for the Torrent hardware performance monitor units (PMU) on =
the LL
> link, WXYZ links, MCD bus, and CAU units is added.  These PMUs are =
specific
> to the Torrent system which is built using POWER7 processors.  These =
PMUs
> are specifc to the IBM P7IH system's Torrent chips, which are used to
> interconnect POWER7 processors.  Hence the platform specific files to
> support these PMUs are in the platform-specific directory
> arch/powerpc/platforms/torrent.  The include files are added to the
> standard powerpc include directory.  The Torrent PMU support uses the
> multiple PMU perf_events support.  A single perf_events PMU type is
> created to cover all of the various Torrent hardware PMUs.  The =
generic
> Torrent PMU type allows all of the specific Torrent hardware PMU =
events to
> be included into a group of events within the perf_events Torrent PMU =
type.
> The advantage of this model is that all of the events for the various
> links are guaranteed to be measured at the same time, providing good
> correlation between the activity on each of the different Torrent =
links.
>=20
> This patch is a forward port of the initial Torrent PMU patch for =
2.6.32
> that was done as part of the development effort on Torrent and never =
pushed
> upstream.
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
> ---
> arch/powerpc/include/asm/cau_pmu.h                 |   39 +
> arch/powerpc/include/asm/hvcall.h                  |   14 +
> arch/powerpc/include/asm/mmu_pmu.h                 |   39 +
> arch/powerpc/include/asm/power_torrent_events.h    |  106 ++
> arch/powerpc/include/asm/powerbus_bus_util_pmu.h   |   39 +
> arch/powerpc/include/asm/powerbus_ll_pmu.h         |   39 +
> arch/powerpc/include/asm/powerbus_mcd_pmu.h        |   44 +
> arch/powerpc/include/asm/powerbus_wxyz_pmu.h       |   38 +
> arch/powerpc/include/asm/torrent_nest_pmu.h        |  192 +++

Seems like a lot of these headers could move to plarforms/p7ih/

> arch/powerpc/kernel/perf_event.c                   |    4 +
> arch/powerpc/platforms/Makefile                    |    1 +
> arch/powerpc/platforms/p7ih/Makefile               |   10 +
> arch/powerpc/platforms/p7ih/cau_pmu.c              |  160 ++
> arch/powerpc/platforms/p7ih/mmu_pmu.c              |  156 ++
> .../powerpc/platforms/p7ih/powerbus_bus_util_pmu.c |  410 +++++
> arch/powerpc/platforms/p7ih/powerbus_ll_pmu.c      |  273 ++++
> arch/powerpc/platforms/p7ih/powerbus_mcd_pmu.c     |  492 ++++++
> arch/powerpc/platforms/p7ih/powerbus_wxyz_pmu.c    |  244 +++
> arch/powerpc/platforms/p7ih/torrent_pmu.c          | 1582 =
++++++++++++++++++++
> arch/powerpc/platforms/pseries/Kconfig             |    5 +
> 20 files changed, 3887 insertions(+), 0 deletions(-)



>=20
> +#define PMU_SPACE_MASK		0xFF000000
> +#define POWERPC_CORE_SPACE	0x00000000
> +#define TORRENT_SPACE		0x01000000
> +#define IS_CORE_EVENT(x)	((x & PMU_SPACE_MASK) =3D=3D =
POWERPC_CORE_SPACE)
> +#define IS_TORRENT_EVENT(x)	((x & PMU_SPACE_MASK) =3D=3D =
TORRENT_SPACE)



>=20
> diff --git a/arch/powerpc/kernel/perf_event.c =
b/arch/powerpc/kernel/perf_event.c
> index 822f630..aa1eb43 100644
> --- a/arch/powerpc/kernel/perf_event.c
> +++ b/arch/powerpc/kernel/perf_event.c
> @@ -19,6 +19,8 @@
> #include <asm/firmware.h>
> #include <asm/ptrace.h>
>=20
> +#include <asm/torrent_nest_pmu.h>
> +
> struct cpu_hw_events {
> 	int n_events;
> 	int n_percpu;
> @@ -1092,6 +1094,8 @@ static int power_pmu_event_init(struct =
perf_event *event)
> 		break;
> 	case PERF_TYPE_RAW:
> 		ev =3D event->attr.config;
> +		if (!IS_CORE_EVENT(ev))
> +			return -ENOENT;

seems like we should put what is needed for IS_CORE_EVENT() into =
asm/pmc.h if we believe its reasonable..

pulling in <asm/torrent_nest_pmu.h> seems the torrent support is pretty =
specific.

> 		break;
> 	default:
> 		return -ENOENT;


- k=
