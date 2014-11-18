Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id B52841A0808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 07:07:20 +1100 (AEDT)
Message-ID: <546BA6F3.2070106@c-s.fr>
Date: Tue, 18 Nov 2014 21:07:15 +0100
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4,17/21] powerpc/8xx: set PTE bit 22 off TLBmiss
References: <20140919083609.A92871AB040@localhost.localdomain>	
 <20141107033745.GA23796@home.buserror.net> <545C7C2E.3060109@c-s.fr>
 <1415405305.3805.45.camel@snotra.buserror.net>
In-Reply-To: <1415405305.3805.45.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 08/11/2014 01:08, Scott Wood a écrit :
>
> OK, so the _PAGE_KERNEL_RO(X) stuff is because initially setting the PTE
> doesn't go through pte_update().
>
> I'll apply this, though it'd be cleaner to just have 8xx versions of the
> relevant PTE accessor functions to maintain the PTE the way the hardware
> wants (this would also eliminate the _PAGE_RW inversion that's still in
> the TLB miss handler).
>
>

Yes, I've been looking at a simple way to also eliminate the _PAGE_RW 
inversion, but i've not been able to find an easy solution up to now.

It seems that we have two functions that set PTE: set_pte_at() and 
pte_update()
I could perform the bit 22 (0x200) stuff and the _PAGE_RW invertion in 
both functions, but then there are functions that read the PTE to make 
decision based on PAGE_RW for instance. Most (but not all it seems) do 
it through pte_val()
But pte_val() is defined in page.h and doesn't seem to be intended to be 
family specific. Should I change this ? if so, what is it cleanest way 
to do so ?
Should I also change __pgprot() and __pte() to do the bit 22 and PAGE_RW 
inversion stuffs ? But not all functions use those accessors.

So for the time being I don't see the best way to progress on this. Any 
suggestion ?

Christophe

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com
