Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 118C71A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 09:15:40 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so142885353pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 16:15:38 -0700 (PDT)
Message-ID: <1433286889.438.13.camel@axtens.net>
Subject: Re: [PATCH v1 2/9]powerpc/powernv: nest pmu init function with
 cpumask attr
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Preeti U Murthy
 <preeti@linux.vnet.ibm.com>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 09:14:49 +1000
In-Reply-To: <1433260778-26497-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-3-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-wUvBtxTCN0sKNtuDJftd"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-wUvBtxTCN0sKNtuDJftd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
> Patch creates a file "nest-pmu-c" to contain nest pmu related functions.
"nest-pmu.c"
> Patch adds nest pmu init function and cpumask function since Nest pmu uni=
ts
> are per-chip. First online cpu for a given node is picked as
> designated thread to read the counter data.
>=20
> Subsequent patch adds the hotplug support.
>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/nest-pmu.c | 70 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 arch/powerpc/perf/nest-pmu.c
>=20
> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
> new file mode 100644
> index 0000000..d4413bb
> --- /dev/null
> +++ b/arch/powerpc/perf/nest-pmu.c
> @@ -0,0 +1,70 @@
> +/*
> + * Nest Performance Monitor counter support for POWER8 processors.
> + *
> + * Copyright 2015 Madhavan Srinivasan, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
Again, I think this is supposed to be v2 only.

> +#include "nest-pmu.h"
> +
> +static cpumask_t cpu_mask_nest_pmu;
> +
> +static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return cpumap_print_to_pagebuf(true, buf, &cpu_mask_nest_pmu);
> +}
> +
> +static DEVICE_ATTR(cpumask, S_IRUGO, cpumask_nest_pmu_get_attr, NULL);
> +
> +static struct attribute *cpumask_nest_pmu_attrs[] =3D {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cpumask_nest_pmu_attr_group =3D {
> +	.attrs =3D cpumask_nest_pmu_attrs,
> +};
> +
> +void cpumask_chip(void)
> +{
> +	const struct cpumask *l_cpumask;
> +	int cpu, nid;
> +
> +	if (!cpumask_empty(&cpu_mask_nest_pmu)) {
> +		printk(KERN_INFO "cpumask not empty\n");
> +		return;
> +	}
> +
> +	cpu_notifier_register_begin();
> +	for_each_online_node(nid) {
> +		l_cpumask =3D cpumask_of_node(nid);
> +		cpu =3D cpumask_first(l_cpumask);
> +		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
> +	}
> +
> +	cpu_notifier_register_done();
> +}
It's not clear from the name of this function what it does. I don't
think I actually understand what it does: it appears to register a
notifier on the first cpu of each node; maybe that should be reflected
in the name.

> +static int __init nest_pmu_init(void)
> +{
> +	int ret =3D 0;
> +
> +	/*
> +	 * Lets do this only if we are hypervisor
> +	 */
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
> +	   strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") ||
> +	   !cpu_has_feature(CPU_FTR_HVMODE))
> +		return ret;
> +
> +	cpumask_chip();
> +
> +	return 0;
> +}
 - Where is ret set? I can only see it set when it's defined: the if
statment doesn't change the value of ret as far as I can see...

 - Would it be clearer if you said
        !(strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") =3D=3D 0)
   That would make it clearer that you're trying to get a list of
possible failure conditions.
=20
 - Is there really no better way to check if a CPU is a power 8 than an
string comparison?

> +device_initcall(nest_pmu_init);

Regards,
Daniel Axtens

--=-wUvBtxTCN0sKNtuDJftd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbjjpAAoJEPC3R3P2I92FMY4P/RSySbQkZhVHnLbC6E3R0w6w
95suMaaK12Uy3GQIGauT6apbR83WxwdVMBW1MVUfhbuhk0yjIM0WFkkTh40V0k47
V4IO1M9hSTDbeGOcH380jcTdJYYQX34OXmKB24DTgev0KVjGA53WbfRLee6Hb40q
8a/BGgawL+nmxAaMiW+eFSBto3HPMDUJJkbQ7Qs8J5Bh15RaIwMHm9oRn5VihvoF
JHP/oHAJWvXILgYLSWWpMNrcbLTN2Xvw6dC6Usw3IMD0LQhfNFMMwacBMde/1wu1
Qzl2VkxpN0CxzBXo+QLifAm9vdUTNuJK2MWNR3f3+1N5+wyErimU6XunniK90b0w
CNbrtOTU7wrgSXB1h5Ju1TWQ+VNObdh9WiegNVimIbHpkqdXtCDZWlrgJopTFTBl
8wXamwiZbfeDQ0Lwit/qFcueE4TzLIF5dO8NjUuAfzBUTOgt624CKfqq7zJeC0EI
m5csn2XcgF429QjmGZ2soUmcsZ4NrtXffOHBOpnmkNpshf2lEbp2iAh9NqE3CuPQ
+ERp7m0gxLbtrSSgkjjr0FquGNwHAN7PbrRf5/JhxNocjW/Ie8D97z1mzq9xUu6g
H46YgJlqInGRW9GBGvYnKxwjqRzDYlg9ix/iOHpWasfuZi8YnNnGpnp+Wu+pJfA8
nRnrqEITdgPzusX3sdKf
=89RX
-----END PGP SIGNATURE-----

--=-wUvBtxTCN0sKNtuDJftd--
