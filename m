Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 103222C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 09:41:20 +1000 (EST)
Message-ID: <1375832471.5600.41.camel@snotra.buserror.net>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 6 Aug 2013 18:41:11 -0500
In-Reply-To: <1375831851.12557.74.camel@pasglop>
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025934.19448.16658.stgit@deepthi>
 <1375830520.5600.23.camel@snotra.buserror.net>
 <1375831851.12557.74.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org,
 dongsheng.wang@freescale.com, srivatsa.bhat@linux.vnet.ibm.com,
 preeti@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-07 at 09:30 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-06 at 18:08 -0500, Scott Wood wrote:
> > Here's another example.  get_lppaca() will only build on book3s -- and
> > yet we get requests for e500 code to use this file.
> 
> Indeed, Besides there is already accessors afaik for lppaca that compile
> to nothing on E (and if not they would be trivial to add).

I don't see such an accessor, but if there were, what would happen when
the caller goes on to dereference that nothing?

There is an accessor for shared_proc specifically (in the spinlock code)
-- not that it would be much help on booke to just compile away that
check and always select one of the pseries state tables over the other.

-Scott
