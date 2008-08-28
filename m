Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1165DE15A
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 03:19:07 +1000 (EST)
Date: Thu, 28 Aug 2008 12:14:39 -0500 (CDT)
Message-Id: <200808281714.m7SHEdCX096569@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: [BUG] linux-next: Tree for August 26 - Badness at
	kernel/notifier.c:25
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1219935307.7107.302.camel@pmac.infradead.org>
References: <1219935307.7107.302.camel@pmac.infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	mingo@elte.hu, Arjan van de Ven <arjan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


David Woodhouse dwmw2 at infradead.org
Fri Aug 29 00:55:07 EST 2008

> On Thu, 2008-08-28 at 15:23 +0100, David Woodhouse wrote:
>> On Thu, 2008-08-28 at 00:38 +1000, Stephen Rothwell wrote:
>>> Hi Arjan,
>>> 
>>> On Thu, 28 Aug 2008 00:33:08 +1000 Stephen Rothwell <sfr at canb.auug.org.au> wrote:
>>>>
>>>> The original reported trace was during setup_system which is very early in
>>>> the boot.
>>> 
>>> But, of course, that version didn't have the necessary extra dereference
>>> of the function address ...
>>> 
>>> And the later debug patch did not check the address at register time,
>>> only at notify time.
>>> 
>>> The later trace also looks to be early in the boot.
>> 
>> It's isa_bridge_notify(), which is neither within _[se]text nor
>> _[se]inittext, so the core_kernel_text() function disavows it.
>> 
>> Where are __devinit functions supposed to end up?
> 
> The TEXT_TEXT macro defined in <asm-generic/vmlinux.lds.h> should get
> this right... but we don't use it. Is there any particular reason for
> that, or should we....

gitk -- arch/powerpc/kernel/vmlinux.S

	e95c91821fa56b489d7beb74103a419466c5ec10
	[POWERPC] Fix link errors for allyesconfig
    
    An allyesconfig build creates a .text section that is so big that the
    .text.init.refok and .fixup sections are too far away for the relocations
    to be fixed up correctly. This patch fixes that by linking all the
    relevent text sections for each file together.
    
    Suggested by Paul Mackerras.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>


Although I think its really fac23fe4be23259a8eaa9bad822f5b14dd07d15c 
powerpc: Introduce infrastructure for feature sections with alternatives
that causes the problems.

If the problem is only reaching the branch-out-of-fixup-section, then
we could create a macro that caculates the branch as if it were already
at the destination address (using something like

	b (target-fixup_start)-(current-alternative_start)

and then removing the code that determines the branch target goes beyond
the feature section.

Just a concept, have't tried it yet and don't know if there are other
problems with .text.init.refok.

Or we fix our defintion and put a comment next to TEXT_TEXT that we
don't use it for future editors.

> 
> Signed-off-by: David Woodhouse <David.Woodhouse at intel.com>
> 
> --- linux-2.6.26.ppc64/arch/powerpc/kernel/vmlinux.lds.S~	2008-07-13 22:51:29.000000000 +0100
> +++ linux-2.6.26.ppc64/arch/powerpc/kernel/vmlinux.lds.S	2008-08-28 15:39:14.000000000 +0100
> @@ -35,10 +35,11 @@ SECTIONS
>  		ALIGN_FUNCTION();
>  		*(.text.head)
>  		_text = .;
> -		*(.text .fixup .text.init.refok .exit.text.refok)
> +		TEXT_TEXT
>  		SCHED_TEXT
>  		LOCK_TEXT
>  		KPROBES_TEXT
> +		*(.fixup)
>  
>  #ifdef CONFIG_PPC32
>  		*(.got1)
> 
> -- 
> David Woodhouse                            Open Source Technology Centre
> David.Woodhouse at intel.com                              Intel Corporation
