Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjwj1YhjzDw23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:53 +1100 (AEDT)
Message-ID: <1479861172.6542.62.camel@neuling.org>
Subject: Re: [PATCH] powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Nov 2016 11:32:52 +1100
In-Reply-To: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 23:36 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> Ensure that PSSCR is set to a safe value corresponding to no
> state-loss each time a POWER9 CPU comes online.
>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Tested here on my configuration... FWIW

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/kernel/cpu_setup_power.S | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S
> b/arch/powerpc/kernel/cpu_setup_power.S
> index 52ff3f0..37ad045 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -96,6 +96,7 @@ _GLOBAL(__setup_cpu_power9)
> =C2=A0	mtlr	r11
> =C2=A0	beqlr
> =C2=A0	li	r0,0
> +	mtspr	SPRN_PSSCR,r0
> =C2=A0	mtspr	SPRN_LPID,r0
> =C2=A0	mfspr	r3,SPRN_LPCR
> =C2=A0	ori	r3, r3, LPCR_PECEDH
> @@ -116,6 +117,7 @@ _GLOBAL(__restore_cpu_power9)
> =C2=A0	mtlr	r11
> =C2=A0	beqlr
> =C2=A0	li	r0,0
> +	mtspr	SPRN_PSSCR,r0
> =C2=A0	mtspr	SPRN_LPID,r0
> =C2=A0	mfspr=C2=A0=C2=A0=C2=A0r3,SPRN_LPCR
> =C2=A0	ori	r3, r3, LPCR_PECEDH
