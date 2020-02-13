Return-Path: <SRS0=qWQb=4B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59371C352A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 23:33:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A120848
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 23:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48JXr30XhqzDqtt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Feb 2020 10:33:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48JXph1SxNzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2020 10:31:54 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 01DNVn6L015172;
 Thu, 13 Feb 2020 17:31:49 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 01DNVmdM015171;
 Thu, 13 Feb 2020 17:31:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 13 Feb 2020 17:31:48 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gustavo Romero <gromero@linux.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Treat unrecognized TM instructions
 as illegal
Message-ID: <20200213233148.GK22482@gate.crashing.org>
References: <20200213151532.12559-1-gromero@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151532.12559-1-gromero@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 13, 2020 at 10:15:32AM -0500, Gustavo Romero wrote:
> On P9 DD2.2 due to a CPU defect some TM instructions need to be emulated by
> KVM. This is handled at first by the hardware raising a softpatch interrupt
> when certain TM instructions that need KVM assistance are executed in the
> guest. Some TM instructions, although not defined in the Power ISA, might
> raise a softpatch interrupt. For instance, 'tresume.' instruction as
> defined in the ISA must have bit 31 set (1), but an instruction that
> matches 'tresume.' OP and XO opcodes but has bit 31 not set (0), like
> 0x7cfe9ddc, also raises a softpatch interrupt, for example, if a code
> like the following is executed in the guest it will raise a softpatch
> interrupt just like a 'tresume.' when the TM facility is enabled:
> 
> int main() { asm("tabort. 0; .long 0x7cfe9ddc;"); }
> 
> Currently in such a case KVM throws a complete trace like the following:

[snip]

> and then treats the executed instruction as 'nop' whilst it should actually
> be treated as an illegal instruction since it's not defined by the ISA.
> 
> This commit changes the handling of the case above by treating the
> unrecognized TM instructions that can raise a softpatch but are not
> defined in the ISA as illegal ones instead of as 'nop' and by gently
> reporting it to the host instead of throwing a trace.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

> ---
>  arch/powerpc/kvm/book3s_hv_tm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
> index 0db937497169..d342a9e11298 100644
> --- a/arch/powerpc/kvm/book3s_hv_tm.c
> +++ b/arch/powerpc/kvm/book3s_hv_tm.c
> @@ -3,6 +3,8 @@
>   * Copyright 2017 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kvm_host.h>
>  
>  #include <asm/kvm_ppc.h>
> @@ -208,6 +210,8 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
>  	}
>  
>  	/* What should we do here? We didn't recognize the instruction */
> -	WARN_ON_ONCE(1);
> +	kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> +	pr_warn_ratelimited("Unrecognized TM-related instruction %#x for emulation", instr);
> +
>  	return RESUME_GUEST;
>  }

Do we actually know it is TM-related here?  Otherwise, looks good to me :-)


Segher
