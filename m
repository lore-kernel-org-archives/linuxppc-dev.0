Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 08/27] Add SLB switching code for entry/exit
In-reply-to: <00BF2D99-F2CE-4204-B4B4-0D113FD54CE6@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-9-git-send-email-agraf@suse.de>
	<6695.1257117827@neuling.org>
	<00BF2D99-F2CE-4204-B4B4-0D113FD54CE6@suse.de>
Date: Mon, 02 Nov 2009 20:39:43 +1100
Message-ID: <11094.1257154783@neuling.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm-ppc <kvm-ppc@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Avi Kivity <avi@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bphilips@suse.de" <bphilips@suse.de>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> This is the really low level of guest entry/exit code.
> >>
> >> Book3s_64 has an SLB, which stores all ESID -> VSID mappings we're
> >> currently aware of.
> >>
> >> The segments in the guest differ from the ones on the host, so we  
> >> need
> >> to switch the SLB to tell the MMU that we're in a new context.
> >>
> >> So we store a shadow of the guest's SLB in the PACA, switch to that  
> >> on
> >> entry and only restore bolted entries on exit, leaving the rest to  
> >> the
> >> Linux SLB fault handler.
> >>
> >> That way we get a really clean way of switching the SLB.
> >>
> >> Signed-off-by: Alexander Graf <agraf@suse.de>
> >> ---
> >> arch/powerpc/kvm/book3s_64_slb.S |  277 ++++++++++++++++++++++++++++ 
> >> ++++++++
> > ++
> >> 1 files changed, 277 insertions(+), 0 deletions(-)
> >> create mode 100644 arch/powerpc/kvm/book3s_64_slb.S
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/ 
> >> book3s_64_sl
> > b.S
> >> new file mode 100644
> >> index 0000000..00a8367
> >> --- /dev/null
> >> +++ b/arch/powerpc/kvm/book3s_64_slb.S
> >> @@ -0,0 +1,277 @@
> >> +/*
> >> + * This program is free software; you can redistribute it and/or  
> >> modify
> >> + * it under the terms of the GNU General Public License, version  
> >> 2, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA   
> >> 02110-1301, USA.
> >> + *
> >> + * Copyright SUSE Linux Products GmbH 2009
> >> + *
> >> + * Authors: Alexander Graf <agraf@suse.de>
> >> + */
> >> +
> >> +/ 
> >> *** 
> >> *** 
> >> *********************************************************************
> > ***
> >> + *
> >  *
> >> + *                               Entry code
> >  *
> >> + *
> >  *
> >> +  
> >> *** 
> >> *** 
> >> *********************************************************************
> > **/
> >> +
> >> +.global kvmppc_handler_trampoline_enter
> >> +kvmppc_handler_trampoline_enter:
> >> +
> >> +    /* Required state:
> >> +     *
> >> +     * MSR = ~IR|DR
> >> +     * R13 = PACA
> >> +     * R9 = guest IP
> >> +     * R10 = guest MSR
> >> +     * R11 = free
> >> +     * R12 = free
> >> +     * PACA[PACA_EXMC + EX_R9] = guest R9
> >> +     * PACA[PACA_EXMC + EX_R10] = guest R10
> >> +     * PACA[PACA_EXMC + EX_R11] = guest R11
> >> +     * PACA[PACA_EXMC + EX_R12] = guest R12
> >> +     * PACA[PACA_EXMC + EX_R13] = guest R13
> >> +     * PACA[PACA_EXMC + EX_CCR] = guest CR
> >> +     * PACA[PACA_EXMC + EX_R3] = guest XER
> >> +     */
> >> +
> >> +    mtsrr0    r9
> >> +    mtsrr1    r10
> >> +
> >> +    mtspr    SPRN_SPRG_SCRATCH0, r0
> >> +
> >> +    /* Remove LPAR shadow entries */
> >> +
> >> +#if SLB_NUM_BOLTED == 3
> >
> > You could alternatively check the persistent entry in the slb_shawdow
> > buffer.  This would give you a run time check.  Not sure what's best
> > though.
> 
> Well we're in the hot path here, so anything using as few registers as  
> possible and being simple is the best :-). I'd guess the more we are  
> clever at compile time the better.

Yeah, I tend to agree.

> 
> >
> >
> >> +
> >> +    ld    r12, PACA_SLBSHADOWPTR(r13)
> >> +    ld    r10, 0x10(r12)
> >> +    ld    r11, 0x18(r12)
> >
> > Can you define something in asm-offsets.c for these magic constants  
> > 0x10
> > and 0x18.  Similarly below.
> >
> >> +    /* Invalid? Skip. */
> >> +    rldicl. r0, r10, 37, 63
> >> +    beq    slb_entry_skip_1
> >> +    xoris    r9, r10, SLB_ESID_V@h
> >> +    std    r9, 0x10(r12)
> >> +slb_entry_skip_1:
> >> +    ld    r9, 0x20(r12)
> >> +    /* Invalid? Skip. */
> >> +    rldicl. r0, r9, 37, 63
> >> +    beq    slb_entry_skip_2
> >> +    xoris    r9, r9, SLB_ESID_V@h
> >> +    std    r9, 0x20(r12)
> >> +slb_entry_skip_2:
> >> +    ld    r9, 0x30(r12)
> >> +    /* Invalid? Skip. */
> >> +    rldicl. r0, r9, 37, 63
> >> +    beq    slb_entry_skip_3
> >> +    xoris    r9, r9, SLB_ESID_V@h
> >> +    std    r9, 0x30(r12)
> >
> > Can these 3 be made into a macro?
> 
> Phew - dynamically generating jump points sounds rather hard. I can  
> give it a try...
> 
> >
> >> +slb_entry_skip_3:
> >> +
> >> +#else
> >> +#error unknown number of bolted entries
> >> +#endif
> >> +
> >> +    /* Flush SLB */
> >> +
> >> +    slbia
> >> +
> >> +    /* r0 = esid & ESID_MASK */
> >> +    rldicr  r10, r10, 0, 35
> >> +    /* r0 |= CLASS_BIT(VSID) */
> >> +    rldic   r12, r11, 56 - 36, 36
> >> +    or      r10, r10, r12
> >> +    slbie    r10
> >> +
> >> +    isync
> >> +
> >> +    /* Fill SLB with our shadow */
> >> +
> >> +    lbz    r12, PACA_KVM_SLB_MAX(r13)
> >> +    mulli    r12, r12, 16
> >> +    addi    r12, r12, PACA_KVM_SLB
> >> +    add    r12, r12, r13
> >> +
> >> +    /* for (r11 = kvm_slb; r11 < kvm_slb + kvm_slb_size;  
> >> r11+=slb_entry) */
> >> +    li    r11, PACA_KVM_SLB
> >> +    add    r11, r11, r13
> >> +
> >> +slb_loop_enter:
> >> +
> >> +    ld    r10, 0(r11)
> >> +
> >> +    rldicl. r0, r10, 37, 63
> >> +    beq    slb_loop_enter_skip
> >> +
> >> +    ld    r9, 8(r11)
> >> +    slbmte    r9, r10
> >
> > If you're updating the first 3 slbs, you need to make sure the slb
> > shadow is updated at the same time
> 
> Well - what happens if we don't? We'd get a segment fault when phyp  
> stole our entry! So what? Let it fault, see the mapping is already  
> there and get back in again :-).

The problem is you won't take the segment fault as PHYP may put a valid
entry in there.  PHYP will put back what's in the shadow buffer, which
could be valid hence no segment fault.

> > (BTW dumb question: can we run this
> > under PHYP?)
> 
> Yes, I tested it on bare metal, phyp and a PS3.

Nice!

Mikey
