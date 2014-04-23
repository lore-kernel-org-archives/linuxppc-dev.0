Return-Path: <monstr@monstr.eu>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59B9C1400AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:22:36 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id b13so919653wgh.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:22:31 -0700 (PDT)
Message-ID: <5357CCA1.9080708@monstr.eu>
Date: Wed, 23 Apr 2014 16:22:25 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 00/21] FDT clean-ups and libfdt support
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A"
Cc: linux-mips@linux-mips.org, Aurelien Jacquiot <a-jacquiot@ti.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linux@lists.openrisc.net,
 Jonas Bonn <jonas@southpole.se>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>,
 devicetree@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
 linux-xtensa@linux-xtensa.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/23/2014 03:18 AM, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> This is a series of clean-ups of architecture FDT code and converts the=

> core FDT code over to using libfdt functions. This is in preparation
> to add FDT based address translation parsing functions for early
> console support. This series removes direct access to FDT data from all=

> arches except powerpc.
>=20
> The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
> to be copied out of init section. Patches 2 and 3 should be applied to
> 3.15.
>=20
> Changes in v2 are relatively minor. There was a bug in the unflattening=

> code where walking up the tree was not being handled correctly (thanks
> to Michal Simek). I re-worked things a bit to avoid globally adding
> libfdt include paths.
>=20
> A branch is available here[1], and I plan to put into linux-next in a f=
ew
> days. Please test! I've compiled on arm, arm64, mips, microblaze, xtens=
a,
> and powerpc and booted on arm and arm64.
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt=

>=20
> Rob Herring (21):
>   mips: octeon: convert to use unflatten_and_copy_device_tree
>   mips: lantiq: copy built-in DTB out of init section
>   mips: xlp: copy built-in DTB out of init section
>   mips: ralink: convert to use unflatten_and_copy_device_tree
>   ARM: dt: use default early_init_dt_alloc_memory_arch
>   c6x: convert fdt pointers to opaque pointers
>   mips: convert fdt pointers to opaque pointers
>   of/fdt: consolidate built-in dtb section variables
>   of/fdt: remove some unneeded includes
>   of/fdt: remove unused of_scan_flat_dt_by_path
>   of/fdt: update of_get_flat_dt_prop in prep for libfdt
>   of/fdt: Convert FDT functions to use libfdt
>   of/fdt: use libfdt accessors for header data
>   of/fdt: create common debugfs
>   of/fdt: move memreserve and dtb memory reservations into core
>   of/fdt: fix phys_addr_t related print size warnings
>   of/fdt: introduce of_get_flat_dt_size
>   powerpc: use libfdt accessors for header data
>   x86: use FDT accessors for FDT blob header data
>   of/fdt: convert initial_boot_params to opaque pointer
>   of: push struct boot_param_header and defines into powerpc
>=20
>  arch/arc/include/asm/sections.h             |   1 -
>  arch/arc/kernel/devtree.c                   |   2 +-
>  arch/arm/include/asm/prom.h                 |   2 -
>  arch/arm/kernel/devtree.c                   |  34 +--
>  arch/arm/mach-exynos/exynos.c               |   2 +-
>  arch/arm/mach-vexpress/platsmp.c            |   2 +-
>  arch/arm/mm/init.c                          |   1 -
>  arch/arm/plat-samsung/s5p-dev-mfc.c         |   4 +-
>  arch/arm64/mm/init.c                        |  21 --
>  arch/c6x/kernel/setup.c                     |   4 +-
>  arch/metag/kernel/setup.c                   |   4 -
>  arch/microblaze/kernel/prom.c               |  39 +--
>  arch/mips/cavium-octeon/setup.c             |  20 +-
>  arch/mips/include/asm/mips-boards/generic.h |   4 -
>  arch/mips/include/asm/prom.h                |   6 +-
>  arch/mips/kernel/prom.c                     |   2 +-
>  arch/mips/lantiq/prom.c                     |  15 +-
>  arch/mips/lantiq/prom.h                     |   2 -
>  arch/mips/mti-sead3/sead3-setup.c           |   8 +-
>  arch/mips/netlogic/xlp/dt.c                 |  19 +-
>  arch/mips/ralink/of.c                       |  29 +-
>  arch/openrisc/kernel/vmlinux.h              |   2 -
>  arch/powerpc/include/asm/prom.h             |  39 +++
>  arch/powerpc/kernel/Makefile                |   1 +
>  arch/powerpc/kernel/epapr_paravirt.c        |   2 +-
>  arch/powerpc/kernel/fadump.c                |   4 +-
>  arch/powerpc/kernel/prom.c                  |  78 ++----
>  arch/powerpc/kernel/rtas.c                  |   2 +-
>  arch/powerpc/mm/hash_utils_64.c             |  22 +-
>  arch/powerpc/platforms/52xx/efika.c         |   4 +-
>  arch/powerpc/platforms/chrp/setup.c         |   4 +-
>  arch/powerpc/platforms/powernv/opal.c       |  12 +-
>  arch/powerpc/platforms/pseries/setup.c      |   4 +-
>  arch/x86/kernel/devicetree.c                |  12 +-
>  arch/xtensa/kernel/setup.c                  |   3 +-
>  drivers/of/Kconfig                          |   1 +
>  drivers/of/Makefile                         |   2 +
>  drivers/of/fdt.c                            | 398 ++++++++++----------=
--------
>  drivers/of/of_reserved_mem.c                |   4 +-
>  include/linux/of_fdt.h                      |  63 +----
>  40 files changed, 280 insertions(+), 598 deletions(-)
>=20

For Microblaze and generic changes:
Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlNXzKIACgkQykllyylKDCHfdwCgiJNPWBZCjUqOaapgY9tFFiZM
34UAl1gzqEO33NTC3JDpDfaBeLQ52K8=
=iDhY
-----END PGP SIGNATURE-----

--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A--
