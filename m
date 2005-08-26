Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 493F46802C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Aug 2005 04:47:56 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0508241017480.23831@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241017480.23831@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <12F17D0A-B60C-4249-9811-95D8159C087D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 26 Aug 2005 13:48:02 -0500
To: "Gala Kumar K.-galak" <kumar.gala@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys system on chip identification additions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oops, this patch doesn't build since its missing a '{'.  Will send up  
an updated patch that fixes the problem.

- kumar

On Aug 24, 2005, at 10:18 AM, Gala Kumar K.-galak wrote:

> Add the ability to identify an SOC by a name and id.  There are  
> cases in
> which the integer identifier is not sufficient to specify a specific
> SOC.
> In these cases we can use a string to further qualify the match.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
> commit 58d478e75ac5d6cb3a1f738a22555c3841445264
> tree 999d1722d74eb8dc76f40c8f4c52966cea681cb4
> parent eb5d5922d749a74f58416ca1a852651e7323449b
> author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005
> 10:14:42 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005
> 10:14:42 -0500
>
>  arch/ppc/syslib/ppc_sys.c |   51
> ++++++++++++++++++++++++++++++++++++++++++++-
>  include/asm-ppc/ppc_sys.h |    1 +
>  2 files changed, 51 insertions(+), 1 deletions(-)
>
> diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
> --- a/arch/ppc/syslib/ppc_sys.c
> +++ b/arch/ppc/syslib/ppc_sys.c
> @@ -6,6 +6,7 @@
>   * Maintainer: Kumar Gala <kumar.gala@freescale.com>
>   *
>   * Copyright 2005 Freescale Semiconductor Inc.
> + * Copyright 2005 MontaVista, Inc. by Vitaly Bordug
> <vbordug@ru.mvista.com>
>   *
>   * This program is free software; you can redistribute  it and/or
> modify it
>   * under  the terms of  the GNU General  Public License as  
> published by
> the
> @@ -35,8 +36,56 @@ void __init identify_ppc_sys_by_id(u32 i
>
>  void __init identify_ppc_sys_by_name(char *name)
>  {
> -    /* TODO */
> +    unsigned int i = 0;
> +    while (ppc_sys_specs[i].ppc_sys_name[0])
> +        if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
> +            break;
> +        i++;
> +    }
> +    cur_ppc_sys_spec = &ppc_sys_specs[i];
>      return;
> +}
> +
> +static int __init count_sys_specs(void)
> +{
> +    int i = 0;
> +    while (ppc_sys_specs[i].ppc_sys_name[0])
> +        i++;
> +    return i;
> +}
> +
> +static int __init find_chip_by_name_and_id(char *name, u32 id)
> +{
> +    int ret = -1;
> +    unsigned int i = 0;
> +    unsigned int j = 0;
> +    unsigned int dups = 0;
> +
> +    unsigned char matched[count_sys_specs()];
> +
> +    while (ppc_sys_specs[i].ppc_sys_name[0]) {
> +        if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
> +            matched[j++] = i;
> +        i++;
> +    }
> +    if (j != 0) {
> +        for (i = 0; i < j; i++) {
> +            if ((ppc_sys_specs[matched[i]].mask & id) ==
> +                ppc_sys_specs[matched[i]].value) {
> +                ret = matched[i];
> +                dups++;
> +            }
> +        }
> +        ret = (dups == 1) ? ret : (-1 * dups);
> +    }
> +    return ret;
> +}
> +
> +void __init identify_ppc_sys_by_name_and_id(char *name, u32 id)
> +{
> +    int i = find_chip_by_name_and_id(name, id);
> +    BUG_ON(i < 0);
> +    cur_ppc_sys_spec = &ppc_sys_specs[i];
>  }
>
>  /* Update all memory resources by paddr, call before
> platform_device_register */
> diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
> --- a/include/asm-ppc/ppc_sys.h
> +++ b/include/asm-ppc/ppc_sys.h
> @@ -50,6 +50,7 @@ extern struct ppc_sys_spec *cur_ppc_sys_
>  /* determine which specific SOC we are */
>  extern void identify_ppc_sys_by_id(u32 id) __init;
>  extern void identify_ppc_sys_by_name(char *name) __init;
> +extern void identify_ppc_sys_by_name_and_id(char *name, u32 id)  
> __init;
>
>  /* describes all devices that may exist in a given family of  
> processors
> */
>  extern struct platform_device ppc_sys_platform_devices[];
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
