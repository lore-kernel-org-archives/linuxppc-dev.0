Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVsHL3fQnzDqlH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 14:26:38 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id c6so7437627pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 19:26:38 -0800 (PST)
Date: Tue, 30 Jan 2018 11:26:33 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 25/26] KVM: PPC: Book3S PR: Support TAR handling for PR
 KVM HTM.
Message-ID: <20180130032633.GK3261@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-26-git-send-email-wei.guo.simon@gmail.com>
 <20180124040257.GA32139@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180124040257.GA32139@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Wed, Jan 24, 2018 at 03:02:58PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:38PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > Currently guest kernel doesn't handle TAR fac unavailable and it always
> > runs with TAR bit on. PR KVM will lazily enable TAR. TAR is not a
> > frequent-use reg and it is not included in SVCPU struct.
> > 
> > To make it work for transaction memory at PR KVM:
> > 1). Flush/giveup TAR at kvmppc_save_tm_pr().
> > 2) If we are receiving a TAR fac unavail exception inside a transaction,
> > the checkpointed TAR might be a TAR value from another process. So we need
> > treclaim the transaction, then load the desired TAR value into reg, and
> > perform trecheckpoint.
> > 3) Load TAR facility at kvmppc_restore_tm_pr() when TM active.
> > The reason we always loads TAR when restoring TM is that:
> > If we don't do this way, when there is a TAR fac unavailable exception
> > during TM active:
> > case 1: it is the 1st TAR fac unavail exception after tbegin.
> > vcpu->arch.tar should be reloaded as checkpoint tar val.
> > case 2: it is the 2nd or later TAR fac unavail exception after tbegin.
> > vcpu->arch.tar_tm should be reloaded as checkpoint tar val.
> > There will be unnecessary difficulty to handle the above 2 cases.
> > 
> > at the end of emulating treclaim., the correct TAR val need to be loaded
> > into reg if FSCR_TAR bit is on.
> > at the beginning of emulating trechkpt., TAR needs to be flushed so that
> > the right tar val can be copy into tar_tm.
> 
> Would it be simpler always to load up TAR when guest_MSR[TM] is 1?
> 
> Paul.
Sure. it will have a similar solution with math regs.
Thanks for the suggestion,

BR
- Simon
