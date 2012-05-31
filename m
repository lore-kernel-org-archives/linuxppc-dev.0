Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (unknown [IPv6:2001:720:418:ca00::9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 58F18B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 21:05:00 +1000 (EST)
Date: Thu, 31 May 2012 13:04:39 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Wrobel Heinz-R39252 <r39252@freescale.com>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
Message-ID: <20120531110439.GA17373@visitor2.iram.es>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
Cc: Michael Ellerman <michael@ellerman.id.au>,
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

On Thu, May 31, 2012 at 07:04:42AM +0000, Wrobel Heinz-R39252 wrote:
> Michael,
> 
> > On Wed, 2012-05-30 at 16:33 +0200, Steffen Rumler wrote:
> > > I've found the following root cause:
> > >
> > >      (6) Unfortunately, the trampoline code (do_plt_call()) is using
> > register r11 to setup the jump.
> > >            It looks like the prologue and epilogue are using also the
> > register r11, in order to point to the previous stack frame.
> > >            This is a conflict !!! The trampoline code is damaging the
> > content of r11.
> > 
> > Hi Steffen,
> > 
> > Great bug report!
> > 
> > I can't quite work out what the standards say, the versions I'm looking
> > at are probably old anyway.
> 
> The ABI supplement from https://www.power.org/resources/downloads/ is explicit about r11 being a requirement for the statically lined save/restore functions in section 3.3.4 on page 59.
> 
> This means that any trampoline code must not ever use r11 or it can't be used to get to such save/restore functions safely from far away.

I believe that the basic premise is that you should provide a directly reachable copy 
of the save/rstore functions, even if this means that you need several copies of the functions.

> 
> Unfortunately the same doc and predecessors show r11 in all basic examples for PLT/trampoline code AFAICS, which is likely why all trampoline code uses r11 in any known case.
> 
> I would guess that it was never envisioned that compiler generated code would be in a different section than save/restore functions, i.e., the Linux module "__init" assumptions for Power break the ABI. Or does the ABI break the __init concept?!
> 
> Using r12 in the trampoline seems to be the obvious solution for module loading.
> 
> But what about other code loading done? If, e.g., a user runs any app from bash it gets loaded and relocated and trampolines might get set up somehow.

I don't think so. The linker/whatever should generate a copy of the save/restore functions for every
executable code area (shared library), and probably more than one copy if the text becomes too large.

For 64 bit code, these functions are actually inserted by the linker.

[Ok, I just recompiled my 64 bit kernel with -Os and I see that vmlinux gets one copy
of the save/restore functions and every module also gets its copy.]

This makes sense, really these functions are there for a compromise between locality 
and performance, there should be one per code section, otherwise the cache line 
used by the trampoline negates a large part of their advantage.

> 
> Wouldn't we have to find fix ANY trampoline code generator remotely related to a basic Power Architecture Linux?
> Or is it a basic assumption for anything but modules that compiler generated code may never ever be outside the .text section? I am not sure that would be a safe assumption.
> 
> Isn't this problem going beyond just module loading for Power Architecture Linux?

I don't think so. It really seems to be a 32 bit kernel problem.

	Regards,
	Gabriel
