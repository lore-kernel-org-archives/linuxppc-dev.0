Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B03D1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Apr 2011 16:06:10 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx)
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110418113638.29c0bc85@kryten>
References: <20110418113638.29c0bc85@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Apr 2011 16:05:52 +1000
Message-ID: <1303625152.2513.136.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-18 at 11:36 +1000, Anton Blanchard wrote:
> - By including linux/spinlock_types.h we can remove the dynamic
> allocation
>   of the spinlock hack and simplify things a lot.

Causes all sort of hell for me on some configs. Lockdep is not happy for
example and there's some nasty include dependency circles. Not sure
that's fixable at least not without some important cleanup of how
mmu_context_t is defined.

Ben.
