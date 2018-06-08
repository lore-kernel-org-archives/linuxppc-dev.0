Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412QSh6T09zDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 00:55:32 +1000 (AEST)
Date: Fri, 8 Jun 2018 09:54:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180608145423.GF17342@gate.crashing.org>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528463979.git.christophe.leroy@c-s.fr>
 <ce98c6b8e80f85635a67093bbb59f13dae758112.1528463979.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce98c6b8e80f85635a67093bbb59f13dae758112.1528463979.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Fri, Jun 08, 2018 at 01:27:39PM +0000, Christophe Leroy wrote:
> ---
> Not tested on PPC64.

> +#ifdef CPU_LITTLE_ENDIAN
> +	rldicl.	r8, r9, 0, 56
> +	beq	20f
> +	rldicl.	r8, r9, 56, 56
> +	beq	21f
> +	rldicl.	r8, r9, 48, 56
> +	beq	22f
> +	rldicl.	r8, r9, 40, 56
> +	beq	23f
> +	addi	r10, r10, 4
> +	rldicl.	r8, r9, 32, 56
> +	beq	20f
> +	rldicl.	r8, r9, 24, 56
> +	beq	21f
> +	rldicl.	r8, r9, 16, 56
> +	beq	22f
> +	rldicl.	r8, r9, 8, 56
> +#else
> +#ifdef CONFIG_PPC64
> +	rldicl.	r8, r9, 8, 56
> +	beq	20f
> +	rldicl.	r8, r9, 16, 56
> +	beq	21f
> +	rldicl.	r8, r9, 24, 56
> +	beq	22f
> +	rldicl.	r8, r9, 32, 56
> +	beq	23f
> +	addi	r10, r10, 4
> +#endif
> +	rlwinm.	r8, r9, 0, 0xff000000
> +	beq	20f
> +	rlwinm.	r8, r9, 0, 0x00ff0000
> +	beq	21f
> +	rlwinm.	r8, r9, 0, 0x0000ff00
> +	beq	22f
> +#endif /* CPU_LITTLE_ENDIAN */

That isn't going to perform well on processors that have more than two
or so cycles penalty on a branch mispredict (i.e. all modern processors).

ISA 2.05 and later cpus (Power6 and later) can use cmpb and a single
cntlz, on BE; on LE you can use the cnttz insn on ISA 3.0 (Power9) or
later, or do add/andc/popcntd (on ISA2.06, Power7 and later) or
neg/and/cntlz/sub.

Lots of options.  You can also write branchless code for this without
using any new insns (less nice of course).


Segher
