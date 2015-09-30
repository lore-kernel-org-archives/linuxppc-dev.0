Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E27A1A05FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 06:18:39 +1000 (AEST)
Message-ID: <1443644298.2828.16.camel@kernel.crashing.org>
Subject: Re: [PATCH V2 19/31] powerpc/mm: Convert 4k hash insert to C
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 01 Oct 2015 06:18:18 +1000
In-Reply-To: <560BD07B.60202@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1443580044-30659-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <560BD07B.60202@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-30 at 17:37 +0530, Anshuman Khandual wrote:
> > +             if (unlikely(old_pte & _PAGE_BUSY))
> > +                     return 0;
> > +             /* If PTE permissions don't match, take page fault */
> 
> We are already in page fault interrupt path,  will it be better
> if we call it "take Linux page fault" instead as we will go back
> walking the page table.

A better wording would be "escalate the page fault"

Cheers,
Ben.
