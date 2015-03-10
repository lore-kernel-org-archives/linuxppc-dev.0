Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B5441A0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 11:15:18 +1100 (AEDT)
Message-ID: <1425946518.19022.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc64: use fixed lock token for !CONFIG_PPC_SPLPAR
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Mar 2015 11:15:18 +1100
In-Reply-To: <1425884006.4636.234.camel@kernel.crashing.org>
References: <1425727183-30880-1-git-send-email-haokexin@gmail.com>
 <1425884006.4636.234.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Kevin Hao <haokexin@gmail.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-09 at 17:53 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2015-03-07 at 19:19 +0800, Kevin Hao wrote:
> > It makes no sense to use a variant lock token on a platform which
> > doesn't support for shared-processor logical partitions. Actually we
> > can eliminate a memory load by using a fixed lock token on these
> > platforms.
> 
> Does this provide an actual measurable benefit ? I found that the lock
> token was quite handy for debugging ...

Yeah. It can be very useful to know which cpu holds a lock when you get into a
dead lock.

Unless you can show this is a performance boost I'm inclined to leave it as-is.

cheers
