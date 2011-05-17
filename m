Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34D1F1007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 19:39:07 +1000 (EST)
Subject: Re: [PATCH 12/13] kvm/powerpc: Accelerate H_PUT_TCE by implementing
	it in real mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1305624945.2781.21.camel@pasglop>
Date: Tue, 17 May 2011 11:39:01 +0200
Message-Id: <4E3B7F59-3865-4B4F-930E-CB149B099D64@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104615.GM2837@brick.ozlabs.ibm.com>
	<E9A07C6B-00BC-490F-95E7-5B025A626C98@suse.de>
	<1305623510.2781.20.camel@pasglop>
	<E483EC5C-5F4A-4783-88D2-1728BD902037@suse.de>
	<1305624945.2781.21.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.05.2011, at 11:35, Benjamin Herrenschmidt wrote:

> On Tue, 2011-05-17 at 11:31 +0200, Alexander Graf wrote:
>> On 17.05.2011, at 11:11, Benjamin Herrenschmidt wrote:
>>=20
>>> On Tue, 2011-05-17 at 10:01 +0200, Alexander Graf wrote:
>>>> I'm not sure I fully understand how this is supposed to work. If =
the
>>>> tables are kept inside the kernel, how does userspace get to know
>>>> where to DMA to?
>>>=20
>>> The guest gets a dma range from the device-tree which is the range =
of
>>> device-side dma addresses it can use that correspond to the table.
>>>=20
>>> The guest kernel uses the normal linux iommu space allocator to =
allocate
>>> space in that region and uses H_PUT_TCE to populate the =
corresponding
>>> table entries.
>>>=20
>>> This is the same interface that is used for "real" iommu's with PCI
>>> devices btw.
>>=20
>> I'm still slightly puzzled here :). IIUC the main point of an IOMMU =
is for the kernel
>> to change where device accesses actually go to. So device DMAs =
address A, goes through
>> the IOMMU, in reality accesses address B.
>=20
> Right :-)
>=20
>> Now, how do we tell the devices implemented in qemu that they're =
supposed to DMA to
>> address B instead of A if the mapping table is kept in-kernel?
>=20
> Oh, bcs qemu mmaps the table :-)

That's the piece to the puzzle I was missing. Please document that =
interface properly - it needs to be rock stable :)


Alex
