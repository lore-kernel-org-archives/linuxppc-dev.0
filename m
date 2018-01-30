Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVrhn3NpdzF0Tx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 14:00:09 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id e11so7367325pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 19:00:09 -0800 (PST)
Date: Tue, 30 Jan 2018 11:00:04 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 17/26] KVM: PPC: Book3S PR: add math support for PR KVM HTM
Message-ID: <20180130030004.GE3261@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-18-git-send-email-wei.guo.simon@gmail.com>
 <20180123072927.GI3924@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123072927.GI3924@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, Jan 23, 2018 at 06:29:27PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:30PM +0800, wei.guo.simon@gmail.com wrote:
> > ines: 219
> > 
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > The math registers will be saved into vcpu->arch.fp/vr and corresponding
> > vcpu->arch.fp_tm/vr_tm area.
> > 
> > We flush or giveup the math regs into vcpu->arch.fp/vr before saving
> > transaction. After transaction is restored, the math regs will be loaded
> > back into regs.
> 
> It looks to me that you are loading up the math regs on every vcpu
> load, not just those with an active transaction.  That seems like
> overkill.
> 
> > If there is a FP/VEC/VSX unavailable exception during transaction active
> > state, the math checkpoint content might be incorrect and we need to do
> > treclaim./load the correct checkpoint val/trechkpt. sequence to retry the
> > transaction.
> 
> I would prefer a simpler approach where just before entering the
> guest, we check if the guest MSR TM bit is set, and if so we make sure
> that whichever math regs are enabled in the guest MSR are actually
> loaded on the CPU, that is, that guest_owned_ext has the same bits set
> as the guest MSR.  Then we never have to handle a FP/VEC/VSX
> unavailable interrupt with a transaction active (other than by simply
> passing it on to the guest).

Good idea. I will rework as this way.

Thanks,
- Simon
