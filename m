Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD7606A33A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+ScNVmp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWqdr4VSDz2xmh;
	Sat, 21 Nov 2026 22:26:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795260368;
	cv=none; b=iAMG4Rk+d3OkQFeavg3E2VLCyXesh9l4BibeNSQdz7A3O7BfsxbK4ZiDHLillj5FtJLpvklsekUDnBBP5jjdV76fhevdCbOJNHiJzKQ+jCzDre6lLuF2SSPGCkPGhBz/Z017sqX+FycFD8UwiR4YAl0ahbkQ9Yqyz3vr7hB1eC8Licg6aXWt6KRD6epAAfzNaICBvrJ5QP+1FtOTwSmYX+hT4I7V7fA4gycED7gr2JXzf+8jQZL7OOlFpOrvfswt3t9Wwn07+40djDB82PGV0aT+ETfyEdBHdx1GgJLbxgBHAQJ6H5ip1bTqqI0n1FAI0u0ijlurlvUM/Zpr7aU3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795260368; c=relaxed/relaxed;
	bh=3bXHcl/fLFqRmej5Iy+GS47hNdziQAQfexcJcjrWskU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXB3lsHMzd8hecASc4iq8p4c6rWAuw70J4h0tR4aTO+ULFL2p0bxfbIEYlyeOlI84hM/z2lji7JYbs2YgQsMsm/lW6xntFKLxkDVf/WKuWiRj68AFXRcqz0soir3bpq7oZG6U0kXLZXxzc+NWPtSZp6uZ5k7d/flnv2/fY1IbkqSA8k/P+3Wzbw6y4AS9pMksBk5YZ6bGsa5XfVVp8SE+EKyLry5pGXEgsXrS6S0rnvdWLV9If7NCAL59kzBNeq5hJE5Iz2P1eSemj3vSddeF431HL1ZDr362KC9SjSeZEeJhhmRqGq9yJrIDcXND3HJzuWzO7lh/PK6jHyKnubarw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+ScNVmp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+ScNVmp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWqdq3jf6z2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 22:26:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79D5B6125A;
	Sat, 21 Nov 2026 11:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E301F000C0;
	Sat, 21 Nov 2026 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260364;
	bh=3bXHcl/fLFqRmej5Iy+GS47hNdziQAQfexcJcjrWskU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P+ScNVmpJZXRRDAXyjPOhxBDFCglcm36joNg8WEYQzO51TFOmvzFOYMf+1flVUS7+
	 u4t0m5jQLG8/Ja9Vqf1w0YVvs0lcwFoztshDpzr14fJul4X6CUiPp4i8aeRuIYe0Nn
	 J4/nVpYGTUKoAZWMXL18VMRWexaIcAvpjrPqm6DpFUwiuydemYvjhgiEoorB6+OemW
	 ToWISm2jQkBnKIvy/rPr63fd7ony+9aCuKjuo9WN8AEIxFt2xdon0BW/fXsWNadM8b
	 mRYFkKndnXPVUlFRtYz1EtFyaV8iQyYuQy0fokeJ5innc3M6pg2dCNQ+FRwsC2z5/j
	 16yMkcp7GvBbQ==
Message-ID: <9ecda3f8-13f7-4bd3-81b9-cf7deafdbcb2@kernel.org>
Date: Sat, 21 Nov 2026 12:25:57 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] powerpc/32: Decode MPC745x L2 and L3 cache machine
 checks
To: Matt Turner <mattst88@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
References: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
 <20261120-ppc32-l2-ecc-v1-1-98fc8e6e0a32@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261120-ppc32-l2-ecc-v1-1-98fc8e6e0a32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 20/11/2026 à 20:33, Matt Turner a écrit :
> On the 745x, SRR1[MSS] means the memory subsystem detected an error, and
> MSSSR0 says which: L2 tag or data parity, MPC7448 L2 ECC, or L3 tag or
> data parity.  machine_check_generic() reports these cache errors as "L2
> data cache parity error" and never clears MSSSR0, whose bits are sticky.
> 
> Add machine_check_745x(), which decodes and clears the MSSSR0 cache
> error bits, and use it for every 745x.  Machine checks without one of
> those bits still go to machine_check_generic().
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   arch/powerpc/include/asm/cputable.h       |  1 +
>   arch/powerpc/include/asm/reg.h            |  5 +++++
>   arch/powerpc/kernel/cpu_specs_book3s_32.h | 22 +++++++++++-----------
>   arch/powerpc/kernel/traps.c               | 28 ++++++++++++++++++++++++++++

Can we avoid machine specific code in traps.c ?

Other machine_check functions are in dedicated locations except e500 
because it is common to mpc85xx and 64e

platforms/44x/machine_check.c:int machine_check_4xx(struct pt_regs *regs)
platforms/44x/machine_check.c:int machine_check_440A(struct pt_regs *regs)
platforms/44x/machine_check.c:int machine_check_47x(struct pt_regs *regs)
platforms/83xx/misc.c:int machine_check_83xx(struct pt_regs *regs)
platforms/8xx/machine_check.c:int machine_check_8xx(struct pt_regs *regs)




>   4 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index a3be81c47df3..8445533c946b 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -34,6 +34,7 @@ extern int machine_check_e500(struct pt_regs *regs);
>   extern int machine_check_47x(struct pt_regs *regs);
>   int machine_check_8xx(struct pt_regs *regs);
>   int machine_check_83xx(struct pt_regs *regs);
> +int machine_check_745x(struct pt_regs *regs);
>   
>   extern void cpu_down_flush_e500v2(void);
>   extern void cpu_down_flush_e500mc(void);
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 541a493e13bf..82a85d44776e 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -729,6 +729,10 @@
>   
>   #define SPRN_MSSCR0	0x3f6	/* Memory Subsystem Control Register 0 */
>   #define SPRN_MSSSR0	0x3f7	/* Memory Subsystem Status Register 1 */
> +#define   MSSSR0_L2TAG	0x00040000	/* L2 tag parity error */
> +#define   MSSSR0_L2DAT	0x00020000	/* L2 data parity/ECC error */
> +#define   MSSSR0_L3TAG	0x00010000	/* L3 tag parity error */
> +#define   MSSSR0_L3DAT	0x00008000	/* L3 data parity error */
>   #define SPRN_LDSTCR	0x3f8	/* Load/Store control register */
>   #define SPRN_LDSTDB	0x3f4	/* */
>   #define SPRN_LR		0x008	/* Link Register */
> @@ -801,6 +805,7 @@
>   #define   SRR1_PROGTRAP		0x00020000 /* Trap */
>   #define   SRR1_PROGADDR		0x00010000 /* SRR0 contains subsequent addr */
>   
> +#define   SRR1_MCE_MSS		0x00100000 /* 745x memory subsystem error (MSSSR0) */
>   #define   SRR1_MCE_MCP		0x00080000 /* Machine check signal caused interrupt */
>   #define   SRR1_BOUNDARY		0x10000000 /* Prefixed instruction crosses 64-byte boundary */
>   #define   SRR1_PREFIXED		0x20000000 /* Exception caused by prefixed instruction */
> diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/powerpc/kernel/cpu_specs_book3s_32.h
> index 3714634d194a..90ca26405c1d 100644
> --- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
> +++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
> @@ -426,7 +426,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7450 2.1 */
> @@ -442,7 +442,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7450 2.3 and newer */
> @@ -458,7 +458,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7455 rev 1.x */
> @@ -474,7 +474,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7455 rev 2.0 */
> @@ -490,7 +490,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7455 others */
> @@ -506,7 +506,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7447/7457 Rev 1.0 */
> @@ -522,7 +522,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7447/7457 Rev 1.1 */
> @@ -538,7 +538,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7447/7457 Rev 1.2 and later */
> @@ -554,7 +554,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7447A */
> @@ -570,7 +570,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* 7448 */
> @@ -586,7 +586,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
>   		.num_pmcs		= 6,
>   		.pmc_type		= PPC_PMC_G4,
>   		.cpu_setup		= __setup_cpu_745x,
> -		.machine_check		= machine_check_generic,
> +		.machine_check		= machine_check_745x,
>   		.platform		= "ppc7450",
>   	},
>   	{	/* default match, we assume split I/D cache & TB (non-601)... */
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 3a8f5416e3f6..4fb1610baa51 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -788,6 +788,34 @@ int machine_check_generic(struct pt_regs *regs)
>   	}
>   	return 0;
>   }
> +
> +#ifdef CONFIG_PPC_BOOK3S_32
> +#define MSSSR0_CACHE_ERR	(MSSSR0_L2TAG | MSSSR0_L2DAT | MSSSR0_L3TAG | MSSSR0_L3DAT)
> +
> +/*
> + * On the 745x, SRR1[MSS] means the memory subsystem detected an error, and
> + * MSSSR0 says which.  The MSSSR0 bits are sticky, so clear them.
> + */
> +int machine_check_745x(struct pt_regs *regs)
> +{
> +	unsigned long reason = regs->msr;
> +	unsigned long msssr0 = mfspr(SPRN_MSSSR0);
> +
> +	if (!(reason & SRR1_MCE_MSS) || !(msssr0 & MSSSR0_CACHE_ERR))
> +		return machine_check_generic(regs);
> +
> +	mtspr(SPRN_MSSSR0, msssr0 & ~MSSSR0_CACHE_ERR);
> +
> +	pr_err("Machine check in kernel mode.\n");
> +	pr_err("Caused by (from SRR1=%lx, MSSSR0=%lx):%s%s%s%s\n",
> +	       reason, msssr0,
> +	       msssr0 & MSSSR0_L2TAG ? " [L2 tag parity]" : "",
> +	       msssr0 & MSSSR0_L2DAT ? " [L2 data parity/ECC]" : "",
> +	       msssr0 & MSSSR0_L3TAG ? " [L3 tag parity]" : "",
> +	       msssr0 & MSSSR0_L3DAT ? " [L3 data parity]" : "");
> +	return 0;
> +}
> +#endif
>   #endif /* everything else */
>   
>   void die_mce(const char *str, struct pt_regs *regs, long err)
> 


