Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE4B7B7D13
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Apr 2010 07:27:38 +1000 (EST)
Received: from e35131.upc-e.chello.nl ([213.93.35.131]
	helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O2t4X-0005oP-Sa
	for linuxppc-dev@lists.ozlabs.org; Fri, 16 Apr 2010 21:27:34 +0000
Subject: Re: Possible bug with mutex adaptative spinning
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1271213767.13059.137.camel@pasglop>
References: <1271212509.13059.135.camel@pasglop>
	<1271213767.13059.137.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 23:27:31 +0200
Message-ID: <1271453251.1674.485.camel@laptop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 12:56 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-04-14 at 12:35 +1000, Benjamin Herrenschmidt wrote:
> > Hi Peter !
> > 
> > I -may- have found a bug with mutex adaptative spinning. We hit it when
> > torture testing CPU unplug.
> 
>  .../...
> 
> In fact, I wonder if there's another potential problem:
> 
> If the owner is actually running, it may do so for a very long time. It
> looks to me that everybody trying to take the mutex will thus spin and
> never get out of the spin loop until the owner stops running.

The inner-most spin loop breaks out on need_resched():

                if (task_thread_info(rq->curr) != owner || need_resched())
                        return 0;
