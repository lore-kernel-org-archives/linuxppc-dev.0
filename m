Return-Path: <sygao.research@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 7C082DF21F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 02:18:19 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1217749wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Apr 2008 09:18:15 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753)
Message-Id: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-embedded@ozlabs.org
From: Shanyuan Gao <sygao.research@gmail.com>
Subject: Problems of using APU/FPU under linux
Date: Mon, 14 Apr 2008 12:18:07 -0400
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

Recently I was trying to make APU/FPU working under Linux on Xilinx  
ML410. The standalone programs work perfectly. However under Linux,  
when I try to use a floating point operation, like *fmuls*, it will  
give me a *trap*.

By studying the user guide from Xilinx and dumping the object files,  
I know I need to change the corresponding bits (APU enable, FP  
enable, maybe APU Exception enable) in Machine State Register. I  
guess I need to enable the bits whenever before the kernel uses  
*mtmsr*. However, it doesn't work. I got the same trap with the same  
MSR, as I had no APU/FPU before. I also tried to add the FPU.S to ppc  
tree, but it doesn't work either.

The questions are
1. I guess there might be some place that changed MSR after all my  
changes. But I don't know where. And can I write a kernel module to  
change the MSR after booting in Linux? (well, it's hard for me though)

2. Does it have any exception/interrupt mechanism to direct FP  
operation to APU/FPU? Or after enabling APU/FPU it will mask the  
exception/interrupt and decode FP operation by itself?


Any ideas are appreciated. Thank you very much!


Shan
