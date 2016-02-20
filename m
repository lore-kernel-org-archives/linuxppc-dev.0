Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0A11A096C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 03:16:30 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 11:16:28 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 44810C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 11:16:22 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1KGGOLS33882232
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:16:24 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KGGNDn015973
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 11:16:23 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 2/9] powerpc/mm/book3s-64: Free up 7 high-order bits
 in the Linux PTE
In-Reply-To: <1455948760-24710-3-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-3-git-send-email-paulus@samba.org>
Date: Sat, 20 Feb 2016 21:46:19 +0530
Message-ID: <871t878ii4.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@samba.org> writes:

> This frees up bits 57-63 in the Linux PTE on 64-bit Book 3S machines.
> In the 4k page case, this is done just by reducing the size of the
> RPN field to 39 bits, giving 51-bit real addresses.  In the 64k page
> case, we had 10 unused bits in the middle of the PTE, so this moves
> the RPN field down 10 bits to make use of those unused bits.  This
> means the RPN field is now 3 bits larger at 37 bits, giving 53-bit
> real addresses in the normal case, or 49-bit real addresses for the
> special 4k PFN case.


Is it ok to have different real address bits between 4k and 64k linux
config ?

-aneesh
