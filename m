Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 288CA2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 09:47:11 +1000 (EST)
Subject: Re: Build errors on mainline kernel
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130809182446.GA26711@us.ibm.com>
Date: Fri, 9 Aug 2013 18:47:04 -0500
Message-Id: <EA801718-CA2E-4F85-AF6B-29119911038E@kernel.crashing.org>
References: <20130809182446.GA26711@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2013, at 1:24 PM, Sukadev Bhattiprolu wrote:

>=20
> I am tryng to compile clean mainline kernel with a few different =
config files
> and running into errors with some configs.
>=20
> I am building on RHEL6.3 with following binaries:
>=20
> 	gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4)
> 	GNU ld version 2.20.51.0.2-5.34.el6 20100205
> 	binutils-2.20.51.0.2-5.34.el6.ppc64
> 	binutils-devel-2.20.51.0.2-5.34.el6.ppc64
>=20
> I am getting the error with several files and configs, but other =
configs=20
> (eg: ppc64_defconfig, pmac32_defconfig) build fine.
>=20
> For instance, with latest mainline kernel (commit 6c2580c) and =
ppc64_defconfig, I get:
>=20
> 	make O=3Dlinux-obj mrproper
> 	make O=3Dlinux-obj ppc64e_defconfig
> 	make O=3Dlinux-obj arch/powerpc/platforms/85xx/smp.o
> 	  ...
>=20
> 	CC      arch/powerpc/platforms/85xx/smp.o
> 	{standard input}: Assembler messages:
> 	{standard input}:240: Error: junk at end of line: `1'
> 	make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
> 	make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2
>=20
> Not sure if 240 is a line number in smp.c, but looking through the =
function
> containing line 240, I was able to compile the smp.c after commenting =
out
> the two WARN_ON() messages.
>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp
> index 5ced4f5..9705850 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -151,8 +151,10 @@ static int smp_85xx_kick_cpu(int nr)
>        int ioremappable;
>        int ret =3D 0;
>=20
> +#if 0
>        WARN_ON(nr < 0 || nr >=3D NR_CPUS);
>        WARN_ON(hw_cpu < 0 || hw_cpu >=3D NR_CPUS);
> +#endif
>=20
>        pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
>=20
> ---
>=20
> The pre-processor output for the first WARN_ON() is:
>=20
> ---
> ({ int __ret_warn_on =3D !!(nr < 0 || nr >=3D 32); if =
(__builtin_constant_p(__ret_warn_on)) { if (__ret_warn_on) do { __asm__ =
__volatile__( "1:    twi 31,0,0\n" ".section __bug_table,\"a\"\n" "2:\t" =
".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previous\n" =
: : "i" ("/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"), "i" =
(154), "i" (((1 << 0) | ((9) << 8))), "i" (sizeof(struct bug_entry))); } =
while (0); } else { __asm__ __volatile__( "1:      ""tdnei" " ""   =
%4,0\n" ".section __bug_table,\"a\"\n" "2:\t" ".llong" " " "1b, %0\n" =
"\t.short %1, %2\n" ".org 2b+%3\n" ".previous\n" : : "i" =
("/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"), "i" (154), =
"i" (((1 << 0) | ((9) << 8))), "i" (sizeof(struct bug_entry)), "r" =
(__ret_warn_on)); } __builtin_expect(!!(__ret_warn_on), 0); });
>=20
> ---
>=20
>=20
> Should I be doing something different to build with these configs ?
>=20

Hmm, that is odd.

How about doing:

$ make V=3D1

so we can see what compiler flags are being passed around.

- k=
