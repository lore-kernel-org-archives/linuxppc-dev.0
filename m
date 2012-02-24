Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47CFCB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 10:31:41 +1100 (EST)
Message-ID: <4F481DD3.30002@freescale.com>
Date: Fri, 24 Feb 2012 17:31:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 33/37] KVM: PPC: bookehv: remove unused code
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-34-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-34-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2012 08:26 AM, Alexander Graf wrote:
> There was some unused code in the exit code path that must have been
> a leftover from earlier iterations. While it did no hard, it's superfluous
> and thus should be removed.

s/hard/harm/ -- at that assumes exit timing wasn't enabled. :-)

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/bookehv_interrupts.S |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
> index 021d087..b1c099b 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -112,9 +112,6 @@
>  	 * appropriate for the exception type).
>  	 */
>  	cmpw	r6, r8
> -	.if	\flags & NEED_EMU
> -	lwz	r9, KVM_LPID(r9)
> -	.endif
>  	beq	1f
>  	mfmsr	r7
>  	.if	\srr0 != SPRN_MCSRR0 && \srr0 != SPRN_CSRR0

Can also remove "lwz	r9, VCPU_KVM(r4)".

-Scott
