Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DD8BB7BB3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 11:48:52 +1100 (EST)
In-Reply-To: <280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-15-git-send-email-agraf@suse.de>
	<A1CBD511-FF08-48BB-A8D6-9F66E20F770B@kernel.crashing.org>
	<280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <070A7C13-92FC-482E-B72B-FDE84501E132@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
Date: Thu, 5 Nov 2009 01:53:29 +0100
To: Alexander Graf <agraf@suse.de>
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

>>> +		case OP_31_XOP_EIOIO:
>>> +			break;
>>
>> Have you always executed an eieio or sync when you get here, or
>> do you just not allow direct access to I/O devices?  Other context
>> synchronising insns are not enough, they do not broadcast on the
>> bus.
>
> There is no device passthrough yet :-). It's theoretically  
> possible, but nothing for it is implemented so far.

You could just always do an eieio here, it's not expensive at all
compared to the emulation trap itself.

However -- eieio is a Book II insn, it will never trap anyway!

>>> +		case OP_31_XOP_DCBZ:
>>> +		{
>>> +			ulong rb =  vcpu->arch.gpr[get_rb(inst)];
>>> +			ulong ra = 0;
>>> +			ulong addr;
>>> +			u32 zeros[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>>> +
>>> +			if (get_ra(inst))
>>> +				ra = vcpu->arch.gpr[get_ra(inst)];
>>> +
>>> +			addr = (ra + rb) & ~31ULL;
>>> +			if (!(vcpu->arch.msr & MSR_SF))
>>> +				addr &= 0xffffffff;
>>> +
>>> +			if (kvmppc_st(vcpu, addr, 32, zeros)) {
>>
>> DCBZ zeroes out a cache line, not 32 bytes; except on 970, where  
>> there
>> are HID bits to make it work on 32 bytes only, and an extra DCBZL  
>> insn
>> that always clears a full cache line (128 bytes).
>
> Yes. We only come here when we patched the dcbz opcodes to invalid  
> instructions

Ah yes, I forgot.  Could you rename it to OP_31_XOP_FAKE_32BIT_DCBZ
or such?

> because cache line size of target == 32.
> On 970 with MSR_HV = 0 we actually use the dcbz 32-bytes mode.
>
> Admittedly though, this could be a lot more clever.

>>> +		/* guest HID5 set can change is_dcbz32 */
>>> +		if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
>>> +		    (mfmsr() & MSR_HV))
>>> +			vcpu->arch.hflags |= BOOK3S_HFLAG_DCBZ32;
>>> +		break;
>>
>> Wait, does this mean you allow other HID writes when MSR[HV] isn't
>> set?  All HIDs (and many other SPRs) cannot be read or written in
>> supervisor mode.
>
> When we're running in MSR_HV=0 mode on a 970 we can use the 32 byte  
> dcbz HID flag. So all we need to do is tell our entry/exit code to  
> set this bit.

Which patch contains that entry/exit code?

> If we're on 970 on a hypervisor or on a non-970 though we can't use  
> the HID5 bit, so we need to binary patch the opcodes.
>
> So in order to emulate real 970 behavior, we need to be able to  
> emulate that HID5 bit too! That's what this chunk of code does - it  
> basically sets us in dcbz32 mode when allowed on 970 guests.

But when MSR[HV]=0 and MSR[PR]=0, mtspr to a hypervisor resource
will not trap but be silently ignored.  Sorry for not being more clear.
...Oh.  You run your guest as MSR[PR]=1 anyway!  Tricky.


Segher
