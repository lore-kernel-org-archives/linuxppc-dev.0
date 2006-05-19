Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hellhawk.shadowen.org",
	Issuer "hellhawk.shadowen.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E7B3A67A40
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:24:45 +1000 (EST)
Message-ID: <446DD4CA.30606@shadowen.org>
Date: Fri, 19 May 2006 15:23:06 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<Pine.LNX.4.64.0605191447060.29077@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0605191447060.29077@skynet.skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, ak@suse.de, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman wrote:
> On Sun, 14 May 2006, Andrew Morton wrote:
> 
>> Mel Gorman <mel@csn.ul.ie> wrote:
>>
>>>
>>> Size zones and holes in an architecture independent manner for ia64.
>>>
>>
>> This one makes my ia64 die very early in boot.   The trace is pretty
>> useless.
>>
>> config at http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
>>
> 
> An indirect fix for this has been set out with a patchset with the
> subject "[PATCH 0/2] Fixes for node alignment and flatmem assumptions" .
> For arch-independent-zone-sizing, the issue was that FLATMEM assumes
> that NODE_DATA(0)->node_start_pfn == 0. This is not the case with
> arch-independent-zone-sizing and IA64. With
> arch-independent-zone-sizing, a nodes node_start_pfn will be at the
> first valid PFN.
> 
>> <log snipped>
>>
>> Note the misaligned pfns.
>>
> 
> You will still get the message about misaligned PFNs on IA64. This is
> because the lowest zone starts at the lowest available PFN which may not
> be 0 or any other aligned number. It shouldn't make a different - or at
> least I couldn't cause any problems.

With the updates I sent out to the zone alignment checks yesterday this
should now be ignored correctly without comment.  The first zone is
allowed to be misaligned because we expect alignment of the mem_map.
With bob picco's patch from your set we ensure it is so.

-apw
