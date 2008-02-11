Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id F1337DDE37
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 18:54:25 +1100 (EST)
Date: Mon, 11 Feb 2008 01:07:39 -0600
From: Milton Miller <miltonm@bga.com>
To: david@gibson.dropbear.id.au, grant.likely@secretlab.ca,
Subject: Re: [RFC][POWERPC] bootwrapper: Add a firmware-independent
Message-Id: <31202713659663348734.1957747793.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, Feb 8, 2008 David Gibson wrote:
> On Fri, Feb 01, 2008 at 11:55:42PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely at secretlab.ca>

[snip]
>> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>> +   unsigned long r6, unsigned long r7)
>> +{
>> +const u32 *na, *ns, *reg, *timebase;
>> +u64 memsize64;
>> +int node, size, i;
>> +
>> +/* Allocate initial heap for probing the tree */
>> +simple_alloc_init(initial_heap, sizeof(initial_heap), 32, 64);
>> +
>> +/* Make sure FDT blob is sane */
>> +if (fdt_check_header(_dtb_start) != 0)
>> +fatal("Invalid device tree blob\n");
> 
> I think most of these fatal()s are pretty pointless.  This is
> platform_init(), so the console won't even have been initialized to
> actually print any of the messages.  Precisely because this is
> simpleboot, in which every bit of information the wrapper has comes
> from teh device tree, if the provided blob is so bad as to fail these
> basic tests, we're totally stuffed anyway.  It'll take a hardware
> debugger to track down, and I don't think the fatal()s will actually
> help much at that point.


My experience is the opposite: fatal is very useful even with a hardware debugger.  Since the code knows what is wrong, one only has to get the printf assembly buffer out of the map and dump it out.  Also, one can find which function called fatal from the nia and/or lr.  Much much easier than figuring out what happend when the prcessor jumps into the middle of code because it took an exception.

Also, one can patch in a debug output routine, possibly even in the __zlib_init.  Having the assertions is good.

That said, we should be conservative in calling something an error.

milton
