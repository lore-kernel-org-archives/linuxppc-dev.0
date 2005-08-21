Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 072C067FAC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 05:37:19 +1000 (EST)
Date: Sun, 21 Aug 2005 16:28:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Studencki Pawel <pawel.studencki@siemens.com>
Message-ID: <20050821192833.GA6746@dmt.cnet>
References: <291992F9ECD9AB4F995C7E96B9A30DC008E088@nbgh103a.nbg6.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <291992F9ECD9AB4F995C7E96B9A30DC008E088@nbgh103a.nbg6.siemens.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: segmentaion fault with array[4096]'
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2005 at 09:17:07AM +0200, Studencki Pawel wrote:
> hello,
> 
> it is very strange, I found that SIGSEGV is generated in function
> do_page_fault() in arch/ppc/mm/fault.c
> 
> ------------------------------------------------------------------
> int do_page_fault(struct pt_regs *regs, unsigned long address,
>                   unsigned long error_code)
> {
>         struct vm_area_struct * vma;
>         struct mm_struct *mm = current->mm;
>         siginfo_t info;
>         int code = SEGV_MAPERR;
> #if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
>         int is_write = error_code & ESR_DST;
> #else
>         int is_write = 0;
> 
>         /*
>          * Fortunately the bit assignments in SRR1 for an instruction
>          * fault and DSISR for a data fault are mostly the same for the
>          * bits we are interested in.  But there are some bits which
>          * indicate errors in DSISR but can validly be set in SRR1.
>          */
> //      printk("fault bad_area is_write is NULL %x\n", regs->dsisr);
>         if (TRAP(regs) == 0x400)
>                 error_code &= 0x48200000;
>         else
>         {
> //              printk("fault bad_area is_write err = %x %x\n", error_code,
> TRAP(regs));
>                 is_write = error_code & 0x02000000;
>         }
> #endif /* CONFIG_4xx || CONFIG_BOOKE */
> ---------------------------------------------------------------
> 
> 
> It is in DSI Exception, so it goes to "else" and sets is_write to value
> error_code & 0x02000000, where error_code is DSISR.
> it is better, when is_write != 0, because if it's NULL, a few lines below
> there
> is an "goto" to bad_area:
> 
>         if (!is_write)
>         {
>                goto bad_area;
>         } 
> 
> 
> and I get exception.

Sometimes is_write is set and sometimes it is not? Can you please be more 
precise? 

> At exception error_code is 0x4821, but in User Manual MPC866 in chapter
> 6.1.2.3
> in table 6-7, they write that bits 0-14 in DSISR are NULL. I'm confused and
> I don't know how should I interpret this. 

You're looking at the wrong table, thats alignment exception. You should look
at data tlb error exception.

> Where does value 0x4821 come
> from??? most of the time it is 0x82000000...

It probably comes from

	if (TRAP(regs) == 0x400)
                error_code &= 0x48200000;

No?

I think you're just doing something wrong in your app.

Check what instruction resides where the invalid access is done (in your 
application), which vma its trying to access, and you will figure out 
what is going on.
