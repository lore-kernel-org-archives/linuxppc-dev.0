Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 14/15] powerpc: Add WSP platform
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <02b9880aa9ef5d49b473c894bce886f2060f9f0b.1302856271.git.michael@ellerman.id.au>
Date: Mon, 18 Apr 2011 07:46:15 -0500
Message-Id: <A6E5DD55-F9D1-430E-BAA7-E770523821A0@kernel.crashing.org>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<02b9880aa9ef5d49b473c894bce886f2060f9f0b.1302856271.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ozlabs.org>
Cc: Jimi Xenidis <jimix@watson.ibm.com>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>, imunsie@au.ibm.com,
	jack@codezen.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2011, at 3:32 AM, Michael Ellerman wrote:

> diff --git a/arch/powerpc/kernel/exceptions-64e.S =
b/arch/powerpc/kernel/exceptions-64e.S
> index ab5c4dd..8e5d2c1 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -864,6 +864,20 @@ have_hes:
> 	 * that will have to be made dependent on whether we are running =
under
> 	 * a hypervisor I suppose.
> 	 */
> +
> +	/* BEWARE, MAGIC
> +	 * This code is called as an ordinary function on the boot CPU. =
But to
> +	 * avoid duplication, this code is also used in SCOM bringup of
> +	 * secondary CPUs. We read the code between the =
initial_tlb_code_start
> +	 * and initial_tlb_code_end labels one instruction at a time and =
RAM it
> +	 * into the new core via SCOM. That doesn't process branches, so =
there
> +	 * must be none between those two labels. It also means if this =
code
> +	 * ever takes any parameters, the SCOM code must also be updated =
to
> +	 * provide them.
> +	 */
> +	.globl a2_tlbinit_code_start
> +a2_tlbinit_code_start:
> +
> 	ori	r11,r3,MAS0_WQ_ALLWAYS
> 	oris	r11,r11,MAS0_ESEL(3)@h /* Use way 3: workaround A2 =
erratum 376 */
> 	mtspr	SPRN_MAS0,r11
> @@ -880,6 +894,9 @@ have_hes:
> 	/* Write the TLB entry */
> 	tlbwe
>=20
> +	.globl a2_tlbinit_after_linear_map
> +a2_tlbinit_after_linear_map:
> +
> 	/* Now we branch the new virtual address mapped by this entry */
> 	LOAD_REG_IMMEDIATE(r3,1f)
> 	mtctr	r3
> @@ -931,10 +948,16 @@ have_hes:
> 	cmpw	r3,r9
> 	blt	2b
>=20
> +	.globl  a2_tlbinit_after_iprot_flush
> +a2_tlbinit_after_iprot_flush:
> +
> 	PPC_TLBILX(0,0,0)
> 	sync
> 	isync
>=20
> +	.globl a2_tlbinit_code_end
> +a2_tlbinit_code_end:
> +
> 	/* We translate LR and return */
> 	mflr	r3
> 	tovirt(r3,r3)

Can this be moved into kernel/cpu_setup_a2.S.  This and the debug patch =
that follows are bit ugly.

- k=
