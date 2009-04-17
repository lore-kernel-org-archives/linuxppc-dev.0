Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 597C7DDF9F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 04:16:58 +1000 (EST)
Message-Id: <BB1B852F-3854-4842-BECE-087C23C35694@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <1239991381-11649-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: ppc32 needs elf_read_implies_exec()
Date: Fri, 17 Apr 2009 13:16:19 -0500
References: <1239991381-11649-1-git-send-email-galak@kernel.crashing.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2009, at 1:03 PM, Kumar Gala wrote:

> On ppc64 we implemented elf_read_implies_exec() for 32-bit binaries
> because old toolchains had bugs with regards to marking PHDRs as
> executable that needed to be.  For some reason we didn't do this on
> ppc32 builds.  This hadn't been an issue until recent changes to I$/D$
> handling that impacted the per-page exec handling on embedded PPC.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/elf.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/ 
> asm/elf.h
> index 1a856b1..b6ada56 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -259,6 +259,7 @@ do {								\
> 		(exec_stk != EXSTACK_DISABLE_X) : 0)
> #else
> # define SET_PERSONALITY(ex) set_personality(PER_LINUX)
> +# define elf_read_implies_exec(ex, exec_stk) (exec_stk !=  
> EXSTACK_DISABLE_X)
> #endif /* __powerpc64__ */
>
> extern int dcache_bsize;
> -- 
> 1.6.0.6

I just want to make sure I understand the implications of this  
change.  It seems to me that we will not be able to support stack exec  
perms on any ppc32 part that has per-page exec support. Is that correct?

I'm wondering if we are too generous in the check, exec_stk can be:

EXSTACK_DEFAULT
EXSTACK_DISABLE_X
EXSTACK_ENABLE_X

It seems like EXSTACK_DISABLE_X/EXSTACK_ENABLE_X are only set if  
p_type == PT_GNU_STACK.  Do we think toolchains existed that set  
p_type to PT_GNU_STACK that don't set PF_X properly?

My thinking is elf_read_implies_exec() should be changed to:

# define elf_read_implies_exec(ex, exec_stk) (exec_stk ==  
EXSTACK_DEFAULT)

- k
