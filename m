Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F533DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:31:05 +1000 (EST)
Message-Id: <535FF889-D311-4C96-9427-DBEF7404A17F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090424062431.D3803120E7@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
Date: Mon, 27 Apr 2009 14:30:40 -0500
References: <20090424062431.D3803120E7@localhost.localdomain>
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


On Apr 24, 2009, at 1:24 AM, Michael Neuling wrote:

> Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_native_64.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
> @@ -38,6 +38,9 @@
>
> static DEFINE_SPINLOCK(native_tlbie_lock);
>
> +#define TLBIE(lp,a) \
> +	stringify_in_c(.long 0x7c000264 | ((a) << 11) | ((lp) << 21))
> +

Put this ppc-opcode.h now that we have it.

- k
