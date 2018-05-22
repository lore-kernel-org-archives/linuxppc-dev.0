Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qv2W3jc8zDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 21:44:51 +1000 (AEST)
Date: Tue, 22 May 2018 21:44:47 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 24/29] KVM: PPC: Book3S PR: Support TAR handling for
 PR KVM HTM.
Message-ID: <20180522114447.GB9871@fergus.ozlabs.ibm.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
 <1526875786-10372-25-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1526875786-10372-25-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 21, 2018 at 12:09:41PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently guest kernel doesn't handle TAR fac unavailable and it always
> runs with TAR bit on. PR KVM will lazily enable TAR. TAR is not a
> frequent-use reg and it is not included in SVCPU struct.
> 
> Due to the above, the checkpointed TAR val might be a bogus TAR val.
> To solve this issue, we will make vcpu->arch.fscr tar bit consistent
> with shadow_fscr when TM enabled.
> 
> At the end of emulating treclaim., the correct TAR val need to be loaded
> into reg if FSCR_TAR bit is on.
> At the beginning of emulating trechkpt., TAR needs to be flushed so that
> the right tar val can be copy into tar_tm.
> 
> Tested with:
> tools/testing/selftests/powerpc/tm/tm-tar
> tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar (remove DSCR/PPR
> related testing).

With this patch, a 32-bit powermac compile with PR KVM enabled gives
this error:

arch/powerpc/kvm/book3s_pr.c:58:12: error: ‘kvmppc_handle_fac’ declared ‘static’ but never defined [-Werror=unused-function]
 static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac);
            ^
cc1: all warnings being treated as errors
scripts/Makefile.build:312: recipe for target 'arch/powerpc/kvm/book3s_pr.o' failed

The easy fix is a #ifdef CONFIG_PPC_BOOK3S_64 around the forward
static definition.

Paul.
