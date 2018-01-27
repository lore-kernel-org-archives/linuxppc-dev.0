Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x234.google.com (mail-pl0-x234.google.com
 [IPv6:2607:f8b0:400e:c01::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zTGNB6ZW0zF0TV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jan 2018 00:10:18 +1100 (AEDT)
Received: by mail-pl0-x234.google.com with SMTP id o13so668470pli.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 05:10:18 -0800 (PST)
Date: Sat, 27 Jan 2018 21:10:12 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 00/26] KVM: PPC: Book3S PR: Transaction memory support on
 PR KVM
Message-ID: <20180127131011.GA2521@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <20180123053832.GA3924@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123053832.GA3924@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, Jan 23, 2018 at 04:38:32PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:13PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > In current days, many OS distributions have utilized transaction
> > memory functionality. In PowerPC, HV KVM supports TM. But PR KVM
> > does not.
> > 
> > The drive for the transaction memory support of PR KVM is the
> > openstack Continuous Integration testing - They runs a HV(hypervisor)
> > KVM(as level 1) and then run PR KVM(as level 2) on top of that.
> > 
> > This patch set add transaction memory support on PR KVM.
> 
> Thanks for the patch set.  It mostly looks good, though I have some
> comments on the individual patches.
> 
> I don't see where you are implementing support for userspace accessing
> the TM checkpointed register values using the GET_ONE_REG/SET_ONE_REG
> API.  This would mean that you couldn't migrate a guest that was in
> the middle of a transaction.  We will need to have the one_reg API
> access to the TM checkpoint implemented, though there will be a
> difficulty in that kvmppc_get_one_reg() and kvmppc_set_one_reg() are
> called with the vcpu context loaded.  With your scheme of having the
> TM checkpoint stored in the CPU while the vcpu context is loaded, the
> values you want to access in kvmppc_get/set_one_reg are inaccessible
> since they're stored in the CPU.  You would have to arrange for
> kvmppc_get/set_one_reg to be called without the vcpu context loaded
> (recent patches in the kvm next branch probably make that easier) or
> else explicitly unload and reload the vcpu context in those functions.
> (This is easier in HV KVM since the checkpoint is not in the CPU at
> the point of doing kvmppc_get/set_one_reg.)
Thanks for point it out. I didn't think about it before and will 
investigate. 

I plan to work out this PR KVM HTM kvmppc_get/set_one_reg() 
(and the KVM_SET_REGS you mentioned in another mail) with seperate 
patch/patch set, so that the reworked V2 of current patches can be 
sent out in parallel. In case it is not appropriate for you, please 
let me know.

> 
> There is also complexity added because it's possible for the guest to
> have TM, FP, VEC and VSX all enabled from its point of view but to
> have FP/VEC/VSX not actually enabled in the hardware when the guest is
> running.  As you note in your patch descriptions, this means that the
> guest can do tbegin and create a checkpoint with bogus values for the
> FP/VEC/VSX registers.  Rather than trying to detect and fix up this
> situation after the fact, I would suggest that if the guest has TM
> enabled then we make sure that the real FP/VEC/VSX bits in the MSR
> match what the guest thinks it has.  That way we would avoid the bogus
> checkpoint problem.  (There is still the possibility of getting bogus
> checkpointed FP/VEC/VSX registers if the guest does tbegin with the
> FP/VEC/VSX bits clear in the MSR, but that is the guest's problem to
> deal with.)
Good idea. I will look into kvmppc_set_msr_pr() / kvmppc_giveup_ext()
to simplify the solution.

Thanks for your review and time.

BR,
- Simon
