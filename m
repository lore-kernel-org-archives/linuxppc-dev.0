Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 76E6DB6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 16:51:11 +1100 (EST)
Date: Wed, 28 Dec 2011 16:51:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: linux-next: manual merge of the driver-core tree with the powerpc tree
Message-Id: <20111228165102.fbb6433fd94d11240134327e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__28_Dec_2011_16_51_02_+1100_yJ10y2J5.i621bn1"
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Dec_2011_16_51_02_+1100_yJ10y2J5.i621bn1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in
arch/powerpc/kernel/sysfs.c between commit 595fe91447b0 ("powerpc: Export
PIR data through sysfs") from the powerpc tree and commits 8a25a2fd126c
("cpu: convert 'cpu' and 'machinecheck' sysdev_class to a regular
subsystem") and 707827f3387d ("powerpc/cpuidle: cpuidle driver for
pSeries") from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/kernel/sysfs.c
index 6fdf5ff,5e7c165..0000000
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@@ -51,8 -50,7 +51,8 @@@ static ssize_t store_smt_snooze_delay(s
  	if (ret !=3D 1)
  		return -EINVAL;
 =20
- 	per_cpu(smt_snooze_delay, cpu->sysdev.id) =3D snooze;
+ 	per_cpu(smt_snooze_delay, cpu->dev.id) =3D snooze;
 +	update_smt_snooze_delay(snooze);
 =20
  	return count;
  }
@@@ -179,13 -177,11 +179,13 @@@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA)
  SYSFS_PMCSETUP(purr, SPRN_PURR);
  SYSFS_PMCSETUP(spurr, SPRN_SPURR);
  SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 +SYSFS_PMCSETUP(pir, SPRN_PIR);
 =20
- static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
- static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
- static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
- static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
- static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
+ static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
+ static DEVICE_ATTR(spurr, 0600, show_spurr, NULL);
+ static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
+ static DEVICE_ATTR(purr, 0600, show_purr, store_purr);
++static DEVICE_ATTR(pir, 0400, show_pir, NULL);
 =20
  unsigned long dscr_default =3D 0;
  EXPORT_SYMBOL(dscr_default);
@@@ -386,19 -381,16 +385,19 @@@ static void __cpuinit register_cpu_onli
 =20
  #ifdef CONFIG_PPC64
  	if (cpu_has_feature(CPU_FTR_MMCRA))
- 		sysdev_create_file(s, &attr_mmcra);
+ 		device_create_file(s, &dev_attr_mmcra);
 =20
  	if (cpu_has_feature(CPU_FTR_PURR))
- 		sysdev_create_file(s, &attr_purr);
+ 		device_create_file(s, &dev_attr_purr);
 =20
  	if (cpu_has_feature(CPU_FTR_SPURR))
- 		sysdev_create_file(s, &attr_spurr);
+ 		device_create_file(s, &dev_attr_spurr);
 =20
  	if (cpu_has_feature(CPU_FTR_DSCR))
- 		sysdev_create_file(s, &attr_dscr);
+ 		device_create_file(s, &dev_attr_dscr);
 +
 +	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
- 		sysdev_create_file(s, &attr_pir);
++		device_create_file(s, &dev_attr_pir);
  #endif /* CONFIG_PPC64 */
 =20
  	cacheinfo_cpu_online(cpu);
@@@ -459,19 -451,16 +458,19 @@@ static void unregister_cpu_online(unsig
 =20
  #ifdef CONFIG_PPC64
  	if (cpu_has_feature(CPU_FTR_MMCRA))
- 		sysdev_remove_file(s, &attr_mmcra);
+ 		device_remove_file(s, &dev_attr_mmcra);
 =20
  	if (cpu_has_feature(CPU_FTR_PURR))
- 		sysdev_remove_file(s, &attr_purr);
+ 		device_remove_file(s, &dev_attr_purr);
 =20
  	if (cpu_has_feature(CPU_FTR_SPURR))
- 		sysdev_remove_file(s, &attr_spurr);
+ 		device_remove_file(s, &dev_attr_spurr);
 =20
  	if (cpu_has_feature(CPU_FTR_DSCR))
- 		sysdev_remove_file(s, &attr_dscr);
+ 		device_remove_file(s, &dev_attr_dscr);
 +
 +	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
- 		sysdev_remove_file(s, &attr_pir);
++		device_remove_file(s, &dev_attr_pir);
  #endif /* CONFIG_PPC64 */
 =20
  	cacheinfo_cpu_offline(cpu);

--Signature=_Wed__28_Dec_2011_16_51_02_+1100_yJ10y2J5.i621bn1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO+q5GAAoJEECxmPOUX5FEn5UQAJRxNbxTRt813eKeSbjP8cX+
MQS7IhEATPwW08tSPqhdhPVM5USKI0ClTHKDKmQvdmmj5buN5jGpHLjbZjSmvhhl
Ntv+bhl+gMrn13KirmdKx7oMEbF9rEyFa3NFHgQJeMtNYD4QBd5LN0CfabBGwt7R
Qop9cJPW4rY9grI/FmtcjRBvJjEAmdr33eBIUwr+m0tT6q9TB0Pk1xLBd2sY5yOb
hAnhXysavp6lEYDFDb3mdtAqDGc4tdzXwoXTh1a4Tx5BT6KOEFwLoSXFPkgqamet
o8+4H2Vt0/gDV5g/9kta7HV6Innn23yoIpM+EAWykqXiPJXsZ/8GKH8ZxxSA+jlm
QhDe2JcTPrU//LeZAqJ3xzDotG7Zgug9opGXY65VEYC55BuzIpTkcq//0qqvF/2p
RQvjNdZb+5uZphW1CWV1ciMs8rrGgZaUyyRUARxz4QYrBI+A7xHHLTOzg8EKBQbs
8IXew6Cp2e3wfQo2CFVVUcYuL/ujrDWSsJVtXUsk+XFKseESM1qQgfjlZoG05PT9
y6+lL/2TF2TDVsOghbROGVMRxNGyFOQ3Gy0kwQzE3CPmsZMoBMdCdmV4dWhiNkes
v7jUtap9E4pToCfq7SA0cS3gjRVOpJvNZj4RtnZrm6rJ7ySUqdB+pH7rjwpmxen/
yxNyTbS6JT4JEGroL11m
=SpoP
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Dec_2011_16_51_02_+1100_yJ10y2J5.i621bn1--
