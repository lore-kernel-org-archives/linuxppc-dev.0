Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61F771A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 09:07:55 +1000 (EST)
Message-ID: <1404428862.21434.113.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/6 v2] KVM: PPC: Book3E: Add AltiVec support
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Thu, 3 Jul 2014 18:07:42 -0500
In-Reply-To: <1404142497-6430-5-git-send-email-mihai.caraman@freescale.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-5-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-30 at 18:34 +0300, Mihai Caraman wrote:
> Add KVM Book3E AltiVec support. KVM Book3E FPU support gracefully reuse host
> infrastructure so follow the same approach for AltiVec.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v2:
>  - integrate Paul's FP/VMX/VSX changes
> 
>  arch/powerpc/kvm/booke.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)

I had to apply the whole patchset to get proper context for reviewing
this, and found some nits:

>         case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
>                 if (kvmppc_supports_spe() || kvmppc_supports_altivec()) {
>                         kvmppc_booke_queue_irqprio(vcpu,
>                                 BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
>                         r = RESUME_GUEST;
>                 } else { 
>                         /*
>                          * These really should never happen without CONFIG_SPE,
>                          * as we should never enable the real MSR[SPE] in the
>                          * guest.
>                          */

Besides the comment not being updated for Altivec, it's not true on HV,
where the guest can enable MSR[VEC] all by itself.  For HV, the reason
we shouldn't be able to get here is that we disable KVM on e6500 if
CONFIG_ALTIVEC is not enabled, and no other HV core supports either SPE
or Altivec.

>                         pr_crit("%s: unexpected SPE interrupt %u at %08lx\n",
>                                 __func__, exit_nr, vcpu->arch.pc);

Error string will say SPE regardless of what sort of chip you're on.
Given that this is explicitly on the "no support for Altivec or SPE"
path, "SPE/Altivec" phrasing seems appropriate.  Of course we have
bigger problems than that if we ever reach this code. :-)

-Scott
