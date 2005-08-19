Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id A4AF5680D8
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Aug 2005 01:28:14 +1000 (EST)
Received: from [192.168.1.7] (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id j7JFHIl32232
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2005 08:17:18 -0700
Message-ID: <4305F7FE.7040709@icarus.com>
Date: Fri, 19 Aug 2005 08:17:18 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: How to map memory uncached on PPC.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


My setup is Linux PPC kernel 2.4.30 on an embedded PPC405BPr.
The board has some image processing devices including compressors.
I'm working with high image rates so performance is a issue.

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
- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDBff9rPt1Sc2b3ikRApayAKDboAm10TN8kN3XLtNOFvoYYC/xNwCgx3Nw
ZyHhUzk3xC8/EMBxLD8odtk=
=QrII
-----END PGP SIGNATURE-----
