Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6608D1A1A3C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 14:09:38 +1000 (AEST)
Received: by pabkd10 with SMTP id kd10so59285316pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:09:35 -0700 (PDT)
Message-ID: <1437538064.30906.20.camel@axtens.net>
Subject: Re: [PATCH v5 4/7] powerpc/powernv: detect supported nest pmus and
 its events
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 14:07:44 +1000
In-Reply-To: <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-/Bdobyz4nnAGlzVbuzDU"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-/Bdobyz4nnAGlzVbuzDU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=20
>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
> +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
> +
> +static int nest_event_info(struct property *pp, char *name,
> +			struct nest_ima_events *p8_events, int string, u32 val)
'int string' is a bit confusing. 'bool is_string' might be clearer, but
I think it would be even better still to have different functions for
string and non-string cases, especially because you only need val in the
non-string case.

That will also allow you to give the functions clearer names. I think
the function is populating the event with info from the dt property (in
the string case) or the val argument (non-string case) - maybe the names
could reflect that somehow?
> +{
> +	char *buf;
> +


> +
> +static int nest_pmu_create(struct device_node *dev, int pmu_index)
> +{
> +	struct nest_ima_events **p8_events_arr, *p8_events;
> +	struct nest_pmu *pmu_ptr;
> +	struct property *pp;
> +	char *buf, *start;
> +	const __be32 *lval;
> +	u32 val;
> +	int idx =3D 0, ret;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	/* memory for nest pmus */
> +	pmu_ptr =3D kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
> +	if (!pmu_ptr)
> +		return -ENOMEM;
> +
> +	/* Needed for hotplug/migration */
> +	per_nest_pmu_arr[pmu_index] =3D pmu_ptr;
> +
> +	/* memory for nest pmu events */
> +	p8_events_arr =3D kzalloc((sizeof(struct nest_ima_events) * 64),
> +								GFP_KERNEL);
> +	if (!p8_events_arr)
> +		return -ENOMEM;
> +	p8_events =3D (struct nest_ima_events *)p8_events_arr;

I'm still quite uncomfortable with this.
 - Why * 64? Should it be * P8_NEST_MAX_EVENTS_SUPPORTED? Or is it a
different constant?
 - p8_events =3D p8_events_arr[0] would be clearer

> +
> +	/*
> +	 * Loop through each property
> +	 */
> +	for_each_property_of_node(dev, pp) {
> +		start =3D pp->name;
> +
> +		if (!strcmp(pp->name, "name")) {
> +			if (!pp->value ||
> +			   (strnlen(pp->value, pp->length) =3D=3D pp->length) ||
> +			   (pp->length > P8_NEST_MAX_PMU_NAME_LEN))
> +				return -EINVAL;
> +
> +			buf =3D kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
> +			if (!buf)
> +				return -ENOMEM;
> +
> +			/* Save the name to register it later */
> +			sprintf(buf, "Nest_%s", (char *)pp->value);
> +			pmu_ptr->pmu.name =3D (char *)buf;
> +			continue;
> +		}
> +
> +		/* Skip these, we dont need it */
"don't" instead of "dont".
> +		if (!strcmp(pp->name, "phandle") ||
> +		    !strcmp(pp->name, "device_type") ||
> +		    !strcmp(pp->name, "linux,phandle"))
> +			continue;
> +
> +		if (strncmp(pp->name, "unit.", 5) =3D=3D 0) {
> +			/* Skip first few chars in the name */
The whole comment is pretty uninformative, as is the similar comment
below. If you need a comment at all, maybe something along the lines of
"Strip the prefix because <reason we don't need/want the prefix>"?
> +			start +=3D 5;
> +			ret =3D nest_event_info(pp, start, p8_events++, 1, 0);
> +		} else if (strncmp(pp->name, "scale.", 6) =3D=3D 0) {
> +			/* Skip first few chars in the name */
> +			start +=3D 6;
> +			ret =3D nest_event_info(pp, start, p8_events++, 1, 0);
> +		} else {
> +			lval =3D of_get_property(dev, pp->name, NULL);
> +			val =3D (uint32_t)be32_to_cpup(lval);
> +
> +			ret =3D nest_event_info(pp, start, p8_events++, 0, val);
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		/* book keeping */
> +		idx++;
You don't seem to use idx in this function, apart from incrementing it
here...?
> +	}
> +
> +	return 0;
> +}


--=20
Regards,
Daniel

--=-/Bdobyz4nnAGlzVbuzDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVrxcQAAoJEPC3R3P2I92FsCEP/Rf+YM34gZBAVGZga9mqgR7z
KqeutpiFUua+LgU0u75Le1I63LrtAkt4bbk/v58nicyH9ph4IgUFGcJZTQOXy5ue
iwf+RwxajEtGXcE+iH8nPGQGY6g9C/W/4DTzgHjS+8o5iumrx5MePEJnEUrWnvK8
Kc+Lo9VPU6vILfGTh4WRtGdg0x54vWAH3ospu6EQXpyb9NrQzubNsbF3miaBaAnG
aItr9OTlNPOj747WUho+veWYNFKJC8BUPlTpLaY19HwF5m660BU3AMfSObzCezZj
RjXIHfO3rQUv2gZz1nGM/8/+i/HDRpLpUlDgVCeeKysRR4wlS2ZK2LxhV8LegibS
QjQ6PvyxX5NOENbF6tDxqJPshCqEZhDQeQ1vMPPYD9MjMWwPeHG7bOgcrSNibNuc
XG63XSYQ17r+K+pQtjabaJAODLswaX6SKYF48M75rfp+oorOjFrstqf1SjMxUPnQ
3QyOUbEk5bNrRWtUp8TbmYyPg3mc/KS7LrdZ//65ic7kEsk/RFwrCEdnlzec1ejY
CmewDJJg40vfr2g4aFvhH1akDAml9ffSvGdzdNUCsM3yy1+ZCVM3+AvHD2w6zcsK
Kg8mSag3Y980ZDguWqSHRvMgkIETF6vBvnObEUrwJCC29ABvc/qb3SyFTPbHNZO4
GYURqdKKzSbdWDfx/tgP
=ABZ9
-----END PGP SIGNATURE-----

--=-/Bdobyz4nnAGlzVbuzDU--
