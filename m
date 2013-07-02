Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id DA44D2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 10:18:27 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/booke64: Use common defines for AltiVec
 interrupts numbers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372692931-16324-1-git-send-email-mihai.caraman@freescale.com>
Date: Tue, 2 Jul 2013 02:18:21 +0200
Message-Id: <8F554F03-E6B0-4140-8830-D4FD6249CEF9@suse.de>
References: <1372692931-16324-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.07.2013, at 17:35, Mihai Caraman wrote:

> On Book3E some SPE/FP/AltiVec interrupts share the same number. Use
> common defines to indentify these numbers.

So why didn't this happen from the beginning? Why the change?


Alex

>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kernel/exceptions-64e.S |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S =
b/arch/powerpc/kernel/exceptions-64e.S
> index 645170a..0c379e9 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -399,7 +399,7 @@ interrupt_end_book3e:
>=20
> /* Altivec Unavailable Interrupt */
> 	START_EXCEPTION(altivec_unavailable);
> -	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_ALTIVEC_UNAVAIL,
> +	NORMAL_EXCEPTION_PROLOG(0x200, =
BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL,
> 				PROLOG_ADDITION_NONE)
> 	/* we can probably do a shorter exception entry for that one... =
*/
> 	EXCEPTION_COMMON(0x200, PACA_EXGEN, INTS_KEEP)
> @@ -421,7 +421,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>=20
> /* AltiVec Assist */
> 	START_EXCEPTION(altivec_assist);
> -	NORMAL_EXCEPTION_PROLOG(0x220, BOOKE_INTERRUPT_ALTIVEC_ASSIST,
> +	NORMAL_EXCEPTION_PROLOG(0x220,
> +				=
BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST,
> 				PROLOG_ADDITION_NONE)
> 	EXCEPTION_COMMON(0x220, PACA_EXGEN, INTS_DISABLE)
> 	bl	.save_nvgprs
> --=20
> 1.7.3.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
