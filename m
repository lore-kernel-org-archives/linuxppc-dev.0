Return-Path: <lacombar@gmail.com>
Received: from mail-pz0-f46.google.com (mail-pz0-f46.google.com
	[209.85.210.46]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFC57B6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 06:00:40 +1000 (EST)
Received: by pzk32 with SMTP id 32so3390513pzk.33
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 13:00:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E56A15D.8070406@freescale.com>
References: <1314288433-26322-1-git-send-email-lacombar@gmail.com>
	<4E56A15D.8070406@freescale.com>
Date: Thu, 25 Aug 2011 16:00:38 -0400
Message-ID: <CACqU3MUWdadkJqii8j8htSbYXN+SaYC5uMSvm3t=2E=n4P1xcg@mail.gmail.com>
Subject: Re: [PATCH] xics/icp_natives: add __init to marker icp_native_init()
From: Arnaud Lacombe <lacombar@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Aug 25, 2011 at 3:24 PM, Timur Tabi <timur@freescale.com> wrote:
> Arnaud Lacombe wrote:
>> This should fix the following warning:
>>
>> =A0LD =A0 =A0 =A0arch/powerpc/sysdev/xics/built-in.o
>> WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1310): Section mism=
atch in
>> reference from the function .icp_native_init() to the function
>> .init.text:.icp_native_init_one_node()
>> The function .icp_native_init() references
>> the function __init .icp_native_init_one_node().
>> This is often because .icp_native_init lacks a __init
>> annotation or the annotation of .icp_native_init_one_node is wrong.
>>
>> icp_native_init() is only referenced in `arch/powerpc/sysdev/xics/xics-c=
ommon.c'
>> by xics_init() which is itself marked with __init.
>>
>> =3D not built-tested =3D
>>
>> Reported-by: Timur Tabi <timur@freescale.com>
>> Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>
>
> Acked-by: Timur Tabi <timur@freescale.com>
>
> This warning still appears, though:
>
> WARNING: arch/powerpc/sysdev/built-in.o(.text+0xf6b8): Section mismatch i=
n
> reference from the function .ics_rtas_init() to the function
> .init.text:.xics_register_ics()
> The function .ics_rtas_init() references
> the function __init .xics_register_ics().
> This is often because .ics_rtas_init lacks a __init
> annotation or the annotation of .xics_register_ics is wrong.
>
he, chain-reaction :)

> To fix this warning, you'll also need:
>
> diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xi=
cs/ics-
> index c782f85..a125721 100644
> --- a/arch/powerpc/sysdev/xics/ics-rtas.c
> +++ b/arch/powerpc/sysdev/xics/ics-rtas.c
> @@ -213,7 +213,7 @@ static int ics_rtas_host_match(struct ics *ics, struc=
t devic
> =A0 =A0 =A0 =A0return !of_device_is_compatible(node, "chrp,iic");
> =A0}
>
> -int ics_rtas_init(void)
> +int __init ics_rtas_init(void)
> =A0{
> =A0 =A0 =A0 =A0ibm_get_xive =3D rtas_token("ibm,get-xive");
> =A0 =A0 =A0 =A0ibm_set_xive =3D rtas_token("ibm,set-xive");
>
>
> However, now we get another similar warning:
>
> WARNING: drivers/built-in.o(.text+0x259c484): Section mismatch in referen=
ce from
> the function .tc3589x_keypad_open() to the function
> .devinit.text:.tc3589x_keypad_init_key_hardware()
> The function .tc3589x_keypad_open() references
> the function __devinit .tc3589x_keypad_init_key_hardware().
> This is often because .tc3589x_keypad_open lacks a __devinit
> annotation or the annotation of .tc3589x_keypad_init_key_hardware is wron=
g.
>
> I'm not sure what to do at this point, because I have a suspicion that ad=
ding
> __devinit to tc3589x_keypad_open() is wrong.
>
tc3589x_keypad_init_key_hardware() annotation looks plain wrong.

 - Arnaud

> --
> Timur Tabi
> Linux kernel developer at Freescale
>
>
