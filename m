Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD10C1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 15:12:38 +1100 (EST)
Message-ID: <1320984711.21206.32.camel@pasglop>
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Suzuki Poulose <suzuki@in.ibm.com>
Date: Fri, 11 Nov 2011 15:11:51 +1100
In-Reply-To: <4EBB3794.9050309@in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble> <4EB3A40C.1070802@in.ibm.com>
 <1320678819.2750.15.camel@treble> <4EB8D628.2090304@in.ibm.com>
 <1320769145.5273.26.camel@treble>
 <20111109120303.51ac3b1b@suzukikp.in.ibm.com>
 <1320850388.3259.18.camel@treble> <4EBB3794.9050309@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nathan Miller <nathanm2@us.ibm.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@us.ibm.com>, Dave Hansen <dave@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Alan Modra <amodra@au1.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-10 at 08:01 +0530, Suzuki Poulose wrote:

> Oops ! You are right. We could go back to the clean_dcache_all() or the
> initial approach that you suggested. (dcbst).
> 
> I am not sure how do we flush the entire dcache(only). Could you post a
> patch which does the same ?
> 
> Another option is to, change the current mapping to 'Write Through' before
> calling the relocate() and revert back to the original setting after relocate().

Why not just keep the dcbst's & icbi's in relocate for now ? (original
patch) Is it noticably slower to boot ? If not I'd say keep it that way,
it will work on all implementations.

Cheers,
Ben.
> >
> >>
> >>
> >>> For i-cache invalidation there's already the (incorrectly named?)
> >>> flush_instruction_cache().  It uses the appropriate platform-specific
> >>> methods (e.g. iccci for 44x) to invalidate the entire i-cache.
> >>
> >> Agreed. The only thing that worries me is the use of KERNELBASE in the
> >> flush_instruction_cache() for CONFIG_4xx. Can we safely assume all 4xx
> >> implementations ignore the arguments passed to iccci ?
> >
> > Good question.  I don't know the answer. :-)
> >
> > That also may suggest a bigger can of worms.  A grep of the powerpc code
> > shows many uses of KERNELBASE.  For a relocatable kernel, nobody should
> > be relying on KERNELBASE except for the early relocation code.  Are we
> > sure that all the other usages of KERNELBASE are "safe"?
> >
> I think we could simply replace the occurrences of KERNELBASE (after the relocate())
>   with '_stext' which would give the virtual start address of the kernel.
> 
> Thanks
> Suzuki
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
