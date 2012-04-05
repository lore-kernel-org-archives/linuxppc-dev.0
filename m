Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E4081B703D
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2012 08:12:49 +1000 (EST)
Message-ID: <1333663961.3040.34.camel@pasglop>
Subject: Re: [PATCH 03/12] powerpc: Rework runlatch code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Fri, 06 Apr 2012 08:12:41 +1000
In-Reply-To: <m2vcldamh2.fsf@igel.home>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
 <m2vcldamh2.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-04-05 at 23:38 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This moves the inlines into system.h and changes the runlatch
> > code to use the thread local flags (non-atomic) rather than
> > the TIF flags (atomic) to keep track of the latch state.
> >
> > The code to turn it back on in an asynchronous interrupt is
> > now simplified and partially inlined.
> 
> This breaks the X server in that it no longer receives SIGIO signals.

Interesting. I have not observed that on my machine here, however I have
seen on my dual G5 (and not on the quad) some occasional loss of
interrupts for seconds which might be related.

Have you verified that you can "fix" it with reverting just the above
patch ? I would have more easily blamed the rest of my series than this
specific one... Anyways, I'll have a closer look but it might have to
wait for tuesday.

Cheers,
Ben.
