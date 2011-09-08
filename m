Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99EEDB6FF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 04:35:27 +1000 (EST)
Subject: Re: [RFC PATCH 03/10] fadump: Register for firmware assisted dump.
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110713180705.6210.44160.stgit@mars.in.ibm.com>
Date: Thu, 8 Sep 2011 13:34:15 -0500
Message-Id: <1D6A3FC8-816D-4257-A50E-60D1FCE7259F@kernel.crashing.org>
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
	<20110713180705.6210.44160.stgit@mars.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>=20
> diff --git a/arch/powerpc/kernel/setup_64.c =
b/arch/powerpc/kernel/setup_64.c
> index a88bf27..3031ea7 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -63,6 +63,7 @@
> #include <asm/kexec.h>
> #include <asm/mmu_context.h>
> #include <asm/code-patching.h>
> +#include <asm/fadump.h>
>=20
> #include "setup.h"
>=20
> @@ -371,6 +372,13 @@ void __init setup_system(void)
> 	rtas_initialize();
> #endif /* CONFIG_PPC_RTAS */
>=20
> +#ifdef CONFIG_FA_DUMP
> +	/*
> +	 * Setup Firmware-assisted dump.
> +	 */
> +	setup_fadump();

Is there a reason this has to be done here?  Can it be an initcall or =
called from platform init code?

> +#endif
> +

- k
