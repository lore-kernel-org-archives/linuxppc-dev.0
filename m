Return-Path: <dja@axtens.net>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57F1A1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 10:47:09 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so144271442pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 17:47:06 -0700 (PDT)
Message-ID: <1433292378.438.58.camel@axtens.net>
Subject: Re: [PATCH v1 6/9]powerpc/powernv: dt parser function for nest pmu
 and its events
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 10:46:18 +1000
In-Reply-To: <1433260778-26497-7-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-7-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-bfjZ9G2BF4b52N3RRZAP"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bfjZ9G2BF4b52N3RRZAP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> +static int nest_pmu_create(struct device_node *dev, int pmu_index)
> +{
> +	struct ppc64_nest_ima_events **p8_events_arr;
> +	struct ppc64_nest_ima_events *p8_events;
> +	struct property *pp;
> +	char *buf;
> +	const __be32 *lval;
> +	u32 val;
> +	int len, idx =3D 0;
> +	struct nest_pmu *pmu_ptr;
> +	const char *start, *end;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	pmu_ptr =3D kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
> +	if (!pmu_ptr)
> +		return -ENOMEM;
> +
> +	/* Needed for hotplug/migration */
> +	per_nestpmu_arr[pmu_index] =3D pmu_ptr;
> +
> +	p8_events_arr =3D kzalloc((sizeof(struct ppc64_nest_ima_events) * 64),
> +								GFP_KERNEL);
> +	if (!p8_events_arr)
> +		return -ENOMEM;
> +	p8_events =3D (struct ppc64_nest_ima_events *)p8_events_arr;
I think you're trying to get the first element of the array here: why
not just `p8_events =3D p8_events_arr[0];`?

> +
> +	/*
> +	 * Loop through each property
> +	 */
> +	for_each_property_of_node(dev, pp) {
> +		start =3D pp->name;
> +		end =3D start + strlen(start);
> +		len =3D strlen(start);
> +
> +		if (!strcmp(pp->name, "name")) {
> +			if (!pp->value ||
> +			   (strnlen(pp->value, pp->length) >=3D pp->length))
> +				return -EINVAL;
> +
> +			buf =3D kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
> +			if (!buf)
> +				return -ENOMEM;
> +
> +			sprintf(buf, "Nest_%s", (char *)pp->value);
> +			pmu_ptr->pmu.name =3D (char *)buf;
> +			pmu_ptr->attr_groups[1] =3D &p8_nest_format_group;
> +			pmu_ptr->attr_groups[2] =3D &cpumask_nest_pmu_attr_group;
> +		}
> +
> +		/* Skip these, we dont need it */
> +		if (!strcmp(pp->name, "name") ||
> +		    !strcmp(pp->name, "phandle") ||
> +		    !strcmp(pp->name, "device_type") ||
> +		    !strcmp(pp->name, "linux,phandle"))
> +			continue;
> +
> +		buf =3D kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +
> +		if (strncmp(pp->name, "unit.", 5) =3D=3D 0) {
> +			start +=3D 5;
> +			len =3D strlen(start);
> +			strncpy(buf, start, strlen(start));
You've just saved strlen(start), you could just use len. This also
applies in the next case below.
> +			p8_events->ev_name =3D buf;
> +
> +			if (!pp->value ||
> +                            (strnlen(pp->value, pp->length) >=3D pp->len=
gth))
> +				return -EINVAL;
The strnlen will never be greater than pp->length, so the only case this
will hit is if strnlen(pp->value, pp->length) =3D=3D pp->length. This also
applies again below.

> +
> +			buf =3D kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
> +			if (!buf)
> +				return -ENOMEM;
> +
> +			strncpy(buf, (const char *)pp->value, pp->length);
> +			p8_events->ev_value =3D buf;
> +			idx++;
> +			p8_events++;
> +
> +		} else if (strncmp(pp->name, "scale.", 6) =3D=3D 0) {
> +			start +=3D 6;
> +			len =3D strlen(start);
> +			strncpy(buf, start, strlen(start));
> +			p8_events->ev_name =3D buf;
> +
> +			if (!pp->value ||
> +			   (strnlen(pp->value, pp->length) >=3D pp->length))
> +				return -EINVAL;
> +
> +			buf =3D kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
> +			if (!buf)
> +				return -ENOMEM;
> +
> +			strncpy(buf, (const char *)pp->value, pp->length);
> +			p8_events->ev_value =3D buf;
> +			idx++;
> +			p8_events++;
> +
> +		} else {
> +			strncpy(buf, start, len);
This is the only case where you actually use the orignal version of len.
This makes me think you could drop the variable entirely and just use
strlen(start) in all cases. I also don't see where `end` is used
anywhere in this function: could that be dropped?
> +			p8_events->ev_name =3D buf;
> +			lval =3D of_get_property(dev, pp->name, NULL);
> +			val =3D (uint32_t)be32_to_cpup(lval);
> +
> +			/*
> +			* Use DT property value as the event
> +			*/
I'm not sure if this is my mailer, but it looks like lines 2 and 3 of
that comment need to be indented to line up under the * in the first
line.
> +			buf =3D kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
> +			if (!buf)
> +                                return -ENOMEM;
> +
> +			sprintf(buf,"event=3D0x%x", val);
> +			p8_events->ev_value =3D buf;
> +			p8_events++;
> +			idx++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

> @@ -288,7 +427,7 @@ static int __init nest_pmu_init(void)
>  	cpumask_chip();
> =20
>  	/*
> -	 * Detect the Nest PMU feature
> +	 * Detect the Nest PMU feature and register the pmus
>  	 */
>  	if (nest_ima_detect_parse())
>  		return 0;
As the changed comment indicates, this function changes the behaviour of
nest_ima_detect_parse. Given that it's a new function introduced by this
patch series, maybe it should also change names.



--=-bfjZ9G2BF4b52N3RRZAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbk5aAAoJEPC3R3P2I92FwLkP/2pZbsZ9fcwBmB3rd+vdnqOa
9aOX/KF53rxrghFPidDrmdXEyOup0ATPCIdXbU2hHkV8zTasTTolcK5GiRiOZQkr
gDeINkH5QpDk58KBULWFnbw6aO7imWzOKnPdCP751KgNtZ1HgXRs96VD1OjUoLc3
iYcDqYVmsivfMDa8VtwfWU3Lzyy4h1XIB7wXz0wsq/3OjniFTf1v4x0UWlRjOP94
9p6SQZkSMMF+b/oyVm7XKMAEqk9/EZBzu4Q+2/q7VAPfBaX5TbmGI4JPCzcKUOeF
pcd39iaEwiVPHodpqZaI4FOZ0XkoFu2GLPhBApssdnjPCQEQHSltNDp4JS4PsWve
Ratmp+v7nieFrBS4TBd2zn4ap7y18oXWv9G1QA6dM6Yg1i0dnM/9BZwithkvjB/6
8798LH8weTSVmmRLMovZbBwMz6N59X9xQ8NoZsq6Skqnpw4N13XZH2Q2RVFYpHfx
amNoUgxqm09+qCL1veNGVIkqNgKxD5es8NxQu+/IsSyIrAgDOKyXSkgSOiA5hMP5
hBaH6Lr0oOUVw+KaY/FCOqv2yw3R8QutQw3rtk+amThU6e/AwcKxxfyrY0p8MD6G
cgFuuXbPSjXF4HmSTE4NLGB1XHfxruvrgHIaUg8a1NQ/sI4r6n9krJYFfuNPqcXJ
zx9qzGe2SppKW6NHj6TD
=lLT1
-----END PGP SIGNATURE-----

--=-bfjZ9G2BF4b52N3RRZAP--
