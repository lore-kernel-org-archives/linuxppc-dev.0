Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id AD763680CE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 02:28:14 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7JGIHl00318
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Aug 2005 09:18:17 -0700
Message-ID: <43060649.6060507@icarus.com>
Date: Fri, 19 Aug 2005 09:18:17 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: How to map memory uncached on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My setup is Linux PPC kernel 2.4.30 on an embedded PPC405GPr.
The board has some image processing devices including compressors.
I'm working with high image rates so performance is an issue.

The drivers for the pci based compressor chips support readv
and use map_user_kiobuf and pci_map_single to map the output
buffers for the read. (The devices do scatter DMA.) This is
too slow, though. More time is spent mapping then compressing!

I did some measurements, at it seems that the vast amount of
the time is spent in pci_map_single, which calls only the
consistent_sync function, which for FROMDEVICE calls only
invalidate_dcache_range. So I'm convinced that invalidating
the cache for the output buffer (which is large, in case the
image that arrives is large) is taking most of the time. So
I want to eliminate it.

And the way I want to do that is to have a heap of memory in
the user-mode process mapped uncached. The hope is that I can
pass that through the readv to the driver, which sets up the
DMA. Then I can skip the pci_map_single (and the thus the
invalidate_dcache_range) thus saving lots of time.

Plan-B would be to have a driver allocate the heap of memory,
but I really need the mapping into user mode to be uncached,
as the processor does some final touch up (header et al) before
sending it to the next device.
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
