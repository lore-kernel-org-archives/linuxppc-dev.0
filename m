Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 57EB2B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 08:02:11 +1100 (EST)
Message-ID: <4F0CA749.3000306@freescale.com>
Date: Tue, 10 Jan 2012 15:02:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: OpenPIC warnings on P1022RDK AMP configuration
References: <93CD5F41FDBC6042A6B449764F3B35CC050CD17A@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CD17A@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="windows-1252"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2012 02:43 AM, Arshad, Farrukh wrote:
> Change kernel configuration as per following to fix this warning.
>=20
> =20
>=20
> Disable Kernel Options -> Support for enabling/disabling CPUs
>=20
> Disable Kernel Options -> Distribute interrupts on all CPUs by default
>=20
> =20
>=20
> Regards,
>=20
> Farrukh Arshad
>=20
> =20
>=20
> *From:*Arshad, Farrukh
> *Sent:* Friday, December 23, 2011 11:18 AM
> *To:* linuxppc-dev@lists.ozlabs.org
> *Subject:* OpenPIC warnings on P1022RDK AMP configuration
>=20
> =20
>=20
> Greetings All
>=20
> =20
>=20
> I am running dual linux on P1022RDK in AMP configuration. My memory
> partitioning is as below
>=20
> =20
>=20
> ---------------------------------------------------------------------
>=20
> Core                      | Base Address  |    Size                 |
>=20
> --------------------------|---------------|-------------------------|
>=20
> Core 0 (MEL RT Kernel)    | 0x0000,0000   | 0x0C00,0000 - 192 (MB)  |
>=20
> Core 1 (LTIB Kernel)      |0x0C00,0000    | 0x1000,0000 - 256 (MB)  |
>=20
> MCAPI - Shared Mem        | 0x1C00,0000   | 0x0400,0000 - 64=20
> (MB)  |           =20
>=20
> ---------------------------------------------------------------------
>=20
> =20
>=20
> My kernel command lines are for both cores
>=20
> =20
>=20
> setenv core0bootargs root=3D/dev/mmcblk0p3 rootdelay=3D5 rw mem=3D192M
>=20
> setenv core1bootargs root=3D/dev/nfs nfsroot=3D<serverip>:/<rootfs> ip=3D=
dhcp
> mem=3D256M
>=20
> =20
>=20
> I have also partitioned my hardware among both cores and supplied
> appropriate =93protected-sources=94 in mpic node of both DTS files. The
> problem is, I receive following warning continuously only on Core 0
> console, but Core 1 is running smooth. In following warnings source irq=
s
> are mostly which I have assigned to Core 1, but they are present in Cor=
e
> 0 mpic node =93protected-sources=94 list, then why I am getting these m=
essages.
>=20
> =20
>=20
> [    6.219204] __ratelimit: 5796 callbacks suppressed
>=20
> [    6.223996]  OpenPIC  : Got protected source 30 !
>=20
> [    7.005809]  OpenPIC  : Got protected source 30 !
>=20
> [    8.005906]  OpenPIC  : Got protected source 30 !
>=20
> [    8.433053]  OpenPIC  : Got protected source 29 !
>=20
> [    8.437942]  OpenPIC  : Got protected source 30 !
>=20
> [    8.443101]  OpenPIC  : Got protected source 30 !
>=20
> [    8.448428]  OpenPIC  : Got protected source 30 !
>=20
> =20
>=20
> Any thoughts ?

Does each dtb have the correct CPU number, both from the command line
boot cpu flag and in the CPU node?

Do both device trees have pic-no-reset in the mpic node?

If neither of those are the issue, start dumping the relevant MPIC
interrupt destination registers, and tracethe code where they're
supposed to be set up.  Also make sure that no interrupts are enabled
when Linux receives control from U-Boot.

-Scott
