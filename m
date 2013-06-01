Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA2312C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 21:44:21 +1000 (EST)
Message-ID: <1370087051.3766.40.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: Always invalidate tlb on hpte invalidate
 and update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Sat, 01 Jun 2013 21:44:11 +1000
In-Reply-To: <20130601111908.GA16571@concordia>
References: <1369998204-31490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130601111908.GA16571@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-01 at 21:19 +1000, Michael Ellerman wrote:
> On Fri, May 31, 2013 at 04:33:24PM +0530, Aneesh Kumar K.V wrote:
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > If a hash bucket gets full, we "evict" a more/less random entry from it.
> > When we do that we don't invalidate the TLB (hpte_remove) because we assume
> > the old translation is still technically "valid". This implies that when
> > we are invalidating or updating pte, even if HPTE entry is not valid
> > we should do a tlb invalidate.
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Has this always been a bug? I assume not.
> 
> I'm asking because I have a kernel that's crashing and I'm wondering if
> I might need this commit.

Bug got introduced in either 
b1022fbd293564de91596b8775340cf41ad5214c or
7e74c3921ad9610c0b49f28b8fc69f7480505841, the jury is still out on
that one :-)

It's unlikely to crash the kernel however (it *can*, it's just unlikely).

Patch is good to have regardless...

Cheers,
Ben.
