Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D01EFB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Apr 2010 08:02:40 +1000 (EST)
Subject: Re: Possible bug with mutex adaptative spinning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1271453251.1674.485.camel@laptop>
References: <1271212509.13059.135.camel@pasglop>
	<1271213767.13059.137.camel@pasglop> <1271453251.1674.485.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Apr 2010 08:01:32 +1000
Message-ID: <1271455292.13059.198.camel@pasglop>
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

On Fri, 2010-04-16 at 23:27 +0200, Peter Zijlstra wrote:
> > If the owner is actually running, it may do so for a very long time. It
> > looks to me that everybody trying to take the mutex will thus spin and
> > never get out of the spin loop until the owner stops running.
> 
> The inner-most spin loop breaks out on need_resched():
> 
>                 if (task_thread_info(rq->curr) != owner || need_resched())
>                         return 0; 

You are right, this was only a problem in conjunction with the other bug
returning 1 all the time, causing us to ignore need_resched(). With
that fixed, it looks fine now.

Thanks !

Cheers,
Ben.
