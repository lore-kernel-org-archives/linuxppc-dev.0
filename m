Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0B501A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 12:46:57 +1100 (AEDT)
Message-ID: <1416275216.1107.2.camel@concordia>
Subject: Re: [PATCH] powerpc: mitigate impact of decrementer reset
From: Michael Ellerman <mpe@ellerman.id.au>
To: paulmck@linux.vnet.ibm.com
Date: Tue, 18 Nov 2014 12:46:56 +1100
In-Reply-To: <20141117191842.GA5050@linux.vnet.ibm.com>
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
 <54343B54.4060500@us.ibm.com>
 <1415614083.5769.18.camel@kernel.crashing.org>
 <546126DC.6090909@us.ibm.com> <1415846532.28703.3.camel@concordia>
 <20141117191842.GA5050@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Clarke <pc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-17 at 11:18 -0800, Paul E. McKenney wrote:
> On Thu, Nov 13, 2014 at 01:42:12PM +1100, Michael Ellerman wrote:
> > On Mon, 2014-11-10 at 14:58 -0600, Paul Clarke wrote:
> > > On 11/10/2014 04:08 AM, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2014-10-07 at 14:13 -0500, Paul Clarke wrote:
> > > >> This patch short-circuits the reset of the decrementer, exiting after
> > > >> the decrementer reset, but before the housekeeping tasks if the only
> > > >> need for the interrupt is simply to reset it.  After this patch,
> > > >> the latency spike was measured at about 150 nanoseconds.
> > > >
> > > > Doesn't this break the irq_work stuff ? We trigger it with a set_dec(1);
> > > > and your patch will probably cause it to be skipped...
> > > 
> > > You're right.
> > 
> > Yeah, thanks Ben, that would have been bad.
> > 
> > So we'll need to come up with a different approach.
> 
> If I am understanding this correctly, it underscores the need for more
> bits in the decrementer register.  :-/

Yes that is the root cause of the problem :)

cheers
