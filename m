Return-Path: <paulus@ozlabs.org>
Date: Wed, 1 Jun 2011 15:11:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110601051145.GB6773@brick.ozlabs.ibm.com>
References: <20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
	<b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
	<6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
	<10cc079a31947ec4b6d39f30f2ac50f2@kernel.crashing.org>
	<A052DEF7-7DA0-4573-89EC-0A685ED4B498@pobox.com>
	<c71b71560e43813012b6f293230dc78e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c71b71560e43813012b6f293230dc78e@kernel.crashing.org>
Cc: kvm-ppc@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Alexander Graf <agraf@suse.de>, KVM list <kvm@vger.kernel.org>,
	Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 01, 2011 at 12:34:43AM +0200, Segher Boessenkool wrote:

> There's a loop of 128 iterations of 3 insns.
> 
> I'm not saying it is actually bad, just that that 50 is slightly off ;-)

That would be the TLB invalidation.  On POWER7 we only need to do that
if the virtual cpu last ran on a different physical cpu, or if this
physical cpu last ran a different virtual cpu in the same partition.
So hopefully we don't have to do it very often.

The reason we have to do it in that case is to allow the optimization
where we use tlbiel for TLB invalidations if the guest claims that
the translation being invalidated was only ever used on this virtual
cpu.  That means that we have to guard against stale TLB entries left
behind when a virtual cpu moves from one physical cpu to another.

Paul.
