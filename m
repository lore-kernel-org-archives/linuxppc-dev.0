Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49DD11A0588
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 10:43:10 +1100 (AEDT)
Message-ID: <1417563789.16722.1.camel@concordia>
Subject: Re: [PATCH v2] powerpc: Remove more traces of bootmem
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 03 Dec 2014 10:43:09 +1100
In-Reply-To: <20141120023319.GA71013@thor.bakeyournoodle.com>
References: <1416442058-19544-1-git-send-email-mpe@ellerman.id.au>
 <20141120023319.GA71013@thor.bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David.Laight@ACULAB.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 2014-11-20 at 13:33 +1100, Tony Breeds wrote:
> On Thu, Nov 20, 2014 at 11:07:38AM +1100, Michael Ellerman wrote:
> > --- a/arch/powerpc/lib/alloc.c
> > +++ b/arch/powerpc/lib/alloc.c
> > @@ -13,9 +13,7 @@ void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
> >  	if (mem_init_done)
> >  		p = kzalloc(size, mask);
> >  	else {
> > -		p = alloc_bootmem(size);
> > -		if (p)
> > -			memset(p, 0, size);
> > +		p = memblock_virt_alloc(size, 0);
> >  	}
> 
> You knew someone would ask but ...
> Do you want to remove the {} form the else clause so that the style matches the  if()

Actually I was going to do a follow-up that just returns directly without p at
all, thanks for the reminder :)

cheers
