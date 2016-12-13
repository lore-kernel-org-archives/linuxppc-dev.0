Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdFsq1ZrzzDvMb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 21:13:51 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 3so4093912pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:13:51 -0800 (PST)
Subject: Re: [PATCH v4 1/4] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <0947ced2f87c68a0a10ede8e1aaf39838a6f8d52.1481288905.git.ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f1bc3387-1118-6fd7-8e1b-2e59bfabdad1@gmail.com>
Date: Tue, 13 Dec 2016 21:13:26 +1100
MIME-Version: 1.0
In-Reply-To: <0947ced2f87c68a0a10ede8e1aaf39838a6f8d52.1481288905.git.ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/12/16 00:32, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the low-power idle states are expected to wake up
> at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
> that puts the CPU to an idle state and never returns.
> 
> On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
> CPU is expected to wake up at the next instruction of the idle
> instruction.
> 
> This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
> no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
> for a variant that allows resuming operation at the instruction next
> to the idle-instruction.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h   |  5 ++++-
>  arch/powerpc/kernel/exceptions-64s.S |  6 +++---
>  arch/powerpc/kernel/idle_book3s.S    | 10 +++++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 3919332..0a3255b 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -21,7 +21,7 @@
>  
>  /* Idle state entry routines */
>  #ifdef	CONFIG_PPC_P7_NAP
> -#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
> +#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
>  	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
>  	std	r0,0(r1);					\
>  	ptesync;						\
> @@ -29,6 +29,9 @@
>  1:	cmpd	cr0,r0,r0;					\
>  	bne	1b;						\
>  	IDLE_INST;						\
> +

Is the power saving magic sequence the same as before for power 9
as well?

Balbir Singh
