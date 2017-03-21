Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnJyn6yS9zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:01:21 +1100 (AEDT)
Date: Tue, 21 Mar 2017 15:01:03 +1100
From: Anton Blanchard <anton@samba.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
Message-ID: <20170321150103.6c1336bd@kryten>
In-Reply-To: <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
References: <20170320234046.32718-1-anton@ozlabs.org>
 <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
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

Hi Nick,

> I've got a patch that makes alternate feature patching a bit
> more flexible and not hit relocation limits when using big "else"
> parts. I was thinking of doing something like
> 
> _GLOBAL_TOC(copy_page)
> BEGIN_FTR_SECTION_NESTED(50)
> #include "copypage_power9.S"
> FTR_SECTION_ELSE_NESTED(50)
> #include "copypage_power7.S"
> ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_300, 50)

Good idea, I hadn't thought of embedding it all in a feature section.

> I guess POWER asm doesn't need this but it's good practice to prevent
> copy paste errors? It would be nice to have some macros to hide all
> these constants, but that's for another patch. The commenting is good.

The .machine X macros? Unfortunately the format of dcbt is different
for recent server chips. This wasn't a great idea in retrospect because
if you do get the instruction layout wrong, you wont get a fault to warn
you.

> I don't suppose the stream setup is costly enough to consider
> touching a cacheline or two ahead before starting it?

Starting up software streams is a bit of an art - if the demand loads
get ahead then a hardware stream gets started before the software one.
Note all the eieios to try and avoid this happening.

I've struggled with software prefetch on previous chips and sometimes I
wonder if it is worth the pain.

> (Also for another day) We might be able to avoid the stack and call
> for some common cases. Pretty small overcall cost I guess, but it
> could be beneficial for memcpy if not copy_page.

Definitely. Also the breakpoint for using vector should be much
lower if we have already saved the user state in a previous call.

Anton
