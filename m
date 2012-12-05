Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1F462C00BA
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2012 17:12:42 +1100 (EST)
Received: from telerig.nabble.com ([192.168.236.162])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <bounces@nabble.com>) id 1Tg7yG-0004mH-MP
 for linuxppc-dev@ozlabs.org; Tue, 04 Dec 2012 21:56:36 -0800
Message-ID: <34760537.post@talk.nabble.com>
Date: Tue, 4 Dec 2012 21:56:36 -0800 (PST)
From: Pegasus11 <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Understanding how kernel updates MMU hash table
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello.

Ive been trying to understand how an hash PTE is updated. Im on a PPC970MP
machine which using the IBM PowerPC 604e core. My Linux version is 2.6.10 (I
am sorry I cannot migrate at the moment. Management issues and I can't help
:-(( )

Now onto the problem:
hpte_update is invoked to sync the on-chip MMU cache which Linux uses as its
TLB. So whenever a change is made to the PTE, it has to be propagated to the
corresponding TLB entry. And this uses hpte_update for the same. Am I right
here?

Now  http://lxr.linux.no/linux-bk+*/+code=hpte_update hpte_update  is
declared as
 
' void hpte_update(pte_t *ptep, unsigned long pte, int wrprot) '. 
The arguments to this function is a POINTER to the PTE entry (needed to make
a change persistent across function call right?), the PTE entry (as in the
value) as well the wrprot flag.

Now the code snippet thats bothering me is this:
'
  86        ptepage = virt_to_page(ptep);
  87        mm = (struct mm_struct *) ptepage->mapping;
  88        addr = ptepage->index +
  89                (((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
'

On line 86, we get the page structure for a given PTE but we pass the
pointer to PTE not the PTE itself whereas virt_to_page is a macro defined
as:

#define virt_to_page(kaddr)   pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

Why are passing the POINTER to pte here? I mean are we looking for the PAGE
that is described by the PTE or are we looking for the PAGE which contains
the pointer to PTE? Me things it is the later since the former is given by
the VALUE of the PTE not its POINTER. Right?

So if it indeed the later, what trickery are we here after? Perhaps
following the snippet will make us understand? As I see from above, after
that we get the 'address space object' associated with this page. 

What I don't understand is the following line:
 addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) *
PTRS_PER_PTE);

First we get the index of the page in the file i.e. the number of pages
preceding the page which holds the address of PTEP. Then we get the lower 12
bits of this page. Then we shift that these bits to the left by 12 again and
to it we add the above index. What is this doing?

There are other things in this function that I do not understand. I'd be
glad if someone could give me a heads up on this.
-- 
View this message in context: http://old.nabble.com/Understanding-how-kernel-updates-MMU-hash-table-tp34760537p34760537.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
