Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1127774755.15882.104.camel@gaston>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<20050924104827.114939ca.sfr@canb.auug.org.au>
	<BCC97EBE-6171-4FF9-A696-B98B11046391@freescale.com>
	<200509261157.37514.michael@ellerman.id.au>
	<1127774755.15882.104.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <65BBD07F-B465-45E0-9422-9015D1FBF93A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 26 Sep 2005 18:22:08 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 26, 2005, at 5:45 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-09-26 at 11:57 +1000, Michael Ellerman wrote:
>
>
>> Here's a version of my patch updated to apply on top of the merge
>>
> tree.
>
>> It'll be a lot cleaner when ppc32 has a single cur_cpu_spec, as we'll
>> be able to remove a lot of the #ifdefs.
>>
>
> There is a small issue here: You turn identify_cpu into C code.  
> However,
> on ppc32, this is called with the kernel not yet relocated (before
> prom_init even !). Same with the feature fixup. On ppc32, in order to
> run C code that early, it needs to be in -mrelocatable bits of code
> (like prom_init) or use RELOC macros (ugh !).

What's the pain in building cputable.c as -mrelocatable on ppc32 for  
now?

> This puts some light on the fact that we do things quite differently
> here between ppc32 and ppc64. On ppc64, the call to identify CPU is  
> done
> after kernel is relocated (after prom_init), and before early_setup,
> though the call to fixup the feature sections is done later, after the
> initial parsing of the flat device-tree, where we can "adjust" some
> features based on firmware properties.
>
> We might want to sync a bit what ppc32 and ppc64 do here, however,  
> that
> will/would require some changes in the way we manipulate some MMU  
> bits.
>
> On ppc32, we first create a temporary initial mapping, using BATs on
> 6xx, using other mecanisms on other CPUs, that covers kernel text &  
> data
> (not much more). This could be "equivalent" of the ppc64 bit that runs
> in real mode. (Though we have to be careful there if we do something
> like unpacking the device-tree, that has to be done -after- final
> translation is turned on with full access to the linear mapping).
>
> Also, the ppc64 bits calls indentify_cpu from asm on the primary  
> CPU at
> least. I don't think that is strictly necessary, at least not any  
> more.
> It could be done instead at the beginning of early_setup.

At the end of the day we should have the same init path for  
everything.  We have to deal with the fact that some processors are  
not going to have "real mode" to run in.  Anything Book-E 32 or 64- 
bit is going to fall into this case.

- kumar
