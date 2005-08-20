Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1635667F92
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Aug 2005 11:10:31 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Williams <steve@icarus.com>
In-Reply-To: <4305F7FE.7040709@icarus.com>
References: <4305F7FE.7040709@icarus.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 11:06:03 +1000
Message-Id: <1124499963.5197.99.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to map memory uncached on PPC.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-08-19 at 08:17 -0700, Stephen Williams wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> My setup is Linux PPC kernel 2.4.30 on an embedded PPC405BPr.
> The board has some image processing devices including compressors.
> I'm working with high image rates so performance is a issue.
> 
> The drivers for the pci based compressor chips support readv
> and use map_user_kiobuf and pci_map_single to map the output
> buffers for the read. (The devices do scatter DMA.) This is
> too slow, though. More time is spent mapping then compressing!
> 
> I did some measurements, at it seems that the vast amount of
> the time is spent in pci_map_single, which calls only the
> consistent_sync function, which for FROMDEVICE calls only
> invalidate_dcache_range. So I'm convinced that invalidating
> the cache for the output buffer (which is large, in case the
> image that arrives is large) is taking most of the time. So
> I want to eliminate it.
> 
> And the way I want to do that is to have a heap of memory in
> the user-mode process mapped uncached. The hope is that I can
> pass that through the readv to the driver, which sets up the
> DMA. Then I can skip the pci_map_single (and the thus the
> invalidate_dcache_range) thus saving lots of time.
> 
> Plan-B would be to have a driver allocate the heap of memory,
> but I really need the mapping into user mode to be uncached,
> as the processor does some final touch up (header et al) before
> sending it to the next device.

A simple experiment you can do is limit the memory used by the kernel
(booting with mem=xxxx) and then use mmap of /dev/mem to map the
remaining memory like if it was an IO device, uncached. With that, you
get a quick hack solution to validate the performance benefit at least.

Ben.
