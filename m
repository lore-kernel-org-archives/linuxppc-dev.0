Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2681B6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:57:22 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc: POWER7 optimised memcpy using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110617045421.615463021@samba.org>
References: <20110617045358.544896830@samba.org>
	<20110617045421.615463021@samba.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 15:57:16 +1000
Message-ID: <1308290236.32158.47.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

O
> +.Lvmx_copy:
> +	mflr	r0
> +	std	r4,56(r1)
> +	std	r5,64(r1)
> +	std	r0,16(r1)
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +	bl	.enable_kernel_altivec
> +	ld	r0,STACKFRAMESIZE+16(r1)
> +	ld	r3,STACKFRAMESIZE+48(r1)
> +	ld	r4,STACKFRAMESIZE+56(r1)
> +	ld	r5,STACKFRAMESIZE+64(r1)
> +	mtlr	r0

Disable interrupts ? We wont save the VMX state on interrupts and memcpy
is definitely re-entrant.

Or only run the optimization when not at interrupt time....

Cheers,
Ben.
