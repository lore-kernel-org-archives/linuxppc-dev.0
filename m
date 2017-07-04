Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1lTD21KdzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 10:37:36 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c24so12799092pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 17:37:36 -0700 (PDT)
Message-ID: <1499128649.8033.5.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/tm: fix live state of vs0/32 in tm_reclaim
From: Cyril Bur <cyrilbur@gmail.com>
To: Breno Leitao <leitao@debian.org>, Gustavo Romero
 <gromero@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 04 Jul 2017 10:37:29 +1000
In-Reply-To: <20170630164135.tlcgh365cjrquscj@gmail.com>
References: <1498783490-23675-1-git-send-email-gromero@linux.vnet.ibm.com>
 <20170630164135.tlcgh365cjrquscj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-30 at 13:41 -0300, Breno Leitao wrote:
> Thanks Gustavo for the patch.
> 
> On Thu, Jun 29, 2017 at 08:39:23PM -0400, Gustavo Romero wrote:
> > Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
> > due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.
> > 
> > Later, we recheckpoint trusting that the live state of FP and VEC are ok
> > depending on the MSR.FP and MSR.VEC bits, i.e. if MSR.FP is enabled that
> > means the FP registers checkpointed before entering are correct and so
> > after a treclaim. we can trust the FP live state, and similarly on VEC regs.
> > However if tm_reclaim() does not return a sane state then tm_recheckpoint()
> > will recheckpoint a corrupted instate back to the checkpoint area.
> > 
> > That commit fixes the corruption by restoring vs0 and vs32 from the
> > ckfp_state and ckvr_state after they are used to save FPSCR and VSCR,
> > respectively.
> > 
> > The effect of the issue described above is observed, for instance, once a
> > VSX unavailable exception is caught in the middle of a transaction with
> > MSR.FP = 1 or MSR.VEC = 1. If MSR.FP = 1, then after getting back to user
> > space FP state is corrupted. If MSR.VEC = 1, then VEC state is corrupted.
> > 
> > The issue does occur if MSR.FP = 0 and MSR.VEC = 0 because ckfp_state and
> > ckvr_state are both copied from fp_state and vr_state, respectively, and
> > on recheckpointing both states will be restored from these thread
> > structures and not from the live state.
> 
> Just complementing what Gustavo said, currently the tm_recheckpoint()
> function grabs the values to be re-checkpoint from two places, depending
> on the MSR configuration.
> 
> If VEC or FP are disabled on MSR argument when tm_recheckpoint() is
> called, then it restorese the values from the thread ckvr/ckfp area and
> recheckpoint these values into processor transactional area.
> 
> On the other side, if VEC or FP are disabled, it does not restore the
> vectors and fp registers from the thread ckvec/ckfp area, and it will
> recheckpoint what is currently on the live registers. If the registers
> changed after the reclaim, we will send these new values recheckpointed,
> and later on userspace when the transaction fails.
> 
> This second scenario is what is causing the error reported on this
> email thread. In fact, I am wondering if we can hit another hidden bug that
> changes the fp and vec values between the tm_reclaim() and
> tm_recheckpoint() invokations, as for example, an interrupt that calls
> memcpy() in this small mean time.
> 
> That said, I am wondering if we shouldn't always rely on thread ckfp and
> ckvec during tm_recheckpoint() (and never rely on the live registers). This
> should simplify the reclaim/recheckpoint mechanism, and make it less
> error prone.

I think you're absolutely correct - its a mess. Personally I think that
the assembly functions should do the bare minimum. So the two cases
that you describe which are handled in assembly could easily be handled
in C either before the call to the assembly or after.

Cyril
