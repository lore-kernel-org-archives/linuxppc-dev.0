Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0280DDE9B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 02:38:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7GGcqh3031132
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 12:38:52 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7GGcpPE246748
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 10:38:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7GGcpqD020445
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 10:38:51 -0600
Date: Thu, 16 Aug 2007 11:38:50 -0500
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
Message-ID: <20070816163850.GU4261@austin.ibm.com>
References: <20070816070922.37B5370074@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070816070922.37B5370074@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 16, 2007 at 05:09:22PM +1000, Michael Neuling wrote:
> This adds two items to the taststats struct to account for user and
> system time based on scaling the CPU frequency and instruction issue
> rates.
> 
> Adds account_(user|system)_time_scaled callbacks which architectures
> can use to account for time using this mechanism.

There's something simple here that I just don't understand.

>  /*
> + * Account scaled user cpu time to a process.
> + * @p: the process that the cpu time gets accounted to
> + * @cputime: the cpu time spent in user space since the last update
> + */
> +void account_user_time_scaled(struct task_struct *p, cputime_t cputime)
> +{
> +	p->utimescaled = cputime_add(p->utimescaled, cputime);
> +}

My gut impression (maybe wrong?) is that the scaled time is,
in a certain sense, "more accurate" than the unscaled time.
In fact, the unscaled time gives me the impression of being
rather meaningless, as it has no particular significance
with respect to the wall-clock, and it also doesn't give
any accurate hint of how much cpu resource was actually
consumed.

If one has a cpu with frequency scaling, then when would
one ever be interested in the non-scaled time? If the answer
is "never", then why not just always use the scaled time,
instead of adding more stuff to the kernel structs?

--linas
