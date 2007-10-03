Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail9.fujitsu.co.jp (fgwmail9.fujitsu.co.jp [192.51.44.39])
	by ozlabs.org (Postfix) with ESMTP id 7CC6ADDF78
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 11:36:25 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	l931HW4s020956 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Wed, 3 Oct 2007 10:17:32 +0900
Date: Wed, 3 Oct 2007 10:19:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
Message-Id: <20071003101954.52308f22.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1191366653.6106.68.camel@dyn9047017100.beaverton.ibm.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1191366653.6106.68.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 02 Oct 2007 16:10:53 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > Otherwise, we need to add arch-specific hooks in hotplug-remove
> > > code to be able to do this.
> > 
> > Isn't it just a matter of abstracting the test for a valid range of
> > memory?  If it's really hard to abstract that, then I guess we can put
> > RAM in iomem_resource, but I'd rather not.
> > 
> 
> Sure. I will work on it and see how ugly it looks.
> 
> KAME, are you okay with abstracting the find_next_system_ram() and
> let arch provide whatever implementation they want ? (since current
> code doesn't work for x86-64 also ?).
> 
Hmm, registering /proc/iomem is complicated ? If too complicated, adding config
like
CONFIG_ARCH_SUPPORT_IORESOURCE_RAM or something can do good work.
you can define your own "check_pages_isolated" (you can rename this to
arch_check_apges_isolated().)


BTW, I shoudl ask people how to describe conventional memory

A. #define IORESOURCE_RAM		IORESOURCE_MEM	(ia64)
B. #define IORESOURCE_RAM		IORESOURCE_MEM | IORESOUCE_BUSY	(i386, x86_64)

Sad to say, memory hot-add registers new memory just as IORESOURCE_MEM.

Thanks,
-Kame
