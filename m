Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id ABD4E67F92
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Aug 2005 01:59:44 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7KFxgl13544
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Aug 2005 08:59:42 -0700
Message-ID: <4307536E.4070800@icarus.com>
Date: Sat, 20 Aug 2005 08:59:42 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <4305F7FE.7040709@icarus.com> <1124499963.5197.99.camel@gaston>
In-Reply-To: <1124499963.5197.99.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: How to map memory uncached on PPC.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> On Fri, 2005-08-19 at 08:17 -0700, Stephen Williams wrote:
>>I did some measurements, at it seems that the vast amount of
>>the time is spent in pci_map_single, which calls only the
>>consistent_sync function, which for FROMDEVICE calls only
>>invalidate_dcache_range. So I'm convinced that invalidating
>>the cache for the output buffer (which is large, in case the
>>image that arrives is large) is taking most of the time. So
>>I want to eliminate it.

> A simple experiment you can do is limit the memory used by the kernel
> (booting with mem=xxxx) and then use mmap of /dev/mem to map the
> remaining memory like if it was an IO device, uncached. With that, you
> get a quick hack solution to validate the performance benefit at least.

I did an even simpler experiment: I commented out the pci_map_single,
which on a PPC only has the effect of calling invalidate_dcache_range
and returning the virt_to_bus of the address. Obviously, the cache
is still enabled for the processor, and the image data may get
corrupted, but this was a performance test, not a solution.

Your "test" is a not implausible solution, although it has for me
some administrative problems.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
