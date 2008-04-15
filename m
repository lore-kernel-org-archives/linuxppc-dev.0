Return-Path: <john.bonesio@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5DC2ADE1DF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 04:59:21 +1000 (EST)
From: John Bonesio <john.bonesio@xilinx.com>
To: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: Problems of using APU/FPU under linux
Date: Tue, 15 Apr 2008 11:59:17 -0700
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<20080415183706.C694717D807B@mail80-dub.bigfish.com>
	<8092B58B-4C3F-4F29-83A9-F53DA23F10F8@gmail.com>
In-Reply-To: <8092B58B-4C3F-4F29-83A9-F53DA23F10F8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <20080415185919.45D16F8806C@mail189-sin.bigfish.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Shan,

It's not clear what you're trying to do. If you have only one application u=
sing the FPU, and you're setting up the APU and FPU from that user applicat=
ion, I'm not sure if you need the FPU unavailable handler.

If you're going to have multiple applications use the FPU, then you should =
use the FPU unavailable handler. In this case, you'll need to look in head_=
44x.S to see how the FPU unavailable handler is set up, and do something si=
milar in head_4xx.S

If you're going to do all FPU from one user application, you just need to m=
ake sure the kernel doesn't ever clear the FP Available bit in the MSR.

Is this making sense?

model #1: One user app owns/uses FPU: Use Yoshio's suggesting on getting ac=
cess to the MSR to setup the fpu from the user application. Don't use FPU u=
navailable handler, Don't use load_up_fpu(). Check kernel code to make sure=
 it doesn't clear FPU available bit on a context switch.
model #2: Kernel owns FPU, user apps use FPU: Set up the MSR for fpu access=
 in kernel startup code. Set up FPU unavailable handler in kernel. Use load=
_up_fpu(). Make sure the kernel clears the FPU available bit in the MSR on =
context switches.

Hope this helps,

=2D John

On Tuesday 15 April 2008 11:47, Shanyuan Gao wrote:
> No, actually I am using head_4xx.S and I cannot find FPU_UNAVAILABLE =20
> in there. Do I need to set it?
>=20
> And I commented out the _GLOBAL(giveup_fpu) in head_4xx.S because it =20
> has conflicts with fpu.S
>=20
>=20
>=20
> Shan
>=20
>=20
> On Apr 15, 2008, at 2:37 PM, Stephen Neuendorffer wrote:
>=20
> > Shanyuan,
> >
> > Did you install the FPU_UNAVAILABLE trap in head_40x.S?
> >
> >
> >> -----Original Message-----
> >> From: Shanyuan Gao [mailto:sygao.research@gmail.com]
> >> Sent: Tuesday, April 15, 2008 11:34 AM
> >> To: Yoshio Kashiwagi; linuxppc-embedded@ozlabs.org
> >> Cc: Stephen Neuendorffer; John Bonesio
> >> Subject: Re: Problems of using APU/FPU under linux
> >>
> >> Thank you, Yoshio!!
> >>
> >> I just applied the change, seems it works! But it doesn't work
> >> correctly. I mean it won't give me traps any more, but the answer is
> >> not correctly. I just tried to multiply two float numbers. But it
> >> gives me 0.
> >>
> >> The first time I change the reg.h was to enable apu enable, apu
> >> exception enable and fpu enable. It gives me answer 0.
> >> The second try I did was enabling apu enable and apu exception,
> >> because I notice that inside /arch/powerpc/kernel/fpu.S, it will
> >> enable FPU in load_up_fpu. So I guess I cannot enable FPU all the
> >> time. However, this time it gave me trap again, well, with a
> >> different MSR.
> >>
> >> Now my guess is load_up_fpu is not working correctly. I am working on
> >> that.
> >>
> >>
> >> Shan
> >>
> >>
> >>
> >> On Apr 15, 2008, at 2:20 PM, Yoshio Kashiwagi wrote:
> >>
> >>> Hi,
> >>>
> >>> The following modification is required if you use APU in user space.
> >>>
> >>> in include/asm-powerpc/reg.h
> >>>
> >>> -#define MSR_USER   (MSR_KERNEL|MSR_PR|MSR_EE)
> >>> +#define MSR_USER   (MSR_KERNEL|MSR_PR|MSR_EE|MSR_VEC)
> >>>
> >>> Yoshio Kashiwagi - Nissin Systems
> >>>
> >>>> Thank you very much, Steve and John!
> >>>>
> >>>> My advisor and I discussed how Linux works with APU/FPU a few days
> >>>> ago.
> >>>  And he had the same thoughts with John. My naive guess was it would
> >>> automatically decode FP operations and mask the trap. Now it
> >>> answers my
> >>> second question. I will try it later.
> >>>>
> >>>> But for my first question, I searched all (almost all) the files,
> >>>> such
> >>> as head.S, entry.S, head_4xx.S, etc. And added following three lines
> >>> before mtmsr or MTMSRD =EF=BF=BDare used
> >>>>
> >>>> ori =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<13 =EF=BF=BD=
/* enable fpu */
> >>>> oris =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<9 =EF=BF=BD =EF=BF=BD=
/* enable apu */
> >>>> oris =EF=BF=BD =EF=BF=BD =EF=BF=BDr10, r10, 1<<3 =EF=BF=BD =EF=BF=BD=
/* enable apu exception */
> >>>>
> >>>> However the MSR in trap prompts keeps the same (2d030) before and
> >>> after I added those lines.=EF=BF=BD
> >>>>
> >>>> [=EF=BF=BD=EF=BF=BD 31.819079] Bad trap at PC: 10000458, MSR: 2d030,
> >>>> vector=3D800=EF=BF=BD=EF=BF=BD=EF=BF=BD Not
> >>> tainted
> >>>> [=EF=BF=BD=EF=BF=BD 31.887027]=EF=BF=BD=EF=BF=BD Signal: 5
> >>>> [=EF=BF=BD=EF=BF=BD 31.887042]=EF=BF=BD=EF=BF=BD Code:=EF=BF=BD=EF=
=BF=BD 0
> >>>> [=EF=BF=BD=EF=BF=BD 31.887058]=EF=BF=BD=EF=BF=BD Addr:=EF=BF=BD=EF=
=BF=BD 0
> >>>> Trace/breakpoint trap
> >>>>
> >>>> I guess there must be some places, like some interrupts that =20
> >>>> changed
> >>> the MSR that I didn't know. =EF=BF=BD
> >>>>
> >>>> And for FP exceptions, it has two bits (two modes) in MSR. I think
> >>> they are for such exceptions like divided by zero. Do I need to set
> >>> them
> >>> also?
> >>>>
> >>>> In my previous build, I also added PPC_FPU under config 40x in =20
> >>>> arch/
> >>> ppc/Kconfig. It compiled arch/powerpc/kernel/fpu.S in, but didn't
> >>> help.
> >>> I will try CONFIG_PPC_FPU later.
> >>>>
> >>>>
> >>>> Shan
> >>>>
> >>>> On Apr 14, 2008, at 2:32 PM, John Bonesio wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> The Linux kernel itself doesn't issue floating point instructions
> >>> other than to save and restore the fpu state when necessary.
> >>>>
> >>>> In Linux, the way it saves and restores the fpu state is to make =20
> >>>> use
> >>> of the trap. When the trap (fpu unavailable) occurs, it loads the =20
> >>> fpu
> >>> state for the current task, sets up the MSR, and returns to re-=20
> >>> try the
> >>> instruction.
> >>>>
> >>>> So, getting the trap is normal. If the FPU is not being set up
> >>> correctly, then there may be a problem with the restoring of the
> >>> state.
> >>>>
> >>>> When you guild the Linux kernel, you need to have CONFIG_PPC_FPU
> >>> enabled. Otherwise the kernel does not setup the fpu exception
> >>> handling.
> >>>>
> >>>> - John
> >>>>
> >>>>
> >>>> On Monday 14 April 2008 10:35, Stephen Neuendorffer wrote:
> >>>>
> >>>> I'm not sure exactly what's going on here.=EF=BF=BD Generally speaki=
ng,
> >>>> if you
> >>>> have the FPU instantiated in the design and enable the APU in the
> >>>> msr,
> >>>> then the processor should decode FP instructions and send them
> >>> directly
> >>>> to the APU with no trap.=EF=BF=BD I haven't done this myself, or I c=
ould
> >>>> probably give you some better help...
> >>>>
> >>>> One thing you should be aware of is that the there are gcc compiler
> >>>> patches which are necessary to get the FPU working properly.=EF=BF=BD
> >>>> However,
> >>> I
> >>>> don't think the failure mode that these patches workaround would
> >>>> cause
> >>> a
> >>>> trap, so my guess is that there is still something else wrong.
> >>>>
> >>>> Steve
> >>>>
> >>>> -----Original Message-----
> >>>> From: linuxppc-embedded-bounces=20
> >>>> +stephen=3Dneuendorffer.name@ozlabs.org
> >>>> [mailto:linuxppc-embedded-
> >>>> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
> >>>> Gao
> >>>> Sent: Monday, April 14, 2008 9:18 AM
> >>>> To: linuxppc-embedded@ozlabs.org
> >>>> Subject: Problems of using APU/FPU under linux
> >>>>
> >>>> Hi,
> >>>>
> >>>> Recently I was trying to make APU/FPU working under Linux on Xilinx
> >>>> ML410. The standalone programs work perfectly. However under Linux,
> >>>> when I try to use a floating point operation, like *fmuls*, it will
> >>>> give me a *trap*.
> >>>>
> >>>> By studying the user guide from Xilinx and dumping the object =20
> >>>> files,
> >>>> I know I need to change the corresponding bits (APU enable, FP
> >>>> enable, maybe APU Exception enable) in Machine State Register. I
> >>>> guess I need to enable the bits whenever before the kernel uses
> >>>> *mtmsr*. However, it doesn't work. I got the same trap with the =20
> >>>> same
> >>>> MSR, as I had no APU/FPU before. I also tried to add the FPU.S =20
> >>>> to ppc
> >>>> tree, but it doesn't work either.
> >>>>
> >>>> The questions are
> >>>> 1. I guess there might be some place that changed MSR after all my
> >>>> changes. But I don't know where. And can I write a kernel module to
> >>>> change the MSR after booting in Linux? (well, it's hard for me
> >>>> though)
> >>>>
> >>>> 2. Does it have any exception/interrupt mechanism to direct FP
> >>>> operation to APU/FPU? Or after enabling APU/FPU it will mask the
> >>>> exception/interrupt and decode FP operation by itself?
> >>>>
> >>>>
> >>>> Any ideas are appreciated. Thank you very much!
> >>>>
> >>>>
> >>>> Shan
> >>>
> >>
> >
>=20
>=20
>=20
