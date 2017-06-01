Return-Path: <hughd@google.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdx0H24CwzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 04:37:19 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id m17so34484145pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 11:37:18 -0700 (PDT)
Date: Thu, 1 Jun 2017 11:37:07 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Christoph Lameter <cl@linux.com>
cc: Hugh Dickins <hughd@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.DEB.2.20.1706011306560.11993@east.gentwo.org>
Message-ID: <alpine.LSU.2.11.1706011128490.3622@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
 <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
 <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
 <alpine.DEB.2.20.1706011306560.11993@east.gentwo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Jun 2017, Christoph Lameter wrote:
> 
> Ok so debugging was off but the slab cache has a ctor callback which
> mandates that the free pointer cannot use the free object space when
> the object is not in use. Thus the size of the object must be increased to
> accomodate the freepointer.

Thanks a lot for working that out.  Makes sense, fully understood now,
nothing to worry about (though makes one wonder whether it's efficient
to use ctors on high-alignment caches; or whether an internal "zero-me"
ctor would be useful).

Hugh
