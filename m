Return-Path: <justinmattock@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A7551007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 01:08:02 +1000 (EST)
Received: by pzk26 with SMTP id 26so629383pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Apr 2011 08:07:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110405131504.1d182da4@schlenkerla.am.freescale.net>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<1302022702-24541-2-git-send-email-justinmattock@gmail.com>
	<20110405131504.1d182da4@schlenkerla.am.freescale.net>
Date: Wed, 6 Apr 2011 08:07:58 -0700
Message-ID: <BANLkTi=5A1P-WAFvCyjbT7RVva9K9d=gQQ@mail.gmail.com>
Subject: Re: [RFC 2/5]arch:powerpc:sysdev:Makefile Remove unused config in the
	Makefile.
From: Justin Mattock <justinmattock@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 5, 2011 at 11:15 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Tue, 5 Apr 2011 09:58:19 -0700
> "Justin P. Mattock" <justinmattock@gmail.com> wrote:
>
>> The patch below removes an unused config variable found by using a kerne=
l
>> cleanup script.
>> Note: I did try to cross compile these but hit erros while doing so..
>> (gcc is not setup to cross compile) and am unsure if anymore needs to be=
 done.
>> Please have a look if/when anybody has free time.
>>
>> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: linuxppc-dev@lists.ozlabs.org
>>
>> ---
>> =A0arch/powerpc/sysdev/Makefile | =A0 =A01 -
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
>> index 1e0c933..243b6ad 100644
>> --- a/arch/powerpc/sysdev/Makefile
>> +++ b/arch/powerpc/sysdev/Makefile
>> @@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_PMC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D=
 fsl_pmc.o
>> =A0obj-$(CONFIG_FSL_LBC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D fsl_lbc.o
>> =A0obj-$(CONFIG_FSL_GTM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D fsl_gtm.o
>> =A0obj-$(CONFIG_MPC8xxx_GPIO) =A0 +=3D mpc8xxx_gpio.o
>> -obj-$(CONFIG_FSL_85XX_CACHE_SRAM) =A0 =A0+=3D fsl_85xx_l2ctlr.o fsl_85x=
x_cache_sram.o
>> =A0obj-$(CONFIG_SIMPLE_GPIO) =A0 =A0+=3D simple_gpio.o
>> =A0obj-$(CONFIG_FSL_RIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D fsl_rio.o
>> =A0obj-$(CONFIG_TSI108_BRIDGE) =A0+=3D tsi108_pci.o tsi108_dev.o
>
> Those files do exist, and aren't pulled in by any other means I can see.
> It was introduced by commit 6db92cc9d07db9f713da8554b4bcdfc8e54ad386, who=
se
> changelog says:
> =A0 =A0 =A0 =A0Drivers can do the following in Kconfig to use these APIs =
"select
> FSL_85XX_CACHE_SRAM if MPC85xx"
>
> Now, the absence of such a kconfig option[1] is a problem, but I don't th=
ink
> outright removal (labelled "trivial cleanup") is appropriate, unless nobo=
dy
> fixes it after the problem is pointed out. =A0And if it is removed, the f=
iles
> should go with it.
>
> -Scott
>
> [1] and of any drivers that select it, though this was added fairly
> recently -- perhaps such a driver change is on its way?
>
>

ahh.. so the:  fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o is still in use
even though FSL_85XX_CACHE_SRAM is not really used, but really is used!!

but might be wrong with this.

--=20
Justin P. Mattock
