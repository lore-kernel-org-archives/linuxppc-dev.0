Return-Path: <pbadari@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3F7BDDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 08:08:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9VK885n026108
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 16:08:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VL8QIN103284
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 15:08:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VL8QK8031596
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 15:08:26 -0600
Subject: Re: [PATCH 1/3] Add remove_memory() for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1193863502.6271.38.camel@localhost>
References: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
	<1193863502.6271.38.camel@localhost>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 14:11:55 -0800
Message-Id: <1193868715.17412.55.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, anton@au1.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-31 at 13:45 -0700, Dave Hansen wrote:
> On Wed, 2007-10-31 at 08:49 -0800, Badari Pulavarty wrote:
> > +#ifdef CONFIG_MEMORY_HOTREMOVE
> > +int remove_memory(u64 start, u64 size)
> > +{
> > +	unsigned long start_pfn, end_pfn;
> > +	unsigned long timeout = 120 * HZ;
> > +	int ret;
> > +	start_pfn = start >> PAGE_SHIFT;
> > +	end_pfn = start_pfn + (size >> PAGE_SHIFT);
> > +	ret = offline_pages(start_pfn, end_pfn, timeout);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(remove_memory);
> > +#endif /* CONFIG_MEMORY_HOTREMOVE */
> 
> Did someone go and copy the ia64 verion?  Tsk.  Tsk.  Bad Badari.  :)
> 
> Can we just make this a weak symbol in the generic mm/memory_hotplug.c?
> Or, make this the generic memory_remove() function int there and have an
> arch_remove_memory() hook called from there if the architectures need to
> tweak it?

Well, We don't need arch-specific remove_memory() for ia64 and ppc64.
x86_64, I don't know. We will know, only when some one does the
verification. I don't need arch_remove_memory() hook also at this time.

KAME and I agreed that, we will kill all this if no arch needs it (after
verifying it with x86/x86-64). No point adding all the infrastructure,
if no one needs it at the end.

Thanks,
Badari
