Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F5321A0DE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:45:07 +1000 (AEST)
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A429140297
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 13:44:55 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so28122926pdj.0
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 20:44:54 -0700 (PDT)
Message-ID: <1433907837.3096.11.camel@axtens.net>
Subject: Re: [PATCH V8 02/10] powerpc, perf: Restore privillege level filter
 support for BHRB
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 13:43:57 +1000
In-Reply-To: <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-nNgRyJwr9SsP+rQAxz4L"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-nNgRyJwr9SsP+rQAxz4L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the subject line, privilege should only have 1 l, and I think it
should probably start with "powerpc/perf:" rather than "powerpc, perf:".

On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>=20
> 'commit 9de5cb0f6df8 ("powerpc/perf: Add per-event excludes on Power8")'
Does this need a 'Fixes:' tag then?

> broke the PMU based BHRB privilege level filter. BHRB depends on the
> same MMCR0 bits for privilege level filter which was used to freeze all
> the PMCs as a group. Once we moved to individual event based privilege
> filters through MMCR2 register on POWER8, event associated privilege
> filters are no longer applicable to the BHRB captured branches.
>=20
> This patch solves the problem by restoring to the previous method of
> privilege level filters for the event in case BHRB based branch stack
> sampling is requested. This patch also changes 'check_excludes' for
> the same reason.
>=20
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-boo=
k3s.c
> index c246e65..ae61629 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -930,7 +930,7 @@ static int power_check_constraints(struct cpu_hw_even=
ts *cpuhw,
>   * added events.
>   */
Does this comment need to be updated?
>  static int check_excludes(struct perf_event **ctrs, unsigned int cflags[=
],
> -			  int n_prev, int n_new)
> +			  int n_prev, int n_new, int bhrb_users)
>  {
>  	int eu =3D 0, ek =3D 0, eh =3D 0;
>  	int i, n, first;
> @@ -941,7 +941,7 @@ static int check_excludes(struct perf_event **ctrs, u=
nsigned int cflags[],
>  	 * don't need to do any of this logic. NB. This assumes no PMU has both
>  	 * per event exclude and limited PMCs.
>  	 */
Likewise, does this comment need to be updated?
> -	if (ppmu->flags & PPMU_ARCH_207S)
> +	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
>  		return 0;
> =20
>  	n =3D n_prev + n_new;
> @@ -1259,7 +1259,7 @@ static void power_pmu_enable(struct pmu *pmu)
>  		goto out;
>  	}
> =20
> -	if (!(ppmu->flags & PPMU_ARCH_207S)) {
> +	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users)
You're using cpuhw->bhrb_users as a bool here, where it's an int. Could
you make the test more specific so that it's clear exactly what you're
expecting bhrb_users to contain?
>  {
>  		/*
>  		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
>  		 * bits for the first event. We have already checked that all
> @@ -1284,7 +1284,7 @@ static void power_pmu_enable(struct pmu *pmu)
>  	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
>  	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
>  				| MMCR0_FC);
> -	if (ppmu->flags & PPMU_ARCH_207S)
> +	if ((ppmu->flags & PPMU_ARCH_207S) && !cpuhw->bhrb_users)
>  		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
> =20
>  	/*
> @@ -1436,7 +1436,8 @@ static int power_pmu_add(struct perf_event *event, =
int ef_flags)
>  	if (cpuhw->group_flag & PERF_EVENT_TXN)
>  		goto nocheck;
> =20
> -	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
> +	if (check_excludes(cpuhw->event, cpuhw->flags,
> +				n0, 1, cpuhw->bhrb_users))
>  		goto out;
>  	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1)=
)
>  		goto out;
> @@ -1615,7 +1616,7 @@ static int power_pmu_commit_txn(struct pmu *pmu)
>  		return -EAGAIN;
>  	cpuhw =3D this_cpu_ptr(&cpu_hw_events);
>  	n =3D cpuhw->n_events;
> -	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
> +	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n, cpuhw->bhrb_users)=
)
>  		return -EAGAIN;
>  	i =3D power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
>  	if (i < 0)
> @@ -1828,10 +1829,12 @@ static int power_pmu_event_init(struct perf_event=
 *event)
>  	events[n] =3D ev;
>  	ctrs[n] =3D event;
>  	cflags[n] =3D flags;
> -	if (check_excludes(ctrs, cflags, n, 1))
> +	cpuhw =3D &get_cpu_var(cpu_hw_events);
Should this be using a this_cpu_ptr rather than a get_cpu_var? (as with
the power_pmu_commit_txn case?)
> +	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users)) {
> +		put_cpu_var(cpu_hw_events);
Likewise with this?
>  		return -EINVAL;
> +	}
> =20
> -	cpuhw =3D &get_cpu_var(cpu_hw_events);
>  	err =3D power_check_constraints(cpuhw, events, cflags, n + 1);
> =20
>  	if (has_branch_stack(event)) {


--=-nNgRyJwr9SsP+rQAxz4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd7J9AAoJEPC3R3P2I92F/C8P/ii8KVBBBEyyQENdlIu1PwuL
+vJ/h62QyA9vL2Suof+RLiwhwSQNUf8K0sRxZ9GsMHUT59nkTZRwTjGBC6TIO30M
I6knuiqDnaoJab+vLEoH9nWpFh4l5UaqPa8DRxdVSMQEx0v2gcGLCwKHeK+1ikIY
XKgLW9SA3bKHOxfDAj9+JEquWqgViooiIdDBbVaGXnW8NPjkL64CFdyIcdjwVloH
W7s989YV/CoKWvReKjzEPsr44Dwm+3qalIoC6UA33N99vUghxu4aH98mtQ9I+hg8
ijb27lYxEjx6JaTwxeHyfXy/7HCcfWWW4d5i0l7r6bb5cBcAn78OnWPoS1b9ok9R
Je2162+hMAh4qiweWsYFXY+R8qj+Q41tSbg8BTW4NxTrEf9SLpC45ns4dDtI45K5
J3m/4cs+9H5KLNynUwQ3ETddkrYYdV41SabpA2Nh4DWFQVeb0O8gRBHfhsUoNK6l
y409J3YdgsOdAqvMQPjDWnO99XIDRWxHJCKO9N5czq10JRKQTHQrYYiCTdBcoAkv
36wijFhLsn3SAcZST0yLIdb97sI+zhFigMDoXiHBleH11NPKlCoNT8E3Vz8/luCW
/6WASyuBcBCX+ccTop7eHcej7hyKYiLyYF2f4rRgg360qBsRPA/sEQd6W67CaPf0
0RR6CNBooFNvSl5lWphY
=Prxn
-----END PGP SIGNATURE-----

--=-nNgRyJwr9SsP+rQAxz4L--
