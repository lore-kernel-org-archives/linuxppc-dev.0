Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4CB78DDE0C
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2007 04:39:34 +1000 (EST)
Message-ID: <467D68D5.6070202@am.sony.com>
Date: Sat, 23 Jun 2007 11:39:17 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>	
	<200706182314.26918.arnd@arndb.de>	
	<F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>	
	<46771140.5000205@am.sony.com>	
	<7F58A02C-5C4C-4717-8D32-65C75C342ADB@pobox.com>
	<1182216218.26853.305
In-Reply-To: <1182216218.26853.305.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2007-06-18 at 20:13 -0400, Jimi Xenidis wrote:
>> > When CONFIG_PS3_USE_LPAR_ADDR=n a translation in the platform code
>> > sets up the page table to map the region to low addresses
>> (continuous
>> > with the boot mem region), but that translation is not compatible
>> > with the mapping scheme used by the spu regions, which use sparse
>> mem.
>> 
>> hmm.. sparse mem is for the linear map. 
> 
> SPE local store used to have special struct pages for it in order to
> return things from nopage(). It was dodgy and racy. I killed that
> recently, it was causing more problem than it was solving. So it should
> be fine now. I'm now using nopfn() and inserting the PTEs directly from
> the nopfn() hook.
> 
> So Geoff, you can remove the option for now or make it n by default.

OK, I'll look into it after I return from OLS.

-Geoff
