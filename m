Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0143.outbound.protection.outlook.com [157.56.110.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7F781A025F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 02:17:41 +1100 (AEDT)
Message-ID: <1444144648.5336.271.camel@freescale.com>
Subject: Re: [PATCH v2 11/25] powerpc/8xx: map 16M RAM at startup
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 6 Oct 2015 10:17:28 -0500
In-Reply-To: <5613D65C.7040301@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <cb26118572adb9976f6870b22a0e5ef4c67f50db.1442939410.git.christophe.leroy@c-s.fr>
 <20150928235846.GF6161@home.buserror.net> <5613D65C.7040301@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 16:10 +0200, Christophe Leroy wrote:
> Le 29/09/2015 01:58, Scott Wood a écrit :
> > On Tue, Sep 22, 2015 at 06:50:50PM +0200, Christophe Leroy wrote:
> > > On recent kernels, with some debug options like for instance
> > > CONFIG_LOCKDEP, the BSS requires more than 8M memory, allthough
> > > the kernel code fits in the first 8M.
> > > Today, it is necessary to activate CONFIG_PIN_TLB to get more than 8M
> > > at startup, allthough pinning TLB is not necessary for that.
> > > 
> > > This patch adds a second 8M page to the initial mapping in order to
> > > have 16M mapped regardless of CONFIG_PIN_TLB, like several other
> > > 32 bits PPC (40x, 601, ...)
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > Is the assumption that nobody is still running 8xx systems with only 8
> > MiB RAM on current kernels?
> > 
> > 
> No, setup_initial_memory_limit() limits the memory to the minimum 
> between 16M and the real memory size, so if a platform has only 8M, it 
> will still be limited to 8M even with 16M mapped.

And you just hope you don't get a speculative fetch from the second 8M?

-Scott
