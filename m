Return-Path: <john.bonesio@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 07E13DEC06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 04:35:07 +1000 (EST)
From: John Bonesio <john.bonesio@xilinx.com>
To: "Stephen Neuendorffer" <stephenn@xilinx.com>
Subject: Re: Problems of using APU/FPU under linux
Date: Mon, 14 Apr 2008 11:32:51 -0700
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<977C41F842E66D4CB2E41332313B615005CB0A39@XSJ-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <977C41F842E66D4CB2E41332313B615005CB0A39@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
Cc: Shanyuan Gao <sygao.research@gmail.com>, git <git@xilinx.com>,
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

Hi,

The Linux kernel itself doesn't issue floating point instructions other than to save and restore the fpu state when necessary.

In Linux, the way it saves and restores the fpu state is to make use of the trap. When the trap (fpu unavailable) occurs, it loads the fpu state for the current task, sets up the MSR, and returns to re-try the instruction.

So, getting the trap is normal. If the FPU is not being set up correctly, then there may be a problem with the restoring of the state.

When you guild the Linux kernel, you need to have CONFIG_PPC_FPU enabled. Otherwise the kernel does not setup the fpu exception handling.

- John


On Monday 14 April 2008 10:35, Stephen Neuendorffer wrote:
> 
> I'm not sure exactly what's going on here.  Generally speaking, if you
> have the FPU instantiated in the design and enable the APU in the msr,
> then the processor should decode FP instructions and send them directly
> to the APU with no trap.  I haven't done this myself, or I could
> probably give you some better help...
> 
> One thing you should be aware of is that the there are gcc compiler
> patches which are necessary to get the FPU working properly.  However, I
> don't think the failure mode that these patches workaround would cause a
> trap, so my guess is that there is still something else wrong.
> 
> Steve
> 
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
> > bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
> Gao
> > Sent: Monday, April 14, 2008 9:18 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: Problems of using APU/FPU under linux
> > 
> > Hi,
> > 
> > Recently I was trying to make APU/FPU working under Linux on Xilinx
> > ML410. The standalone programs work perfectly. However under Linux,
> > when I try to use a floating point operation, like *fmuls*, it will
> > give me a *trap*.
> > 
> > By studying the user guide from Xilinx and dumping the object files,
> > I know I need to change the corresponding bits (APU enable, FP
> > enable, maybe APU Exception enable) in Machine State Register. I
> > guess I need to enable the bits whenever before the kernel uses
> > *mtmsr*. However, it doesn't work. I got the same trap with the same
> > MSR, as I had no APU/FPU before. I also tried to add the FPU.S to ppc
> > tree, but it doesn't work either.
> > 
> > The questions are
> > 1. I guess there might be some place that changed MSR after all my
> > changes. But I don't know where. And can I write a kernel module to
> > change the MSR after booting in Linux? (well, it's hard for me though)
> > 
> > 2. Does it have any exception/interrupt mechanism to direct FP
> > operation to APU/FPU? Or after enabling APU/FPU it will mask the
> > exception/interrupt and decode FP operation by itself?
> > 
> > 
> > Any ideas are appreciated. Thank you very much!
> > 
> > 
> > Shan
> > 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
