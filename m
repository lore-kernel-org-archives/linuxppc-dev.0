Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 8027CB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 18:21:27 +1100 (EST)
Date: Fri, 20 Jan 2012 18:21:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20120120182117.01a6eb5d3cfb3f2bdfb32ae4@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__20_Jan_2012_18_21_17_+1100_RwYsliQiamGwI/J."
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Trinabh Gupta <g.trinabh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__20_Jan_2012_18_21_17_+1100_RwYsliQiamGwI/J.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allmodconfig) failed like this:

arch/powerpc/platforms/pseries/processor_idle.c:35:6: error: redefinition o=
f 'update_smt_snooze_delay'
arch/powerpc/include/asm/system.h:230:20: note: previous definition of 'upd=
ate_smt_snooze_delay' was here
arch/powerpc/platforms/pseries/processor_idle.c:175:5: error: redefinition =
of 'pseries_notify_cpuidle_add_cpu'
arch/powerpc/include/asm/system.h:231:19: note: previous definition of 'pse=
ries_notify_cpuidle_add_cpu' was here

Caused by commit 707827f3387d ("powerpc/cpuidle: cpuidle driver for
pSeries").  For this build, CONFIG_PSERIES_IDLE is "m".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__20_Jan_2012_18_21_17_+1100_RwYsliQiamGwI/J.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPGRXtAAoJEECxmPOUX5FEApcQAITKaIX9PWvFMm23HFlwcD4p
Hgkef5wdmfHvsjwDmi7tmYZeuMNtRwlnT1XpwXgf2Fe0AWS8Wxq3yGemNJasOT/n
VA5G8/BvSW/Yb2RPC7NHvag+ynKgxOMHHe5LAyHVIZpACxNoGPXerXpV3lT5m1oo
b1fUa/AoVYiSl0FJp8jhS8bXdTvBW5rYwmmpGl2/q2XRks+/W4Xm6HkphWUpK1bO
DapQ30sQ85S7A9zRMMvas/EtKUX3UMwpySn1RKnMqZVrVYzaH0hkksbQOpGFU6uc
d7lDXF7NuDxqp45GPjVYrOF05e3JuhkirD/K9BfL9ZUyGzeQwnNxfLK9smINAr2v
XsP1uAsdh4YE7vN1lzwYt6XxM0r8SuFz+g8nPeKeVA51JjtvrysKa4HqMb0ZcFb/
0OpG78f5L+Ph2zN/dWSb/bkTHlzGcx6HKgsql2NVQTCk1YkBN8XaoECnVcnZakHR
erewd+shGM8ftY2FfshsjFwBlp6V9gYdgyMhlbII2E6xhZRueTEqMPL/ztwu7LMu
k4DwTtj7W40C2+cf2QQh0yHUDVzm+kVS3NAOWOSJM+mKotkrYvXBxHPijAg6ow56
4SgnYbRdtKQX7wQ6TLPYCW9LkaITPCvVTzX9Eho9d8CNLcRX5Amtz8Z6ATWXX0WI
XFkJh5r6gXF8btG9dLTI
=dIUY
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jan_2012_18_21_17_+1100_RwYsliQiamGwI/J.--
