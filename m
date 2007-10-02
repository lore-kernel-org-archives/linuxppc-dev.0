Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound9-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 07D6CDDFC4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 06:50:18 +1000 (EST)
Message-ID: <4702AF03.6080206@am.sony.com>
Date: Tue, 02 Oct 2007 13:50:11 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>	
	<4702A5FE.5000308@am.sony.com>
	<1191357435.6106.31.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1191357435.6106.31.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
> On Tue, 2007-10-02 at 13:11 -0700, Geoff Levand wrote:
>> Hi Badari,
>> 
>> Badari Pulavarty wrote:
>> > Hi Paul & Ben,
>> > 
>> > I am trying to get hotplug memory remove working on ppc64.
>> > In order to verify a given memory region, if its valid or not -
>> > current hotplug-memory patches used /proc/iomem. On IA64 and
>> > x86-64 /proc/iomem shows all memory regions. 
>> > 
>> > I am wondering, if its acceptable to do the same on ppc64 also ?
>> > Otherwise, we need to add arch-specific hooks in hotplug-remove
>> > code to be able to do this.
>> 
>> 
>> It seems the only reasonable place is in /proc/iomem, as the the 
>> generic memory hotplug routines put it in there, and if you have
>> a ppc64 system that uses add_memory() you will have mem info in
>> several places, none of which are complete.  
> 
> Well, this information exists in various places (lmb structures
> in the kernel), /proc/device-tree for various users. I want to
> find out what ppc experts think about making this available through
> /proc/iomem also since generic memory hotplug routines expect 
> it there.


Well, I can't say I am one of those experts you seek, but for PS3 we
already have the hotplug mem in /proc/iomem (I set it up to use
add_memory()), so it seems reasonable to have the bootmem there too.

-Geoff
