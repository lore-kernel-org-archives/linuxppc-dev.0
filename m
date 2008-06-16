Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 567BCDE2E0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 05:26:17 +1000 (EST)
Message-Id: <55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
Content-Type: multipart/alternative; boundary=Apple-Mail-5--886027935
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Mon, 16 Jun 2008 14:26:13 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Apple-Mail-5--886027935
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jun 16, 2008, at 10:46 AM, Kumar Gala wrote:
>
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1522,6 +1522,21 @@ static struct cpu_spec __initdata cpu_specs[]  
> = {
> 		.machine_check		= machine_check_e500,
> 		.platform		= "ppc8548",
> 	},
> +	{	/* e500mc */
> +		.pvr_mask		= 0xffff0000,
> +		.pvr_value		= 0x80230000,
> +		.cpu_name		= "e500mc",
> +		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
> +		.cpu_features		= CPU_FTRS_E500MC,
> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
> +		.icache_bsize		= 64,
> +		.dcache_bsize		= 64,
> +		.num_pmcs		= 4,
> +		.oprofile_cpu_type	= "ppc/e500", /* xxx - galak, e500mc? */
> +		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
> +		.machine_check		= machine_check_e500,
> +		.platform		= "ppc4080",

Do you really want the platform to be this specific?

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
> platforms/Kconfig.cputype
> index f7efaa9..9e67cf1 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -95,6 +95,12 @@ config E500
> 	select FSL_EMB_PERFMON
> 	bool
>
> +config PPC_E500MC
> +	bool "e500mc Support"
> +	select PPC_FPU
> +	depends on E500
> +	default n
> +
> config PPC_FPU
> 	bool
> 	default y if PPC64
> @@ -157,7 +163,7 @@ config ALTIVEC
>
> config SPE
> 	bool "SPE Support"
> -	depends on E200 || E500
> +	depends on E200 || (E500 && !PPC_E500MC)

Why make E500MC a config option, if it's so similar? This way you  
can't make a kernel with SPE support that can boot on both e500{,v2}  
and e500mc...


> config SMP
> -	depends on PPC_STD_MMU
> +	depends on PPC_STD_MMU || FSL_BOOKE

Isn't there quite a bit more needed than just enabling this config  
option for SMP to work? I.e. why not save this for when the rest is  
posted?




-Olof
--Apple-Mail-5--886027935
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><div>On Jun 16, 2008, at =
10:46 AM, Kumar Gala wrote:</div><blockquote type=3D"cite"><div><font =
class=3D"Apple-style-span" color=3D"#000000"><br></font></div><div>--- =
a/arch/powerpc/kernel/cputable.c<br>+++ =
b/arch/powerpc/kernel/cputable.c<br>@@ -1522,6 +1522,21 @@ static struct =
cpu_spec __initdata cpu_specs[] =3D {<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.machine_check<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
machine_check_e500,<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.platform<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
"ppc8548",<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>},<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>{<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/* e500mc */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.pvr_mask<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
0xffff0000,<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.pvr_value<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>=3D 0x80230000,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.cpu_name<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
"e500mc",<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.cpu_features<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>=3D CPU_FTRS_E500MC,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.cpu_user_features<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>=3D COMMON_USER_BOOKE | =
PPC_FEATURE_HAS_FPU,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.icache_bsize<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
64,<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.dcache_bsize<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>=3D 64,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.num_pmcs<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>=3D 4,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.oprofile_cpu_type<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
"ppc/e500", /* xxx - galak, e500mc? */<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.oprofile_type<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
PPC_OPROFILE_FSL_EMB,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.machine_check<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
machine_check_e500,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>.platform<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=3D =
"ppc4080",<br></div></blockquote><div><br></div><div>Do you really want =
the platform to be this specific?</div><blockquote =
type=3D"cite"></blockquote><br><blockquote type=3D"cite"><div>diff --git =
a/arch/powerpc/platforms/Kconfig.cputype =
b/arch/powerpc/platforms/Kconfig.cputype<br>index f7efaa9..9e67cf1 =
100644<br>--- a/arch/powerpc/platforms/Kconfig.cputype<br>+++ =
b/arch/powerpc/platforms/Kconfig.cputype<br>@@ -95,6 +95,12 @@ config =
E500<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>select FSL_EMB_PERFMON<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>bool<br><br>+config =
PPC_E500MC<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>bool "e500mc Support"<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>select PPC_FPU<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>depends =
on E500<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>default n<br>+<br> config PPC_FPU<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>bool<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>default y if PPC64<br>@@ -157,7 +163,7 @@ config ALTIVEC<br><br> =
config SPE<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>bool "SPE Support"<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>depends on E200 || E500<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>depends =
on E200 || (E500 &amp;&amp; !PPC_E500MC)<br> <span =
class=3D"Apple-tab-span" =
style=3D"white-space:pre"></span></div></blockquote><div><br></div><div>Wh=
y make E500MC a config option, if it's so similar? This way you can't =
make a kernel with SPE support that can boot on both e500{,v2} and =
e500mc...</div><div><br></div><br><blockquote type=3D"cite"><div>config =
SMP<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>depends on PPC_STD_MMU<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>depends on PPC_STD_MMU || =
FSL_BOOKE<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre"></span></div></blockquote><div><br></div><div>Is=
n't there quite a bit more needed than just enabling this config option =
for SMP to work? I.e. why not save this for when the rest is =
posted?</div><div><br></div></div><br><div><br></div><div><br></div><div>-=
Olof</div></body></html>=

--Apple-Mail-5--886027935--
