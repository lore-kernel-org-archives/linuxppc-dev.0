Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QkM14H9fzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 02:00:57 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6BFwxGv037791
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 12:00:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k5khq49e5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 12:00:54 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 11 Jul 2018 17:00:52 +0100
Date: Wed, 11 Jul 2018 21:30:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v06 1/9] hotplug/cpu: Conditionally acquire/release DRC
 index
To: linuxppc-dev@lists.ozlabs.org, Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <a86bdaf8-ad27-ffb4-aa89-77294c98010f@linux.vnet.ibm.com>
In-Reply-To: <a86bdaf8-ad27-ffb4-aa89-77294c98010f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1531324062.imrh0yfelc.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann wrote:
> powerpc/cpu: Modify dlpar_cpu_add and dlpar_cpu_remove to allow the
> skipping of DRC index acquire or release operations during the CPU
> add or remove operations.  This is intended to support subsequent
> changes to provide a 'CPU readd' operation.
>=20
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in patch:
>   -- Move new validity check added to pseries_smp_notifier
>      to another patch
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |   68 +++++++++++++++-----=
------
>  1 file changed, 39 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index 6ef77ca..3632db2 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -432,7 +432,7 @@ static bool valid_cpu_drc_index(struct device_node *p=
arent, u32 drc_index)
>  	return found;
>  }
>=20
> -static ssize_t dlpar_cpu_add(u32 drc_index)
> +static ssize_t dlpar_cpu_add(u32 drc_index, bool acquire_drc)
>  {
>  	struct device_node *dn, *parent;
>  	int rc, saved_rc;
> @@ -457,19 +457,22 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  		return -EINVAL;
>  	}
>=20
> -	rc =3D dlpar_acquire_drc(drc_index);
> -	if (rc) {
> -		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
> -			rc, drc_index);
> -		of_node_put(parent);
> -		return -EINVAL;
> +	if (acquire_drc) {
> +		rc =3D dlpar_acquire_drc(drc_index);
> +		if (rc) {
> +			pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
> +				rc, drc_index);
> +			of_node_put(parent);
> +			return -EINVAL;
> +		}
>  	}
>=20
>  	dn =3D dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>  	if (!dn) {
>  		pr_warn("Failed call to configure-connector, drc index: %x\n",
>  			drc_index);
> -		dlpar_release_drc(drc_index);
> +		if (acquire_drc)
> +			dlpar_release_drc(drc_index);
>  		of_node_put(parent);
>  		return -EINVAL;
>  	}
> @@ -484,8 +487,9 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
>  			dn->name, rc, drc_index);
>=20
> -		rc =3D dlpar_release_drc(drc_index);
> -		if (!rc)
> +		if (acquire_drc)
> +			rc =3D dlpar_release_drc(drc_index);
> +		if (!rc || acquire_drc)
>  			dlpar_free_cc_nodes(dn);

(!rc) can only be true if acquire_drc is true, so we seem to be only=20
invoking dlpar_free_cc_nodes() if acquire_drc is true. Would it be=20
better to frame that condition in this manner:

	if (acquire_drc) {
		rc =3D dlpar_release_drc(drc_index):
		if (!rc)
			dlpar_free_cc_nodes(dn);
	}

>=20
>  		return saved_rc;
> @@ -498,7 +502,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  			dn->name, rc, drc_index);
>=20
>  		rc =3D dlpar_detach_node(dn);
> -		if (!rc)
> +		if (!rc && acquire_drc)
>  			dlpar_release_drc(drc_index);
>=20
>  		return saved_rc;
> @@ -566,7 +570,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
>=20
>  }
>=20
> -static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> +static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
> +				bool release_drc)
>  {
>  	int rc;
>=20
> @@ -579,12 +584,14 @@ static ssize_t dlpar_cpu_remove(struct device_node =
*dn, u32 drc_index)
>  		return -EINVAL;
>  	}
>=20
> -	rc =3D dlpar_release_drc(drc_index);
> -	if (rc) {
> -		pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
> -			drc_index, dn->name, rc);
> -		dlpar_online_cpu(dn);
> -		return rc;
> +	if (release_drc) {
> +		rc =3D dlpar_release_drc(drc_index);
> +		if (rc) {
> +			pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
> +				drc_index, dn->name, rc);
> +			dlpar_online_cpu(dn);
> +			return rc;
> +		}
>  	}
>=20
>  	rc =3D dlpar_detach_node(dn);
> @@ -593,7 +600,10 @@ static ssize_t dlpar_cpu_remove(struct device_node *=
dn, u32 drc_index)
>=20
>  		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
>=20
> -		rc =3D dlpar_acquire_drc(drc_index);
> +		if (release_drc)
> +			rc =3D dlpar_acquire_drc(drc_index);
> +		else
> +			rc =3D 0;
>  		if (!rc)
>  			dlpar_online_cpu(dn);

Here, we seem to want to invoke dlpar_online_cpu() unconditionally if=20
release_drc is false. So, to make that explicit, would it be better to=20
frame that as:
	if (release_drc)
		rc =3D dlpar_acquire_drc(drc_index);
	if (!release_drc || !rc)
		dlpar_online_cpu(dn);

- Naveen

>=20
> @@ -622,7 +632,7 @@ static struct device_node *cpu_drc_index_to_dn(u32 dr=
c_index)
>  	return dn;
>  }
>=20
> -static int dlpar_cpu_remove_by_index(u32 drc_index)
> +static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
>  {
>  	struct device_node *dn;
>  	int rc;
> @@ -634,7 +644,7 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  		return -ENODEV;
>  	}
>=20
> -	rc =3D dlpar_cpu_remove(dn, drc_index);
> +	rc =3D dlpar_cpu_remove(dn, drc_index, release_drc);
>  	of_node_put(dn);
>  	return rc;
>  }
> @@ -699,7 +709,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remo=
ve)
>  	}
>=20
>  	for (i =3D 0; i < cpus_to_remove; i++) {
> -		rc =3D dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +		rc =3D dlpar_cpu_remove_by_index(cpu_drcs[i], true);
>  		if (rc)
>  			break;
>=20
> @@ -710,7 +720,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remo=
ve)
>  		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
>=20
>  		for (i =3D 0; i < cpus_removed; i++)
> -			dlpar_cpu_add(cpu_drcs[i]);
> +			dlpar_cpu_add(cpu_drcs[i], true);
>=20
>  		rc =3D -EINVAL;
>  	} else {
> @@ -780,7 +790,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  	}
>=20
>  	for (i =3D 0; i < cpus_to_add; i++) {
> -		rc =3D dlpar_cpu_add(cpu_drcs[i]);
> +		rc =3D dlpar_cpu_add(cpu_drcs[i], true);
>  		if (rc)
>  			break;
>=20
> @@ -791,7 +801,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  		pr_warn("CPU hot-add failed, removing any added CPUs\n");
>=20
>  		for (i =3D 0; i < cpus_added; i++)
> -			dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +			dlpar_cpu_remove_by_index(cpu_drcs[i], true);
>=20
>  		rc =3D -EINVAL;
>  	} else {
> @@ -817,7 +827,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc =3D dlpar_cpu_remove_by_count(count);
>  		else if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc =3D dlpar_cpu_remove_by_index(drc_index);
> +			rc =3D dlpar_cpu_remove_by_index(drc_index, true);
>  		else
>  			rc =3D -EINVAL;
>  		break;
> @@ -825,7 +835,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc =3D dlpar_cpu_add_by_count(count);
>  		else if (hp_elog->id_type =3D=3D PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc =3D dlpar_cpu_add(drc_index);
> +			rc =3D dlpar_cpu_add(drc_index, true);
>  		else
>  			rc =3D -EINVAL;
>  		break;
> @@ -850,7 +860,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_=
t count)
>  	if (rc)
>  		return -EINVAL;
>=20
> -	rc =3D dlpar_cpu_add(drc_index);
> +	rc =3D dlpar_cpu_add(drc_index, true);
>=20
>  	return rc ? rc : count;
>  }
> @@ -871,7 +881,7 @@ static ssize_t dlpar_cpu_release(const char *buf, siz=
e_t count)
>  		return -EINVAL;
>  	}
>=20
> -	rc =3D dlpar_cpu_remove(dn, drc_index);
> +	rc =3D dlpar_cpu_remove(dn, drc_index, true);
>  	of_node_put(dn);
>=20
>  	return rc ? rc : count;
>=20
>=20
=
