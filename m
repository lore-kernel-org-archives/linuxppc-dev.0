Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzPNf5QFWzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 09:54:58 +1100 (AEDT)
Date: Wed, 11 Jan 2017 16:54:41 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
Message-ID: <20170111225440.GQ28613@gate.crashing.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 10, 2017 at 07:26:15AM +0100, Christophe LEROY wrote:
> >Maybe ppc32 is not supposed to be built with CC_STACKPROTECTOR ?
> 
> Indeed, the latest versions of GCC don't use anymore the global variable 
> __stack_chk_guard as canary value, but a value stored at -0x7008(r2). 
> This is not compatible with the current implementation of  the kernel 
> with uses r2 as a pointeur to current task struct.
> So until we fix it, I don't think CC_STACKPROTECTOR is usable on PPC 
> with modern versions of GCC.

I still wonder what changed.  Nothing relevant has changed for ten years
or whatever as far as I see; unless it is just the -fstack-protector-strong
that makes it fail now.  Curious.


Segher
