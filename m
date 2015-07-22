Return-Path: <dja@axtens.net>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F6631A1A34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 13:51:36 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so131248051pdr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:51:33 -0700 (PDT)
Message-ID: <1437536981.30906.9.camel@axtens.net>
Subject: Re: [PATCH v5 3/7] powerpc/powernv: Nest PMU detection and device
 tree parser
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 13:49:41 +1000
In-Reply-To: <1437045206-7491-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-4-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-kX+xYsq+0FG/YOIK7Wfj"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-kX+xYsq+0FG/YOIK7Wfj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> +static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
> +
> +static int nest_ima_dt_parser(void)
> +{
> +	const __be32 *gcid;
> +	const __be64 *chip_ima_reg;
> +	const __be64 *chip_ima_size;
> +	struct device_node *dev;
> +	struct perchip_nest_info *p8ni;
> +	int idx;
> +
> +	/*
> +	 * "nest-ima" folder contains two things,
> +	 * a) per-chip reserved memory region for Nest PMU Counter data
> +	 * b) Support Nest PMU units and their event files
> +	 */
> +	for_each_node_with_property(dev, "ibm,ima-chip") {
> +		gcid =3D of_get_property(dev, "ibm,chip-id", NULL);
> +		chip_ima_reg =3D of_get_property(dev, "reg", NULL);
> +		chip_ima_size =3D of_get_property(dev, "size", NULL);
> +
> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
> +			pr_err("Nest_PMU: device %s missing property\n",
> +							dev->full_name);
> +			return -ENODEV;
> +		}
> +
> +		/* chip id to save reserve memory region */
> +		idx =3D (uint32_t)be32_to_cpup(gcid);
So be32_to_cpup returns a __u32. You're casting to a uint32_t and then
assigning to an int.
 - Do you need the intermediate cast?
 - Should idx be an unsigned type?
> +
> +		/*
> +		 * Using a local variable to make it compact and
> +		 * easier to read
> +		 */
We probably don't need this comment. But a better variable name would be
helpful!=20
> +		p8ni =3D &p8_nest_perchip_info[idx];
> +		p8ni->pbase =3D be64_to_cpup(chip_ima_reg);
> +		p8ni->size =3D be64_to_cpup(chip_ima_size);
> +		p8ni->vbase =3D (uint64_t) phys_to_virt(p8ni->pbase);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init nest_pmu_init(void)
> +{
> +	int ret =3D -ENODEV;
> +
> +	/*
> +	 * Lets do this only if we are hypervisor
> +	 */
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
> +	    !(strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") =3D=3D 0)=
 ||
> +	    !cpu_has_feature(CPU_FTR_HVMODE))
> +		return ret;
> +
I'm still really uncomfortable with doing this via oprofile_cpu_type.
If the kernel is compiled without oprofile support, will that get
populated?

I'm also curious about why we need checking for power8 at all. We
already know we're not going to run on hardware without a nest PMU
because of the device tree check below.=20

What happens if there's a future generation of chip that supports nest
PMUs?

If it's really important to check versions in this function, maybe you
could put a version property in the ibm,ima-chip node?
> +	/*
> +	 * Nest PMU information is grouped under "nest-ima" node
> +	 * of the top-level device-tree directory. Detect Nest PMU
> +	 * by the "ibm,ima-chip" property.
> +	 */
> +	if (!of_find_node_with_property(NULL, "ibm,ima-chip"))
> +		return ret;
> +
> +	/*
> +	 * Parse device-tree for Nest PMU information
> +	 */
> +	ret =3D nest_ima_dt_parser();
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +device_initcall(nest_pmu_init);

--=20
Regards,
Daniel

--=-kX+xYsq+0FG/YOIK7Wfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVrxLVAAoJEPC3R3P2I92F97YP/jNCHgTGxWUhd4s5GcuuS0ZU
aEdirldcCxyGsV08gdJK3+Nt2mcOEoDWG3zwnkUjhXR9q7CoFbK2Sl/2PY5ZBWGq
31cwH4u85YP9sgkSzDxMD62wZhm2SlGBUO3PR6NTFS+Mk5zoi6jcZb9Bysp2hlR2
ndmXSWQ4JPbvQdHaP6Kvppp0MqR9nmbfoo4BxhsnrjWyuYh+RO943Yf1fD0GZYYp
zBLIsRs81fHe5sF18fX+915wZ89Zhikmc+v2V1fArX3g/vvDq96GJTwldYm5fDZW
zzMZ7p6RbBHjS57h4HN/9Wi0cXsq9rbMjgy7RImm2GeAQIkuZKhBCsq5oBUdGxE+
NbEKnxCGbpEeQ/+Mn6c66N70ptK8vHBePdPOaIgG1D+it737/7CRpBU+pyJmP6g8
l9x5RurBKNUBu+qO3RzNzxJtDJ7xcEdmu7OxaAiSB9Zo403cMT4l3sAlOrKDZzaC
XQ2Ssq2bY9swMLpuvWr/Glzek6Kbuyx3w1lqnqa/lfZm9vAmkxXwce+TiwqLtIv1
W5DSWRdeoDk6ew9XRAMmfyu2M/NcSmwPHj2nAcqGvn1SH5UCriNpy3Pim+PBPJQT
VAug1TBw8Cv9C4hOun2OJWk2DX16ok6hXFeBCkW+c+1QDGmHHw3B6bImBCLHFn0t
U6rBfDQ5diwEouQt7tMS
=zB/+
-----END PGP SIGNATURE-----

--=-kX+xYsq+0FG/YOIK7Wfj--
