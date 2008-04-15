Return-Path: <sygao.research@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id A7F97DE439
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 04:34:35 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so1209918ywj.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 11:34:26 -0700 (PDT)
In-Reply-To: <JO200804160320143.12198109@co-nss.co.jp>
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<977C41F842E66D4CB2E41332313B615005CB0A39@XSJ-EXCHVS1.xlnx.xilinx.com>
	<20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
	<1B35E815-094F-40CB-AEDA-C04A6CBECC07@gmail.com>
	<JO200804160320143.12198109@co-nss.co.jp>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <607F58E8-CB29-4BD7-9886-DF3C8B495ED7@gmail.com>
From: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: Problems of using APU/FPU under linux
Date: Tue, 15 Apr 2008 14:34:15 -0400
To: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>,
 linuxppc-embedded@ozlabs.org
Cc: John Bonesio <john.bonesio@xilinx.com>,
	Stephen Neuendorffer <stephenn@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you, Yoshio!!

I just applied the change, seems it works! But it doesn't work =20
correctly. I mean it won't give me traps any more, but the answer is =20
not correctly. I just tried to multiply two float numbers. But it =20
gives me 0.

The first time I change the reg.h was to enable apu enable, apu =20
exception enable and fpu enable. It gives me answer 0.
The second try I did was enabling apu enable and apu exception, =20
because I notice that inside /arch/powerpc/kernel/fpu.S, it will =20
enable FPU in load_up_fpu. So I guess I cannot enable FPU all the =20
time. However, this time it gave me trap again, well, with a =20
different MSR.

Now my guess is load_up_fpu is not working correctly. I am working on =20=

that.


Shan



On Apr 15, 2008, at 2:20 PM, Yoshio Kashiwagi wrote:

> Hi,
>
> The following modification is required if you use APU in user space.
>
> in include/asm-powerpc/reg.h
>
> -#define MSR_USER   (MSR_KERNEL|MSR_PR|MSR_EE)
> +#define MSR_USER   (MSR_KERNEL|MSR_PR|MSR_EE|MSR_VEC)
>
> Yoshio Kashiwagi - Nissin Systems
>
>> Thank you very much, Steve and John!
>>
>> My advisor and I discussed how Linux works with APU/FPU a few days =20=

>> ago.
>  And he had the same thoughts with John. My naive guess was it would
> automatically decode FP operations and mask the trap. Now it =20
> answers my
> second question. I will try it later.
>>
>> But for my first question, I searched all (almost all) the files, =20
>> such
> as head.S, entry.S, head_4xx.S, etc. And added following three lines
> before mtmsr or MTMSRD =EF=BF=BDare used
>>
>> ori =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<13 =EF=BF=BD/* =
enable fpu */
>> oris =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<9 =EF=BF=BD =EF=BF=BD/* =
enable apu */
>> oris =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<3 =EF=BF=BD =EF=BF=BD/* =
enable apu exception */
>>
>> However the MSR in trap prompts keeps the same (2d030) before and
> after I added those lines.=EF=BF=BD
>>
>> [=EF=BF=BD=EF=BF=BD 31.819079] Bad trap at PC: 10000458, MSR: 2d030, =20=

>> vector=3D800=EF=BF=BD=EF=BF=BD=EF=BF=BD Not
> tainted
>> [=EF=BF=BD=EF=BF=BD 31.887027]=EF=BF=BD=EF=BF=BD Signal: 5
>> [=EF=BF=BD=EF=BF=BD 31.887042]=EF=BF=BD=EF=BF=BD Code:=EF=BF=BD=EF=BF=BD=
 0
>> [=EF=BF=BD=EF=BF=BD 31.887058]=EF=BF=BD=EF=BF=BD Addr:=EF=BF=BD=EF=BF=BD=
 0
>> Trace/breakpoint trap
>>
>> I guess there must be some places, like some interrupts that changed
> the MSR that I didn't know. =EF=BF=BD
>>
>> And for FP exceptions, it has two bits (two modes) in MSR. I think
> they are for such exceptions like divided by zero. Do I need to set =20=

> them
> also?
>>
>> In my previous build, I also added PPC_FPU under config 40x in arch/
> ppc/Kconfig. It compiled arch/powerpc/kernel/fpu.S in, but didn't =20
> help.
> I will try CONFIG_PPC_FPU later.
>>
>>
>> Shan
>>
>> On Apr 14, 2008, at 2:32 PM, John Bonesio wrote:
>>
>> Hi,
>>
>> The Linux kernel itself doesn't issue floating point instructions
> other than to save and restore the fpu state when necessary.
>>
>> In Linux, the way it saves and restores the fpu state is to make use
> of the trap. When the trap (fpu unavailable) occurs, it loads the fpu
> state for the current task, sets up the MSR, and returns to re-try the
> instruction.
>>
>> So, getting the trap is normal. If the FPU is not being set up
> correctly, then there may be a problem with the restoring of the =20
> state.
>>
>> When you guild the Linux kernel, you need to have CONFIG_PPC_FPU
> enabled. Otherwise the kernel does not setup the fpu exception =20
> handling.
>>
>> - John
>>
>>
>> On Monday 14 April 2008 10:35, Stephen Neuendorffer wrote:
>>
>> I'm not sure exactly what's going on here.=EF=BF=BD Generally =
speaking, =20
>> if you
>> have the FPU instantiated in the design and enable the APU in the =20
>> msr,
>> then the processor should decode FP instructions and send them
> directly
>> to the APU with no trap.=EF=BF=BD I haven't done this myself, or I =
could
>> probably give you some better help...
>>
>> One thing you should be aware of is that the there are gcc compiler
>> patches which are necessary to get the FPU working properly.=EF=BF=BD =
=20
>> However,
> I
>> don't think the failure mode that these patches workaround would =20
>> cause
> a
>> trap, so my guess is that there is still something else wrong.
>>
>> Steve
>>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
>> [mailto:linuxppc-embedded-
>> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
>> Gao
>> Sent: Monday, April 14, 2008 9:18 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Problems of using APU/FPU under linux
>>
>> Hi,
>>
>> Recently I was trying to make APU/FPU working under Linux on Xilinx
>> ML410. The standalone programs work perfectly. However under Linux,
>> when I try to use a floating point operation, like *fmuls*, it will
>> give me a *trap*.
>>
>> By studying the user guide from Xilinx and dumping the object files,
>> I know I need to change the corresponding bits (APU enable, FP
>> enable, maybe APU Exception enable) in Machine State Register. I
>> guess I need to enable the bits whenever before the kernel uses
>> *mtmsr*. However, it doesn't work. I got the same trap with the same
>> MSR, as I had no APU/FPU before. I also tried to add the FPU.S to ppc
>> tree, but it doesn't work either.
>>
>> The questions are
>> 1. I guess there might be some place that changed MSR after all my
>> changes. But I don't know where. And can I write a kernel module to
>> change the MSR after booting in Linux? (well, it's hard for me =20
>> though)
>>
>> 2. Does it have any exception/interrupt mechanism to direct FP
>> operation to APU/FPU? Or after enabling APU/FPU it will mask the
>> exception/interrupt and decode FP operation by itself?
>>
>>
>> Any ideas are appreciated. Thank you very much!
>>
>>
>> Shan
>
