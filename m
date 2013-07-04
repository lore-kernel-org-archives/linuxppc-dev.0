Return-Path: <RA8135@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 001002C030E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 07:56:57 +1000 (EST)
Date: Thu, 4 Jul 2013 16:56:49 -0500
From: James Yang <James.Yang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Emulate sync instruction variants
In-Reply-To: <1372930164.4122.95.camel@pasglop>
Message-ID: <alpine.LRH.2.00.1307041641500.796@ra8135-ec1.am.freescale.net>
References: <1372886807-12109-1-git-send-email-James.Yang@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72CA@saturn3.aculab.com>
 <1372930164.4122.95.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: James.Yang@freescale.com, scottwood@freescale.com,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 4 Jul 2013, Benjamin Herrenschmidt wrote:

> On Thu, 2013-07-04 at 09:31 +0100, David Laight wrote:
> > Do you need to execute 'sync' here?
> > It is worth checking whether the trap entry/exit doesn't
> > do an implicit one for you.
> 
> Not really. It does an implicit isync (more than one even) but not a 
> sync.

The execution of a sync is required because the original sync variant 
instruction is not actually executed, and, per Ben, no other explicit 
sync exists in the exception handler.  If the ISA extends the sync 
instruction using its reserved bits, the intent would also be that 
executing a heavyweight sync is suitably compatible, otherwise they 
should have modified some other synchronization instruction.  This 
patch ensures at least one sync instruction is executed for each sync 
variant instruction executed that triggers a program exception.
