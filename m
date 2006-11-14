Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 99D3E67D3E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 20:55:35 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
Date: Tue, 14 Nov 2006 10:55:21 +0100
References: <4554DA9C.9040102@am.sony.com>
	<1163475880.8048.78.camel@localhost.localdomain>
In-Reply-To: <1163475880.8048.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611141055.22317.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 14 November 2006 04:44, Michael Ellerman wrote:
> OK, back to the task at hand :) =A0For the moment I'd rather see you leave
> out dump_data_fields(), as neither HV or baremetal implementations do
> anything. Just put the offending xmon code inside an #ifdef
> CONFIG_PPC_CELL_NATIVE. eg:
>=20
> Index: cell/arch/powerpc/xmon/xmon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- cell.orig/arch/powerpc/xmon/xmon.c =A02006-11-14 14:43:11.000000000 +=
1100
> +++ cell/arch/powerpc/xmon/xmon.c =A0 =A0 =A0 2006-11-14 14:42:35.0000000=
00 +1100
> @@ -2807,12 +2807,11 @@ static void dump_spu_fields(struct spu *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be32(&spu->problem->sp=
u_status_R));
> =A0 =A0 =A0 =A0 DUMP_VALUE("0x%x", problem->spu_npc_RW,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be32(&spu->problem->sp=
u_npc_RW));
> +#ifdef CONFIG_PPC_CELL_NATIVE
> =A0 =A0 =A0 =A0 DUMP_FIELD(spu, "0x%p", priv1);
> -
> - =A0 =A0 =A0 if (spu->priv1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be64(&sp=
u->priv1->mfc_sr1_RW));
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be64(&spu->priv1->mfc_sr=
1_RW));
> +#endif

Oops. Null pointer dereference.

You can't do this if you want to compile in both native and PS3PF
support in a single kernel. I think your original code that prints
priv1 and the sr1 only if priv1 exists is fine on both ways.

	Arnd <><
