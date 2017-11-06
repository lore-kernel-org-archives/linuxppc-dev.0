Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVrcT5MlDzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 22:56:09 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id b192so8026301pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 03:56:09 -0800 (PST)
Date: Mon, 6 Nov 2017 22:55:56 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 2/5] powerpc/64s/hash: Allow MAP_FIXED allocations to
 cross 128TB boundary
Message-ID: <20171106225556.79aea9c8@roar.ozlabs.ibm.com>
In-Reply-To: <87vainsn45.fsf@linux.vnet.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-3-npiggin@gmail.com>
 <87vainsn45.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 06 Nov 2017 16:14:10 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > While mapping hints with a length that cross 128TB are disallowed,
> > MAP_FIXED allocations that cross 128TB are allowed. These are failing
> > on hash (on radix they succeed). Add an additional case for fixed
> > mappings to expand the addr_limit when crossing 128TB.  
> 
> Shouldn't that be fixed in radix. But i see x86 also doing this?
> 
> 
> 	if (flags & MAP_FIXED)
> 		return addr;
> 
> Kiril,
> 
> Is that expected?

I should actually reply to this one because the other did not
have Kirill on cc.

Generic mapping code appears it will always succeed when given an
explicit hint request, even if the address is below the boundary
and address + length is above it. Even when !MAP_FIXED. This is the
sane behaviour AFAIKS. So we should switch powerpc to match,
shouldn't we?

Thanks,
Nick
