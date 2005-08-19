Return-Path: <pawel.studencki@siemens.com>
Received: from alea.erlm.siemens.de (alea.erlm.siemens.de [217.194.35.70])
	by ozlabs.org (Postfix) with ESMTP id 984B8680BE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 17:26:32 +1000 (EST)
Message-ID: <291992F9ECD9AB4F995C7E96B9A30DC008E088@nbgh103a.nbg6.siemens.de>
From: Studencki Pawel <pawel.studencki@siemens.com>
To: 'Marcelo Tosatti' <marcelo.tosatti@cyclades.com>
Date: Fri, 19 Aug 2005 09:17:07 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: segmentaion fault with array[4096]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,

it is very strange, I found that SIGSEGV is generated in function
do_page_fault() in arch/ppc/mm/fault.c

------------------------------------------------------------------
int do_page_fault(struct pt_regs *regs, unsigned long address,
                  unsigned long error_code)
{
        struct vm_area_struct * vma;
        struct mm_struct *mm = current->mm;
        siginfo_t info;
        int code = SEGV_MAPERR;
#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
        int is_write = error_code & ESR_DST;
#else
        int is_write = 0;

        /*
         * Fortunately the bit assignments in SRR1 for an instruction
         * fault and DSISR for a data fault are mostly the same for the
         * bits we are interested in.  But there are some bits which
         * indicate errors in DSISR but can validly be set in SRR1.
         */
//      printk("fault bad_area is_write is NULL %x\n", regs->dsisr);
        if (TRAP(regs) == 0x400)
                error_code &= 0x48200000;
        else
        {
//              printk("fault bad_area is_write err = %x %x\n", error_code,
TRAP(regs));
                is_write = error_code & 0x02000000;
        }
#endif /* CONFIG_4xx || CONFIG_BOOKE */
---------------------------------------------------------------


It is in DSI Exception, so it goes to "else" and sets is_write to value
error_code & 0x02000000, where error_code is DSISR.
it is better, when is_write != 0, because if it's NULL, a few lines below
there
is an "goto" to bad_area:

        if (!is_write)
        {
               goto bad_area;
        } 


and I get exception.
At exception error_code is 0x4821, but in User Manual MPC866 in chapter
6.1.2.3
in table 6-7, they write that bits 0-14 in DSISR are NULL. I'm confused and
I don't know how should I interpret this. Where does value 0x4821 come
from??? most of the time it is 0x82000000...

best regards
Pawel







> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
> Sent: Thursday, August 18, 2005 8:01 PM
> To: Studencki Pawel
> Cc: 'linuxppc-embedded@ozlabs.org'
> Subject: Re: segmentaion fault with array[4096]
> 
> Hi!
> On Thu, Aug 18, 2005 at 11:45:04AM +0200, Studencki Pawel wrote:
> > hello,
> > 
> > because I want to do some tests with fusion/RTAI on my mpc852,
> > I had to downgrade my system to kernel 2.6.10
> 
> Downgrade from what? 
> 
> > And I get a strange problem: if I start application with 
> char array size
> > 4096 (or even smaller 2600) I get "segmentation fault".
> >
> > Could someone gives me a hint? Is this kernel configuration problem?
> > Where can I start looking for a reason?
> 
> Have you tried to debug the application with gdb to spot more 
> precisely 
> what is it doing that makes it receive a segfault? 
> 
> Most likely its doing an invalid memory access.
> 
