Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05B64B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 13:20:35 +1100 (EST)
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com
	[172.24.198.69]) by smtp-out.google.com with ESMTP id p2L2KTZT019969
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2011 19:20:29 -0700
Received: from iyf40 (iyf40.prod.google.com [10.241.50.104])
	by wpaz5.hot.corp.google.com with ESMTP id p2L2KSDQ023487
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2011 19:20:28 -0700
Received: by iyf40 with SMTP id 40so7791618iyf.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 19:20:28 -0700 (PDT)
Date: Sun, 20 Mar 2011 19:20:18 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
In-Reply-To: <1300672207.2402.205.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1103201901340.7257@sister.anvils>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
	<1300672207.2402.205.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 Mar 2011, Benjamin Herrenschmidt wrote:
> 
> As long as the races to avoid are between map/unmap vs. access, yes, it
> -should- be fine, and we used to not do demand faulting on kernel space
> (but for how long ?). I'm wondering why we don't just stick a ptl in
> there or is there a good reason why we can't ?

We can - but we usually prefer to avoid unnecessary locking.
An arch function which locks init_mm.page_table_lock on powerpc,
but does nothing on others?

Hugh
