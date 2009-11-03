Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A11D9B7BE2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 08:38:58 +1100 (EST)
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-15-git-send-email-agraf@suse.de>
	<A1CBD511-FF08-48BB-A8D6-9F66E20F770B@kernel.crashing.org>
	<280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Nov 2009 08:38:33 +1100
Message-ID: <1257284313.7907.80.camel@pasglop>
Mime-Version: 1.0
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-03 at 10:06 +0100, Alexander Graf wrote:

> > DCBZ zeroes out a cache line, not 32 bytes; except on 970, where there
> > are HID bits to make it work on 32 bytes only, and an extra DCBZL insn
> > that always clears a full cache line (128 bytes).
> 
> Yes. We only come here when we patched the dcbz opcodes to invalid  
> instructions because cache line size of target == 32.
> On 970 with MSR_HV = 0 we actually use the dcbz 32-bytes mode.
> 
> Admittedly though, this could be a lot more clever.

Yeah well, we also really need to fix ppc32 Linux to use the device-tree
provided cache line size :-) For 64-bits, that should already be the
case, and thus the emulation trick shouldn't be useful as long as you
properly provide the guest with the right size in the device-tree.

(Though glibc can be nasty, afaik it might load up optimized variants of
some routines with hard wired cache line sizes based on the CPU type)

> >> +	switch (sprn) {
> >> +	case SPRN_IBAT0U ... SPRN_IBAT3L:
> >> +		bat = &vcpu_book3s->ibat[(sprn - SPRN_IBAT0U) / 2];
> >> +		break;
> >> +	case SPRN_IBAT4U ... SPRN_IBAT7L:
> >> +		bat = &vcpu_book3s->ibat[(sprn - SPRN_IBAT4U) / 2];
> >> +		break;
> >> +	case SPRN_DBAT0U ... SPRN_DBAT3L:
> >> +		bat = &vcpu_book3s->dbat[(sprn - SPRN_DBAT0U) / 2];
> >> +		break;
> >> +	case SPRN_DBAT4U ... SPRN_DBAT7L:
> >> +		bat = &vcpu_book3s->dbat[(sprn - SPRN_DBAT4U) / 2];
> >> +		break;
> >
> > Do xBAT4..7 have the same SPR numbers on all CPUs?  They are CPU- 
> > specific
> > SPRs, after all.  Some CPUs have only six, some only four, some  
> > none, btw.
> 
> For now only Linux runs which only uses the first 3(?) IIRC. But yes,  
> it's probably worth looking into at one point or the other.
> 
> >
> >> +	case SPRN_HID0:
> >> +		to_book3s(vcpu)->hid[0] = vcpu->arch.gpr[rs];
> >> +		break;
> >> +	case SPRN_HID1:
> >> +		to_book3s(vcpu)->hid[1] = vcpu->arch.gpr[rs];
> >> +		break;
> >> +	case SPRN_HID2:
> >> +		to_book3s(vcpu)->hid[2] = vcpu->arch.gpr[rs];
> >> +		break;
> >> +	case SPRN_HID4:
> >> +		to_book3s(vcpu)->hid[4] = vcpu->arch.gpr[rs];
> >> +		break;
> >> +	case SPRN_HID5:
> >> +		to_book3s(vcpu)->hid[5] = vcpu->arch.gpr[rs];
> >
> > HIDs are different per CPU; and worse, different CPUs have different
> > registers (SPR #s) for the same register name!
> 
> Sigh :-(

On the other hand, you can probably just "Swallow" all of these and
Linux won't even notice, except for the case of the sleep state maybe on
6xx/7xx/7xxx. Just a matter of knowing what your are emulating as guest.

Cheers,
Ben.
