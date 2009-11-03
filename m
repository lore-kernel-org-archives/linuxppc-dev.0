Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C5CF51007D3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 20:06:44 +1100 (EST)
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <A1CBD511-FF08-48BB-A8D6-9F66E20F770B@kernel.crashing.org>
Date: Tue, 3 Nov 2009 10:06:39 +0100
Message-Id: <280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-15-git-send-email-agraf@suse.de>
	<A1CBD511-FF08-48BB-A8D6-9F66E20F770B@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
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


On 03.11.2009, at 09:47, Segher Boessenkool wrote:

> Nice patchset.  Some comments on the emulation part:

Cool, thanks for looking though them!

>> +#define OP_31_XOP_EIOIO		854
>
> You mean EIEIO.

Probably, yeah.

>> +	case 19:
>> +		switch (get_xop(inst)) {
>> +		case OP_19_XOP_RFID:
>> +		case OP_19_XOP_RFI:
>> +			vcpu->arch.pc = vcpu->arch.srr0;
>> +			kvmppc_set_msr(vcpu, vcpu->arch.srr1);
>> +			*advance = 0;
>> +			break;
>
> I think you should only emulate the insns that exist on whatever the  
> guest
> pretends to be.  RFID exist only on 64-bit implementations.  Same  
> comment
> everywhere else.

True.

>
>> +		case OP_31_XOP_EIOIO:
>> +			break;
>
> Have you always executed an eieio or sync when you get here, or
> do you just not allow direct access to I/O devices?  Other context
> synchronising insns are not enough, they do not broadcast on the
> bus.

There is no device passthrough yet :-). It's theoretically possible,  
but nothing for it is implemented so far.

>
>> +		case OP_31_XOP_DCBZ:
>> +		{
>> +			ulong rb =  vcpu->arch.gpr[get_rb(inst)];
>> +			ulong ra = 0;
>> +			ulong addr;
>> +			u32 zeros[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>> +
>> +			if (get_ra(inst))
>> +				ra = vcpu->arch.gpr[get_ra(inst)];
>> +
>> +			addr = (ra + rb) & ~31ULL;
>> +			if (!(vcpu->arch.msr & MSR_SF))
>> +				addr &= 0xffffffff;
>> +
>> +			if (kvmppc_st(vcpu, addr, 32, zeros)) {
>
> DCBZ zeroes out a cache line, not 32 bytes; except on 970, where there
> are HID bits to make it work on 32 bytes only, and an extra DCBZL insn
> that always clears a full cache line (128 bytes).

Yes. We only come here when we patched the dcbz opcodes to invalid  
instructions because cache line size of target == 32.
On 970 with MSR_HV = 0 we actually use the dcbz 32-bytes mode.

Admittedly though, this could be a lot more clever.

>> +	switch (sprn) {
>> +	case SPRN_IBAT0U ... SPRN_IBAT3L:
>> +		bat = &vcpu_book3s->ibat[(sprn - SPRN_IBAT0U) / 2];
>> +		break;
>> +	case SPRN_IBAT4U ... SPRN_IBAT7L:
>> +		bat = &vcpu_book3s->ibat[(sprn - SPRN_IBAT4U) / 2];
>> +		break;
>> +	case SPRN_DBAT0U ... SPRN_DBAT3L:
>> +		bat = &vcpu_book3s->dbat[(sprn - SPRN_DBAT0U) / 2];
>> +		break;
>> +	case SPRN_DBAT4U ... SPRN_DBAT7L:
>> +		bat = &vcpu_book3s->dbat[(sprn - SPRN_DBAT4U) / 2];
>> +		break;
>
> Do xBAT4..7 have the same SPR numbers on all CPUs?  They are CPU- 
> specific
> SPRs, after all.  Some CPUs have only six, some only four, some  
> none, btw.

For now only Linux runs which only uses the first 3(?) IIRC. But yes,  
it's probably worth looking into at one point or the other.

>
>> +	case SPRN_HID0:
>> +		to_book3s(vcpu)->hid[0] = vcpu->arch.gpr[rs];
>> +		break;
>> +	case SPRN_HID1:
>> +		to_book3s(vcpu)->hid[1] = vcpu->arch.gpr[rs];
>> +		break;
>> +	case SPRN_HID2:
>> +		to_book3s(vcpu)->hid[2] = vcpu->arch.gpr[rs];
>> +		break;
>> +	case SPRN_HID4:
>> +		to_book3s(vcpu)->hid[4] = vcpu->arch.gpr[rs];
>> +		break;
>> +	case SPRN_HID5:
>> +		to_book3s(vcpu)->hid[5] = vcpu->arch.gpr[rs];
>
> HIDs are different per CPU; and worse, different CPUs have different
> registers (SPR #s) for the same register name!

Sigh :-(

>> +		/* guest HID5 set can change is_dcbz32 */
>> +		if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
>> +		    (mfmsr() & MSR_HV))
>> +			vcpu->arch.hflags |= BOOK3S_HFLAG_DCBZ32;
>> +		break;
>
> Wait, does this mean you allow other HID writes when MSR[HV] isn't
> set?  All HIDs (and many other SPRs) cannot be read or written in
> supervisor mode.

When we're running in MSR_HV=0 mode on a 970 we can use the 32 byte  
dcbz HID flag. So all we need to do is tell our entry/exit code to set  
this bit.

If we're on 970 on a hypervisor or on a non-970 though we can't use  
the HID5 bit, so we need to binary patch the opcodes.

So in order to emulate real 970 behavior, we need to be able to  
emulate that HID5 bit too! That's what this chunk of code does - it  
basically sets us in dcbz32 mode when allowed on 970 guests.

Alex
