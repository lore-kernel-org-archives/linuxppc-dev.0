Return-Path: <cody@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E6612C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 08:19:58 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Mon, 3 Feb 2014 14:19:56 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4734F19D8048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 14:19:55 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13LJtsp3539304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 22:19:55 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s13LNDsw008344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 14:23:13 -0700
Message-ID: <52F007EE.3090500@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 13:19:42 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/8] perf: add PMU_RANGE_ATTR() helper for use by sw-like
 pmus
References: <20140201055805.6FF982C00AF@ozlabs.org>
In-Reply-To: <20140201055805.6FF982C00AF@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2014 09:58 PM, Michael Ellerman wrote:
> On Thu, 2014-16-01 at 23:53:47 UTC, Cody P Schafer wrote:
>> Add PMU_RANGE_ATTR() and PMU_RANGE_RESV() (for reserved areas) which
>> generate functions to extract the relevent bits from
>> event->attr.config{,1,2} for use by sw-like pmus where the
>> 'config{,1,2}' values don't map directly to hardware registers.
>
> This is neat.
>
> The split of the macros is a bit weird, ie. PMU_RANGE_RESV() doesn't really do
> what it's name suggests.
>
> I think you want one macro which creates the accessors, with a name that
> reflects that - yeah I can't think of a good one right now, but "event" should
> probably be in there because that's what it operates on.
>
> Having a macro for the reserved regions is good, but you MUST actually check
> that the reserved regions are zero. Otherwise you are permitting your caller to
> pass junk in there and you then can't unreserved them in a future version of
> the API.
>
> So I think a macro that gives you a special reserved region routine would be
> good, so you can write something like:
>
>    if (event_check_reserved1() || event_check_reserved2())
>    	return -EINVAL;
>

The way it's set up right now, RESV is just a hint to the user of the 
PMU_RANGE_ATTR() and PMU_RANGE_RESV() macros to indicate which to use. 
RESV simply avoids creating an attr format which would go unused only in 
the case where the range is a reserved one (and gcc would complain about 
it).

I don't like the "event_check_foo()" bit because that is actually 
identical to "event_get_foo()", I don't see a point in generating 
differently named functions that do exactly the same thing.

The current user (hv-24x7.c) of PMU_RANGE_RESV() already does the 
appropriate checking:

	if (event_get_reserved1(event) ||
	    event_get_reserved2(event) ||
	    event_get_reserved3(event)) {
		pr_devel("reserved set when forbidden 0x%llx(0x%llx) 0x%llx(0x%llx) 
0x%llx(0x%llx)\n",
				event->attr.config,
				event_get_reserved1(event),
				event->attr.config1,
				event_get_reserved2(event),
				event->attr.config2,
				event_get_reserved3(event));
		return -EINVAL;
	}
