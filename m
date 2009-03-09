Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2725DE140
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 03:37:29 +1100 (EST)
Message-Id: <E2DCB3CA-0547-494B-B94A-F38BA0899479@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liming Wang <liming.wang@windriver.com>
In-Reply-To: <1236142278-9276-1-git-send-email-liming.wang@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Add unwind information for SPE registers of E500 core
Date: Mon, 9 Mar 2009 11:37:15 -0500
References: <1236142278-9276-1-git-send-email-liming.wang@windriver.com>
Cc: Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@au.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 3, 2009, at 10:51 PM, Liming Wang wrote:

> SPE registers use the high part bit0~bit31 of E500 GPR0~GPR31.
> The unwind information in "eh_frame" section is used during exception
> handling and describes register information in the signal frame. But
> current unwind information doesn't cover SPE registers, which have
> been saved in the signal frame. This patch adds this unwind  
> information
> to "eh_frame" section.
>
> SPE registers use register number 1200+N to identify register 'N', but
> they start from 113 in unwind column, which is computed from gcc
> source code, macro DWARF_REG_TO_UNWIND_COLUMN:
>
> 	#define FIRST_PSEUDO_REGISTER 114
> 	#define DWARF_REG_TO_UNWIND_COLUMN(r) \
>  	  ((r) > 1200 ? ((r) - 1200 + FIRST_PSEUDO_REGISTER - 1) : (r))
>
> Signed-off-by: Liming Wang <liming.wang@windriver.com>
> ---
> arch/powerpc/kernel/vdso32/sigtramp.S |   34 ++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 34 insertions(+), 0 deletions(-)

What about SPEFSCR & the accumulator?  Are they not part of the  
frame?  They probably should be.

> diff --git a/arch/powerpc/kernel/vdso32/sigtramp.S b/arch/powerpc/ 
> kernel/vdso32/sigtramp.S
> index 68d49dd..789a343 100644
> --- a/arch/powerpc/kernel/vdso32/sigtramp.S
> +++ b/arch/powerpc/kernel/vdso32/sigtramp.S
> @@ -251,6 +251,40 @@ V_FUNCTION_END(__kernel_sigtramp_rt32)
>   vsave_msr1 (31);							\
>   vsave_msr2 (33, 32*16+12);						\
>   vsave      (32, 32*16)
> +#elif defined(CONFIG_SPE)
> +#define EH_FRAME_VMX \

introduce EH_FRAME_SPE.

> +  rsave (113, VREGS);							\

we should probably be doing the same thing as vsave_msr1()

- k
