Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7AD252C02EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 08:03:41 +1000 (EST)
Message-ID: <1371593004.21896.199.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 08:03:24 +1000
In-Reply-To: <8738sfi7er.fsf@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop> <1371353865.21896.94.camel@pasglop>
 <1371355567.21896.101.camel@pasglop> <8738sfi7er.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-19 at 00:16 +0530, Aneesh Kumar K.V wrote:

> But will that by anonymous memory ? ie, will we find them suitable for
> THP allocation ?

The 4k pages themselves with 4k_PFN no, but the segment yes. A single of
these will demote the whole segment, ie 256M or 1T.

> >   * If you find a THP in hash_page and the segment size is 4k, fault
> >
> >   * In do_page_fault, re-check for that condition (or maybe we can make
> > hash_page return a specific bit that gets ORed into the error_code into
> > do_page_fault ?) and split huge pages there.
> >
> > But that's just an idea off the top of my mind, there might be a better
> > way. Of course this needs to be tested.
> >
> > BTW. For the subpage protection, similarily, you need to make sure you
> > properly map the entire segment as "no THP", not just the range
> > passed-in by the user.
> 
> Can you explain that more, why should the entire segment be marked no THP ?
> The segment can work with 4K base page size and we still be able to
> allocate a hugepage in that segment.

Will we be able to track all the possible hashings of the huge page on a
4k segment ?

Ben.
