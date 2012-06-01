Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C2926B7006
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 19:19:07 +1000 (EST)
Message-ID: <1338542315.16119.50.camel@pasglop>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Date: Fri, 01 Jun 2012 19:18:35 +1000
In-Reply-To: <20120531110439.GA17373@visitor2.iram.es>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wrobel Heinz-R39252 <r39252@freescale.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Steffen Rumler <steffen.rumler.ext@nsn.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-31 at 13:04 +0200, Gabriel Paubert wrote:

> I believe that the basic premise is that you should provide a directly reachable copy 
> of the save/rstore functions, even if this means that you need several copies of the functions.

I just fixed a very similar problem with grub2 in fact. It was using r0
and trashing the saved LR that way.

The real fix is indeed to statically link those gcc "helpers", we
shouldn't generate things like cross-module calls inside function
prologs and epilogues, when stackframes aren't even guaranteed to be
reliable.

However, in the grub2 case, it was easier to just use r12 :-)

Cheers,
Ben.

> > 
> > Unfortunately the same doc and predecessors show r11 in all basic examples for PLT/trampoline code AFAICS, which is likely why all trampoline code uses r11 in any known case.
> > 
> > I would guess that it was never envisioned that compiler generated code would be in a different section than save/restore functions, i.e., the Linux module "__init" assumptions for Power break the ABI. Or does the ABI break the __init concept?!
> > 
> > Using r12 in the trampoline seems to be the obvious solution for module loading.
> > 
> > But what about other code loading done? If, e.g., a user runs any app from bash it gets loaded and relocated and trampolines might get set up somehow.
> 
> I don't think so. The linker/whatever should generate a copy of the save/restore functions for every
> executable code area (shared library), and probably more than one copy if the text becomes too large.
> 
> For 64 bit code, these functions are actually inserted by the linker.
> 
> [Ok, I just recompiled my 64 bit kernel with -Os and I see that vmlinux gets one copy
> of the save/restore functions and every module also gets its copy.]
> 
> This makes sense, really these functions are there for a compromise between locality 
> and performance, there should be one per code section, otherwise the cache line 
> used by the trampoline negates a large part of their advantage.
> 
> > 
> > Wouldn't we have to find fix ANY trampoline code generator remotely related to a basic Power Architecture Linux?
> > Or is it a basic assumption for anything but modules that compiler generated code may never ever be outside the .text section? I am not sure that would be a safe assumption.
> > 
> > Isn't this problem going beyond just module loading for Power Architecture Linux?
> 
> I don't think so. It really seems to be a 32 bit kernel problem.
> 
> 	Regards,
> 	Gabriel
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
