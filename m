Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14960DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:44:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VFij3p006781
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:44:45 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFijfq064436
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:44:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VFiiWd025353
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:44:45 -0600
Subject: [PATCH 0/3] hotplug memory remove support for PPC64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1193771951.8904.22.camel@dyn9047017100.beaverton.ibm.com>
	<20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
	<20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:48:10 -0800
Message-Id: <1193849290.17412.29.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
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

Hi Paul/Andrew,

Here are few minor fixes needed to get hotplug memory remove working
on ppc64. Could you please consider them for -mm ?

	[PATCH 1/3] Add remove_memory() for ppc64
	[PATCH 2/3] Enable hotplug memory remove for ppc64
	[PATCH 3/3] Add arch-specific walk_memory_remove() for ppc64

I am able to successfully add/remove memory on ppc64 with these patches.
ZONE_MOVABLE guarantees the success, if we really really want to be able
to remove memory.

Thanks to Mel and KAME for doing all the real work :) 

TODO:
	- I am running into migrate_pages() issues on reiserfs backed
files. Nothing to do with ppc64.

Thanks,
Badari
