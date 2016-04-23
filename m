Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qsQfY1R5qzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 18:30:28 +1000 (AEST)
Message-ID: <1461400219.3135.55.camel@kernel.crashing.org>
Subject: Re: [PATCH V2 26/68] powerpc/mm/radix: Add radix pte defines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 23 Apr 2016 18:30:19 +1000
In-Reply-To: <5718531C.80903@gmail.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5718531C.80903@gmail.com>
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

On Thu, 2016-04-21 at 14:12 +1000, Balbir Singh wrote:
> > +     } while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
> > +                                                    cpu_to_be64(old_pte),
> > +                                                    cpu_to_be64(new_pte)));
> > +     /* We already do a sync in cmpxchg, is ptesync needed ?*/
> > +     asm volatile("ptesync" : : : "memory");
> 
> Yes, I think ptesync is required after PTE changes

Is it really on radix ? I'm not 100% sure... it's usually needed to
synchronize the writebacks of R and C...

Cheers,
Ben.
