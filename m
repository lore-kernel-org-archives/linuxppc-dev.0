Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnKQT3QTBzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:21:53 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 79so14500490pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:21:53 -0700 (PDT)
Date: Tue, 21 Mar 2017 14:21:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
Message-ID: <20170321142139.3072b9b6@roar.ozlabs.ibm.com>
In-Reply-To: <20170321150103.6c1336bd@kryten>
References: <20170320234046.32718-1-anton@ozlabs.org>
 <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
 <20170321150103.6c1336bd@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Mar 2017 15:01:03 +1100
Anton Blanchard <anton@samba.org> wrote:

> Hi Nick,
> 
> > I've got a patch that makes alternate feature patching a bit
> > more flexible and not hit relocation limits when using big "else"
> > parts. I was thinking of doing something like
> > 
> > _GLOBAL_TOC(copy_page)
> > BEGIN_FTR_SECTION_NESTED(50)
> > #include "copypage_power9.S"
> > FTR_SECTION_ELSE_NESTED(50)
> > #include "copypage_power7.S"
> > ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_300, 50)  
> 
> Good idea, I hadn't thought of embedding it all in a feature section.

It may not work currently because you get those ftr_alt_97 relocation
errors with the "else" parts because relative branches to other code
need to be direct and I think reachable from both places.


> > I guess POWER asm doesn't need this but it's good practice to prevent
> > copy paste errors? It would be nice to have some macros to hide all
> > these constants, but that's for another patch. The commenting is good.  
> 
> The .machine X macros? Unfortunately the format of dcbt is different
> for recent server chips. This wasn't a great idea in retrospect because
> if you do get the instruction layout wrong, you wont get a fault to warn
> you.

Is that embedded vs server, or pre-POWER4 vs POWER4 and up? Anyway no
big deal.

> > I don't suppose the stream setup is costly enough to consider
> > touching a cacheline or two ahead before starting it?  
> 
> Starting up software streams is a bit of an art - if the demand loads
> get ahead then a hardware stream gets started before the software one.
> Note all the eieios to try and avoid this happening.
> 
> I've struggled with software prefetch on previous chips and sometimes I
> wonder if it is worth the pain.

Oh I see. Makes sense.

> > (Also for another day) We might be able to avoid the stack and call
> > for some common cases. Pretty small overcall cost I guess, but it
> > could be beneficial for memcpy if not copy_page.  
> 
> Definitely. Also the breakpoint for using vector should be much
> lower if we have already saved the user state in a previous call.

Yes agreed.

Another problem is multiple small mem/string/crypto operations may
never trip the limit even if it would make sense. Difficult to improve
that (kernel could provide a hint to the arch maybe).
