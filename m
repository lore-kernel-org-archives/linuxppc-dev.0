Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc: 64K page support for kexec
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <772e4d4c76807769449cf1bf874d2ce1@bga.com>
References: <1177626236.24866.99.camel@luke-laptop>
	, <1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 11:42:30 -0300
Message-Id: <1177684950.24866.121.camel@luke-laptop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-26 at 23:36 -0500, Milton Miller wrote:

> Was your development testing going from 64k to 64k base
> kernel?   Or 64k to 4k or 4k to 64k?   Did your development
> break 4k pages along the way?
> 

The test was from a 64K to 64K kernel.  The primary fix was to 4K
mappings as the PAGE_SHIFT macro resolves to 16, so the 4K page hash was
incorrectly applied.  The 16M and 64K pages were correctly cleared.
Presumably, this is the reason we had problems with I/O.

> The reason I ask is because when starting a similar kernel,
> I expect any failures of invalidating the kernel linear
> mapping to be mapped with the same mapping the next time.
> If you were going to a dissimilar kernel, or possibly a
> modular kernel with modules loaded in random order, I would
> expect incorrect io-mapping and vmalloc could also pose
> problems you mentioned.
> 
> It appears the distros want to use a similar kernel for
> their dump kernel.  The would prefer it be the same binary;
> I'm trying to influence people that it is a softer requirement
> than not slowing down the primary kernel.

Here's anon-related question.  What is the pSeries strategy for
automating the capture of the dump image and rebooting to a usable
kernel.  Has anybody provided a customized initrd for this purpose that
ultimately reboots the system to the default kernel. Seems like that is
more important in terms of minimizing downtime than inlining a function.

> I think a better way to debug this code is to call it from a
> debugfs hook or xmon dump command to scan the table and do
> the computation.  That code would have the full debugger to
> notice and print the assert.

I am not familiar with debugfs but I suspect that wasn't an option,
because the system hung immediately.  xmon was not invoked either.

> 
> Having a xmon function to dump the hash table or a slot
> might be useful for other purposes.
> 

agreed.

> If you think you need the assert, then I ask it be put under
> an ifdef or it not be triggered when kexec is called with
> panic=1  (ie BUG_ON(x && !panic).  Alternatively you could
> run the table with dry-run sometime between cpu_down and the
> kernel copy.

That is a good idea.  That way, people can use kexec -l to debug.

> 
> > > Appart from that,
> > >
> > > Acked-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> > >
> 
> milton
> 
