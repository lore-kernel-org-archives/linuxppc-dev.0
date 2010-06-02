Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A3BFB7D24
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 15:25:10 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o525PBd6024184
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 15:25:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o525P9BZ1458258
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 15:25:09 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o525P9Su004080
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 15:25:09 +1000
Date: Wed, 2 Jun 2010 10:55:02 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH] powerpc: Emulate most load and store instructions in
	emulate_step()
Message-ID: <20100602052502.GA2451@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100520124955.GA29903@brick.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 20, 2010 at 10:49:55PM +1000, Paul Mackerras wrote:
> This extends the emulate_step() function to handle most of the load
> and store instructions implemented on current 64-bit server processors.
> The aim is to handle all the load and store instructions used in the
> kernel, so this handles the Altivec/VMX lvx and stvx and the VSX
> lxv2dx and stxv2dx instructions (implemented in POWER7).
> 

Can the emulate_step() function be used on BookIII E processors as well
(arch/powerpc/kernel/kprobes.c invokes it irrespective of the host
processor though)?

If yes, we can use it with hw_breakpoint_handler() of BookE
processors (like what is done on the PPC64 counterpart).

> The new code can emulate user mode instructions, and checks the
> effective address for a load or store if the saved state is for
> user mode.  It doesn't handle little-endian mode at present.
> 
> For floating-point, Altivec/VMX and VSX instructions, it checks
> that the saved MSR has the enable bit for the relevant facility
> set, and if so, assumes that the FP/VMX/VSX registers contain
> valid state, and does loads or stores directly to/from the
> FP/VMX/VSX registers, using assembly helpers in ldstfp.S.
> 

Thanks,
K.Prasad
