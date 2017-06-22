Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtmzQ2k9WzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 02:21:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MGIssu042439
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 12:21:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8dhwcxe0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 12:21:03 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 22 Jun 2017 12:21:02 -0400
Date: Thu, 22 Jun 2017 09:20:51 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC v2 01/12] powerpc: Free up four 64K PTE bits in 4K backed
 hpte pages.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
 <7348e178-b79e-421a-8dd5-4cfbcd56027a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7348e178-b79e-421a-8dd5-4cfbcd56027a@linux.vnet.ibm.com>
Message-Id: <20170622162051.GN5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 22, 2017 at 02:37:27PM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:22 AM, Ram Pai wrote:
> > Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> > in the 4K backed hpte pages. These bits continue to be used
> > for 64K backed hpte pages in this patch, but will be freed
> > up in the next patch.
> > 
> > The patch does the following change to the 64K PTE format
> > 
> > H_PAGE_BUSY moves from bit 3 to bit 9
> > H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> > 	of the pte.
> > H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> > 	second part of the pte.
> > 
> > the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> > is  initialized  to  0xF  indicating  an invalid  slot.  If  a hpte
> > gets cached in a 0xF  slot(i.e  7th  slot  of  secondary),  it   is
> > released immediately. In  other  words, even  though   0xF   is   a
> > valid slot we discard  and consider it as an invalid
> > slot;i.e hpte_soft_invalid(). This  gives  us  an opportunity to not
> > depend on a bit in the primary PTE in order to determine the
> > validity of a slot.
> > 
> > When  we  release  a    hpte   in the 0xF   slot we also   release a
> > legitimate primary   slot  and    unmap    that  entry. This  is  to
> > ensure  that we do get a   legimate   non-0xF  slot the next time we
> > retry for a slot.
> > 
> > Though treating 0xF slot as invalid reduces the number of available
> > slots  and  may  have an effect  on the performance, the probabilty
> > of hitting a 0xF is extermely low.
> > 
> > Compared  to the current scheme, the above described scheme reduces
> > the number of false hash table updates  significantly  and  has the
> > added  advantage  of  releasing  four  valuable  PTE bits for other
> > purpose.
> > 
> > This idea was jointly developed by Paul Mackerras, Aneesh, Michael
> > Ellermen and myself.
> > 
> > 4K PTE format remain unchanged currently.
> 
> Scanned through the PTE format again for hash 64K and 4K. It seems
> to me that there might be 5 free bits already present on the PTE
> format. I might have seriously mistaken something here :) Please
> correct me if that is not the case. _RPAGE_RPN* I think is applicable
> only for hash page table format and will not be available for radix
> later.
> 
> +#define _PAGE_FREE_1           0x0000000000000040UL /* Not used */
> +#define _RPAGE_SW0             0x2000000000000000UL /* Not used */
> +#define _RPAGE_SW1             0x0000000000000800UL /* Not used */
> +#define _RPAGE_RPN42           0x0040000000000000UL /* Not used */
> +#define _RPAGE_RPN41           0x0020000000000000UL /* Not used */
> 

The bits are chosen to future proof for radix implementation.
_RPAGE_SW* will eat into what is available for software in the future,
and these key-bits will certainly be something that the radix
hardware will read, in the future.

The _RPAGE_RPN* bits cannot be relied on for radix.

But finally the bits that we chose (H_PAGE_F_SECOND|H_PAGE_F_GIX) had
the best potential for giving us the highest number of free bits with
relatively less effort.

RP
