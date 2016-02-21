Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6745C1A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:46:13 +1100 (AEDT)
Date: Mon, 22 Feb 2016 09:43:34 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 2/9] powerpc/mm/book3s-64: Free up 7 high-order bits
 in the Linux PTE
Message-ID: <20160221224334.GD30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-3-git-send-email-paulus@samba.org>
 <871t878ii4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t878ii4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 20, 2016 at 09:46:19PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > This frees up bits 57-63 in the Linux PTE on 64-bit Book 3S machines.
> > In the 4k page case, this is done just by reducing the size of the
> > RPN field to 39 bits, giving 51-bit real addresses.  In the 64k page
> > case, we had 10 unused bits in the middle of the PTE, so this moves
> > the RPN field down 10 bits to make use of those unused bits.  This
> > means the RPN field is now 3 bits larger at 37 bits, giving 53-bit
> > real addresses in the normal case, or 49-bit real addresses for the
> > special 4k PFN case.
> 
> 
> Is it ok to have different real address bits between 4k and 64k linux
> config ?

Do you mean a different number of address bits, or a different
location?  In fact both were different before this patch anyway.

Paul.
