Return-Path: <pbadari@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99EF7DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:21:08 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VFL2xx031505
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:21:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFGDcU112324
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:21:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VExBTC028910
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:59:11 -0600
Subject: Re: [RFC] hotplug memory remove - walk_memory_resource for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1193771951.8904.22.camel@dyn9047017100.beaverton.ibm.com>
	<20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
	<20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:02:40 -0800
Message-Id: <1193846560.17412.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	Paul Mackerras <paulus@samba.org>, linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-31 at 14:34 +0900, KAMEZAWA Hiroyuki wrote:
> On Wed, 31 Oct 2007 14:28:46 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > ioresource was good structure for remembering "which memory is conventional
> > memory" and i386/x86_64/ia64 registered conventional memory as "System RAM",
> > when I posted patch. (just say "System Ram" is not for memory hotplug.)
> > 
> If I remember correctly, System RAM is for kdump (to know which memory should
> be dumped.) Then, memory-hotadd/remove has to modify it anyway.

Yes. kdump uses it for finding memory holes on x86/x86-64 (not sure
about ia64). On PPC64, since its not represented in /proc/iomem, we
end up reading /proc/device-tree/memory* nodes to construct the 
memory map.

Paul's concern is, since we didn't need it so far - why we need this
for hotplug memory remove to work ? It might break API for *unknown*
applications. Its unfortunate that, hotplug memory add updates 
/proc/iomem. We can deal with it later, as a separate patch.

Thanks,
Badari
