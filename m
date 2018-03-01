Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsHB91XNHzF1kW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 13:56:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
Date: Thu, 01 Mar 2018 13:55:57 +1100
Message-ID: <87woyw8pxe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, t=
he
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=3D1):
>
>   CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c: In function =E2=80=98check_cpu_feature_proper=
ties=E2=80=99:
> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expressi=
on < 0 is always false [-Werror=3Dtype-limits]
>   for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 ^
> cc1: all warnings being treated as errors

Ugh, that's annoying.

This seems to work?

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4dffef947b8a..5215119e249c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -291,11 +291,11 @@ static inline void identical_pvr_fixup(unsigned long =
node)
=20
 static void __init check_cpu_feature_properties(unsigned long node)
 {
-	unsigned long i;
 	struct feature_property *fp =3D feature_properties;
 	const __be32 *prop;
+	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
+	for (i =3D 0; i < (int)ARRAY_SIZE(feature_properties); ++i, ++fp) {
 		prop =3D of_get_flat_dt_prop(node, fp->name, NULL);
 		if (prop && be32_to_cpup(prop) >=3D fp->min_value) {
 			cur_cpu_spec->cpu_features |=3D fp->cpu_feature;


cheers
