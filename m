Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPj308n0zDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:46:30 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id i5-v6so12510187plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:46:30 -0700 (PDT)
Date: Wed, 23 May 2018 15:01:39 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 24/29] KVM: PPC: Book3S PR: Support TAR handling for
 PR KVM HTM.
Message-ID: <20180523070139.GB2498@simonLocalRHEL7.x64>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
 <1526875786-10372-25-git-send-email-wei.guo.simon@gmail.com>
 <20180522114447.GB9871@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180522114447.GB9871@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, May 22, 2018 at 09:44:47PM +1000, Paul Mackerras wrote:
> On Mon, May 21, 2018 at 12:09:41PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > Currently guest kernel doesn't handle TAR fac unavailable and it always
> > runs with TAR bit on. PR KVM will lazily enable TAR. TAR is not a
> > frequent-use reg and it is not included in SVCPU struct.
> > 
> > Due to the above, the checkpointed TAR val might be a bogus TAR val.
> > To solve this issue, we will make vcpu->arch.fscr tar bit consistent
> > with shadow_fscr when TM enabled.
> > 
> > At the end of emulating treclaim., the correct TAR val need to be loaded
> > into reg if FSCR_TAR bit is on.
> > At the beginning of emulating trechkpt., TAR needs to be flushed so that
> > the right tar val can be copy into tar_tm.
> > 
> > Tested with:
> > tools/testing/selftests/powerpc/tm/tm-tar
> > tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar (remove DSCR/PPR
> > related testing).
> 
> With this patch, a 32-bit powermac compile with PR KVM enabled gives
> this error:
> 
> arch/powerpc/kvm/book3s_pr.c:58:12: error: ‘kvmppc_handle_fac’ declared ‘static’ but never defined [-Werror=unused-function]
>  static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac);
>             ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:312: recipe for target 'arch/powerpc/kvm/book3s_pr.o' failed
> 
> The easy fix is a #ifdef CONFIG_PPC_BOOK3S_64 around the forward
> static definition.
Thx for find that. I will fix that and send V4 includes that simple fix.

BR,
- Simon
