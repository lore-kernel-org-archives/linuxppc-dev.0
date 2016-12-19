Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjCwG4hYnzDw3D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 07:59:42 +1100 (AEDT)
Message-ID: <1482181162.15937.32.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 4/5] powerpc/mm: add radix__remove_section_mapping()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Date: Tue, 20 Dec 2016 07:59:22 +1100
In-Reply-To: <87wpewtfl4.fsf@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-5-git-send-email-arbab@linux.vnet.ibm.com>
 <87wpewtfl4.fsf@linux.vnet.ibm.com>
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

On Mon, 2016-12-19 at 15:18 +0530, Aneesh Kumar K.V wrote:
> > +     pte = pte_start + pte_index(addr);
> > +     for (; addr < end; addr = next, pte++) {
> > +             next = (addr + PAGE_SIZE) & PAGE_MASK;
> > +             if (next > end)
> > +                     next = end;
> > +
> > +             if (!pte_present(*pte))
> > +                     continue;
> > +
> > +             spin_lock(&init_mm.page_table_lock);
> > +             pte_clear(&init_mm, addr, pte);
> > +             spin_unlock(&init_mm.page_table_lock);
> > +     }
> > +
> > +     flush_tlb_mm(&init_mm);
> 
> Why call a flush here. we do that at the end of remove_page_table .
> Isn't that sufficient ?

All those lock/unlock ... what for ? Can't we just do the whole page ?

Also I agree, we can delay the flush of the PTEs to the end.

Ben.
