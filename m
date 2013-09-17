Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 465C42C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 10:06:22 +1000 (EST)
Message-ID: <1379376371.2536.218.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/3] powerpc/booke64: add sync after writing PTE
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 16 Sep 2013 19:06:11 -0500
In-Reply-To: <1379281131.4098.48.camel@pasglop>
References: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
 <1379281131.4098.48.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-16 at 07:38 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-09-13 at 22:50 -0500, Scott Wood wrote:
> > The ISA says that a sync is needed to order a PTE write with a
> > subsequent hardware tablewalk lookup.  On e6500, without this sync
> > we've been observed to die with a DSI due to a PTE write not being seen
> > by a subsequent access, even when everything happens on the same
> > CPU.
> 
> This is gross, I didn't realize we had that bogosity in the
> architecture...
> 
> Did you measure the performance impact ?

I didn't see a noticeable impact on the tests I ran, but those were
aimed at measuring TLB miss overhead.  I'll need to try it with a
benchmark that's more oriented around lots of page table updates.

-Scott
