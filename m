Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4239DE048
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 05:35:41 +1000 (EST)
Message-Id: <7B118E94-F308-4768-8ED6-BD66C5C3D3CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080618004734.0B72E70296@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
Date: Wed, 18 Jun 2008 14:35:30 -0500
References: <20080618004734.0B72E70296@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 7:47 PM, Michael Neuling wrote:

> The layout of the new VSR registers and how they overlap on top of the
> legacy FPR and VR registers is:
>
>                   VSR doubleword 0               VSR doubleword 1
>           
> ----------------------------------------------------------------
>  VSR[0]  |             FPR[0]             
> |                              |
>           
> ----------------------------------------------------------------
>  VSR[1]  |             FPR[1]             
> |                              |
>           
> ----------------------------------------------------------------
>          |              ...               
> |                              |
>          |              ...               
> |                              |
>           
> ----------------------------------------------------------------
>  VSR[30] |             FPR[30]            
> |                              |
>           
> ----------------------------------------------------------------
>  VSR[31] |             FPR[31]            
> |                              |
>           
> ----------------------------------------------------------------
>  VSR[32] |                              
> VR[0]                            |
>           
> ----------------------------------------------------------------
>  VSR[33] |                              
> VR[1]                            |
>           
> ----------------------------------------------------------------
>           
> |                              ...                             |
>           
> |                              ...                             |
>           
> ----------------------------------------------------------------
>  VSR[62] |                              
> VR[30]                           |
>           
> ----------------------------------------------------------------
>  VSR[63] |                              
> VR[31]                           |
>           
> ----------------------------------------------------------------
>
> VSX has 64 128bit registers.  The first 32 regs overlap with the FP
> registers and hence extend them with and additional 64 bits.  The
> second 32 regs overlap with the VMX registers.
>
> This patch introduces the thread_struct changes required to reflect
> this register layout.  Ptrace and signals code is updated so that the
> floating point registers are correctly accessed from the thread_struct
> when CONFIG_VSX is enabled.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---

Is VSX mutually exclusive with altivec/fp?  is there a MSR bit for it?

- k
