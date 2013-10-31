Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AEC5D2C03C3
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 15:35:58 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 30 Oct 2013 22:35:53 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BCBA819D8041
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 22:35:47 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9V4Zopi257952
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 22:35:50 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9V4cesc012122
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 22:38:41 -0600
Date: Wed, 30 Oct 2013 21:33:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131031043346.GR4126@linux.vnet.ibm.com>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131030155116.GO16117@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131030155116.GO16117@laptop.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 04:51:16PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2013 at 03:28:54PM +0200, Victor Kaplansky wrote:
> > one of the authors of Documentation/memory-barriers.txt is on cc: list ;-)
> > 
> > Disclaimer: it is anyway impossible to prove lack of *any* problem.
> > 
> > Having said that, lets look into an example in
> > Documentation/circular-buffers.txt:
> 
> > 
> > We can see that authors of the document didn't put any memory barrier
> 
> Note that both documents have the same author list ;-)
> 
> Anyway, I didn't know about the circular thing, I suppose I should use
> CIRC_SPACE() thing :-)

Interesting that we didn't seem to supply a definition...  ;-)

							Thanx, Paul
