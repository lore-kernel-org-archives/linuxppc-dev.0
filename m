Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D44411A1CFF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 12:51:46 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EED6B140D19
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 12:51:45 +1000 (AEST)
Message-ID: <1436322938.2658.60.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
From: Scott Wood <scottwood@freescale.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
CC: <linuxppc-dev@ozlabs.org>
Date: Tue, 7 Jul 2015 21:35:38 -0500
In-Reply-To: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
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

On Wed, 2015-07-08 at 11:23 +1000, Samuel Mendoza-Jonas wrote:
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
>  arch/powerpc/kernel/misc_64.S | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 4e314b9..c73e587 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -475,9 +475,20 @@ _GLOBAL(kexec_wait)
>  #ifdef CONFIG_KEXEC          /* use no memory without kexec */
>       lwz     r4,0(r5)
>       cmpwi   0,r4,0
> -     bnea    0x60
> +     beq     99b
> +     mfmsr   r9              /* Check endianess */
> +     clrldi. r10,r9,63
> +     beqa    0x60            /* Already big-endian */
> +     bcl     20,31,$+4
> +     mflr    r10
> +     addi    r10,r10,28
> +     mfmsr   r11
> +     xori    r11,r11,1
> +     mtsrr0  r10
> +     mtsrr1  r11
> +     rfid
> +     .long   0x62000048      /* ba 0x60 */
>  #endif
> -     b       99b

Could you put a book3s ifdef around this?  The low bit of MSR is reserved on 
book3e (and rfid doesn't exist).  Granted the bit should be zero, at least on 
FSL book3e, but it's better to be explicit about code that is subarch-
specific.

And yes, I have book3e kexec patches coming.

Also, it would be better to use label subtraction rather than hardcoding 
"28", and the bcl instruction would be more readable as "bl <label>".

-Scott
