Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQg116gjHzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:29:41 +1100 (AEDT)
Date: Tue, 23 Jan 2018 18:29:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 17/26] KVM: PPC: Book3S PR: add math support for PR KVM HTM
Message-ID: <20180123072927.GI3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-18-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-18-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:30PM +0800, wei.guo.simon@gmail.com wrote:
> ines: 219
> 
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> The math registers will be saved into vcpu->arch.fp/vr and corresponding
> vcpu->arch.fp_tm/vr_tm area.
> 
> We flush or giveup the math regs into vcpu->arch.fp/vr before saving
> transaction. After transaction is restored, the math regs will be loaded
> back into regs.

It looks to me that you are loading up the math regs on every vcpu
load, not just those with an active transaction.  That seems like
overkill.

> If there is a FP/VEC/VSX unavailable exception during transaction active
> state, the math checkpoint content might be incorrect and we need to do
> treclaim./load the correct checkpoint val/trechkpt. sequence to retry the
> transaction.

I would prefer a simpler approach where just before entering the
guest, we check if the guest MSR TM bit is set, and if so we make sure
that whichever math regs are enabled in the guest MSR are actually
loaded on the CPU, that is, that guest_owned_ext has the same bits set
as the guest MSR.  Then we never have to handle a FP/VEC/VSX
unavailable interrupt with a transaction active (other than by simply
passing it on to the guest).

Paul.
