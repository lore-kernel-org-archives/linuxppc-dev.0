Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 73B6B2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 20:33:11 +1000 (EST)
Subject: Re: [PATCH 4/6 v5] KVM: PPC: exit to user space on "ehpriv"
 instruction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07086E00@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 26 Jun 2013 12:33:04 +0200
Message-Id: <F0D9E9B5-553F-45EA-9438-9CE66BEC58BB@suse.de>
References: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1372225346-5029-5-git-send-email-Bharat.Bhushan@freescale.com>
 <51CA903A.4070809@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07086C2F@039-SN2MPN1-013.039d.mgd.msft.net>
 <51CAB199.8080306@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07086E00@039-SN2MPN1-013.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "mikey@neuling.org" <mikey@neuling.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.06.2013, at 11:27, Bhushan Bharat-R65777 wrote:

>=20
>=20
>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>> Sent: Wednesday, June 26, 2013 2:47 PM
>> To: Bhushan Bharat-R65777
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; agraf@suse.de; Wood =
Scott-
>> B07421; benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; =
linux-
>> kernel@vger.kernel.org; mikey@neuling.org
>> Subject: Re: [PATCH 4/6 v5] KVM: PPC: exit to user space on "ehpriv" =
instruction
>>=20
>> On 06/26/2013 04:44 PM, Bhushan Bharat-R65777 wrote:
>>>=20
>>>=20
>>>> -----Original Message-----
>>>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>>>> Sent: Wednesday, June 26, 2013 12:25 PM
>>>> To: Bhushan Bharat-R65777
>>>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; agraf@suse.de; =
Wood
>>>> Scott- B07421; benh@kernel.crashing.org;
>>>> linuxppc-dev@lists.ozlabs.org; linux- kernel@vger.kernel.org;
>>>> mikey@neuling.org; Bhushan Bharat-R65777
>>>> Subject: Re: [PATCH 4/6 v5] KVM: PPC: exit to user space on =
"ehpriv"
>>>> instruction
>>>>=20
>>>> On 06/26/2013 01:42 PM, Bharat Bhushan wrote:
>>>>> "ehpriv" instruction is used for setting software breakpoints by
>>>>> user space. This patch adds support to exit to user space with
>>>>> "run->debug" have relevant information.
>>>>>=20
>>>>> As this is the first point we are using run->debug, also defined =
the
>>>>> run->debug structure.
>>>>>=20
>>>>> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
>>>>> ---
>>>>>   arch/powerpc/include/asm/disassemble.h |    4 ++++
>>>>>   arch/powerpc/include/uapi/asm/kvm.h    |   21 =
+++++++++++++++++----
>>>>>   arch/powerpc/kvm/e500_emulate.c        |   27 =
+++++++++++++++++++++++++++
>>>>>   3 files changed, 48 insertions(+), 4 deletions(-)
>>>>>=20
>>>>> diff --git a/arch/powerpc/include/asm/disassemble.h
>>>> b/arch/powerpc/include/asm/disassemble.h
>>>>> index 9b198d1..856f8de 100644
>>>>> --- a/arch/powerpc/include/asm/disassemble.h
>>>>> +++ b/arch/powerpc/include/asm/disassemble.h
>>>>> @@ -77,4 +77,8 @@ static inline unsigned int get_d(u32 inst)
>>>>>   	return inst & 0xffff;
>>>>>   }
>>>>>=20
>>>>> +static inline unsigned int get_oc(u32 inst) {
>>>>> +	return (inst >> 11) & 0x7fff;
>>>>> +}
>>>>>   #endif /* __ASM_PPC_DISASSEMBLE_H__ */ diff --git
>>>>> a/arch/powerpc/include/uapi/asm/kvm.h
>>>> b/arch/powerpc/include/uapi/asm/kvm.h
>>>>> index 0fb1a6e..ded0607 100644
>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>>>>> @@ -269,7 +269,24 @@ struct kvm_fpu {
>>>>>   	__u64 fpr[32];
>>>>>   };
>>>>>=20
>>>>> +/*
>>>>> + * Defines for h/w breakpoint, watchpoint (read, write or both) =
and
>>>>> + * software breakpoint.
>>>>> + * These are used as "type" in KVM_SET_GUEST_DEBUG ioctl and =
"status"
>>>>> + * for KVM_DEBUG_EXIT.
>>>>> + */
>>>>> +#define KVMPPC_DEBUG_NONE		0x0
>>>>> +#define KVMPPC_DEBUG_BREAKPOINT		(1UL << 1)
>>>>> +#define KVMPPC_DEBUG_WATCH_WRITE	(1UL << 2)
>>>>> +#define KVMPPC_DEBUG_WATCH_READ		(1UL << 3)
>>>>>   struct kvm_debug_exit_arch {
>>>>> +	__u64 address;
>>>>> +	/*
>>>>> +	 * exiting to userspace because of h/w breakpoint, watchpoint
>>>>> +	 * (read, write or both) and software breakpoint.
>>>>> +	 */
>>>>> +	__u32 status;
>>>>> +	__u32 reserved;
>>>>>   };
>>>>>=20
>>>>>   /* for KVM_SET_GUEST_DEBUG */
>>>>> @@ -281,10 +298,6 @@ struct kvm_guest_debug_arch {
>>>>>   		 * Type denotes h/w breakpoint, read watchpoint, =
write
>>>>>   		 * watchpoint or watchpoint (both read and =
write).
>>>>>   		 */
>>>>> -#define KVMPPC_DEBUG_NONE		0x0
>>>>> -#define KVMPPC_DEBUG_BREAKPOINT		(1UL << 1)
>>>>> -#define KVMPPC_DEBUG_WATCH_WRITE	(1UL << 2)
>>>>> -#define KVMPPC_DEBUG_WATCH_READ		(1UL << 3)
>>>>>   		__u32 type;
>>>>>   		__u32 reserved;
>>>>>   	} bp[16];
>>>>> diff --git a/arch/powerpc/kvm/e500_emulate.c
>>>>> b/arch/powerpc/kvm/e500_emulate.c index b10a012..dab9d07 100644
>>>>> --- a/arch/powerpc/kvm/e500_emulate.c
>>>>> +++ b/arch/powerpc/kvm/e500_emulate.c
>>>>> @@ -26,6 +26,8 @@
>>>>>   #define XOP_TLBRE   946
>>>>>   #define XOP_TLBWE   978
>>>>>   #define XOP_TLBILX  18
>>>>> +#define XOP_EHPRIV  270
>>>>> +#define EHPRIV_OC_DEBUG 0
>>>>=20
>>>> As I think the case, "OC =3D 0", is a bit specific since IIRC, if =
the
>>>> OC operand is omitted, its equal 0 by default. So I think we should
>>>> start this OC value from 1 or other magic number.
>>>=20
>>> ehpriv instruction is defined to be used as:
>>> 	ehpriv OC // where OC can be 0,1, ... n and in extended for it =
can be
>>> used as
>>> 	ehpriv // With no OC, and here it assumes OC =3D 0 So OC =3D 0 =
is not
>>> specific but "ehpriv" is same as "ehpriv 0".
>>=20
>> Yes, this is just what I mean.
>>=20
>>>=20
>>> I do not think of any special reason to reserve "ehpriv" and "ehpriv =
0".
>>=20
>> So I still prefer we can reserve the 'ehpriv' without OC operand as =
one simple
>> approach to test or develop something for KVM quickly because its =
really
>> convenient to trap into the hypervisor only with one 'ehpriv' =
instruction
>> easily.
>>=20
>> But I have no further objection if you guys are fine to this ;-)
>=20
> I can see the using "ehpriv" can be a default choice. But all ehvpriv =
trap is handled at one place (in a single function) so the accidently =
overlap with debug should not be an issue.
>=20
> I too do not have any strong opinion to keep either way, so want to =
leave as is ;-).

Seconded. On x86 we also just use int3 for soft breakpoints IIRC.


Alex
