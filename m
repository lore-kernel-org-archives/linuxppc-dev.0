Return-Path: <dja@axtens.net>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 150D61A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 10:04:29 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so60671487pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 17:04:27 -0700 (PDT)
Message-ID: <1433289819.438.38.camel@axtens.net>
Subject: Re: [PATCH v1 4/9]powerpc/powernv: Add generic nest pmu ops
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 10:03:39 +1000
In-Reply-To: <1433260778-26497-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-5-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-grPzKLbrxwBORSTjrpks"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-grPzKLbrxwBORSTjrpks
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
> Patch adds generic nest pmu functions and format attribute.
>=20
I'm not sure this commit message accurately reflects the content of the
patch. At any rate, please could you:
 - say what the patch adds the functions and attributes to.
 - phrase your message as "Add generic ..." not "Patch adds
generic ...": see
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docume=
ntation/SubmittingPatches#n155


> =20
> +PMU_FORMAT_ATTR(event, "config:0-20");
> +struct attribute *p8_nest_format_attrs[] =3D {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +struct attribute_group p8_nest_format_group =3D {
> +	.name =3D "format",
> +	.attrs =3D p8_nest_format_attrs,
> +};
Can these structs be constified?

> +
> +int p8_nest_event_init(struct perf_event *event)
> +{
> +	int chip_id;
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling not supported yet */
> +	if (event->hw.sample_period)
> +		return -EINVAL;
> +
> +	/* unsupported modes and filters */
> +	if (event->attr.exclude_user   ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv     ||
> +	    event->attr.exclude_idle   ||
> +	    event->attr.exclude_host   ||
> +	    event->attr.exclude_guest  ||
> +	    event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
You test for sample period twice here.

> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	chip_id =3D topology_physical_package_id(event->cpu);
> +	event->hw.event_base =3D event->attr.config +
> +				p8_perchip_nest_info[chip_id].vbase;
> +
> +	return 0;
> +}
> +
> +void p8_nest_read_counter(struct perf_event *event)
> +{
> +	u64 *addr;
> +	u64 data =3D 0;
> +
> +	addr =3D (u64 *)event->hw.event_base;
> +	data =3D __be64_to_cpu((uint64_t)*addr);
> +	local64_set(&event->hw.prev_count, data);
> +}
> +
> +void p8_nest_perf_event_update(struct perf_event *event)
> +{
> +	u64 counter_prev, counter_new, final_count;
> +	uint64_t *addr;
> +
> +	addr =3D (u64 *)event->hw.event_base;
> +	counter_prev =3D local64_read(&event->hw.prev_count);
> +	counter_new =3D __be64_to_cpu((uint64_t)*addr);
> +	final_count =3D counter_new - counter_prev;
> +
> +	local64_set(&event->hw.prev_count, counter_new);
> +	local64_add(final_count, &event->count);
> +}
> +
> +void p8_nest_event_start(struct perf_event *event, int flags)
> +{
> +	event->hw.state =3D 0;
> +	p8_nest_read_counter(event);
> +}
> +
> +void p8_nest_event_stop(struct perf_event *event, int flags)
> +{
> +	p8_nest_perf_event_update(event);
> +}
> +
> +int p8_nest_event_add(struct perf_event *event, int flags)
> +{
> +	p8_nest_event_start(event, flags);
> +	return 0;
> +}
> +
> +void p8_nest_event_del(struct perf_event *event, int flags)
> +{
> +	p8_nest_event_stop(event, flags);
Is this necessary?

Stop calls update, which I guess makes sense as it finalises the value.
But if the event is being deleted anyway, why not just do nothing here?
> +}
> +

Regards,
Daniel Axtens

--=-grPzKLbrxwBORSTjrpks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbkRbAAoJEPC3R3P2I92FrtIP/3zRvYtLrarGxnw6TER8BKE3
DHz97mzLkxQAtu+OPCYEc7YCen0Kd4ny9xDjsGmGhA42LfiqMo/a+au/jqtu9zgE
tZxkz/EEqqRygPfe72y5lUb0J9tyKuSR0UJQKaYbnR+7zdhvBl4H1E/DgXYdhsmo
45w/bEJw5Q136xr95pKtzvAfTGBOmUv2XU9XIzhD+W5Edzr6Y/qKtWyp7Z3DcVSo
ZuRkGU9qDAnYkXJkfJXJaMcCulZWt9CrePs9W0Zn9x3GG7XmRbZT5XZZi9gWpDRZ
TFzn+lUGWk9EiuXo32wRDHOpgQiesaa8aUkqL/QtNADlkaXWDE6QO3NfVQ0I3KZ2
vTFZP8wNaUO8MvYewiiurFB6oeAlbhJ8U/yZoBQ9TWlv3tCJ6DVl3BXwTPxR9058
MiaMIOUYwv0Lm0IKpSAOzf8U50bzvjFr0i/KwS78kdGsTE+DIVPJuM2z9Zv5si3E
BMGZYbJc5QcS7T13VlodTgStt1jpF4oEEswmTwTtEhlm2gxYkkNLklej9e/SeP7i
cy8DYUdk+FuyYNGUPeGcs4gk+G8d0jkI/h5OZsqM9KLGyfikG3noLw8gMT7aMKtl
DFo4Mc2GjxzufHKGnkPxsGjytwKs1FpxM5RmyHQGSEQPbjA2f+CFRVtoyZmh3sZ4
99Lvr6M80TlQP8UwcToJ
=Z6dh
-----END PGP SIGNATURE-----

--=-grPzKLbrxwBORSTjrpks--
