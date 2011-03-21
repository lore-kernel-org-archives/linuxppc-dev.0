Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D785B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 13:23:19 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
In-Reply-To: <alpine.LSU.2.00.1103201901340.7257@sister.anvils>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
	<1300672207.2402.205.camel@pasglop>
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 13:22:30 +1100
Message-ID: <1300674150.2402.207.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-20 at 19:20 -0700, Hugh Dickins wrote:
> > As long as the races to avoid are between map/unmap vs. access, yes, it
> > -should- be fine, and we used to not do demand faulting on kernel space
> > (but for how long ?). I'm wondering why we don't just stick a ptl in
> > there or is there a good reason why we can't ?
> 
> We can - but we usually prefer to avoid unnecessary locking.
> An arch function which locks init_mm.page_table_lock on powerpc,
> but does nothing on others? 

That still means gratuitous differences between how the normal and
kernel page tables are handled. Maybe that's not worth bothering ...

Cheers,
Ben.
