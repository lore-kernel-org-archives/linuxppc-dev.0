Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 624FEDDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:33:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l93FX6tX005539
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 11:33:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l93FWvJ8416536
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 09:32:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l93FWt7B010739
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 09:32:57 -0600
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
From: Badari Pulavarty <pbadari@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20071003101954.52308f22.kamezawa.hiroyu@jp.fujitsu.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1191366653.6106.68.camel@dyn9047017100.beaverton.ibm.com>
	<20071003101954.52308f22.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 08:35:35 -0700
Message-Id: <1191425735.6106.76.camel@dyn9047017100.beaverton.ibm.com>
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

On Wed, 2007-10-03 at 10:19 +0900, KAMEZAWA Hiroyuki wrote:
> On Tue, 02 Oct 2007 16:10:53 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > > Otherwise, we need to add arch-specific hooks in hotplug-remove
> > > > code to be able to do this.
> > > 
> > > Isn't it just a matter of abstracting the test for a valid range of
> > > memory?  If it's really hard to abstract that, then I guess we can put
> > > RAM in iomem_resource, but I'd rather not.
> > > 
> > 
> > Sure. I will work on it and see how ugly it looks.
> > 
> > KAME, are you okay with abstracting the find_next_system_ram() and
> > let arch provide whatever implementation they want ? (since current
> > code doesn't work for x86-64 also ?).
> > 
> Hmm, registering /proc/iomem is complicated ?

Its not complicated. Like Paul mentioned, its part of user/kernel API
which he is not prefering to break (if possible) + /proc/iomem seems
like a weird place to export conventional memory.

>  If too complicated, adding config
> like
> CONFIG_ARCH_SUPPORT_IORESOURCE_RAM or something can do good work.
> you can define your own "check_pages_isolated" (you can rename this to
> arch_check_apges_isolated().)

I was thinking more in the lines of 

CONFIG_ARCH_HAS_VALID_MEMORY_RANGE. Then define own
find_next_system_ram() (rename to is_valid_memory_range()) - which
checks the given range is a valid memory range for memory-remove
or not. What do you think ?

Thanks,
Badari
