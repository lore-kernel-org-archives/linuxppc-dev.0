Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A93EAB6F9C
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 13:53:07 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1323750427.19891.59.camel@pasglop>
Date: Tue, 13 Dec 2011 20:53:25 -0600
Message-Id: <C9D58E47-96F4-45ED-BE54-758D71B361FD@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
 <1323314600.12793.19.camel@pasglop>
 <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
 <4BCA9D4A-4284-4DE8-95B9-D5DBA9254CC1@kernel.crashing.org>
 <1323750427.19891.59.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 12, 2011, at 10:27 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2011-12-12 at 21:55 -0600, Becky Bruce wrote:
>> 1) dma_direct_alloc_coherent strips GFP_HIGHMEM out of the flags =
field
>> when calling the actual allocator and the iotlb version does not.  I
>> don't know how much this matters - I did a quick grep and I don't see
>> any users that specify that, but somebody went through the trouble of
>> putting it in there in the first place and without knowing why I
>> wasn't willing to get rid of it.  Now, since my patch it looks like
>> someone added a VM_BUG_ON into __get_free_pages() if GFP_HIGHMEM so
>> this would get caught.  However, I don't know if we really want to
>> throw a bug there.
>>=20
>> 2)  The iotlb code doesn't deal with the !coherent parts like 8xx.  =
We
>> can work around that by setting up the dma_ops differently for that
>> case instead.
>=20
> Does the rest of it handle them ? I mean swiotlb_map_sg_attrs etc...

The non-coherent "specialness" is in the dma sync stuff and no, I don't =
think the iotlb stuff deals with that properly.

Do you not have a problem with 1)?  If not then I think we can look at =
switching over; 2) was more of a secondary thing.

-B
