Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C5DC1A0791
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 14:08:20 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 20:08:19 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B2F821FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 19:56:58 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAI38Dsx8323492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 04:08:13 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 sAI3D6ZU029952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:13:06 -0700
Date: Mon, 17 Nov 2014 19:08:06 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: mitigate impact of decrementer reset
Message-ID: <20141118030806.GK5050@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
 <54343B54.4060500@us.ibm.com>
 <1415614083.5769.18.camel@kernel.crashing.org>
 <546126DC.6090909@us.ibm.com> <1415846532.28703.3.camel@concordia>
 <20141117191842.GA5050@linux.vnet.ibm.com>
 <1416275216.1107.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416275216.1107.2.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Clarke <pc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 18, 2014 at 12:46:56PM +1100, Michael Ellerman wrote:
> On Mon, 2014-11-17 at 11:18 -0800, Paul E. McKenney wrote:
> > On Thu, Nov 13, 2014 at 01:42:12PM +1100, Michael Ellerman wrote:
> > > On Mon, 2014-11-10 at 14:58 -0600, Paul Clarke wrote:
> > > > On 11/10/2014 04:08 AM, Benjamin Herrenschmidt wrote:
> > > > > On Tue, 2014-10-07 at 14:13 -0500, Paul Clarke wrote:
> > > > >> This patch short-circuits the reset of the decrementer, exiting after
> > > > >> the decrementer reset, but before the housekeeping tasks if the only
> > > > >> need for the interrupt is simply to reset it.  After this patch,
> > > > >> the latency spike was measured at about 150 nanoseconds.
> > > > >
> > > > > Doesn't this break the irq_work stuff ? We trigger it with a set_dec(1);
> > > > > and your patch will probably cause it to be skipped...
> > > > 
> > > > You're right.
> > > 
> > > Yeah, thanks Ben, that would have been bad.
> > > 
> > > So we'll need to come up with a different approach.
> > 
> > If I am understanding this correctly, it underscores the need for more
> > bits in the decrementer register.  :-/
> 
> Yes that is the root cause of the problem :)

Sigh!!!  I was hoping!  ;-)

							Thanx, Paul
