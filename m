Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC37C1A0AE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 07:14:40 +1000 (AEST)
Message-ID: <1434575662.2353.107.camel@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Change the swap encoding in pte.
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>
Date: Wed, 17 Jun 2015 16:14:22 -0500
In-Reply-To: <1434534342.28933.5.camel@ellerman.id.au>
References: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87616ngi8x.fsf@linux.vnet.ibm.com>
 <1434534342.28933.5.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-17 at 19:45 +1000, Michael Ellerman wrote:
> On Wed, 2015-06-17 at 08:21 +0530, Aneesh Kumar K.V wrote:
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> > 
> > 
> > Hi Scott,
> > 
> > > Current swap encoding in pte can't support large pfns
> > > above 4TB. Change the swap encoding such that we put
> > > the swap type in the PTE bits. Also add build checks
> > > to make sure we don't overlap with HPTEFLAGS.
> > > 
> > 
> > Can you please review this w.r.t 64bit booke ? 

It looks OK.

I'm curious why _PAGE_BIT_SWAP_TYPE is 2 -- it seems like it could be 
any value >= 1 that isn't large enough to cause a conflict. Does 
something get stored in that second bit?

> I booted it on our p5020ds FWIW.

Actively using swap?

-Scott
