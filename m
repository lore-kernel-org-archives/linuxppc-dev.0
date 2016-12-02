Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVWWV1NL3zDw2Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 22:04:38 +1100 (AEDT)
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tVWWT0xFqz9vDS
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2016 22:04:37 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id 50so24347814uae.2
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Dec 2016 03:04:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 2 Dec 2016 22:04:34 +1100
Message-ID: <CAKTCnzkAaKNtcTOGuyO=kkjFGFSObGeEf+Dy0qvTM7xXit5dJg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
To: Alistair Popple <alistair@popple.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>

>  static void __init radix_init_partition_table(void)
>  {
> -       unsigned long rts_field;
> +       unsigned long rts_field, ptcr;

I think these functions have changed, check for conflicts against
http://git.kernel.org/cgit/linux/kernel/git/paulus/powerpc.git/commit/?h=kvm-ppc-next&id=9d66195807ac6cb8a14231fd055ff755977c5fca



>
>         rts_field = radix__get_tree_size();
>
> @@ -193,7 +194,9 @@ static void __init radix_init_partition_table(void)
>          * update partition table control register,
>          * 64 K size.
>          */
<snip>
>
> +#ifdef CONFIG_PPC_POWERNV
> +extern void powernv_set_ptcr(unsigned long ptcr);
> +#else
> +static inline void powernv_set_ptcr(unisigned long ptcr) { }

Michael caught you for this already

Balbir
