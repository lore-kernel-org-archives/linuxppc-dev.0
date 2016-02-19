Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 909C61A06F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 21:37:44 +1100 (AEDT)
Message-ID: <1455878263.6506.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm/hash: Clear the invalid slot information
 correctly
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 19 Feb 2016 21:37:43 +1100
In-Reply-To: <56C6ADC6.5000603@linux.vnet.ibm.com>
References: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56C6ADC6.5000603@linux.vnet.ibm.com>
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

On Fri, 2016-02-19 at 11:23 +0530, Anshuman Khandual wrote:
> On 02/18/2016 10:14 PM, Aneesh Kumar K.V wrote:
> > We can get a hash pte fault with 4k base page size and find the pte
> > already inserted with 64K base page size. In that case we need to clear
...
>
> > diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> > index e7c04542ba62..e3e76b929f33 100644
> > --- a/arch/powerpc/mm/hash64_4k.c
> > +++ b/arch/powerpc/mm/hash64_4k.c
> > @@ -106,7 +106,7 @@ repeat:
> >  			}
> >  		}
> >  		/*
> > -		 * Hypervisor failure. Restore old pmd and return -1
> > +		 * Hypervisor failure. Restore old pte and return -1
>
> This change is not relevant here. Should be a separate patch.

Yeah.

If it was -rc1 then I would probably let it go, but this will land in rc6 so
the fixes need to be tight.

cheers
