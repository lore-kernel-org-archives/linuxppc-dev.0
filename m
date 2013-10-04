Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 93A712C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 00:02:53 +1000 (EST)
Subject: Re: [PATCH 0/4 v6] KVM :PPC: Userspace Debug support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
Date: Fri, 4 Oct 2013 16:02:46 +0200
Message-Id: <B93277EB-FD72-4FDB-AF99-2ADCA51C16D3@suse.de>
References: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: sfr@canb.auug.org.au, mikey@neuling.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Bharat Bhushan <bharat.bhushan@freescale.com>,
 tiejun.chen@windriver.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2013, at 08:57, Bharat Bhushan wrote:

> From: Bharat Bhushan <bharat.bhushan@freescale.com>
>=20
> Note: These patches depends on https://lkml.org/lkml/2013/7/4/49.
>=20
> This patchset adds the userspace debug support for booke/bookehv.
> this is tested on powerpc e500v2/e500mc devices.

Thanks, applied to kvm-ppc-queue.


Alex

>=20
> We are now assuming that debug resource will not be used by kernel for
> its own debugging. It will be used for only kernel user process =
debugging.
> So the kernel debug load interface during context_to is used to load
> debug conext for that selected process.
>=20
> v5->v6
> - Earlier it was a patchset of six patches. Now this is devided into
>   two parts: 1) powerpc spcific changes 2) kvm specific changes.
>   This patchset now contains only KVM specific changes.
> - using "ehpriv 1" (earlier using "ehpriv") for software breakpoint
> -
>=20
> v4->v5
> - Some comments reworded and other cleanup (like change of function =
name etc)
> - Added a function for setting MSRP rather than inline
>=20
> v3->v4
> - 4 out of 7 patches of initial patchset were applied.
>   This patchset is on and above those 4 patches
> - KVM local "struct kvmppc_booke_debug_reg" is replaced by
>   powerpc global "struct debug_reg"
> - use switch_booke_debug_regs() for debug register context switch.
> - Save DBSR before kernel pre-emption is enabled.
> - Some more cleanup
>=20
> v2->v3
> - We are now assuming that debug resource will not be used by
>   kernel for its own debugging.
>   It will be used for only kernel user process debugging.
>   So the kernel debug load interface during context_to is
>   used to load debug conext for that selected process.
>=20
> v1->v2
> - Debug registers are save/restore in vcpu_put/vcpu_get.
>   Earlier the debug registers are saved/restored in guest entry/exit
>=20
> Bharat Bhushan (4):
>  powerpc: export debug registers save function for KVM
>  KVM: PPC: exit to user space on "ehpriv 1" instruction
>  KVM: PPC: Using "struct debug_reg"
>  KVM: PPC: Add userspace debug stub support
>=20
> arch/powerpc/include/asm/disassemble.h |    4 +
> arch/powerpc/include/asm/kvm_booke.h   |    7 +-
> arch/powerpc/include/asm/kvm_host.h    |   16 +--
> arch/powerpc/include/asm/switch_to.h   |    1 +
> arch/powerpc/include/uapi/asm/kvm.h    |   22 ++-
> arch/powerpc/kernel/process.c          |    3 +-
> arch/powerpc/kvm/booke.c               |  275 =
++++++++++++++++++++++++++++----
> arch/powerpc/kvm/booke.h               |    5 +
> arch/powerpc/kvm/e500_emulate.c        |   26 +++
> 9 files changed, 312 insertions(+), 47 deletions(-)
>=20
>=20
