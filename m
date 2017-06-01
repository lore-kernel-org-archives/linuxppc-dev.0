Return-Path: <cl@linux.com>
Received: from resqmta-ch2-05v.sys.comcast.net
 (resqmta-ch2-05v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdrtc3wXqzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 01:32:08 +1000 (AEST)
Date: Thu, 1 Jun 2017 10:31:03 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Hugh Dickins <hughd@google.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
Message-ID: <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> > I am curious as to what is going on there. Do you have the output from
> > these failed allocations?
>
> I thought the relevant output was in my mail.  I did skip the Mem-Info
> dump, since that just seemed noise in this case: we know memory can get
> fragmented.  What more output are you looking for?

The output for the failing allocations when you disabling debugging. For
that I would think that you need remove(!) the slub_debug statement on the kernel
command line. You can verify that debug is off by inspecting the values in
/sys/kernel/slab/<yourcache>/<debug option>

> But it was still order 4 when booted with slub_debug=O, which surprised me.
> And that surprises you too?  If so, then we ought to dig into it further.

No it does no longer. I dont think slub_debug=O does disable debugging
(frankly I am not sure what it does). Please do not specify any debug options.
