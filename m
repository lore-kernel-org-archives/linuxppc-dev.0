Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D396B1A0185
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:47:03 +1000 (AEST)
Message-ID: <1442904408.19102.222.camel@freescale.com>
Subject: Re: [PATCH 09/31] powerpc/mm: Don't use pte_val as lvalue
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2015 01:46:48 -0500
In-Reply-To: <87d1xb3qd4.fsf@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150922022223.GA12728@home.buserror.net>
 <87d1xb3qd4.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 12:14 +0530, Aneesh Kumar K.V wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
> > On Mon, Sep 21, 2015 at 12:10:36PM +0530, Aneesh Kumar K.V wrote:
> > > +static inline pte_t pte_mkwrite(pte_t pte)
> > > +{
> > > + pte_basic_t ptev;
> > > +
> > > + ptev = pte_val(pte) & ~_PAGE_RO;
> > > + ptev |= _PAGE_RW;
> > > + return __pte(pte);
> > > +}
> > 
> > s/__pte(pte)/__pte(ptev)/
> > 
> > ...to fix an endless handle_mm_fault() loop.
> > 
> > CONFIG_STRICT_MM_TYPECHECKS would have caught this.
> > 
> 
> Thanks will update the patch. As you noticied the patch series was not
> tested on anything other than power7 and power8 (BE/LE). So any testing
> on other platforms is going to be really useful. Now I did compile test
> this with large number of configs. I guess none of them enable
> STRICT_MM_TYPES.
> 
> Did the series boot fine on the platform after the above fix ?

Yes, I booted on e500v2 (with and without 64-bit physical addresses), e500mc, 
and e6500.

-Scott
