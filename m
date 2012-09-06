Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DAAB42C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 12:56:36 +1000 (EST)
Message-ID: <1346900172.19098.17.camel@pasglop>
Subject: Re: [powerpc:next 24/29] drivers/atm/fore200e.h:263:3: error:
 redefinition of typedef 'opcode_t' with different type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 06 Sep 2012 12:56:12 +1000
In-Reply-To: <20120906021929.GA16076@localhost>
References: <20120906021929.GA16076@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Meelis Roos <mroos@linux.ee>,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-06 at 10:19 +0800, Fengguang Wu wrote:
> Hi Ananth,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> head:   8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad
> commit: 8b7b80b9ebb46dd88fbb94e918297295cf312b59 [24/29] powerpc: Uprobes port to powerpc
> config: powerpc-allmodconfig (attached as .config)
> 
> All related error/warning messages:
> 
> In file included from drivers/atm/fore200e.c:70:0:
> drivers/atm/fore200e.h:263:3: error: redefinition of typedef 'opcode_t' with different type
> arch/powerpc/include/asm/probes.h:25:13: note: previous declaration of 'opcode_t' was here

This is a bit more annoying. Ananth, do we need that to be called
opcode_t for generic reasons or can we make it ppc_opcode_t ? If it has
to remain, I suppose we can try to change that ATM driver to use a
different type name...

(CC'ing Dave and Meelis who from the git history *might* have HW access
to test a possible patch).

Cheers,
Ben.
