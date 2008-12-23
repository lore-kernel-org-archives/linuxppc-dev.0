Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EC3EDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 01:52:47 +1100 (EST)
Date: Tue, 23 Dec 2008 17:52:40 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1810068989.20081223175240@emcraft.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re[2]: [PATCH] mm/shmem.c: fix division by zero
In-Reply-To: <Pine.LNX.4.64.0812230016510.13610@blonde.anvils>
References: <200812190844.57996.yur@emcraft.com>
	<Pine.LNX.4.64.0812230016510.13610@blonde.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	viro@zeniv.linux.org.uk, Geert.Uytterhoeven@sonycom.com,
	yanok@emcraft.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Hugh,

On Tuesday, December 23, 2008 you wrote:

> On Fri, 19 Dec 2008, Yuri Tikhonov wrote:
>>=20
>> The following patch fixes division by zero, which we have in
>> shmem_truncate_range() and shmem_unuse_inode(), if use big
>> PAGE_SIZE values (e.g. 256KB on ppc44x).
>>=20
>> With 256KB PAGE_SIZE the ENTRIES_PER_PAGEPAGE constant becomes
>> too large (0x1.0000.0000), so this patch just changes the types
>> from 'ulong' to 'ullong' where it's necessary.
>>=20
>> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>

> Sorry for the slow reply, but I'm afraid I don't like spattering
> around an increasing number of unsigned long longs to fix that division
> by zero on an unusual configuration: I doubt that's the right solution.

> It's ridiculous for shmem.c to be trying to support a wider address
> range than the page cache itself can support, and it's wasteful for
> it to be using 256KB pages for its index blocks (not to mention its
> data blocks! but we'll agree to differ on that).

> Maybe it should be doing a kmalloc(4096) instead of using alloc_pages();
> though admittedly that's not a straightforward change, since we do make
> use of highmem and page->private.  Maybe I should use this as stimulus
> to switch shmem over to storing its swap entries in the pagecache radix
> tree.  Maybe we should simply disable its use of swap in such an
> extreme configuration.

> But I need to understand more about your ppc44x target to make
> the right decision.  What's very strange to me is this: since
> unsigned long long is the same size as unsigned long on 64-bit,
> this change appears to be for a 32-bit machine with 256KB pages.
> I wonder what market segment that is targeted at?

 Right, sizeof(unsigned long long)=3D=3D8 on our ppc44x target.

 The main processor here is a PPC440SPe from AMCC, which is a 32-bit=20
RISC machine with 36-bit physical addressing.=20

 The market segment for this are RAID applications. The Linux s/w RAID=20
driver had been significantly reworked over the last years, and now it
allows efficiently offload the RAID-related operations (as well as=20
the data copy) from CPU to the dedicated engines via  ASYN_TX/ADMA=20
API. The 440SPe controller has a reach RAID-related peripheral=20
integrated on chip: XOR engine and two DMA engines with different=20
capabilities including XOR calculations/checks for RAID5/6, PQ=20
parities calculations/checks for RAID6, memory copy, and so on. All=20
these make 440SPe to be a good choice for developing RAID storage=20
applications.

 By increasing the PAGE_SIZE we improve the performance of RAID=20
operations, because the RAID stripes (on which basic the Linux RAID=20
driver operates) have a PAGE_SIZE width: so, the bigger the strip is,=20
then the less CPU cycles are necessary to process the same chunk of=20
data. The value of improvement differs from case to case, and has the=20
maximum number in such cases like sequential writes.

 For example, on the ppc440spe-base Katmai board we observe the=20
following performance distribution of sequential writes to RAID-5=20
built on 16 drives (actually, we can achieve higher performance if=20
skipping RAID caching of the data; the following figures are measured=20
involving the RAID caching):

  4K PAGE_SIZE:   s/w:  84 MBps;  h/w accelerated: 172 MBps
 16K PAGE_SIZE:   s/w: 123 MBps;  h/w accelerated: 361 MBps
 64K PAGE_SIZE:   s/w: 125 MBps;  h/w accelerated: 409 MBps
256K PAGE_SIZE:   s/w: 132 MBps;  h/w accelerated: 473 MBps

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
