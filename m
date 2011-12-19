Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF6A8B703F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 14:19:16 +1100 (EST)
Message-ID: <1324264747.30454.15.camel@pasglop>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 19 Dec 2011 14:19:07 +1100
In-Reply-To: <1324263652.30454.13.camel@pasglop>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
 <5188.1323323649@neuling.org> <20111208171145.3ab3c423@kryten>
 <1324263652.30454.13.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-19 at 14:00 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2011-12-08 at 17:11 +1100, Anton Blanchard wrote:
> > Implement a POWER7 optimised copy_to_user/copy_from_user using VMX.
> > For large aligned copies this new loop is over 10% faster, and for
> > large unaligned copies it is over 200% faster.
> 
> Breaks !CONFIG_ALTIVEC build an pops some WARN's with preempt & lockdep,
> this seems to fix them:

And it's missing another ifdef actually for !CONFIG_ALTIVEC, I'll fix it
locally and will put a fixed version in -next.

Cheers,
Ben.
