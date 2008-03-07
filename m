Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA09.emeryville.ca.mail.comcast.net
	(qmta09.emeryville.ca.mail.comcast.net [76.96.30.96])
	by ozlabs.org (Postfix) with ESMTP id A7FA5DDF4F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 11:50:37 +1100 (EST)
Message-ID: <47D09199.4090800@gmail.com>
Date: Thu, 06 Mar 2008 19:51:37 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] The MPC83xx family doesn't support performance monitor
	instructions
References: <20080306003316.GA14068@cideas.com>
	<74F2472D-65F2-422B-821B-554EC81A3494@kernel.crashing.org>
In-Reply-To: <74F2472D-65F2-422B-821B-554EC81A3494@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mar 5, 2008, at 6:33 PM, Gerald Van Baren wrote:
> 
>> "Errata to MPC8349EA PowerQUICC[tm] II Pro Integrated Host Processor  
>> Family
>> Reference Manual, Rev. 1" (Freescale)
>>
>> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
>> ---
>>
>> Hi Kumar,
>>
>> Please apply this fix to 2.6.25rc4 if possible.  Without this
>> patch, the PPC_83xx family configuration is broken (will not compile).
> 
> What's the compile issue?  Some of the 83xx family have perf mon so we  
> need to fix the compile issue.
> 
> - k

Hi Kumar,

The mpc8360 and mpc8349 do not have a perfmon register (I don't find it 
at all in the MPC8360RM and the mpc8349 errata I referenced says the 
MPC8349RM is in error).

The result is that the assembler dies with an error.  If the assembler 
didn't die with an error, I presume the kernel would since it is an 
invalid SPR.

   CC      arch/powerpc/kernel/pmc.o
{standard input}: Assembler messages:
{standard input}:7: Error: Unrecognized opcode: `mfpmr'
{standard input}:11: Error: Unrecognized opcode: `mtpmr'
make[1]: *** [arch/powerpc/kernel/pmc.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

This is using ELDK4.1 (also 4.2rc) using the ppc_6xx- version of the 
compiler (which symlinks to powerpc-linux-gcc).

If some of the mpc83xx processors have perfmon registers, we need a more 
granular way of selecting the CONFIG_FSL_EMB_PERFMON option (or a Plan 
B, but I don't know what Plan B would be).

Best regards,
gvb
