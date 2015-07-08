Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 605FA1A1D83
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:37:28 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7AB361402BD
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:37:27 +1000 (AEST)
Message-ID: <1436326636.2658.68.camel@freescale.com>
Subject: Re: [kexec-lite PATCH V2] trampoline: Reset primary cpu endian to
 big-endian
From: Scott Wood <scottwood@freescale.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
CC: <anton@samba.org>, <linuxppc-dev@ozlabs.org>
Date: Tue, 7 Jul 2015 22:37:16 -0500
In-Reply-To: <1436326178-17021-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436326178-17021-1-git-send-email-sam.mj@au1.ibm.com>
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

On Wed, 2015-07-08 at 13:29 +1000, Samuel Mendoza-Jonas wrote:
> Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> meaning if we kexec from a little-endian kernel the target kernel will
> fail to boot.
> Returning to big-endian before we enter the target kernel ensures that
> the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> ---
> V2: As suggested by Anton take advantage of the rfid call and switch off
> MSR_LE and branch to the target kernel in the same step.
> 
>  kexec_trampoline.S | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec_trampoline.S b/kexec_trampoline.S
> index a3eb314..3751112 100644
> --- a/kexec_trampoline.S
> +++ b/kexec_trampoline.S
> @@ -88,8 +88,15 @@ start:
>  
>       li      r5,0
>  
> -     mtctr   r4
> -     bctr
> +     mtsrr0  r4
> +
> +     mfmsr   r5
> +     clrrdi  r5,r5,1         /* Clear MSR_LE */
> +     mtsrr1  r5
> +
> +     li      r5,0
> +
> +     rfid

Is kexec-lite meant to be specific to book3s-64?  The README just says "A 
simple kexec for flattened device tree platforms" and I see a __powerpc64__ 
ifdef in kexec_trampoline.S (but not in the above patch)...

-Scott
