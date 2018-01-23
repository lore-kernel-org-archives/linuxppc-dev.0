Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfkD27CVzDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:16:52 +1100 (AEDT)
Date: Tue, 23 Jan 2018 18:16:35 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 00/26] KVM: PPC: Book3S PR: Transaction memory support on
 PR KVM
Message-ID: <20180123071635.GH3924@fergus.ozlabs.ibm.com>
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

Another complexity that hasn't been dealt with as far as I can see is
that if userspace does a KVM_SET_REGS that changes the TS field in the
guest MSR, we don't do anything to make the state of the CPU match.
As with GET/SET_ONE_REG, KVM_SET_REGS is called with the vcpu loaded,
so it needs to make the physical CPU state match what it would have
been had the new state been present at load time, perhaps by unloading
the CPU before changing the state, then reloading it.  But if you do
that and you are using the vcpu->arch.save_msr_tm field that you add,
then you need to modify that when you do kvmppc_set_msr().  (I would
rather that your save/restore TM functions work off kvmppc_get_msr()
rather than having the save_msr_tm field.)

Paul.
