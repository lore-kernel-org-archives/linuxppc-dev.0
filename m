Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQjC31WL9zDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 20:08:31 +1100 (AEDT)
Date: Tue, 23 Jan 2018 20:08:25 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 20/26] KVM: PPC: Book3S PR: enable NV reg restore for
 reading TM SPR at guest privilege state
Message-ID: <20180123090825.GL3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-21-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-21-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:33PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently kvmppc_handle_fac() will not update NV GPRs and thus it can
> return with GUEST_RESUME.
> 
> However PR KVM guest always disables MSR_TM bit at privilege state. If PR
> privilege guest are trying to read TM SPRs, it will trigger TM facility
> unavailable exception and fall into kvmppc_handle_fac(). Then the emulation
> will be done by kvmppc_core_emulate_mfspr_pr(). The mfspr instruction can
> include a RT with NV reg. So it is necessary to restore NV GPRs at this
> case, to reflect the update to NV RT.
> 
> This patch make kvmppc_handle_fac() return GUEST_RESUME_NV at TM fac
> exception and with guest privilege state.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
