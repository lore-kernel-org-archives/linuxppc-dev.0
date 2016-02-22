Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 142AD1A0607
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:27:37 +1100 (AEDT)
Message-ID: <1456100856.4690.3.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 7/9] powerpc/mm/book3s-64: Shuffle read, write,
 execute and user bits in PTE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 22 Feb 2016 11:27:36 +1100
In-Reply-To: <20160221223616.GB30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-8-git-send-email-paulus@samba.org>
 <87si0m7c5t.fsf@linux.vnet.ibm.com>
 <20160221223616.GB30309@fergus.ozlabs.ibm.com>
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

On Mon, 2016-02-22 at 09:36 +1100, Paul Mackerras wrote:
> On Sun, Feb 21, 2016 at 01:00:54PM +0530, Aneesh Kumar K.V wrote:
> > Paul Mackerras <paulus@samba.org> writes:
> >
> > Also can you use constants like
> > #define _PAGE_USER PPC_BIT(60)
>
> I'd really rather not - that is harder for the casual reader to parse,
> because they then have to go off and find out what exactly PPC_BIT
> does.  The only time that using PPC_BIT would help is when checking
> that the bit definitions match the Power ISA, and that's presumably
> done by intelligent people that can handle backwards bit numbering in
> their heads. :)

Yep agree 100%.

Using PPC_BIT() means every time someone sees that defintion they need to think
about what the conversion is and whether it's right, ie. for the entire future
history of this code.

On the other hand not using PPC_BIT() means the person who writes the
definition needs to think about it and do the correct conversion, but only
once.

cheers
