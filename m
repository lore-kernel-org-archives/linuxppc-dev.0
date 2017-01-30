Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBcJ60qYKzDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:44:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash: Properly mask the ESID bits when
 building proto-VSID
In-Reply-To: <20170128154840.32468-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170128154840.32468-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 15:44:53 +1100
Message-ID: <87r33lw3zu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> proto-vsid is built using both mmu context id and ESID. We should not have
> overlapping bits between those. That will result in us having vsid
> collision. With the current code we missed masking the top bits of effective
> address. This implies for kernel address we ended up using the top 4 bits
> as part of proto-vsid, which is wrong. For the kernel we should have the
> below mapping
>
> 0xf000000000000000 -> 0x7ffff  (19 bits context + 6 bits ESID ).
>
> Without the patch we endup with
> 0xf000000000000000 ->  0xf7ffff (0x7ffff | 0xf00000)

As discussed offline, this is missing the << 6.

Which means we end up with:

  ea         = 0xf000000000000000
  context    = 0x7ffff 
  proto_vsid = (0x7ffff << 6 | 0xf000000000000000 >> 40)
             = (0x1ffffc0 | 0xf00000)
             =  0x1ffffc0

ie. the proto-vsid is not affected by the extra bits. Same is true for
the 0xc/d/e regions.

So there is no bug here, as long as we use the current mapping from
kernel EA to context ID.

I'll merge this into next.

cheers
