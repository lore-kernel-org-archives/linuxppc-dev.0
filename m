Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 02D1A679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 18:21:23 +1000 (EST)
Date: Fri, 21 Apr 2006 10:21:22 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1145572869.4517.12.camel@localhost.localdomain>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <8178.1145607682@www025.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Eugene Surovegin <ebs@ebshome.net>
> Kopie: Gerhard Pircher <gerhard_pircher@gmx.net>,
> linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Fri, 21 Apr 2006 08:41:09 +1000
> 
> On Thu, 2006-04-20 at 14:33 -0700, Eugene Surovegin wrote:
> > On Fri, Apr 21, 2006 at 07:06:13AM +1000, Benjamin Herrenschmidt wrote:
> > > (On 6xx this is deadly even if you don't access those cacheable pages
> > > because the CPU prefetch may do it for you).
> > 
> > Here is another thought if this "prefetch" theory is correct.
> > 
> > You guys seems to focus on 
> > dma_alloc_coherent()/pci_alloc_consistent(), but forgeting about so 
> > called "streaming" mappings.
> > 
> > You cannot just flush/invalidate cache any more, because "CPU can 
> > prefetch this data back". So, to be completely correct (if you insist 
> > on "6xx can prefetch"-theory), you have to actually _copy_ data to 
> > your consistent memory on dma_map_single(). You can imagine 
> > performance implications. I suspect even 440 will be faster in this 
> > case than G4 :).
> 
> Yes.

I'm not sure, if I can follow you here. Would that mean I have to allocate
two consistent buffers of the same size? I guess the first buffer would be
used for the actual DMA transfer and is read only and the second one by the
CPU for further data processing (after the CPU has copied the data from the
first one to the second one)?

Hmm, doesn't sound feasible for me.. ?)

Gerhard

-- 
Analog-/ISDN-Nutzer sparen mit GMX SmartSurfer bis zu 70%!
Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
