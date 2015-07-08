Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 543791A19E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 08:02:23 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 711641402AC
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 08:02:21 +1000 (AEST)
Message-ID: <1436392928.2658.85.camel@freescale.com>
Subject: Re: [PATCH V2 1/2] powerpc/kexec: Reset secondary cpu endianess
 before kexec
From: Scott Wood <scottwood@freescale.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
CC: <linuxppc-dev@ozlabs.org>
Date: Wed, 8 Jul 2015 17:02:08 -0500
In-Reply-To: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-08 at 14:37 +1000, Samuel Mendoza-Jonas wrote:
> If the target kernel does not inlcude the FIXUP_ENDIAN check, coming
> from a different-endian kernel will cause the target kernel to panic.
> All ppc64 kernels can handle starting in big-endian mode, so return to
> big-endian before branching into the target kernel.
> 
> This mainly affects pseries as secondaries on powernv are returned to
> OPAL.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> ---
> v2: Add an #ifdef for subarch-specific code
>     Neaten the endian check (and extra call to mfmsr!) by modifying the msr 
> and
>     branching to the target kernel in the same call to rfid.
>  arch/powerpc/kernel/misc_64.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 4e314b9..89f0600 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -475,9 +475,18 @@ _GLOBAL(kexec_wait)
>  #ifdef CONFIG_KEXEC          /* use no memory without kexec */
>       lwz     r4,0(r5)
>       cmpwi   0,r4,0
> -     bnea    0x60
> +     beq     99b
> +#ifdef CONFIG_PPC_BOOK3S_64
> +     li      r10,0x60
> +     mfmsr   r11
> +     clrrdi  r11,r11,1       /* Clear MSR_LE */
> +     mtsrr0  r10
> +     mtsrr1  r11
> +     rfid
> +#else
> +     b       0x60
> +#endif
>  #endif
> -     b       99b

"b 0x60" needs to be "ba 0x60".

-Scott
