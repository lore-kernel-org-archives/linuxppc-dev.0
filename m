Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSnQ62s7hzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 17:24:14 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 1so591925pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 22:24:14 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 17:24:06 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Always clear UPRT and Host Radix bits
 when setting up CPU
Message-ID: <20170222062406.GD9967@balbir.ozlabs.ibm.com>
References: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2017 at 10:42:02AM +0530, Aneesh Kumar K.V wrote:
> We will set LPCR with correct value for radix during int. This make sure we
> start with a sanitized value of LPCR. In case of kexec, cpus can have LPCR
> value based on the previous translation mode we were running.
> 
> Fixes: fe036a0605d60 ("powerpc/64/kexec: Fix MMU cleanup on radix")
> Cc: stable@vger.kernel.org # v4.9+
> Acked-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/cpu_setup_power.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 917188615bf5..7fe8c79e6937 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -101,6 +101,8 @@ _GLOBAL(__setup_cpu_power9)
>  	mfspr	r3,SPRN_LPCR
>  	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
>  	or	r3, r3, r4
> +	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
> +	andc	r3, r3, r4
>  	bl	__init_LPCR
>  	bl	__init_HFSCR
>  	bl	__init_tlb_power9
> @@ -122,6 +124,8 @@ _GLOBAL(__restore_cpu_power9)
>  	mfspr   r3,SPRN_LPCR
>  	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
>  	or	r3, r3, r4
> +	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
> +	andc	r3, r3, r4
>  	bl	__init_LPCR
>  	bl	__init_HFSCR
>  	bl	__init_tlb_power9

My previous comment mentions GTSE, but really we should be clearing
LPCR to 0 and setting it to sane values in __init_LPCR

Balbir
