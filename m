Return-Path: <mj.embd@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by ozlabs.org (Postfix) with ESMTP id 28D90B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 14:57:33 +1000 (EST)
Received: by wwe15 with SMTP id 15so348397wwe.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Jul 2010 21:57:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Date: Fri, 9 Jul 2010 10:27:30 +0530
Message-ID: <AANLkTilp94NW1GMMew3oI-4czkUEA5W-CFqN9UVs8xcZ@mail.gmail.com>
Subject: Re: [PATCH 00/27] KVM PPC PV framework
From: MJ embd <mj.embd@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 1, 2010 at 4:12 PM, Alexander Graf <agraf@suse.de> wrote:
> On PPC we run PR=3D0 (kernel mode) code in PR=3D1 (user mode) and don't u=
se the
> hypervisor extensions.
>
> While that is all great to show that virtualization is possible, there ar=
e
> quite some cases where the emulation overhead of privileged instructions =
is
> killing performance.
>
> This patchset tackles exactly that issue. It introduces a paravirtual fra=
mework
> using which KVM and Linux share a page to exchange register state with. T=
hat

KVM and Linux or KVM and GuestOS ?

> way we don't have to switch to the hypervisor just to change a value of a
> privileged register.
>
> To prove my point, I ran the same test I did for the MMU optimizations ag=
ainst
> the PV framework. Here are the results:
>
> [without]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null=
; done
>
> real =A0 =A00m14.659s
> user =A0 =A00m8.967s
> sys =A0 =A0 0m5.688s
>
> [with]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null=
; done
>
> real =A0 =A00m7.557s
> user =A0 =A00m4.121s
> sys =A0 =A0 0m3.426s
>
>
> So this is a significant performance improvement! I'm quite happy how fas=
t this
> whole thing becomes :)
>
> I tried to take all comments I've heard from people so far about such a P=
V
> framework into account. In case you told me something before that is a no=
-go
> and I still did it, please just tell me again.
>
> Now go and have fun with fast VMs on PPC! Get yourself a G5 on ebay and s=
tart
> experiencing the power yourself. - heh
>
> v1 -> v2:
>
> =A0- change hypervisor calls to use r0 and r3
> =A0- make crit detection only trigger in supervisor mode
> =A0- RMO -> PAM
> =A0- introduce kvm_patch_ins
> =A0- only flush icache when patching
> =A0- introduce kvm_patch_ins_b
> =A0- update documentation
>
> Alexander Graf (27):
> =A0KVM: PPC: Introduce shared page
> =A0KVM: PPC: Convert MSR to shared page
> =A0KVM: PPC: Convert DSISR to shared page
> =A0KVM: PPC: Convert DAR to shared page.
> =A0KVM: PPC: Convert SRR0 and SRR1 to shared page
> =A0KVM: PPC: Convert SPRG[0-4] to shared page
> =A0KVM: PPC: Implement hypervisor interface
> =A0KVM: PPC: Add PV guest critical sections
> =A0KVM: PPC: Add PV guest scratch registers
> =A0KVM: PPC: Tell guest about pending interrupts
> =A0KVM: PPC: Make RMO a define
> =A0KVM: PPC: First magic page steps
> =A0KVM: PPC: Magic Page Book3s support
> =A0KVM: PPC: Magic Page BookE support
> =A0KVM: PPC: Expose magic page support to guest
> =A0KVM: Move kvm_guest_init out of generic code
> =A0KVM: PPC: Generic KVM PV guest support
> =A0KVM: PPC: KVM PV guest stubs
> =A0KVM: PPC: PV instructions to loads and stores
> =A0KVM: PPC: PV tlbsync to nop
> =A0KVM: PPC: Introduce kvm_tmp framework
> =A0KVM: PPC: Introduce branch patching helper
> =A0KVM: PPC: PV assembler helpers
> =A0KVM: PPC: PV mtmsrd L=3D1
> =A0KVM: PPC: PV mtmsrd L=3D0 and mtmsr
> =A0KVM: PPC: PV wrteei
> =A0KVM: PPC: Add Documentation about PV interface
>
> =A0Documentation/kvm/ppc-pv.txt =A0 =A0 =A0 =A0 =A0 =A0 | =A0185 ++++++++=
++++++
> =A0arch/powerpc/include/asm/kvm_book3s.h =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/include/asm/kvm_host.h =A0 =A0 =A0| =A0 15 +-
> =A0arch/powerpc/include/asm/kvm_para.h =A0 =A0 =A0| =A0121 +++++++++-
> =A0arch/powerpc/include/asm/kvm_ppc.h =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/kernel/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/powerpc/kernel/asm-offsets.c =A0 =A0 =A0 =A0| =A0 18 ++-
> =A0arch/powerpc/kernel/kvm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0408 ++++=
++++++++++++++++++++++++++
> =A0arch/powerpc/kernel/kvm_emul.S =A0 =A0 =A0 =A0 =A0 | =A0237 ++++++++++=
+++++++
> =A0arch/powerpc/kvm/44x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 =
+
> =A0arch/powerpc/kvm/44x_tlb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +-
> =A0arch/powerpc/kvm/book3s.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0165 ++++=
++++-----
> =A0arch/powerpc/kvm/book3s_32_mmu.c =A0 =A0 =A0 =A0 | =A0 28 ++-
> =A0arch/powerpc/kvm/book3s_32_mmu_host.c =A0 =A0| =A0 16 +-
> =A0arch/powerpc/kvm/book3s_64_mmu.c =A0 =A0 =A0 =A0 | =A0 42 +++-
> =A0arch/powerpc/kvm/book3s_64_mmu_host.c =A0 =A0| =A0 16 +-
> =A0arch/powerpc/kvm/book3s_emulate.c =A0 =A0 =A0 =A0| =A0 25 +-
> =A0arch/powerpc/kvm/book3s_paired_singles.c | =A0 11 +-
> =A0arch/powerpc/kvm/booke.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0113 ++++=
+++--
> =A0arch/powerpc/kvm/booke.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +-
> =A0arch/powerpc/kvm/booke_emulate.c =A0 =A0 =A0 =A0 | =A0 14 +-
> =A0arch/powerpc/kvm/booke_interrupts.S =A0 =A0 =A0| =A0 =A03 +-
> =A0arch/powerpc/kvm/e500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 =
+
> =A0arch/powerpc/kvm/e500_tlb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 31 ++-
> =A0arch/powerpc/kvm/e500_tlb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/kvm/emulate.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 47 +++-
> =A0arch/powerpc/kvm/powerpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 42 +++-
> =A0arch/powerpc/platforms/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 10 +
> =A0arch/x86/include/asm/kvm_para.h =A0 =A0 =A0 =A0 =A0| =A0 =A06 +
> =A0include/linux/kvm_para.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +-
> =A030 files changed, 1420 insertions(+), 174 deletions(-)
> =A0create mode 100644 Documentation/kvm/ppc-pv.txt
> =A0create mode 100644 arch/powerpc/kernel/kvm.c
> =A0create mode 100644 arch/powerpc/kernel/kvm_emul.S
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
