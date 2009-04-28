Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3698BDDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 22:05:27 +1000 (EST)
Message-Id: <B5DD5BF4-8EFF-472F-9D96-DE2941AAD70B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090428050338.221EF1EA0F4@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
Date: Tue, 28 Apr 2009 07:05:00 -0500
References: <20090428050338.221EF1EA0F4@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 12:03 AM, Michael Neuling wrote:

> From: Milton Miller <miltonm@bga.com>
>
> This adds the PowerPC 2.06 tlbie mnemonics and keeps backwards
> compatibilty for CPUs before 2.06.
>
> Only useful for bare metal systems.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
> arch/powerpc/include/asm/ppc-opcode.h |    3 +++
> arch/powerpc/kernel/cputable.c        |    6 ++++--
> arch/powerpc/mm/hash_native_64.c      |   11 +++++++++--

did you miss the update to mmu.h to add MMU_FTR_TLBIE_206?

> 3 files changed, 16 insertions(+), 4 deletions(-)
>
> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> @@ -79,4 +79,7 @@
> #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
> 					__PPC_WC(w))
>
> +#define TLBIE(lp,a) \
> +	stringify_in_c(.long 0x7c000264 | ((a) << 11) | ((lp) << 21))
> +

Can you match the format of the file and define a PPC_INST_TLBIE

- k
