Return-Path: <john.bonesio@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0309CDE01F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 08:20:08 +1000 (EST)
From: John Bonesio <john.bonesio@xilinx.com>
To: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: Problems of using APU/FPU under linux
Date: Mon, 14 Apr 2008 15:20:01 -0700
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
	<1B35E815-094F-40CB-AEDA-C04A6CBECC07@gmail.com>
In-Reply-To: <1B35E815-094F-40CB-AEDA-C04A6CBECC07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <20080414222003.E500E11E0057@mail67-dub.bigfish.com>
Cc: John Bonesio <john.bonesio@xilinx.com>,
	Stephen Neuendorffer <stephenn@xilinx.com>, linuxppc-embedded@ozlabs.org
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

Someone here reminded me that the ppc405 is not BookE. One of your problems maybe in getting the kernel to set up an FPU unavilable handler.

- John


On Monday 14 April 2008 13:46, Shanyuan Gao wrote:
> Thank you very much, Steve and John!
> 
> My advisor and I discussed how Linux works with APU/FPU a few days  
> ago. And he had the same thoughts with John. My naive guess was it  
> would automatically decode FP operations and mask the trap. Now it  
> answers my second question. I will try it later.
> 
> But for my first question, I searched all (almost all) the files,  
> such as head.S, entry.S, head_4xx.S, etc. And added following three  
> lines before mtmsr or MTMSRD  are used
> 
> ori        r10, r10, 1<<13  /* enable fpu */
> oris      r10, r10, 1<<9    /* enable apu */
> oris      r10, r10, 1<<3    /* enable apu exception */
> 
> However the MSR in trap prompts keeps the same (2d030) before and  
> after I added those lines.
> 
> [   31.819079] Bad trap at PC: 10000458, MSR: 2d030, vector=800     
> Not tainted
> [   31.887027]   Signal: 5
> [   31.887042]   Code:   0
> [   31.887058]   Addr:   0
> Trace/breakpoint trap
> 
> I guess there must be some places, like some interrupts that changed  
> the MSR that I didn't know.
> 
> And for FP exceptions, it has two bits (two modes) in MSR. I think  
> they are for such exceptions like divided by zero. Do I need to set  
> them also?
> 
> In my previous build, I also added PPC_FPU under config 40x in arch/ 
> ppc/Kconfig. It compiled arch/powerpc/kernel/fpu.S in, but didn't  
> help. I will try CONFIG_PPC_FPU later.
> 
> 
> Shan
> 
> On Apr 14, 2008, at 2:32 PM, John Bonesio wrote:
> 
> > Hi,
> >
> > The Linux kernel itself doesn't issue floating point instructions  
> > other than to save and restore the fpu state when necessary.
> >
> > In Linux, the way it saves and restores the fpu state is to make  
> > use of the trap. When the trap (fpu unavailable) occurs, it loads  
> > the fpu state for the current task, sets up the MSR, and returns to  
> > re-try the instruction.
> >
> > So, getting the trap is normal. If the FPU is not being set up  
> > correctly, then there may be a problem with the restoring of the  
> > state.
> >
> > When you guild the Linux kernel, you need to have CONFIG_PPC_FPU  
> > enabled. Otherwise the kernel does not setup the fpu exception  
> > handling.
> >
> > - John
> >
> >
> > On Monday 14 April 2008 10:35, Stephen Neuendorffer wrote:
> >>
> >> I'm not sure exactly what's going on here.  Generally speaking, if  
> >> you
> >> have the FPU instantiated in the design and enable the APU in the  
> >> msr,
> >> then the processor should decode FP instructions and send them  
> >> directly
> >> to the APU with no trap.  I haven't done this myself, or I could
> >> probably give you some better help...
> >>
> >> One thing you should be aware of is that the there are gcc compiler
> >> patches which are necessary to get the FPU working properly.   
> >> However, I
> >> don't think the failure mode that these patches workaround would  
> >> cause a
> >> trap, so my guess is that there is still something else wrong.
> >>
> >> Steve
> >>
> >>> -----Original Message-----
> >>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> >> [mailto:linuxppc-embedded-
> >>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
> >> Gao
> >>> Sent: Monday, April 14, 2008 9:18 AM
> >>> To: linuxppc-embedded@ozlabs.org
> >>> Subject: Problems of using APU/FPU under linux
> >>>
> >>> Hi,
> >>>
> >>> Recently I was trying to make APU/FPU working under Linux on Xilinx
> >>> ML410. The standalone programs work perfectly. However under Linux,
> >>> when I try to use a floating point operation, like *fmuls*, it will
> >>> give me a *trap*.
> >>>
> >>> By studying the user guide from Xilinx and dumping the object files,
> >>> I know I need to change the corresponding bits (APU enable, FP
> >>> enable, maybe APU Exception enable) in Machine State Register. I
> >>> guess I need to enable the bits whenever before the kernel uses
> >>> *mtmsr*. However, it doesn't work. I got the same trap with the same
> >>> MSR, as I had no APU/FPU before. I also tried to add the FPU.S to  
> >>> ppc
> >>> tree, but it doesn't work either.
> >>>
> >>> The questions are
> >>> 1. I guess there might be some place that changed MSR after all my
> >>> changes. But I don't know where. And can I write a kernel module to
> >>> change the MSR after booting in Linux? (well, it's hard for me  
> >>> though)
> >>>
> >>> 2. Does it have any exception/interrupt mechanism to direct FP
> >>> operation to APU/FPU? Or after enabling APU/FPU it will mask the
> >>> exception/interrupt and decode FP operation by itself?
> >>>
> >>>
> >>> Any ideas are appreciated. Thank you very much!
> >>>
> >>>
> >>> Shan
> >>>
> >>> _______________________________________________
> >>> Linuxppc-embedded mailing list
> >>> Linuxppc-embedded@ozlabs.org
> >>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >>
> >
> 
> 
