Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C46E7B6FA6
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2011 03:01:11 +1100 (EST)
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111014183144.GD28556@local>
Date: Mon, 17 Oct 2011 11:00:55 -0500
Message-Id: <4D73F261-3795-4F71-9921-568C1B9F06E0@kernel.crashing.org>
References: <1318521058-15662-1-git-send-email-galak@kernel.crashing.org>
 <20111014183144.GD28556@local>
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
 Kai Jiang <Kai.Jiang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2011, at 1:31 PM, Hans J. Koch wrote:

> On Thu, Oct 13, 2011 at 10:50:58AM -0500, Kumar Gala wrote:
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>=20
>> To support >32-bit physical addresses for UIO_MEM_PHYS type we need =
to
>> extend the width of 'addr' in struct uio_mem.  Numerous platforms =
like
>> embedded PPC, ARM, and X86 have support for systems with larger =
physical
>> address than logical.
>>=20
>> Since 'addr' may contain a physical, logical, or virtual address the
>> easiest solution is to just change the type to 'phys_addr_t' which
>> should always be greater than or equal to the sizeof(void *) such =
that
>> it can properly hold any of the address types.
>>=20
>> For physical address we can support up to a 44-bit physical address =
on a
>> typical 32-bit system as we utilize remap_pfn_range() for the mapping =
of
>> the memory region and pfn's are represnted by shifting the address by
>> the page size (typically 4k).
>>=20
>> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> Signed-off-by: "Hans J. Koch" <hjk@hansjkoch.de>
>=20
> That looks good to me. There's an unnecessary cast (see below), but I =
fixed that
> on the way.
>=20
> Greg, please pull this from branch uio-for-gregkh from
>=20
> git://hansjkoch.de/git/linux-hjk
>=20
> Thanks,
> Hans

I think removing that cast is wrong:

drivers/uio/uio.c: In function 'uio_vma_fault':
drivers/uio/uio.c:637:26: warning: cast to pointer from integer of =
different size

- k
