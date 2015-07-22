Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6BA1A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 14:46:48 +1000 (AEST)
Received: by pdjr16 with SMTP id r16so134432119pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:46:46 -0700 (PDT)
Message-ID: <1437540294.30906.30.camel@axtens.net>
Subject: Re: [PATCH v5 5/7] powerpc/powernv: add event attribute and group
 to nest pmu
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 14:44:54 +1000
In-Reply-To: <1437045206-7491-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-6-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-8WvJsVQhIMhMJI5QxNct"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8WvJsVQhIMhMJI5QxNct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2015-07-16 at 16:43 +0530, Madhavan Srinivasan wrote:
> Add code to create event/format attributes and attribute groups for
> each nest pmu.
>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/nest-pmu.c | 65 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
> index c4c08e4dee55..f3418bdec1cd 100644
> --- a/arch/powerpc/perf/nest-pmu.c
> +++ b/arch/powerpc/perf/nest-pmu.c
> @@ -13,6 +13,17 @@
>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>  static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
> =20
> +PMU_FORMAT_ATTR(event, "config:0-20");
> +static struct attribute *p8_nest_format_attrs[] =3D {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group p8_nest_format_group =3D {
> +	.name =3D "format",
> +	.attrs =3D p8_nest_format_attrs,
> +};
> +
>  static int nest_event_info(struct property *pp, char *name,
>  			struct nest_ima_events *p8_events, int string, u32 val)
>  {
> @@ -46,6 +57,56 @@ static int nest_event_info(struct property *pp, char *=
name,
>  	return 0;
>  }
> =20
> +/*
> + * Populate event name and string in attribute
> + */
> +static struct attribute *dev_str_attr(const char *name, const char *str)
> +{
> +	struct perf_pmu_events_attr *attr;
> +
> +	attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> +
> +	sysfs_attr_init(&attr->attr.attr);
> +
> +	attr->event_str =3D str;
> +	attr->attr.attr.name =3D name;
> +	attr->attr.attr.mode =3D 0444;
> +	attr->attr.show =3D perf_event_sysfs_show;
> +
> +	return &attr->attr.attr;
So I asked you about this before, and you pointed me to
perf_event_sysfs_show. Looking at that in kernel/events/core.c, it looks
like that uses container_of to pull out the perf_pmu_events_attr. So I
guess that is at least mostly correct.

I'm hoping something else uses container_of to pull out attr->attr, so
that they can actually grab the attr->attr.show function pointer, so
that perf_event_sysfs_show actually gets called. Where would that be?

> +}
> +
> +static int update_events_in_group(
> +	struct nest_ima_events *p8_events, int idx, struct nest_pmu *pmu)
> +{
> +	struct attribute_group *attr_group;
> +	struct attribute **attrs;
> +	int i;
> +
> +	/*
> +	 * Allocate memory for both event attribute group and for
> +	 * event attributes array.
> +	 */
> +	attr_group =3D kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
> +				sizeof(*attr_group)), GFP_KERNEL);
> +	if (!attr_group)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Assign memory for event attribute array
> +	 */
> +	attrs =3D (struct attribute **)(attr_group + 1);
> +	attr_group->name =3D "events";
> +	attr_group->attrs =3D attrs;
I am super uncomfortable with this block, especially the assignment to
attrs. I *think* you're trying to allocate an attribute group and a set
of attributes, but you've combined the allocation into one big
contiguous chunk, and then you're trying to tease them apart. Is that
necessary? Could it be two allocs, one for the attribute_group and one
for the attribute?

--=20
Regards,
Daniel

--=-8WvJsVQhIMhMJI5QxNct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVrx/GAAoJEPC3R3P2I92FRJQQAJm23zIpG0JK5klaAp09KH9m
qeRsAzTtwuogpVUFbmG+LxQD/GGFgkoJLYamJ1HKLisbFuCo6EkcS0KKZLTMC2uc
wi+HdwU3WQocnQ/bMKrF32daKtQ9R2WVq67Daza01BGQuvkzJLTmoLNIDB4wS6Fy
dgMvMe/ngq+CsvRu2McVDNVy32jDMHvSR/06AhfL4TtxwgOg5+crLXlokSGOT7wY
szTGTC5XQox1wm/ZJxyA6Z//imAM+vYONMABK/ou+yNhdEbtyXoebmYvHdqyRW7o
fCFlPRRMGwbp7dYbfbMtv3rcBtbI//bAcUPeb5Z0yldpqwZCJdvyUhUz2kqPIwAp
BnVXWNH0un4MEH2EdQ7JTxfRWjUSyPaU3lOyxB+Q91XVqAuGN1CKi6BTWi481eNV
kuTjjA0mIyxoTn0Ln+8qJgg5fs53L97x3BPOT71CBna5fhq1noHLwFVznbiNCak2
x6nSJCYSu1DKGj47PL5iM/UtVJPgBTNbI2xeekIArvDmCpamS4WI2dmbaGspXksl
JAqOi/pBZHF8fSVbwqecOuDQwPiDptAIZGL/rht+zTVNMsnHKvcI5RIs9o3AQOcY
Zz5ExjMZUq2oXIua3ed8Zq5/+TGcW0HPm8pZ/DA/+pkjFg5p7NeX7LzTexDdsoai
2lbTPWoWRZuH6yysh4j7
=R2yZ
-----END PGP SIGNATURE-----

--=-8WvJsVQhIMhMJI5QxNct--
