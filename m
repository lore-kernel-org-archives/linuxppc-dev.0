Return-Path: <cotte@de.ibm.com>
Message-ID: <46815286.1010808@de.ibm.com>
Date: Tue, 26 Jun 2007 19:53:10 +0200
From: Carsten Otte <cotte@de.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [patch 3/5] cell: updated driver for DDR2 memory
	on AXON
References: <OF39A5D2DB.6FC50A30-ONC1257306.0051B925-C1257306.0052040B@de.ibm.com>
	<200706261821.06516.arnd@arndb.de>
In-Reply-To: <200706261821.06516.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
Reply-To: carsteno@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> What will actually happen if you try to mount an axonram device with ext2?
> I suppose mount should fail with a proper error code if the block size is
> larger than 4kb, but does that happen?
> 
> If you have a 4k block size axonram device, the ext2 really should work
> using XIP as expected, including the mmap() operation.
> 
Absolutely. What's the symptom if you try mount -o xip? I am willing 
to fix any bugs that show in the ext2/xip code in that scenario...

>> We have the direct_access method here only because it is needed for the
>> azfs file-system, which we recommend to use for accessing the Axon's RAM
>> rather then ext2 or any other buffered file-systems.
> 
> I think I've understood what the problem is now. The generic xip code
> assumes that the data to be mapped has a 'struct page' in mem_map,
> and that it's part of the linear kernel mapping. This is actually
> true on s390, where it is currently used, but not for us. The point
> on s390 is that the kernel virtual address is _identical_ to the
> physical address, so it may never have shown up as a problem.
> 
> I'll talk to Carsten about this, he already had plans to remove
> the need for struct page from the filemap_xip infrastructure.
Removing the need for struct page is indeed impossible with current 
memory management because of the fact that VM_PFNMAP vmas have the 
downside that they require a linear physical image of the vma. Ext2 
does not comply to that requriement, a given file may be spread all 
over a media.
