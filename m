Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 3.9.5 [patch to fix powerpc build error attached]
In-reply-to: <20130608143055.GA21207@roeck-us.net>
References: <20130607195816.GA28479@kroah.com>
 <20130608143055.GA21207@roeck-us.net>
Date: Sun, 09 Jun 2013 19:47:54 +1000
Message-ID: <26857.1370771274@ale.ozlabs.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg KH <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Mackerras <paulus@samba.org>, lwn@lwn.net,
 Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Jun 07, 2013 at 12:58:16PM -0700, Greg KH wrote:
> > I'm announcing the release of the 3.9.5 kernel.
> > 
> > All users of the 3.9 kernel series must upgrade.
> > 
> > The updated 3.9.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.9.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> Powerpc build is fixed with the following patch.
> 
> From 8ce3edac0a86f103bd1037110662d5d80a42dd5b Mon Sep 17 00:00:00 2001
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Sat, 8 Jun 2013 07:23:47 -0700
> Subject: [PATCH] powerpc: Fix build error in stable/3.9
> 
> Commit e71c42189 (powerpc/tm: Abort on emulation and alignment faults)
> introduced a powerpc build error in 3.9.5.

ACK.

Looks like ba12eed (powerpc: Exception hooks for context tracking
subsyste) was the cause (but not a prerequisite) that was introduced
post 3.9.

Thanks,
Mikey

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> No upstream commit. Compile tested only.
> 
>  arch/powerpc/kernel/traps.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1c22b2d..29857c6 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1151,7 +1151,7 @@ void alignment_exception(struct pt_regs *regs)
>  		local_irq_enable();
>  
>  	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
> -		goto bail;
> +		return;
>  
>  	/* we don't implement logging of alignment exceptions */
>  	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
> -- 
> 1.7.9.7
> 
