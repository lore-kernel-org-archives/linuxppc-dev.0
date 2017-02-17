Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPkQW6s2pzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 17:58:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: jallen@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 mdroth@linux.vnet.ibm.com, sahilmehta17@gmail.com
Subject: Re: [PATCH v7 3/4] powerpc/pseries: Implement indexed-count hotplug
 memory add
In-Reply-To: <20170215184536.11755.63813.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20170215184536.11755.63813.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Fri, 17 Feb 2017 17:58:59 +1100
Message-ID: <878tp5job0.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index 9609a72..0d1aa77 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -810,9 +901,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  	u32 count, drc_index;
>  	int rc;
>=20=20
> -	count =3D hp_elog->_drc_u.drc_count;
> -	drc_index =3D hp_elog->_drc_u.drc_index;
        ^^^

This fails to build for me because of the above removal, ...


> @@ -829,20 +917,32 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elo=
g)
>=20=20
...
>  		break;
>  	case PSERIES_HP_ELOG_ACTION_READD:
>  		rc =3D dlpar_memory_readd_by_index(drc_index, prop);
						 ^^^
And the existing usage here.


Which leads to:


  arch/powerpc/platforms/pseries/hotplug-memory.c: In function =E2=80=98dlp=
ar_memory=E2=80=99:
  arch/powerpc/platforms/pseries/hotplug-memory.c:581:6: error: =E2=80=98dr=
c_index=E2=80=99 may be used uninitialized in this function [-Werror=3Dmayb=
e-uninitialized]
  if (lmbs[i].drc_index =3D=3D drc_index) {
  ^

Presumably you're using an old compiler that didn't pick that up? If so
please update to a more modern compiler.


I did the obvious fix, hopefully it is correct:

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc=
/platforms/pseries/hotplug-memory.c
index bc73546587e7..e28abfa013e5 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1019,6 +1019,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
=20
 		break;
 	case PSERIES_HP_ELOG_ACTION_READD:
+		drc_index =3D hp_elog->_drc_u.drc_index;
 		rc =3D dlpar_memory_readd_by_index(drc_index, prop);
 		break;
 	default:

cheers
