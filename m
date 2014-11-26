Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECA871A056E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 12:58:33 +1100 (AEDT)
Message-ID: <1416967101.15957.174.camel@freescale.com>
Subject: Re: [v4,17/21] powerpc/8xx: set PTE bit 22 off TLBmiss
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Tue, 25 Nov 2014 19:58:21 -0600
In-Reply-To: <546BA6F3.2070106@c-s.fr>
References: <20140919083609.A92871AB040@localhost.localdomain>
 <20141107033745.GA23796@home.buserror.net> <545C7C2E.3060109@c-s.fr>
 <1415405305.3805.45.camel@snotra.buserror.net> <546BA6F3.2070106@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Tue, 2014-11-18 at 21:07 +0100, christophe leroy wrote:
> Le 08/11/2014 01:08, Scott Wood a écrit :
> >
> > OK, so the _PAGE_KERNEL_RO(X) stuff is because initially setting the PTE
> > doesn't go through pte_update().
> >
> > I'll apply this, though it'd be cleaner to just have 8xx versions of the
> > relevant PTE accessor functions to maintain the PTE the way the hardware
> > wants (this would also eliminate the _PAGE_RW inversion that's still in
> > the TLB miss handler).
> >
> >
> 
> Yes, I've been looking at a simple way to also eliminate the _PAGE_RW 
> inversion, but i've not been able to find an easy solution up to now.
> 
> It seems that we have two functions that set PTE: set_pte_at() and 
> pte_update()
> I could perform the bit 22 (0x200) stuff and the _PAGE_RW invertion in 
> both functions, but then there are functions that read the PTE to make 
> decision based on PAGE_RW for instance.

Where?  The only relevant use of _PAGE_RW outside accessors that I see
is in gup_pte_range(), which shouldn't be too hard to fix up.

-Scott
