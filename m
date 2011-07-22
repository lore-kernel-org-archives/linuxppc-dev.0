Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3E1B6B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 11:59:16 +1000 (EST)
Received: by fxe23 with SMTP id 23so4019320fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 18:59:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <EBAEF199-2D62-477F-BD40-861149AB1CFA@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-10-git-send-email-dbaryshkov@gmail.com>
	<EBAEF199-2D62-477F-BD40-861149AB1CFA@kernel.crashing.org>
Date: Thu, 21 Jul 2011 21:59:11 -0400
Message-ID: <CAP=VYLqdBUjZz7gcuiEfGZ+pLkxz+Hk9DBxD7J4UUrpaD66mGA@mail.gmail.com>
Subject: Re: [PATCH 09/14] 85xx/sbc8548: read hardware revision when it's
	required for first time
From: Paul Gortmaker <paul.gortmaker@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 19, 2011 at 10:12 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:
>
>> Currently sbc8548 reads hardware revision during bootup. To simplify
>> things read it when it's first required when the kernel is up and
>> running.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>> arch/powerpc/platforms/85xx/sbc8548.c | =A0 =A08 +++++---
>> 1 files changed, 5 insertions(+), 3 deletions(-)
>
> How is this simplifying things, seems more complicated to add an addition=
al if() check.

Agreed -- I don't see what this is meant to achieve.

Paul.

>
> - k
>
>>
>> diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platfo=
rms/85xx/sbc8548.c
>> index ecdd8c0..2eeb376 100644
>> --- a/arch/powerpc/platforms/85xx/sbc8548.c
>> +++ b/arch/powerpc/platforms/85xx/sbc8548.c
>> @@ -49,7 +49,7 @@
>> #include <sysdev/fsl_soc.h>
>> #include <sysdev/fsl_pci.h>
>>
>> -static int sbc_rev;
>> +static int sbc_rev =3D -EINVAL;
>>
>> static void __init sbc8548_pic_init(void)
>> {
>> @@ -82,7 +82,7 @@ static void __init sbc8548_pic_init(void)
>> }
>>
>> /* Extract the HW Rev from the EPLD on the board */
>> -static int __init sbc8548_hw_rev(void)
>> +static int sbc8548_hw_rev(void)
>> {
>> =A0 =A0 =A0 struct device_node *np;
>> =A0 =A0 =A0 struct resource res;
>> @@ -130,7 +130,6 @@ static void __init sbc8548_setup_arch(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> #endif
>> - =A0 =A0 sbc_rev =3D sbc8548_hw_rev();
>> }
>>
>> static void sbc8548_show_cpuinfo(struct seq_file *m)
>> @@ -140,6 +139,9 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
>> =A0 =A0 =A0 pvid =3D mfspr(SPRN_PVR);
>> =A0 =A0 =A0 svid =3D mfspr(SPRN_SVR);
>>
>> + =A0 =A0 if (sbc_rev =3D=3D -EINVAL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 sbc_rev =3D sbc8548_hw_rev();
>> +
>> =A0 =A0 =A0 seq_printf(m, "Vendor\t\t: Wind River\n");
>> =A0 =A0 =A0 seq_printf(m, "Machine\t\t: SBC8548 v%d\n", sbc_rev);
>> =A0 =A0 =A0 seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
>> --
>> 1.7.2.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
