Return-Path: <amodra@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 592CBB7D1D
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 08:40:37 +1000 (EST)
Received: by pxi6 with SMTP id 6so2191823pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jun 2010 15:40:36 -0700 (PDT)
Date: Wed, 2 Jun 2010 08:10:26 +0930
From: Alan Modra <amodra@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Optimise per cpu accesses on 64bit
Message-ID: <20100601224026.GG5631@bubble.grove.modra.org>
References: <20100601044511.GF28295@kryten> <1275375920.1931.699.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275375920.1931.699.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 01, 2010 at 05:05:20PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2010-06-01 at 14:45 +1000, Anton Blanchard wrote:
> > Now we dynamically allocate the paca array, it takes an extra load
> > whenever we want to access another cpu's paca. One place we do that a lot
> > is per cpu variables. A simple example:
> 
> Can't we dedicate a GPR instead ? Or it isn't worth it ? Something we
> almost never use in the kernel like r12 ?

Not r12.  It is used in function prologue and epilogue code.  If you
want a dedicated gpr I think you'll need to use (and lose) one of the
non-volatile regs.

-- 
Alan Modra
Australia Development Lab, IBM
