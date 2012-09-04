Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 797362C00B0
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 05:49:31 +1000 (EST)
Message-ID: <1346788157.3025.12.camel@pasglop>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 05 Sep 2012 05:49:17 +1000
In-Reply-To: <1346768840.27919.2.camel@gandalf.local.home>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
 <1346768840.27919.2.camel@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-04 at 10:27 -0400, Steven Rostedt wrote:
> As a test case, continuing on error is fine, but I would not recommend
> that as a fix. If it fails, but still does the patch, that could be
> harmful, and confusing of a result.
> 
> Need to figure out why put_user is failing. 

It's probably not failiing... it's just called in a context in very
early boot on ppc32 where the might_sleep() test in there will trip
(because we are running before we are operating at our link address) and
will crash horribly.

I'll try to figure out a good way to fix this today.

Cheers,
Ben.
