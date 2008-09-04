Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDD24DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 10:02:29 +1000 (EST)
Date: Wed, 3 Sep 2008 17:01:52 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
In-Reply-To: <1220484812.3254.59.camel@localhost.localdomain>
Message-ID: <alpine.LFD.1.10.0809031636320.3515@nehalem.linux-foundation.org>
References: <1220473137.3254.29.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
	<1220481754.3254.42.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031546310.3515@nehalem.linux-foundation.org>
	<1220482853.3254.47.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031602270.3515@nehalem.linux-foundation.org>
	<1220484812.3254.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-ia64@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 3 Sep 2008, James Bottomley wrote:
> 
> Oh ... because Arjan has a patch to export
> dereference_function_descriptor.  I suppose I could make him do the
> heavy lifting, but it seemed sensible to make it easy for him (and me)
> by putting it in a header.
> 
> http://marc.info/?l=linux-kernel&m=121976793429869

Ahh.

NOW it all starts to make sense.

Or perhaps not sense, but I at least understand why people want to move it 
around. The kernel.h location kind of goes together with that 
core_kernel_text() thing, although it seems to be more of a "random 
collection of routines" thing than anything else (but hey, that's the very 
definition of "kernel.h" for you).

The module.h location still seems to be more of a "oh, both 
kernel/extable.c and lib/vsprintf.c already included <linux/module.h>" and 
it's a bit sad, since it really has nothing at all to do with modules.

Grr. It does seem like we don't have any kind of "abi" header file. 
<linux/kernel.h> and <asm/processor.h> has various random things.

So yea, there doesn't seem to be any _obvious_ place that makes sense.

		Linus

Not-very-strong-opinion: How about <asm/sections.h>? That does seem to be 
where we already hide things like "in_kernel_text()" at least on powerpc. 
In fact, since we already always have a generic version, the patch would 
actually be something like

 - in <asm-generic/sections.h>, just do

	#define dereference_function_descriptor(p) (p)

 - in architectures that want to override it

	#undef dereference_function_descriptor

   followed by 

	static inline void *dereference_function_descriptor(..) ..
	or
	#define dereference_function_descriptor my_fn_dereference

   since they all include the generic one as a base

Hmm? I do admit that "<asm/sections.h>" doesn't really strike me as a very 
natural name for this, but kernel/extable.c does already include it for 
other reasons, and it's at least no worse than module.h.
