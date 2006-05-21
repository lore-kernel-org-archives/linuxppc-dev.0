Return-Path: <mel@csn.ul.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 987D267A3E
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 02:21:01 +1000 (EST)
Date: Sun, 21 May 2006 17:20:53 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
In-Reply-To: <200605202327.19606.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0605211709530.16327@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
	<20060520135922.129a481d.akpm@osdl.org>
	<200605202327.19606.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 20 May 2006, Andi Kleen wrote:

>
>> Anyway.  From the implementation I can see what the code is doing.  But I
>> see no description of what it is _supposed_ to be doing.  (The process of
>> finding differences between these two things is known as "debugging").  I
>> could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough.
>> I look forward to the next version ;)
>
> Or we could just keep the working old code.
>
> Can somebody remind me what this patch kit was supposed to fix or 
> improve again?
>

The current code for discovering the zone sizes and holes is sometimes 
very hairy despite there being some similaries in each arch. This patch 
kit will eliminiate some of the uglier code and have one place where zones 
and holes can be sized. To me, that is a good idea once the bugs are 
rattled out.

On a related note, parts of the current zone-based anti-fragmentation 
implementation are an architecture-specific mess because changing how 
zones are sized is tricky with the current code. With this patch kit, 
sizing zones for easily reclaimable pages is relatively straight-forward.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
