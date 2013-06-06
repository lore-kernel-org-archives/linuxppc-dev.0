Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id D71B92C008F
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 14:56:00 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
In-reply-to: <1369716452-28689-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369716452-28689-2-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Thu, 06 Jun 2013 14:56:00 +1000
Message-ID: <20699.1370494560@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> Completely ignore BHRB privilege state filter request as we are
> already configuring that with privilege state filtering attribute
> for the accompanying PMU event. This would help achieve cleaner
> user space interaction for BHRB.
>=20
> This patch fixes a situation like this
>=20
> Before patch:-
> ------------
> ./perf record -j any -e branch-misses:k ls
> Error:
> The sys_perf_event_open() syscall returned with 95 (Operation not support=
ed) for event (branch-misses:k).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=3Dy kernel support configured?
>=20
> Here 'perf record' actually copies over ':k' filter request into BHRB
> privilege state filter config and our previous check in kernel would
> fail that.
>=20
> After patch:-
> -------------
> ./perf record -j any -e branch-misses:k ls
> perf  perf.data  perf.data.old  test-mmap-ring
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (~102 samples) ]
>=20
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power8-pmu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pm=
u.c
> index f7d1c4f..3a58416 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -525,16 +525,12 @@ static u64 power8_bhrb_filter_map(u64 branch_sample=
_type)
>  	u64 pmu_bhrb_filter =3D 0;
>  	u64 br_privilege =3D branch_sample_type & ONLY_PLM;
>=20=20
> -	/* BHRB and regular PMU events share the same prvillege state
> +	/* BHRB and regular PMU events share the same privilege state
>  	 * filter configuration. BHRB is always recorded along with a
> -	 * regular PMU event. So privilege state filter criteria for BHRB
> -	 * and the companion PMU events has to be the same. As a default
> -	 * "perf record" tool sets all privillege bits ON when no filter
> -	 * criteria is provided in the command line. So as along as all
> -	 * privillege bits are ON or they are OFF, we are good to go.
> +	 * regular PMU event. As the privilege state filter is handled
> +	 * in the basic PMC configuration of the accompanying regular
> +	 * PMU event, we ignore any separate BHRB specific request.
>  	 */
> -	if ((br_privilege !=3D 7) && (br_privilege !=3D 0))
> -		return -1;

br_privilege is now unused which causes this compile error.

arch/powerpc/perf/power8-pmu.c:526:6: error: unused variable =E2=80=98br_pr=
ivilege=E2=80=99 [-Werror=3Dunused-variable]

I assume since you didn't compile test this code, you also didn't
runtime test it either?!!?!?!?

Mikey

>=20=20
>  	/* No branch filter requested */
>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> --=20
> 1.7.11.7
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
