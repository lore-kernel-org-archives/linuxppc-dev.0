Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 339CDDE0E4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 00:46:17 +1100 (EST)
Date: Tue, 10 Mar 2009 13:46:10 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: 2.6.29-rc7-git2 : crash in kmem_list3_init()
Message-ID: <20090310134610.GB13020@csn.ul.ie>
References: <49B5448B.6030205@in.ibm.com> <49B60371.7050508@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <49B60371.7050508@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cl@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 11:36:41AM +0530, Sachin P. Sant wrote:
> Sachin P. Sant wrote:
>> sure if this is a new problem or a recurring one. Will try booting
>> some older kernels on this box and will report the results.
> I tried few older kernels till 2.6.28 and all of them had the
> same problem.
>

Well, the machine must have started with some kernel. What mainline
version does that correspond to and can you bisect it?

What is the base page size of the test kernel - 4K or 64K? Depending on
which one it is, the start of node 1 may not be MAX_ORDER-aligned, gets
overlapped with node-0 and goes downhill from there.

> I also tried using SLUB instead of SLAB. That also failed to
> boot with following trace.
>
> Unable to handle kernel paging request for data at address 0xc000000070001030
> Faulting instruction address: 0xc00000000011c7e0
> cpu 0x0: Vector: 300 (Data Access) at [c000000000ac39a0]
>    pc: c00000000011c7e0: .new_slab+0x2b8/0x33c
>    lr: c00000000011c7dc: .new_slab+0x2b4/0x33c
>    sp: c000000000ac3c20
>   msr: 8000000000009032
>   dar: c000000070001030
> dsisr: 42000000
>  current = 0xc0000000009ea4b0
>  paca    = 0xc000000000b53480
>    pid   = 0, comm = swapper
> enter ? for help
> [c000000000ac3cc0] c00000000011dc28 .kmem_cache_open+0x1a4/0x448
> [c000000000ac3d90] c00000000011f5dc .create_kmalloc_cache+0x78/0x100
> [c000000000ac3e40] c000000000948bec .kmem_cache_init+0x8c/0x1c8
> [c000000000ac3ee0] c000000000920a5c .start_kernel+0x360/0x480
> [c000000000ac3f90] c0000000000083d8 .start_here_common+0x1c/0x44
>
> Complete dmesg log attached. Is there anything else i can try ?
>
