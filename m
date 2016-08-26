Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLNVc1CYZzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 00:20:21 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id ECF50440DA9_7C0501FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 14:20:15 +0000 (GMT)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 611DE43E048_7C0501FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 14:20:15 +0000 (GMT)
Received: by mail-qk0-f182.google.com with SMTP id l2so77769681qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 07:20:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <46ccc73b-72d9-3ae9-afce-1962d51bd967@c-s.fr>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
 <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
 <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
 <CAPk1OjGR0gTAXvSUw=QUqkOrOZbmXCnd71Fu0mm5Pfrg46uc5w@mail.gmail.com>
 <b843cd6d-b9df-a5b2-4015-042c7894313f@c-s.fr>
 <1472178736.25630.288.camel@buserror.net>
 <46ccc73b-72d9-3ae9-afce-1962d51bd967@c-s.fr>
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Fri, 26 Aug 2016 16:20:13 +0200
Message-ID: <CAPk1OjGSvCDR=xOpAc1conrSeMyF=G_gPeUFrhafaRebwFidJw@mail.gmail.com>
Subject: Re: Suspected regression?
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

On 26 August 2016 at 14:46, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
[...]
> Can you try the patch below ? I have identified that in case the packet is
> smaller than a cacheline, it doesn't get cache-aligned so the result shall
> not be rotated in case of odd dest address.
>
> This patch goes in addition to the previous fix (1bc8b816cb805) as it fixes
> a different case.
>
> Christophe
>
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index 68f6862..3971cfb 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -127,18 +127,19 @@ _GLOBAL(csum_partial_copy_generic)
>         stw     r7,12(r1)
>         stw     r8,8(r1)
>
> -       rlwinm  r0,r4,3,0x8
> -       rlwnm   r6,r6,r0,0,31   /* odd destination address: rotate one byte
> */
> -       cmplwi  cr7,r0,0        /* is destination address even ? */
>         addic   r12,r6,0
>         addi    r6,r4,-4
>         neg     r0,r4
>         addi    r4,r3,-4
>         andi.   r0,r0,CACHELINE_MASK    /* # bytes to start of cache line */
> +       crset   4*cr7+eq
>         beq     58f
>
>         cmplw   0,r5,r0                 /* is this more than total to do? */
>         blt     63f                     /* if not much to do */
> +       rlwinm  r7,r6,3,0x8
> +       rlwnm   r12,r12,r7,0,31 /* odd destination address: rotate one byte
> */
> +       cmplwi  cr7,r7,0        /* is destination address even ? */
>         andi.   r8,r0,3                 /* get it word-aligned first */
>         mtctr   r8
>         beq+    61f

Yeah! It fixes my problem! Thank you very much!

Ciao,
Alessio
