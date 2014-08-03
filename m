Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A245C1A0129
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 01:51:35 +1000 (EST)
Date: Sun, 3 Aug 2014 10:51:08 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
Message-ID: <20140803155108.GA19710@gate.crashing.org>
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/*
> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Software Breakpoint.
> + * Based on PowerISA v2.07, Instruction with opcode 0s will be treated as illegal
> + * instruction.
> + */

"primary opcode 0" instead?

> +#define OP_ZERO                 0x0

Using 0x0 where you mean 0, making a #define for 0 in the first place...
This all looks rather silly doesn't it.

> +	case OP_ZERO:
> +		if((inst & 0x00FFFF00) == KVMPPC_INST_BOOK3S_DEBUG) {

You either shouldn't mask at all here, or the mask is wrong (the primary
op is the top six bits, not the top eight).


Segher
