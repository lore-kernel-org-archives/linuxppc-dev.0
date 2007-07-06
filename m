Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E2E3DDFCE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 23:24:38 +1000 (EST)
In-Reply-To: <468D68D4.4050704@freescale.com>
References: <468D68D4.4050704@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A6D2FF2-ADD3-4D8A-ADBB-F04CAA778539@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Executing from readablee, no-exec pages
Date: Fri, 6 Jul 2007 15:24:20 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> As revealed by the recent "Prevent data exception in kernel
> space" patch, versions of glibc prior to 2.4[1] assume that,

Are you sure that this hasn't been fixed somewhere in the 2.3
series, too?

> on powerpc32, they can execute out of any readable mapping,
> regardless of whether it is marked for execution.  This happens
> in the elf_machine_load_address() function.
>
> To maintain compatibility with these versions, we could change
> the test in do_page_fault() to include VM_READ as well as VM_EXEC
> on targets that don't have a separate exec-bit in hardware (are
> there any powerpc mmus that do?).  However, Segher suggested on
> IRC that we may want to drop compatibility with those old versions
> of glibc, and that I should seek your input.

"drop compatibility" -- this sounds worse than it is, this is all
about supporting a badly broken application.

I wonder how this works with 32-bit userland on a 64-bit kernel,
or with older kernels.  With arch/ppc/ an exec fault would do
the read checks IIRC, maybe we need to change to that.

> Personally, I'd rather stick the VM_READ in there, partially for
> selfish reasons (our root filesystems are based on older glibcs),
> and because it seems a little too soon to deprecate glibc 2.3,

Oh I don't know, can't we just deprecate glibc completely?  ;-)

> but also because in the absence of hardware support, the VM_EXEC
> check will be nondeterministic, kicking in only when the first
> fault for a page is to execute.

I don't think that is a big concern.

> [1] It's possible that there are other instances of this in 2.4 and  
> that the actual version is newer; I ran into obnoxious cross  
> compilation issues trying to try it.  However,

<rant>"Trying to try it" sounds like compiling glibc, indeed.</rant>

> <rant>
> Glibc already has target-specific code/headers; if you need to know  
> something that you'd otherwise need a runs-on-the-target autoconf  
> test for, why not just stick it in such a target-specific header?   
> In this case, it was trying to figure out the size of "long double".
> </rant>

You can do a test like this by cross-compiling some code, and looking
at the size of the symbol in the resulting object file.  Well that's
all off-topic here.


Segher
