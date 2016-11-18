Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKtKk15vvzDvk9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 20:41:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 1/4] powerpc: asm: introduce new macros for assembly
 globals
In-Reply-To: <e4e5fb867e0190aea3f30591fb5025b55bb8f2c5.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e4e5fb867e0190aea3f30591fb5025b55bb8f2c5.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 18 Nov 2016 20:41:13 +1100
Message-ID: <87poltgm6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> - Introduce _GLOBAL_SYM() for global symbols in assembly. This helps
> reduce verbosity of assembly files.

Unfortunately you've walked into a bit of mine field here :)

In user space they use FUNC_START() to declare the start of a function,
and we should do the same. Anton added FUNC_START/END, but didn't quite
get around to converting everything, see 151f25112ff7 ("powerpc: define
FUNC_START/FUNC_END").

So what I'd like is all uses of _GLOBAL() to become FUNC_START(), and
then we can change _GLOBAL() to just define a global symbol.

We can probably decouple that from most of this series though, as I
mentioned in my other reply, just by using _ASM_NOKPROBE_SYMBOL().

cheers
