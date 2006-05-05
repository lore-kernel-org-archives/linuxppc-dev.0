Return-Path: <gautam@eisodus.com>
Received: from smtp1.iitb.ac.in (smtp1.iitb.ac.in [202.68.145.249])
	by ozlabs.org (Postfix) with SMTP id 1E247679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 18:38:39 +1000 (EST)
Message-ID: <445B1019.9010103@eisodus.com>
Date: Fri, 05 May 2006 14:13:05 +0530
From: Gautam Borad <gautam@eisodus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: frequent sig 11 with malloc() on mpc8xx
References: <20060504144605.B18B3353BE7@atlas.denx.de>
In-Reply-To: <20060504144605.B18B3353BE7@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:

>In message <4459B1CF.60909@eisodus.com> you wrote:
>  
>
>>We are having a frequent sig 11 problem on our custom mpc852t board
>>with linux kernel 2.6.14 and U-boot version 1.1.3
>>    
>>
>That's a FAQ.
>
>  
>
>>I had the same problem with 2.4 kernel and after posting the problem 
>>    
>>
>This confirms that the FAQ matches your problem. See
>http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly
>
>  
>
Thanks for the reply. We have checked the cpu sdram settings and would
re-check the sdram initialization sequence.
However the problem faced is following:
The sig. 11 is generated at a specific instance of accessing memory 
areas in
range of 0x00000024 - 0x000000C8 (i.e low address range).
AFAIK this is assigned to kernel area.
We have a ptrintk in arch/ppc/mm/fault.c which shows the frequent page 
fault
and its recovery from the fault, however as soon as the DAR loads 
0x00000024
or such low address we get a sig. 11.

Bad emulation malloctest/657
 NIP: 30000c10 instruction: 00000000 opcode: 0 A: 0 B: 0 C: 0 code: 0 rc: 0
 pte @ 0x30000c10:  (0xc1d3b300)->(0xc020f000)->0x01c2b889
 RPN: 01c2b PP: 2 SPS: 1 SH: 0 CI: 0 v: 1
Kernel VA for NIP c1c2bc10  pte @ 0xc1c2bc10: no pmd
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00286C8 LR: C0186684 SP: C02CDCA0 REGS: c02cdbf0 TRAP: 0300    Not 
tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: C2000000                                          
<======== here the DAR is 0x00000000
TASK = c1d0e070[657] 'malloctest' THREAD: c02cc000

We have tested the SDRAM in both U-boot (mtest) and linux, and the tests 
doesnt show anything
wrong with the SDRAM.

thanks in advance.
