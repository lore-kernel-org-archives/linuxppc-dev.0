Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 0A378DE05F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 17:07:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/14] ps3: smp interrupt fixes
Date: Thu, 25 Jan 2007 07:07:07 +0100
References: <45B81883.2010508@am.sony.com>
In-Reply-To: <45B81883.2010508@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250707.07626.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:40, Geoff Levand wrote:
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
> @@ -317,22 +317,23 @@ struct ps3_bmp {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long unused_1[3];
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long mask;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long unused_2[3];
> -=A0=A0=A0=A0=A0=A0=A0} __attribute__ ((packed));
> +=A0=A0=A0=A0=A0=A0=A0} __attribute__ ((aligned (64)));

Is that meant to be a 64 _byte_ alignment? By default, it is
already aligned to 64 bit.
If 64 byte is some magic requirement by the hypervisor, you
might want to make that explicit by using a constant definition
for it.

> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
> @@ -109,6 +109,7 @@ static int __init ps3_probe(void)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0powerpc_firmware_features |=3D FW_FEATURE_PS3_POS=
SIBLE;
> +=A0=A0=A0=A0=A0=A0=A0cur_cpu_spec->cpu_features |=3D CPU_FTR_SMT;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0ps3_os_area_init();
> =A0=A0=A0=A0=A0=A0=A0=A0ps3_mm_init();
>=20
CPU_FTRS_CELL already contains CPU_FTR_SMT, why do you need to enable
it explicitly?

	Arnd <><
