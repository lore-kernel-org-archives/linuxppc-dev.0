Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYrhZ3QxrzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 20:10:05 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id q4so255903pfg.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 01:10:05 -0800 (PST)
Date: Sat, 11 Nov 2017 20:09:51 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/slice: Use addr limit when computing slice
 mask
Message-ID: <20171111200951.648f37c6@roar.ozlabs.ibm.com>
In-Reply-To: <87mv3urqi2.fsf@linux.vnet.ibm.com>
References: <20171110045507.30147-1-aneesh.kumar@linux.vnet.ibm.com>
 <87zi7uo4c9.fsf@concordia.ellerman.id.au>
 <87mv3urqi2.fsf@linux.vnet.ibm.com>
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

On Fri, 10 Nov 2017 22:59:57 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> >  
> >> While computing slice mask for the free area we need make sure we only search
> >> in the addr limit applicable for this mmap. We update the slb_addr_limit
> >> after we request for a mmap above 128TB. But the following mmap request
> >> with hint addr below 128TB should still limit its search to below 128TB. ie.
> >> we should not use slb_addr_limit to compute slice mask in this case. Instead,
> >> we should derive high addr limit based on the mmap hint addr value.
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/mm/slice.c | 34 ++++++++++++++++++++++------------
> >>  1 file changed, 22 insertions(+), 12 deletions(-)  
> >
> > How does this relate to the fixes Nick has sent?  
> 
> This patch is on top of the patch series sent by Nick. Without this
> patch we will allocate memory across the 128TB range if hint_addr <
> 128TB but hint_addr + len is more. Inorder to recreate this issue we
> will have to map stack below. Hence one won't hit the error in general
> case.

I couldn't get it to trigger this case after that series -- hash
get_unmapped_area should be excluding that case up front before
getting into the slice allocator. Do you have an strace to reproduce
it?

Either way I do think it would be good to tighten up all the slice
bitmap limits, including all the other places that hardcodes the
max bitmap size.

Thanks,
Nick
