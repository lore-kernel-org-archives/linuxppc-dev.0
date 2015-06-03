Return-Path: <dja@axtens.net>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 647181A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 11:07:23 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so61647908pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 18:07:21 -0700 (PDT)
Message-ID: <1433293592.438.74.camel@axtens.net>
Subject: Re: [PATCH v1 7/9]powerpc/powernv: Event attr creation and PMU
 registration
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 11:06:32 +1000
In-Reply-To: <1433260778-26497-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-8-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-3UvNLlBH0iFn4hydQOlX"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3UvNLlBH0iFn4hydQOlX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
> Patch adds common event attribute function and Nest pmu registration call=
.
>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/nest-pmu.c | 52 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
> index 514a0be..dd84fd7 100644
> --- a/arch/powerpc/perf/nest-pmu.c
> +++ b/arch/powerpc/perf/nest-pmu.c
> @@ -244,6 +244,49 @@ static int update_pmu_ops(struct nest_pmu *pmu)
>  	return 0;
>  }
> =20
> +/*
> + * Populate event name and string in attribute
> + */
> +struct attribute *dev_str_attr(char *name, char *str)
> +{
> +	struct perf_pmu_events_attr *attr;
> +
> +	attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> +
> +	attr->event_str =3D (const char *)str;
Erk. Two things:
 - Is str const or not? If you're treating it as const here, should you
pass that through the function signature?
 - Who is responsible for the memory behind it? It looks like a caller
can't construct str dynamically, pass it to this function and then free
it, because that will invalidate attr->event_str. Is this documented?

> +	attr->attr.attr.name =3D name;
> +	attr->attr.attr.mode =3D 0444;
> +	attr->attr.show =3D perf_event_sysfs_show;
> +
> +	return &attr->attr.attr;
If you're returning the address of attr->attr.attr, then:
 - why don't you just deal directly with struct attribute * in the
function? Why an entire struct perf_pmu_events_attr *?
 - with the function as written, if you return just &attr->attr.attr,
don't attr->event_str and attr->attr.show get lost?

> +}
> +
> +int update_events_in_group(
> +	struct ppc64_nest_ima_events *p8_events, int idx,
> +		struct nest_pmu *pmu)
> +{
> +	struct attribute_group *attr_group;
> +	struct attribute **attrs;
> +	int i;
> +
> +	attr_group =3D kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
> +				sizeof(*attr_group)), GFP_KERNEL);
> +	if (!attr_group)
> +		return -ENOMEM;
> +
> +	attrs =3D (struct attribute **)(attr_group + 1);
> +	attr_group->name =3D "events";
> +	attr_group->attrs =3D attrs;
> +
> +	for (i=3D0; i< idx; i++, p8_events++)
> +		attrs[i] =3D dev_str_attr((char *)p8_events->ev_name,
> +						(char *)p8_events->ev_value);
> +
> +	pmu->attr_groups[0] =3D attr_group;
> +	return 0;
> +}
I'm very confused by what this function is trying to do. Could you add
some comments? I'm particularly confused by the relationship between
attrs and attr_group.

> +
> +
>  static int nest_pmu_create(struct device_node *dev, int pmu_index)
>  {
>  	struct ppc64_nest_ima_events **p8_events_arr;
> @@ -364,6 +407,15 @@ static int nest_pmu_create(struct device_node *dev, =
int pmu_index)
>  		}
>  	}
> =20
> +	update_events_in_group(
> +		(struct ppc64_nest_ima_events *)p8_events_arr,
> +							idx, pmu_ptr);
> +	update_pmu_ops(pmu_ptr);
> +
> +	/* Register the pmu */
> +	perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
> +	printk(KERN_INFO "Nest PMU %s Registered\n", pmu_ptr->pmu.name);
> +
>  	return 0;
>  }
> =20

Regards,
Daniel


--=-3UvNLlBH0iFn4hydQOlX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVblMZAAoJEPC3R3P2I92FGdIQANzpg6CJiccMpX6x6PdJVSz1
HRHjpNrK1KcmapqtS+OMOKbT7BAnRuadZgD6WgINOTznw0gpuVPzDpPwvBDjLgc6
tKMyMjMN9cg1f1tW4Mj1nno8MsPg9klCBHXmUQ20otWEaEh/a3AMbCNVGK6unbrV
51Kh8VBGXpKiCHTywQd4j1x1enXKPEmAs5eI4+9VOC8V9YIkljsndDAWAmR/NuLr
S92Y6ubDbvXk2Dln/BU3DggP7j0VTXFigtaTn5qfaf435Dt01qVwk6NqeVBiA4qD
pgs86SAuwQAbxHl3PwQmS4DC4WjH7YxO9tlR/Ej4sU3Sr49+U+cXBc+cpUHuzz6U
c8JPCH5qGNysJjDqLOsKc19X6co7fRhozuN1yANvcI+Y+Jg6MqgfctOOYxIItyXy
wlCQv0u4GSFp1mLvX5bUZrlmm8woRwE2zUJ2SUDm9qVOAbUzNaIebf4gukfWw2v+
eIfrQZP9mGOvqVm0zafXQLFSmYb02ZZ9mFi7CYcrQB6QumewkBJnYD6fR39Td3HY
lcbFPkMDUPaVXgv9x8GbTG9mkIqrl1yC8V7wZRy/s0Q77riTZAriuECqSky7fgEO
29FpisoyEE3oI3eCWPuunebVGe2V3CNFkmSTClIZyDY0lFFeoyEppbTA7AX59lbl
Vi7o8+9eJGPeH7fpvaIO
=7AbK
-----END PGP SIGNATURE-----

--=-3UvNLlBH0iFn4hydQOlX--
