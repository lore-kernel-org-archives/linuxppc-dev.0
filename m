Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 24F3B2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:22:13 +1000 (EST)
Message-ID: <1377303726.3819.6.camel@pasglop>
Subject: Re: [PATCH] powerpc/ppc64: remove __volatile__ in  get_current()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 24 Aug 2013 10:22:06 +1000
In-Reply-To: <1377301732.20722.110.camel@snotra.buserror.net>
References: <1376110162-3462-1-git-send-email-James.Yang@freescale.com>
 <alpine.LRH.2.00.1308231832570.4940@ra8135-ec1.am.freescale.net>
 <1377301732.20722.110.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 18:48 -0500, Scott Wood wrote:
> Actually, I changed my mind in the other direction in parallel. :-P
> 
> I think it's probably safe.

Yes, I think it is as well ... but only because "current" is special and
whatever the r13 for the thread is, r13->current will always be the same
value for that thread :-)

Note: That would NOT work if we used a C construct such as
local_paca->current, because in that case, gcc might be stupid enough to
*copy* r13 to another reg, and later on dereference using that other
reg. At that point, the paca pointer itself might become stale when
used.

Cheers,
Ben.
