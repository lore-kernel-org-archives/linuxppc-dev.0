Return-Path: <michael@ozlabs.org>
In-Reply-To: <1389916434-2288-2-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/8] perf: add PMU_RANGE_ATTR() helper for use by sw-like
 pmus
Message-Id: <20140201055805.6FF982C00AF@ozlabs.org>
Date: Sat,  1 Feb 2014 16:58:05 +1100 (EST)
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-16-01 at 23:53:47 UTC, Cody P Schafer wrote:
> Add PMU_RANGE_ATTR() and PMU_RANGE_RESV() (for reserved areas) which
> generate functions to extract the relevent bits from
> event->attr.config{,1,2} for use by sw-like pmus where the
> 'config{,1,2}' values don't map directly to hardware registers.

This is neat.

The split of the macros is a bit weird, ie. PMU_RANGE_RESV() doesn't really do
what it's name suggests.

I think you want one macro which creates the accessors, with a name that
reflects that - yeah I can't think of a good one right now, but "event" should
probably be in there because that's what it operates on.

Having a macro for the reserved regions is good, but you MUST actually check
that the reserved regions are zero. Otherwise you are permitting your caller to
pass junk in there and you then can't unreserved them in a future version of
the API.

So I think a macro that gives you a special reserved region routine would be
good, so you can write something like:

  if (event_check_reserved1() || event_check_reserved2())
  	return -EINVAL;


cheers
