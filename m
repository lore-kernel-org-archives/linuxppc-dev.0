Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17923.45909.143614.592837@cargo.ozlabs.ibm.com>
Date: Fri, 23 Mar 2007 22:00:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: anton@samba.org
Subject: Re: [patch 05/10] Use KERN_EMERG everywhere in oops printout
In-Reply-To: <20070321013825.179096000@samba.org>
References: <20070321013810.404636000@samba.org>
	<20070321013825.179096000@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

anton@samba.org writes:

> @@ -926,9 +934,10 @@
>  		    && stack[FRAME_MARKER] == REGS_MARKER) {
>  			struct pt_regs *regs = (struct pt_regs *)
>  				(sp + STACK_FRAME_OVERHEAD);
> -			printk("--- Exception: %lx", regs->trap);
> +			printk("%s--- Exception: %lx", log_lvl, regs->trap);
>  			print_symbol(" at %s\n", regs->nip);
>  			lr = regs->link;
> +			printk(KERN_EMERG);

Why is this one KERN_EMERG rather than log_lvl?  Just an oversight?

Paul.
